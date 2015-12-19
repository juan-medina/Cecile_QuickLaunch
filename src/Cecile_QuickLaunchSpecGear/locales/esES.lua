----------------------------------------------------------------------------------------------------
-- localized Spanish (specgear module) strings
--

--get the add-on engine
local AddOnName, Engine = ...;

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

--specgear module
L["SPECGEAR_MODULE"] = "Especializaciones y Conjuntos de Equipo"
L["SPECGEAR_SPEC"] = "Especialización"
L["SPECGEAR_RETURN_SPECS"] = "Devolver Especializacipnes"
L["SPECGEAR_RETURN_SPECS_DESC"] = "Devuelve especializacipnes de clase"
L["SPECGEAR_ACTIVE"] = "activa"
L["SPECGEAR_INACTIVE"] = "inactiva"
L["SPECGEAR_AUTO_EQUIP_SET"] = "Auto equipar conjunto"
L["SPECGEAR_AUTO_EQUIP_SET_DESC"] = "Al elegir una especialización auto equipar el conjunto que tenga el mismo nombre que la especialización"
L["SPECGEAR_TOKEN_SPEC"] = "Etiqueta Especialización"
L["SPECGEAR_TOKEN_SPEC_DESC"] = "Cambia la etiqueta para especializaciones"
L["SPECGEAR_ACTIVE_TAG"] = "Etiqueta Activa"
L["SPECGEAR_ACTIVE_TAG_DESC"] = "Cambia la etiqueta para la especialización activa"
L["SPECGEAR_INACTIVE_TAG"] = "Etiqueta Inactiva"
L["SPECGEAR_INACTIVE_TAG_DESC"] = "Cambia la etiqueta para la especialización inactiva"
L["SPECGEAR_RETURN_SETS"] = "Devolver Conjuntos"
L["SPECGEAR_RETURN_SETS_DESC"] = "Devolver conjuntos de equipo"
L["SPECGEAR_SET"] = "Conjunto de equipo"
L["SPECGEAR_TOKEN_SET"] = "Etiqueta Conjuntos"
L["SPECGEAR_TOKEN_SET_DESC"] = "Cambia la etiqueta de conjuntos"
L["SPECGEAR_EQUIPPED"] = "equipado"
L["SPECGEAR_EQUPPED_TAG"] = "Etiqueta equipado"
L["SPECGEAR_EQUIPPED_TAG_DESC"] = "Cambia la etiqueta de equipados"
L["SPECGEAR_UNEQUIPPED"] = "no equipado"
L["SPECGEAR_UNEQUPPED_TAG"] = "Etiqueta no equipado"
L["SPECGEAR_UNEQUIPPED_TAG_DESC"] = "Cambia la etiqueta para no equipado"
