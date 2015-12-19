----------------------------------------------------------------------------------------------------
-- localized Spanish (Spells module) strings
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

--Spells module
L["SPELLS"] = "Echizo"
L["SPELLS_MODULE"] = "Echizos"
L["SPELLS_TOKEN"] = "Etiqueta Echizos"
L["SPELLS_TOKEN_DESC"] = "Cambia la etiqueta de Echizos"
