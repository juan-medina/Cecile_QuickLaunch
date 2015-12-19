----------------------------------------------------------------------------------------------------
-- localized Spanish (debug module) strings
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

--debug module
L["DEV_SETTINGS"] = "Depuración"
L["DEBUGGING"] = "Activar Depuración"
L["DEBUGGING_DESC"] = "Activa la depuración del AddOn y muestra la ventana de depuración."
L["DEBUG_WINDOW_HELP"] = "Rueda de ratón para desplazarse (pulsar shift para principio/fin). Click titulo mover y esquina inferior derecha para tamaño."
