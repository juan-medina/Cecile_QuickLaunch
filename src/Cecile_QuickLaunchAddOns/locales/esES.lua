----------------------------------------------------------------------------------------------------
-- localized Spanish (addons config module) strings
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

--addons config module
L["ADDONS_CONFIG_ITEM"] = "Configuración AddOn"
L["ADDONS_MODULE"] = "Configuraciónes de AddOns"
L["ADDONS_RETURN_SUBSET"] = "Devolver subconjuntos"
L["ADDONS_RETURN_SUBSET_DESC"] = "Activa/Desactiva devolver subconjuntos de configuracion"
L["ADDONS_HELP_ITEM"] = "Pulsa %s para la Configuración,\n %s para cancelar."