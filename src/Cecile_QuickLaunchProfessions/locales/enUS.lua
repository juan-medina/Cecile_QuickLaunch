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

