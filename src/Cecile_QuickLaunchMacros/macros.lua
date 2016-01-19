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

--dummy
function mod.dummy(item)

  print(item.id)

end

--populate
function mod:PopulateMacros()

  --options
  local token = mod.Profile.token;
  local searchableText,item;

  for index = 1, 10 do

    --base text
    searchableText = token .. ": ";

    --complete the text
    searchableText = searchableText .. index;

    --add the text and function
    item = { text = searchableText , id=index, func = mod.dummy, help = L["MACROS_HELP_ITEM"]};

    --insert the result
    table.insert(self.items,item);

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing Macros data");

  --populate data
  self:PopulateMacros();

  debug("data refreshed");

end