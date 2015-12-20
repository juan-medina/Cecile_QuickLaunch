----------------------------------------------------------------------------------------------------
-- localized Spanish ((Professions module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--Spanish or Latin America Spanish
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "esES")
if not L then
  L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "esMX");
  if not L then
    return;
  end
end

--Professions module
L["PROFESSIONS_MODULE"] = "Profesionses"
L["PROFESSIONS_OPEN"] = "Abrir"
L["PROFESSIONS_OPEN_TOKEN"] = "Etiqueta Abrir"
L["PROFESSIONS_OPEN_TOKEN_DESC"] = "Cambia la etiqueta par abrir la profesión"


