----------------------------------------------------------------------------------------------------
-- localized English (pets module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--pets module
L["PETS_PET"] = "Pet"
L["PETS_FAVORITE"] = "favorite"
L["PETS_DISMISS"] = "Dismiss"
L["PETS_RANDOM"] = "Random"
L["PETS_MODULE"] = "Pets"
L["PETS_RETURN_FAVORITES"] = "Return Favorites"
L["PETS_RETURN_FAVORITES_DESC"] = "Enable/Disable returning favorites pets"
L["PETS_RETURN_NO_FAVORITES"] = "Return No Favorites"
L["PETS_RETURN_NO_FAVORITES_DESC"] = "Enable/Disable returning no favorites pets"
L["PETS_FAVORITE_TAG"] = "Favorite Tag"
L["PETS_FAVORITE_TAG_DESC"] = "Change the favorite pets tag"
L["PETS_HELP_ITEM"] = "Press %s to summon,\n %s to cancel."
L["PETS_HELP_ITEM_DISMISS"] = "Press %s to dismiss,\n %s to cancel."
