----------------------------------------------------------------------------------------------------
-- localized English (addons config module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--addons config module
L["ADDONS_CONFIG_ITEM"] = "AddOn Config"
L["ADDONS_MODULE"] = "AddOns Config"
L["ADDONS_RETURN_SUBSET"] = "Return Subsets"
L["ADDONS_RETURN_SUBSET_DESC"] = "Enable/Disable returning subsets configuration items"