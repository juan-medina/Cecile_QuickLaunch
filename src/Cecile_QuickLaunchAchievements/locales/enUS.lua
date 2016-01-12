----------------------------------------------------------------------------------------------------
-- localized English (achievements module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--pets module
L["ACHIEVEMENTS_MODULE"] = "Achievements"
L["ACHIEVEMENTS_ACHIEVEMENT"] = "Achievement"
L["ACHIEVEMENTS_COMPLETED"] = "completed"
L["ACHIEVEMENTS_UNCOMPLETED"] = "uncompleted"
L["ACHIEVEMENTS_RETURN_COMPLETED"] = "Return Completed"
L["ACHIEVEMENTS_RETURN_COMPLETED_DESC"] = "Enable/Disable returning completed achievements"
L["ACHIEVEMENTS_RETURN_UNCOMPLETED"] = "Return Uncompleted"
L["ACHIEVEMENTS_RETURN_UNCOMPLETED_DESC"] = "Enable/Disable returning uncompleted achievements"
L["ACHIEVEMENTS_RETURN_CATEGORY"] = "Return Category"
L["ACHIEVEMENTS_RETURN_CATEGORY_DESC"] = "Enable/Disable returning achievement category"
L["ACHIEVEMENTS_COMPLETED_TAG"] = "Completed Tag"
L["ACHIEVEMENTS_COMPLETED_TAG_DESC"] = "Change the completed achievement tag"
L["ACHIEVEMENTS_UNCOMPLETED_TAG"] = "Uncompleted Tag"
L["ACHIEVEMENTS_UNCOMPLETED_TAG_DESC"] = "Change the uncompleted achievement tag"
L["ACHIEVEMENTS_HELP_ITEM"] = "Press %s to open the achievement,\n %s to cancel."