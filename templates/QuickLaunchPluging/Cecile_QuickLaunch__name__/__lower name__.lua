----------------------------------------------------------------------------------------------------
-- search {{name}} module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("{{lower name}}");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["{{upper name}}_MODULE"];

--module vars
mod.Vars = {
  token =  {
    type = "string",
    default = L["{{upper name}}_NAME"],
    order = 1,
    label = L["{{upper name}}_TOKEN"],
    desc = L["{{upper name}}_TOKEN_DESC"],
  },
};

--dummy
function mod.dummy(item)

  print(item.id)

end

--populate
function mod:Populate{{name}}()

  --options
  local token = mod.Profile.token;
  local searchableText,item;

  for index = 1, 10 do

    --base text
    searchableText = token .. ": ";

    --complete the text
    searchableText = searchableText .. index;

    --add the text and function
    item = { text = searchableText , id=index, func = mod.dummy};

    --insert the result
    table.insert(self.items,item);

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing {{name}} data");

  --populate data
  self:Populate{{name}}();

  debug("data refreshed");

end