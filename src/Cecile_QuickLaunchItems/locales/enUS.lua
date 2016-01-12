----------------------------------------------------------------------------------------------------
-- localized English (Items module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--Items module
L["ITEMS"] = "Item"
L["ITEMS_MODULE"] = "Items"
L["ITEMS_TOKEN"] = "Items Token"
L["ITEMS_TOKEN_DESC"] = "Change the Items Token"
L["ITEMS_EQUIPPED"] = "equipped"
L["ITEMS_EQUIPPED_TOKEN"] = "Equipped Tag"
L["ITEMS_EQUIPPED_TOKEN_DESC"] = "Change the equipped tag"
L["ITEMS_BAGS"] = "bags"
L["ITEMS_BAGS_TOKEN"] = "Bags Tag"
L["ITEMS_BAGS_TOKEN_DESC"] = "Change the bags tag"
L["ITEMS_RETURN_EQUIPPED"] = "Return Equipped"
L["ITEMS_RETURN_EQUIPPED_DESC"] = "Enable/Disable returning equipped items"
L["ITEMS_RETURN_BAGS"] = "Return Bags"
L["ITEMS_RETURN_BAGS_DESC"] = "Enable/Disable returning bags items"
L["ITEM_HELP_ITEM"] = "Press %s to use,\n %s to cancel."
L["ITEM_HELP_ITEM_EQUIPP"] = "Press %s to equipp,\n %s to cancel."