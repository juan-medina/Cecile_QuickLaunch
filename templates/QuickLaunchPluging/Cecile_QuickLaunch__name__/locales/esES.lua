----------------------------------------------------------------------------------------------------
-- localized Spanish (({{name}} module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--Spanish or Latin America Spanish
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "esES")
if not L then
  L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "esMX");
  if not L then
    return;
  end
end

--{{name}} module
L["{{upper name}}"] = "{{name}}"
L["{{upper name}}_MODULE"] = "{{name}}"
L["{{upper name}}_TOKEN"] = "{{name}} Token"
L["{{upper name}}TOKEN_DESC"] = "Change the {{name}} Token"

