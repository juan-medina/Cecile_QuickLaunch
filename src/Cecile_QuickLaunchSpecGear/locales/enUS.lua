----------------------------------------------------------------------------------------------------
-- localized English (specgear module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--specgear module
L["SPECGEAR_MODULE"] = "Specialization and Gear Sets"
L["SPECGEAR_SPEC"] = "Specialization"
L["SPECGEAR_RETURN_SPECS"] = "Return Specializations"
L["SPECGEAR_RETURN_SPECS_DESC"] = "Return class specializations"
L["SPECGEAR_ACTIVE"] = "active"
L["SPECGEAR_INACTIVE"] = "inactive"
L["SPECGEAR_AUTO_EQUIP_SET"] = "Auto equip set"
L["SPECGEAR_AUTO_EQUIP_SET_DESC"] = "When choosing a specialization auto equip the equipment set that has the same name as the specialization"
L["SPECGEAR_TOKEN_SPEC"] = "Specialization token"
L["SPECGEAR_TOKEN_SPEC_DESC"] = "Change the specialization token"
L["SPECGEAR_ACTIVE_TAG"] = "Active Tag"
L["SPECGEAR_ACTIVE_TAG_DESC"] = "Change the active specialization tag"
L["SPECGEAR_INACTIVE_TAG"] = "Inactive Tag"
L["SPECGEAR_INACTIVE_TAG_DESC"] = "Change the inactive specialization tag"
L["SPECGEAR_RETURN_SETS"] = "Return Sets"
L["SPECGEAR_RETURN_SETS_DESC"] = "Return equipments sets"
L["SPECGEAR_SET"] = "Equipment Set"
L["SPECGEAR_TOKEN_SET"] = "Equipment Set Token"
L["SPECGEAR_TOKEN_SET_DESC"] = "Change the equipment set token"
L["SPECGEAR_EQUIPPED"] = "equipped"
L["SPECGEAR_EQUPPED_TAG"] = "Equipped tag"
L["SPECGEAR_EQUIPPED_TAG_DESC"] = "Change the equipped tag"
L["SPECGEAR_UNEQUIPPED"] = "unequipped"
L["SPECGEAR_UNEQUPPED_TAG"] = "Unequipped tag"
L["SPECGEAR_UNEQUIPPED_TAG_DESC"] = "Change the unequipped tag"