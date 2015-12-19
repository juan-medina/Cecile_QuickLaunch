----------------------------------------------------------------------------------------------------
-- localized English (version module) strings
--

--get the add-on engine
local AddOnName, Engine = ...;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true);
if not L then return; end

--version module
L["WRONG_VERSION"] = "%s - A new version (|cff0070de%s|r) for this add-on its available, please update your version."
L["PLAYER_VERSION"] = "%s - Player %s has a outdated version (|cff0070de%s|r) for this add-on."