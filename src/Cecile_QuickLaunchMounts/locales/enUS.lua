----------------------------------------------------------------------------------------------------
-- localized English (mounts module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--mounts module
L["MOUNTS_MOUNT"] = "Mount"
L["MOUNT_FAVORITE"] = "favorite"
L["MOUNT_DISMOUNT"] = "Dismount"
L["MOUNT_RANDOM"] = "Random"
L["MOUNTS_MODULE"] = "Mounts"
L["MOUNT_RETURN_FAVORITES"] = "Return Favorites"
L["MOUNT_RETURN_FAVORITES_DESC"] = "Enable/Disable returning favorites mounts"
L["MOUNT_RETURN_NO_FAVORITES"] = "Return No Favorites"
L["MOUNT_RETURN_NO_FAVORITES_DESC"] = "Enable/Disable returning no favorites mounts"
L["MOUNT_FAVORITE_TAG"] = "Favorite Tag"
L["MOUNT_FAVORITE_TAG_DESC"] = "Change the favorite mounts tag"
L["MOUNT_HELP_ITEM"] = "Press %s to summon,\n %s to cancel."
L["MOUNT_HELP_ITEM_DISMOUNT"] = "Press %s to dismount,\n %s to cancel."