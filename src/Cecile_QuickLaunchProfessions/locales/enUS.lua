----------------------------------------------------------------------------------------------------
-- localized English (Professions module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--Items module
L["PROFESSIONS_MODULE"] = "Professions"
L["PROFESSIONS_OPEN"] = "Open"
L["PROFESSIONS_OPEN_TOKEN"] = "Open Tag"
L["PROFESSIONS_OPEN_TOKEN_DESC"] = "Change the open profession tag"
L["PROFESSIONS_HELP_ITEM"] = "Press %s to cast,\n %s to cancel."
