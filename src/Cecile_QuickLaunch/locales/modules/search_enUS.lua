----------------------------------------------------------------------------------------------------
-- localized English (search module) strings
--

--get the add-on engine
local AddOnName = ...;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true);
if not L then return; end

--search module
L["SEARCH_NAME"] = "Search"
L["SEARCH_ENABLE_MODULE"] = "Enabled"
L["SEARCH_ENABLE_MODULE_DESC"] = "Enable/Disable this module"
L["SEARCH_ALIASES"] = "Aliases"
L["SEARCH_ALIASES_DESC"] = "Choose and alias"
L["SEARCH_ALIAS_NAME"] = "Alias Name"
L["SEARCH_ALIAS_VALUE"] = "Alias Value"
L["SEARCH_ALIAS_SAVE"] = "Save"
L["SEARCH_ALIAS_SAVE_DESC"] = "Save the alias"
L["SEARCH_ALIAS_NEW"] = "New"
L["SEARCH_ALIAS_NEW_DESC"] = "New alias"
L["SEARCH_ALIAS_DELETE"] = "Delete"
L["SEARCH_ALIAS_DELETE_DESC"] = "Delete the alias"
L["SEARCH_TOKEN"] = "Search Token"
L["SEARCH_TOKEN_DESC"] = "Change the search returned token"
L["SEARCH_BLACKLIST"] = "Blacklist"
L["SEARCH_BLACKLIST_DESC"] = "Choose a blacklist"
L["SEARCH_BLACKLIST_NAME"] = "Blacklist Name"
L["SEARCH_BLACKLIST_VALUE"] = "Blacklist Value"
L["SEARCH_BLACKLIST_SAVE"] = "Save"
L["SEARCH_BLACKLIST_SAVE_DESC"] = "Save the blacklist item"
L["SEARCH_BLACKLIST_NEW"] = "New"
L["SEARCH_BLACKLIST_NEW_DESC"] = "New blacklist item"
L["SEARCH_BLACKLIST_DELETE"] = "Delete"
L["SEARCH_BLACKLIST_DELETE_DESC"] = "Delete the blacklist item"
L["SEARCH_ALIAS_HELP"] = [[

Aliases works like substitutions, whenever you do a search it will replace each occurrence of the alias name with the alias value.

]]
L["SEARCH_BLACKIST_HELP"] = [[

Blacklist is like a negative search, whenever you type a search all items that are returned by any blacklist value will be discarded from the result.

]]
L["SEARCH_MODULES"] = "Modules"
L["SEARCH_TWO_STEPS"] = "Two steps"
L["SEARCH_TWO_STEPS_DESC"] = "Change search to be a 'two steps', first module, them the items for that module"
L["SEARCH_GENERAL"] = "General"
L["SEARCH_TWO_STEPS_HELP"] = [[

When 'two steps' search is enabled after using the binding you will search in the list of availables modules, them after selecting a module you will search on the items only of that module.

]]
L["SEARCH_MODULE_UP"] = "Move Up"
L["SEARCH_MODULE_UP_DESC"] = "Move this module UP in the list of modules"
L["SEARCH_MODULE_DOWN"] = "Move Down"
L["SEARCH_MODULE_DOWN_DESC"] = "Move this module DOWN in the list of modules"