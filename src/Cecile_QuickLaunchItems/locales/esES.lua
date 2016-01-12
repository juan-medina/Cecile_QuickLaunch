----------------------------------------------------------------------------------------------------
-- localized Spanish (Items module) strings
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

--Items module
L["ITEMS"] = "Objeto"
L["ITEMS_MODULE"] = "Objetos"
L["ITEMS_TOKEN"] = "Etiqueta Objetos"
L["ITEMS_TOKEN_DESC"] = "Cambia la etiqueta de Objetos"
L["ITEMS_EQUIPPED"] = "equipado"
L["ITEMS_EQUIPPED_TOKEN"] = "Etiqueta equipado"
L["ITEMS_EQUIPPED_TOKEN_DESC"] = "Cambia la etiqueta para equipado"
L["ITEMS_BAGS"] = "bolsas"
L["ITEMS_BAGS_TOKEN"] = "Etiqueta bolsas"
L["ITEMS_BAGS_TOKEN_DESC"] = "Cambia la etiqueta para bolsas"
L["ITEMS_RETURN_EQUIPPED"] = "Devolver Equipados"
L["ITEMS_RETURN_EQUIPPED_DESC"] = "Activar/Desactivar devolver objetos equipados"
L["ITEMS_RETURN_BAGS"] = "Devolver en Bolsas"
L["ITEMS_RETURN_BAGS_DESC"] = "Activar/Desactivar devolver objetos en las bolsas"
L["ITEM_HELP_ITEM"] = "Pulsa %s para usar,\n %s para cancelar."
L["ITEM_HELP_ITEM_EQUIPP"] = "Pulsa %s para equipar,\n %s para cancelar."


