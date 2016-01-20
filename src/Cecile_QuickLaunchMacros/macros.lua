----------------------------------------------------------------------------------------------------
-- search Macros module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("macros");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["MACROS_MODULE"];

--module vars
mod.Vars = {
  token =  {
    type = "string",
    default = L["MACROS_NAME"],
    order = 1,
    label = L["MACROS_TOKEN"],
    desc = L["MACROS_TOKEN_DESC"],
  },
};

--set the macro tooltip
function mod.setTooltip(tooltip,item)
  local name, link = _G.GetMacroItem(item.id);

  if name then
    local itemString = string.match(link, "item[%-?%d:]+");
    tooltip:SetHyperlink(itemString);
  else
    local spellName, _, spellID = _G.GetMacroSpell(item.id);

    if spellName then
      tooltip:SetSpellByID(spellID);
    else
      tooltip:AddLine(item.name or item.text);
      tooltip:Show();
    end

  end
end

--populate
function mod:PopulateMacros()

  --options
  local token = mod.Profile.token;
  local searchableText,item;
  local name, icon, _;

  local maxMacroButtons = _G.MAX_ACCOUNT_MACROS + _G.MAX_CHARACTER_MACROS;
  for index=1, maxMacroButtons do

    name, icon, _ = _G.GetMacroInfo(index);

    if name then
      --base text
      searchableText = token .. ": ";

      --complete the text
      searchableText = searchableText .. name;

      --add the text and function
      item = { text = searchableText, icon = icon, id = index, type = "macro", help = L["MACROS_HELP_ITEM"], tooltipFunc = mod.setTooltip };

      --insert the result
      table.insert(self.items,item);

    end

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing Macros data");

  --populate data
  self:PopulateMacros();

  debug("data refreshed");

end