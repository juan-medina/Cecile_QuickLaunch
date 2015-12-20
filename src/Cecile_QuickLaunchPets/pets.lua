----------------------------------------------------------------------------------------------------
-- search pets module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("pets");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["PETS_MODULE"];

--module vars
mod.Vars = {
  favorites =  {
    type = "boolean",
    default = true,
    order = 1,
    label = L["PETS_RETURN_FAVORITES"],
    desc = L["PETS_RETURN_FAVORITES_DESC"]
  },
  noFavorites =  {
    type = "boolean",
    default = true,
    order = 2,
    label = L["PETS_RETURN_NO_FAVORITES"],
    desc = L["PETS_RETURN_NO_FAVORITES_DESC"]
  },
  token =  {
    type = "string",
    default = L["PETS_PET"],
    order = 3,
    label = L["SEARCH_TOKEN"],
    desc = L["SEARCH_TOKEN_DESC"]
  },
  favoriteTag =  {
    type = "string",
    default = L["PETS_FAVORITE"],
    order = 4,
    label = L["PETS_FAVORITE_TAG"],
    desc = L["PETS_FAVORITE_TAG_DESC"]
  },
};

--summon a pet if id==0 its random
function mod.summonPet(item)

  --check if its summon normal o random (favorite)
  if(item.id==0) then
    _G.C_PetJournal.SummonRandomPet(false);
  else
    _G.C_PetJournal.SummonPetByGUID(item.id);
  end

end

--populate the list
function mod:PopulatePets()

  --lcoal vars
  local item,creatureName;

  --options
  local token = mod.Profile.token;
  local favorites = mod.Profile.favorites;
  local noFavorites = mod.Profile.noFavorites;
  local favoriteTag = mod.Profile.favoriteTag;

  --get number of pets
  local numPets = _G.C_PetJournal.GetNumPets();

  --for formating the text
  local searchableText;

  --loop the pets
  for index = 1, numPets do
    local petID, _, owned, customName, _, isFavorite, _, speciesName, icon = _G.C_PetJournal.GetPetInfoByIndex(index)

    --if we own the pet
    if owned then


      searchableText = nil;

      creatureName = speciesName .. (customName and ( " [" .. customName .. "]" ) or "");

      if isFavorite and favorites then

        searchableText = token .. ": " .. creatureName .. " (".. favoriteTag .. ")";

      elseif not(isFavorite) and noFavorites then

        searchableText = token .. ": " .. creatureName;

      end

      if searchableText then

        --add the text and function
        item = { text = searchableText , id=petID, func = mod.summonPet, icon = icon ;};

        --insert the result
        table.insert(self.items,item);

      end

    end

  end

  --add a random favorite pet on top
  searchableText = token .. ": " .. L["PETS_RANDOM"] .. " (".. favoriteTag .. ")";
  item = { text = searchableText , id=0, func = mod.summonPet, icon = "Interface\\Icons\\INV_Misc_QuestionMark"; };
  table.insert(mod.items,1,item);

  --get the GUID for summoned pet
  local summonedPetGUID = _G.C_PetJournal.GetSummonedPetGUID();

  --if we have a pet sumoned create a search for dismiss
  if not (summonedPetGUID  == nil) then

    --create the text
    searchableText = token .. ": " .. L["PETS_DISMISS"];

    --set the text and function, we calling again to summon will dismm it
    item = { text = searchableText , id=summonedPetGUID, func = mod.summonPet; };
    table.insert(mod.items,1,item);

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing pet data");

  --populate the data
  self:PopulatePets();

  debug("data refreshed");

end
