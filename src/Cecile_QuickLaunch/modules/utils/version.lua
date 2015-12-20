----------------------------------------------------------------------------------------------------
-- version module, controls add-on version
--

--get the engine and create the module
local Engine = select(2,...);
local mod = Engine.AddOn:NewModule("version");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get locale
local L = Engine.Locale;

--get a version table from a version string
function mod.GetVersion(versionStr)

  local Version = {};

  Version.Label = versionStr;
  Version.Major,Version.Minor,Version.Release,Version.type = _G.strsplit(".",versionStr);

  return Version;
end


--compare our version and returns : 0 if are equals, 1 if we higher, or 2 if we are lower
function mod:CompareVersions(version)

  if (self.Major>version.Major) then
    return 1;
  elseif self.Major<version.Major then
    return 2;
  --equal Major version
  else
    if (self.Minor>version.Minor) then
      return 1;
    elseif self.Minor<version.Minor then
      return 2;
    --equal Major and Minor version
    else
      if (self.Release>version.Release) then
        return 1;
      elseif self.Release<version.Release then
        return 2;
      --equal Major, Minor and Release version
      else
        return 0;
      end
    end
  end

end

--we receive a message from other player add-on
function mod.VersionReceived(prefix, message, _ , sender)
  --if we get a version
  if prefix == Engine.VERSION_PREFIX then
    debug("VersionReceived from '%s' : %s", sender,message);

    --don't compare versions if we know that we are outdated
    if mod.OutDated then return; end

    --compare versions
    local otherVersion = mod.GetVersion(message);
    local compare = mod:CompareVersions(otherVersion);

    --if our version is higher than the other player, we notify him that has a wrong version
    if (compare==1) then

      mod.VersionSend(sender);
      print(string.format(L["PLAYER_VERSION"],mod.Title,sender,message));

    --if our version its lower than the other player, we print a message and we set that we have
    -- an outdated version, so we do not display the message any more during this session
    elseif (compare==2) then

      mod.OutDated=true
      print(string.format(L["WRONG_VERSION"],mod.Title,message));

    end

  end
end

--send our add-on version, if not target just send to the instance group
function mod.VersionSend(target)

  --do not send messages if we are outdated
  if mod.OutDated then return; end

  --if we do not have a target send to instance chat, that works as well for user created group
  if not target or target == "" then
    debug("Version %s send to instance chat", mod.Label);

    --set the message to the right chat
    if _G.IsInRaid() then
      Engine.AddOn:SendCommMessage(Engine.VERSION_PREFIX,mod.Label,
        (not _G.IsInRaid(_G.LE_PARTY_CATEGORY_HOME) and _G.IsInRaid(_G.LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or "RAID");
    elseif _G.IsInGroup() then
      Engine.AddOn:SendCommMessage(Engine.VERSION_PREFIX,mod.Label,
        (not _G.IsInGroup(_G.LE_PARTY_CATEGORY_HOME) and _G.IsInGroup(_G.LE_PARTY_CATEGORY_INSTANCE)) and "INSTANCE_CHAT" or "PARTY");
    end

  else
    debug("Version %s send to char: %s",mod.Label,target);
    Engine.AddOn:SendCommMessage(Engine.VERSION_PREFIX,mod.Label,"WHISPER",target);
  end

end

--party has change
function mod.PartyMembersChanged()

  --get group members, first from instance group, if not from player created group
  local numGroup = _G.GetNumGroupMembers();

  --if we have players in the group
  if numGroup>0 then

    --if we were not grouped before
    if not mod.inGroup then

      debug("join a new group")
      --send our version to the group
      mod.VersionSend("");

      --now we are in a group
      mod.inGroup = true;
    end

  else
    --means we have leave the group or disbanded
    mod.inGroup = false;

    debug("leaving a group")
  end

end

--store the add-on version
function mod:OnInitialize()

  --default values
  self.Label = "0.0.0";
  self.Major = 0;
  self.Minor = 0;
  self.Release = 0;
  self.type = "alpha";

  --get the version from meta-data
  local versionStr = _G.GetAddOnMetadata(Engine.Name, "Version");

  --parse the version
  if(versionStr) then

    local Version = self.GetVersion(versionStr);

    self.Label 	= Version.Label;
    self.Major 	= Version.Major;
    self.Minor 	= Version.Minor;
    self.Release = Version.Release;
    self.type 	= Version.type;

  end

  --get add-on title
  local title = _G.GetAddOnMetadata(Engine.Name, "Title");

  if (title) then
    self.Title = title;
  else
    self.Title = Engine.Name;
  end

  --we register the version message based on our slash that is based on the add-on name
  -- for example for add-on named Cecile_ExampleAddon will be CEA_VER
  Engine.VERSION_PREFIX = string.upper(Engine.slash1).."_VER"

  --register prefix for version checking and set-up the listener function
  Engine.AddOn:RegisterComm(Engine.VERSION_PREFIX,self.VersionReceived);

  debug("Registered add-on message %s",Engine.VERSION_PREFIX);

  --control if we are in a group
  self.inGroup = false;

  --we are not outdated, yet
  self.OutDated=false;

  --listen to group changes
  Engine.AddOn:RegisterEvent("GROUP_ROSTER_UPDATE",self.PartyMembersChanged);

end
