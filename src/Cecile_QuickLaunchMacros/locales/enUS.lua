----------------------------------------------------------------------------------------------------
-- localized English (Macros module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--Items module
L["MACROS"] = "Macros"
L["MACROS_NAME"] = "Macro"
L["MACROS_MODULE"] = "Macros"
L["MACROS_TOKEN"] = "Macros Token"
L["MACROS_TOKEN_DESC"] = "Change the Macros Token"
L["MACROS_HELP_ITEM"] = "Press %s to use,\n %s to cancel."
