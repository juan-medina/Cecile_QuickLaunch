----------------------------------------------------------------------------------------------------
-- localized Spanish (achievements module) strings
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

--achievements module
L["ACHIEVEMENTS_MODULE"] = "Logros"
L["ACHIEVEMENTS_ACHIEVEMENT"] = "Logro"
L["ACHIEVEMENTS_COMPLETED"] = "completado"
L["ACHIEVEMENTS_UNCOMPLETED"] = "sin completar"
L["ACHIEVEMENTS_RETURN_COMPLETED"] = "Devolver Completados"
L["ACHIEVEMENTS_RETURN_COMPLETED_DESC"] = "Activar/Desactivar devolver logros completados"
L["ACHIEVEMENTS_RETURN_UNCOMPLETED"] = "Devolver Sin Completar"
L["ACHIEVEMENTS_RETURN_UNCOMPLETED_DESC"] = "Activar/Desactivar devolver logros no completados"
L["ACHIEVEMENTS_RETURN_CATEGORY"] = "Devolver Categoria"
L["ACHIEVEMENTS_RETURN_CATEGORY_DESC"] = "Activar/Desactivar devolver la categoria de los logros"
L["ACHIEVEMENTS_COMPLETED_TAG"] = "Etiqueta Completados"
L["ACHIEVEMENTS_COMPLETED_TAG_DESC"] = "Cambia la etiqueta para los logros completados"
L["ACHIEVEMENTS_UNCOMPLETED_TAG"] = "Etiqueta No Completados"
L["ACHIEVEMENTS_UNCOMPLETED_TAG_DESC"] = "Cambia la etiqueta para los logros no completados"