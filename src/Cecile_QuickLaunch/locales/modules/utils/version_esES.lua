----------------------------------------------------------------------------------------------------
-- localized Spanish (version module) strings
--

--get the add-on engine
local AddOnName, Engine = ...;

--Spanish or Latin America Spanish
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esES")
if not L then
	L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esMX");
	if not L then
		return;
	end
end

--version module
L["WRONG_VERSION"] = "%s - Una nueva versión (|cff0070de%s|r) de este add-on esta disponible, por favor actualice su versión."
L["PLAYER_VERSION"] = "%s - El jugador %s tiene una versión (|cff0070de%s|r) del add-on desactualizada."
