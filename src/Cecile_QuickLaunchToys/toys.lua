----------------------------------------------------------------------------------------------------
-- search toys module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("toys");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["TOYS_MODULE"];

--module vars
mod.Vars = {
  favorites =  {
    type = "boolean",
    default = true,
    order = 1,
    label = L["TOYS_RETURN_FAVORITES"],
    desc = L["TOYS_RETURN_FAVORITES_DESC"]
  },
  noFavorites =  {
    type = "boolean",
    default = true,
    order = 2,
    label = L["TOYS_RETURN_NO_FAVORITES"],
    desc = L["TOYS_RETURN_NO_FAVORITES_DESC"]
  },
  token =  {
    type = "string",
    default = L["TOYS"],
    order = 1,
    label = L["TOYS_TOKEN"],
    desc = L["TOYS_TOKEN_DESC"],
  },
  favoriteTag =  {
    type = "string",
    default = L["TOYS_FAVORITE"],
    order = 4,
    label = L["TOYS_FAVORITE_TAG"],
    desc = L["TOYS_FAVORITE_TAG_DESC"]
  },
};

--populate
function mod:Populate()

  --options
  local token = mod.Profile.token;
  local favorites = mod.Profile.favorites;
  local noFavorites = mod.Profile.noFavorites;
  local favoriteTag = mod.Profile.favoriteTag;

  --get number of toys
  _G.C_ToyBox.FilterToys();
  local numToys = _G.C_ToyBox.GetNumToys();

  --local vars
  local idx,toyID, name, icon, start, duration, remain;
  local item, searchableText, isFavorite;

  for index = 1, numToys do

    idx = _G.C_ToyBox.GetToyFromIndex(index);
    toyID, name, icon, isFavorite = _G.C_ToyBox.GetToyInfo(idx);

    if name ~= nil and toyID ~= nil then
      if _G.PlayerHasToy(toyID) then

        searchableText = nil;

        if isFavorite and favorites then

          searchableText = token .. ": " .. name .. " (".. favoriteTag .. ")";

        elseif not(isFavorite) and noFavorites then

          searchableText = token .. ": " .. name;

        end

        if searchableText then

          --get the cooldown
          start, duration = _G.GetItemCooldown(toyID);

          if start>0 then
            remain = duration - (_G.GetTime() - start);
            searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
          end

          --add the text and function
          item = { text = searchableText , id=toyID, type = "item", icon = icon};

          --insert the result
          table.insert(self.items,item);

        end


      end

    end

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing toys data");

  --populate data
  self:Populate();

  debug("data refreshed");

end