----------------------------------------------------------------------------------------------------
-- localized Spanish (Toys module) strings
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

--Toys module
L["TOYS"] = "Juguetes"
L["TOYS_MODULE"] = "Juguetes"
L["TOYS_TOKEN"] = "Etiqueta de Juguetes"
L["TOYS_TOKEN_DESC"] = "Cambia la etiqueta de Juguetes"
L["TOYS_FAVORITE"] = "favorito"
L["TOYS_RETURN_FAVORITES"] = "Devolver Favoritos"
L["TOYS_RETURN_FAVORITES_DESC"] = "Activar/Desactivar devolver juguetes favoritos"
L["TOYS_RETURN_NO_FAVORITES"] = "Return No Favoritos"
L["TOYS_RETURN_NO_FAVORITES_DESC"] = "Activar/Desactivar devolver juguetes no favoritos"
L["TOYS_FAVORITE_TAG"] = "Etiqueta Favoritos"
L["TOYS_FAVORITE_TAG_DESC"] = "Cambia la etiqueta para los juguetes favoritos"
L["TOYS_HELP_ITEM"] = "Pulsa %s para usar,\n %s para cancelar."