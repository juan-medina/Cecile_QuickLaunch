----------------------------------------------------------------------------------------------------
-- search specgear module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("specgear");

--version
local Version = Engine.AddOn:GetModule("version");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["SPECGEAR_MODULE"];

--module vars
mod.Vars = {
  returnSpecs =  {
    type = "boolean",
    default = true,
    order = 1,
    label = L["SPECGEAR_RETURN_SPECS"],
    desc = L["SPECGEAR_RETURN_SPECS_DESC"]
  },
  tokenSpec =  {
    type = "string",
    default = L["SPECGEAR_SPEC"],
    order = 2,
    label = L["SPECGEAR_TOKEN_SPEC"],
    desc = L["SPECGEAR_TOKEN_SPEC_DESC"]
  },
  activeTag =  {
    type = "string",
    default = L["SPECGEAR_ACTIVE"],
    order = 3,
    label = L["SPECGEAR_ACTIVE_TAG"],
    desc = L["SPECGEAR_ACTIVE_TAG_DESC"]
  },
  inactiveTag =  {
    type = "string",
    default = L["SPECGEAR_INACTIVE"],
    order = 4,
    label = L["SPECGEAR_INACTIVE_TAG"],
    desc = L["SPECGEAR_INACTIVE_TAG_DESC"]
  },
  autoEquipSet =  {
    type = "boolean",
    default = true,
    order = 5,
    label = L["SPECGEAR_AUTO_EQUIP_SET"],
    desc = L["SPECGEAR_AUTO_EQUIP_SET_DESC"]
  },
  returnSets =  {
    type = "boolean",
    default = true,
    order = 6,
    label = L["SPECGEAR_RETURN_SETS"],
    desc = L["SPECGEAR_RETURN_SETS_DESC"]
  },
  tokenSet =  {
    type = "string",
    default = L["SPECGEAR_SET"],
    order = 7,
    label = L["SPECGEAR_TOKEN_SET"],
    desc = L["SPECGEAR_TOKEN_SET_DESC"]
  },
  equippedTag =  {
    type = "string",
    default = L["SPECGEAR_EQUIPPED"],
    order = 8,
    label = L["SPECGEAR_EQUPPED_TAG"],
    desc = L["SPECGEAR_EQUIPPED_TAG_DESC"]
  },
  umequippedTag =  {
    type = "string",
    default = L["SPECGEAR_UNEQUIPPED"],
    order = 9,
    label = L["SPECGEAR_UNEQUPPED_TAG"],
    desc = L["SPECGEAR_UNEQUIPPED_TAG_DESC"]
  },
};

--set the set tooltip
function mod.setTooltip(tooltip,item)

  tooltip:SetEquipmentSet(item.id);

end

--set the sepc tooltip
function mod.specTooltip(tooltip,item)

  local description = select(3,_G.GetSpecializationInfo(_G.GetSpecialization(false, false, item.id)));

  tooltip:AddLine(item.name, _G.HIGHLIGHT_FONT_COLOR.r, _G.HIGHLIGHT_FONT_COLOR.g, _G.HIGHLIGHT_FONT_COLOR.b);
  tooltip:AddLine(description);
  tooltip:Show();

end

function mod.PlayerSpecChange(_,unit)

  if unit=="player" then

    --if we need to auto equip the gear set
    if mod.Profile.autoEquipSet then

      --create a new item with the name of the specialization
      local name,activeIndex;

      activeIndex = _G.GetSpecialization();
      name = select(2,_G.GetSpecializationInfo(activeIndex));

      local itemSet = { id = name } ;

      --equip the set
      mod.EquippSet(itemSet);

    end

  end

end

function mod:OnInitialize()
  search.preInitialize(mod);
  Engine.AddOn:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED",self.PlayerSpecChange);
end

--equip a set
function mod.EquippSet(item)

  --loop the sets
  for i = 1, _G.GetNumEquipmentSets() do

    --get the set name and if is equipped
    local name, _, _, equipped, _, _, _, _, _ = _G.GetEquipmentSetInfo(i);

    --if the set is named as what we are searching
    if item.id == name then

      --if not equipped, just equip it
      if not equipped then
        _G.UseEquipmentSet(name);
      end

      --all done
      return;

    end

  end
end

--switch spec
function mod.SpecSwitch(item)

  --set the spec
  _G.SetSpecialization(item.id);

end

function mod:PopulateSpecs()

  --options
  local tokenSpec = mod.Profile.tokenSpec;
  local activeTag = mod.Profile.activeTag;
  local inactiveTag = mod.Profile.inactiveTag;
  local activeIndex = _G.GetSpecialization();
  local active;
  local searchableText;
  local item;
  local shortName;

  for index = 1, _G.GetNumSpecializations() do

    local _, name, _, icon  = _G.GetSpecializationInfo(index);

      --its this the active spec?
      active = (index == activeIndex and true or false);

      --base text
      searchableText = tokenSpec .. ": ";

      --complete the text
      searchableText = searchableText .. name .. " (" .. (active and activeTag or inactiveTag) .. ")";

      shortName = tokenSpec .. ": " .. name;

      --add the text and function
      item = { name = shortName, text = searchableText , id=index, func = mod.SpecSwitch, icon=icon, help = L["SPECGEAR_HELP_SPEC"], tooltipFunc = mod.specTooltip };

      --insert the result
      table.insert(self.items,item);

  end
end

--populate equippement sets
function mod:PopulateSets()

  --options
  local tokenSet = mod.Profile.tokenSet;
  local equippedTag = mod.Profile.equippedTag;
  local umequippedTag = mod.Profile.umequippedTag;
  local item, searchableText;
  local shortName;

  for index = 1, _G.GetNumEquipmentSets() do

    --get the set name, icon and if is equipped
    local name, icon, _, equipped, _, _, _, _, _ = _G.GetEquipmentSetInfo(index);

    --base text
    searchableText = tokenSet .. ": ";

    --complete the text
    searchableText = searchableText .. name .. " (" .. (equipped and equippedTag or umequippedTag) .. ")";

    shortName = tokenSet .. ": " .. name;

    --add the text and function
    item = { name = shortName , text = searchableText , id=name, func = mod.EquippSet, icon=icon, help = L["SPECGEAR_HELP_SET"], tooltipFunc = mod.setTooltip };

    --insert the result
    table.insert(self.items,item);

  end

end



--refresh the data
function mod:Refresh()

  debug("refreshing specs & gear data");

  --return specializations
  if self.Profile.returnSpecs then
      self:PopulateSpecs();
  end

  --return sets
  if self.Profile.returnSets then
    self:PopulateSets();
  end

  debug("data refreshed");

end
