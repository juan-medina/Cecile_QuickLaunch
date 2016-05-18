----------------------------------------------------------------------------------------------------
-- search social module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("social");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["SOCIAL_MODULE"];

--module vars
mod.Vars = {
  returnWhispers =  {
    type = "boolean",
    default = true,
    order = 1,
    label = L["SOCIAL_RETURN_WHISPERS"],
    desc = L["SOCIAL_RETURN_WHISPERS_DESC"]
  },
  whispersToken =  {
    type = "string",
    default = L["SOCIAL_WHISPER"],
    order = 2,
    label = L["SOCIAL_WHISPER_TOKEN"],
    desc = L["SOCIAL_WHISPER_TOKEN_DESC"]
  },
  returnInvite =  {
    type = "boolean",
    default = true,
    order = 3,
    label = L["SOCIAL_RETURN_INVITE"],
    desc = L["SOCIAL_RETURN_INVITE_DESC"]
  },
  inviteToken =  {
    type = "string",
    default = L["SOCIAL_INVITE"],
    order = 4,
    label = L["SOCIAL_INVITE_TOKEN"],
    desc = L["SOCIAL_INVITE_TOKEN_DESC"]
  },
  returnConvert =  {
    type = "boolean",
    default = true,
    order = 5,
    label = L["SOCIAL_RETURN_CONVERT"],
    desc = L["SOCIAL_RETURN_CONVERT_DESC"]
  },
  convertToken =  {
    type = "string",
    default = L["SOCIAL_CONVERT"],
    order = 6,
    label = L["SOCIAL_CONVERT_TOKEN"],
    desc = L["SOCIAL_CONVERT_TOKEN_DESC"]
  },
};

--invite function
function mod.invite(item)

  if type(item.id) ~= 'number' then
    _G.InviteUnit(item.id)
  else
    _G.BNInviteFriend(item.id);
  end

end

--whisper function
function mod.whisper(item)
  _G.ChatFrame_SendSmartTell(item.id)
end

--populate friends
function mod:PopulateFriends()

  --local vars
  local returnWhispers = mod.Profile.returnWhispers;
  local returnInvite = mod.Profile.returnInvite;
  local whispersToken = mod.Profile.whispersToken;
  local inviteToken = mod.Profile.inviteToken;
  local searchableText;
  local charText;
  local item;

  local numFriends = _G.GetNumFriends();

  for index = 1, numFriends do
    local name, level, class, _, connected = _G.GetFriendInfo(index);

    if connected then

      --base text
      charText = name .. " [" .. level .. " " .. class .. "]";


      if returnWhispers then
        searchableText = whispersToken .. ": " .. charText;

        --add the text and function
        item = { text = searchableText , id=name, func = mod.whisper, help=L["SOCIAL_HELP_WHISPER"]  };

        --insert the result
        table.insert(mod.items,item);
      end

      if returnInvite then
        searchableText = inviteToken .. ": " .. charText;

        --add the text and function
        item = { text = searchableText , id=name, func = mod.invite, help=L["SOCIAL_HELP_INVITE"]  };

        --insert the result
        table.insert(self.items,item);
      end

    end

  end

end

function mod.GetClientIcon(client)
  if ( client == _G.BNET_CLIENT_WOW ) then
    return "Interface\\FriendsFrame\\Battlenet-WoWicon";
  elseif ( client == _G.BNET_CLIENT_SC2 ) then
    return "Interface\\FriendsFrame\\Battlenet-Sc2icon";
  elseif ( client == _G.BNET_CLIENT_D3 ) then
    return "Interface\\FriendsFrame\\Battlenet-D3icon";
  elseif ( client == _G.BNET_CLIENT_WTCG ) then
    return "Interface\\FriendsFrame\\Battlenet-WTCGicon";
  elseif ( client == _G.BNET_CLIENT_HEROES ) then
    return "Interface\\FriendsFrame\\Battlenet-HotSicon";
  elseif ( client == _G.BNET_CLIENT_OVERWATCH ) then
    return "Interface\\FriendsFrame\\Battlenet-Overwatchicon";
  else
    return "Interface\\FriendsFrame\\Battlenet-Battleneticon";
  end
end

--populate friends
function mod:PopulateBNetFriends()

  --local vars
  local returnWhispers = mod.Profile.returnWhispers;
  local returnInvite = mod.Profile.returnInvite;
  local whispersToken = mod.Profile.whispersToken;
  local inviteToken = mod.Profile.inviteToken;
  local searchableText;
  local charText;
  local item;

  local playerFaction = _G.UnitFactionGroup("player");

  local numFriends =  _G.BNGetNumFriends();

  for index = 1, numFriends do

    local bnetIDAccount, accountName, battleTag, _, _, bnetIDGameAccount, client, isOnline = _G.BNGetFriendInfo(index)

    if isOnline then

      local icon = mod.GetClientIcon(client);

      if client == _G.BNET_CLIENT_WOW then

        local _, characterName, _, _, _, faction, _, class, _, _, level, _, _, _, _, toonID, _, _, _  = _G.BNGetGameAccountInfo(bnetIDGameAccount or bnetIDAccount);

        --base text
        charText = battleTag .. " (".. characterName ..  ")  [" .. level .. " " .. class .. "]";

        if returnWhispers then
          searchableText = whispersToken .. ": " .. charText;

          --add the text and function
          item = { text = searchableText , id=accountName, func = mod.whisper, icon=icon, help=L["SOCIAL_HELP_WHISPER"] };

          --insert the result
          table.insert(mod.items,item);
        end

        if returnInvite and playerFaction==faction then
          searchableText = inviteToken .. ": " .. charText;

          --add the text and function
          item = { text = searchableText , id=toonID, func = mod.invite, icon=icon, help=L["SOCIAL_HELP_INVITE"] };

          --insert the result
          table.insert(mod.items,item);

        end
      else
        --base text
        charText = battleTag .. " [".. client ..  "]";

        if returnWhispers then
          searchableText = whispersToken .. ": " .. charText;

          --add the text and function
          item = { text = searchableText , id=accountName, func = mod.whisper, icon=icon, help=L["SOCIAL_HELP_WHISPER"] };

          --insert the result
          table.insert(self.items,item);
        end

      end

    end

  end

end



--populate convert items
function mod:PopulateConvert()

  if (_G.GetNumGroupMembers() > 0) and (_G.UnitIsGroupLeader("player")) then

    local item,searchableText;
    local convertToken = mod.Profile.convertToken;

    if _G.IsInRaid() and (_G.GetNumGroupMembers()<6) then

      --base text
      searchableText = convertToken .. ": " .. L["SOCIAL_CONVERT_TO_PARTY"];

      --add the text and function
      item = { text = searchableText , func = _G.ConvertToParty, help=L["SOCIAL_HELP_CONVERT"] };

      --insert the result
      table.insert(self.items,item);

    elseif _G.IsInGroup() then

      --base text
      searchableText = convertToken .. ": " .. L["SOCIAL_CONVERT_TO_RAID"];

      --add the text and function
      item = { text = searchableText , func = _G.ConvertToRaid, help=L["SOCIAL_HELP_CONVERT"] };

      --insert the result
      table.insert(self.items,item);

    end

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing social data");

  --return social
  if self.Profile.returnWhispers or self.Profile.returnInvite then
    self:PopulateFriends();
    self:PopulateBNetFriends();
  end

  if self.Profile.returnConvert then
    self:PopulateConvert();
  end

  debug("data refreshed");

end
