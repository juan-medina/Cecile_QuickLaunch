----------------------------------------------------------------------------------------------------
-- localized English ({{name}} module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--Items module
L["{{upper name}}"] = "{{name}}"
L["{{upper name}}_MODULE"] = "{{name}}"
L["{{upper name}}_TOKEN"] = "{{name}} Token"
L["{{upper name}}TOKEN_DESC"] = "Change the {{name}} Token"

