----------------------------------------------------------------------------------------------------
-- search mounts module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("mounts");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["MOUNTS_MODULE"];

--module vars
mod.Vars = {
  favorites =  {
    type = "boolean",
    default = true,
    order = 1,
    label = L["MOUNT_RETURN_FAVORITES"],
    desc = L["MOUNT_RETURN_FAVORITES_DESC"]
  },
  noFavorites =  {
    type = "boolean",
    default = true,
    order = 2,
    label = L["MOUNT_RETURN_NO_FAVORITES"],
    desc = L["MOUNT_RETURN_NO_FAVORITES_DESC"]
  },
  token =  {
    type = "string",
    default = L["MOUNTS_MOUNT"],
    order = 3,
    label = L["SEARCH_TOKEN"],
    desc = L["SEARCH_TOKEN_DESC"]
  },
  favoriteTag =  {
    type = "string",
    default = L["MOUNT_FAVORITE"],
    order = 4,
    label = L["MOUNT_FAVORITE_TAG"],
    desc = L["MOUNT_FAVORITE_TAG_DESC"]
  },
};

--summon a mount
function mod.summonMount(item)

  --summon the mount
  _G.C_MountJournal.Summon(item.id);

end

--dismount
function mod.dismmissMount()

  --dismount
  _G.C_MountJournal.Dismiss();

end

--set the mount tooltip
function mod.setTooltip(tooltip,item)

  local _,spellID = _G.C_MountJournal.GetMountInfo(item.id);

  tooltip:SetMountBySpellID(spellID);

end

--create the list of mounts
function mod:PopulateMounts()

  --options
  local token = mod.Profile.token;
  local favorites = mod.Profile.favorites;
  local noFavorites = mod.Profile.noFavorites;
  local favoriteTag = mod.Profile.favoriteTag;

  --get max num of mounts
  local numMounts = _G.C_MountJournal.GetNumMounts();

  --to format the text
  local searchableText, item;

  --we are not mounted
  local mounted = false;

  --loop mounts
  for index = 1, numMounts do

    --get the mount details
    local creatureName, _, icon, active, isUsable, _, isFavorite, _, _, _, isCollected = _G.C_MountJournal.GetMountInfo(index);

    --if its usable (faction, profesion, etc) and we have it
    if isUsable and isCollected then

      --if its active we are mounted
      if active then
        mounted = true;
      end

      searchableText = nil;

      if isFavorite and favorites then

        searchableText = token .. ": " .. creatureName .. " (".. favoriteTag .. ")";

      elseif not(isFavorite) and noFavorites then

        searchableText = token .. ": " .. creatureName;

      end

      if searchableText then

        --set our function and text
        item = { name = creatureName, text = searchableText , id=index, func = mod.summonMount, icon = icon, tooltipFunc = mod.setTooltip, help = L["MOUNT_HELP_ITEM"]};

        --add the item
        table.insert(self.items,item);

      end

    end

  end

  --add on top a search for random mount
  searchableText = token .. ": " .. L["MOUNT_RANDOM"] .. " (".. favoriteTag .. ")";
  item = { name = searchableText, text = searchableText , id=0, func = mod.summonMount, icon = "Interface\\Icons\\INV_Misc_QuestionMark", help = L["MOUNT_HELP_ITEM"]};
  table.insert(mod.items,1,item);

  --if we are mounted add a search text for dismount on top
  if mounted then
    searchableText = token .. ": " .. L["MOUNT_DISMOUNT"];
    item = { name = searchableText, text = searchableText , id=0, func = mod.dismmissMount, help = L["MOUNT_HELP_ITEM_DISMOUNT"]};
    table.insert(mod.items,1,item);
  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing mount data");

  --populate the mounts
  self:PopulateMounts();

  debug("data refreshed");

end
