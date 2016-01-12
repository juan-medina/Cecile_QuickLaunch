----------------------------------------------------------------------------------------------------
-- localized Spanish (mounts module) strings
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

--mounts module
L["MOUNTS_MOUNT"] = "Montura"
L["MOUNT_FAVORITE"] = "favorita"
L["MOUNT_DISMOUNT"] = "Desmontar"
L["MOUNT_RANDOM"] = "Aleatoria"
L["MOUNTS_MODULE"] = "Monturas"
L["MOUNT_RETURN_FAVORITES"] = "Devolver Favoritas"
L["MOUNT_RETURN_FAVORITES_DESC"] = "Activar/Desactivar devolver monturas favoritas"
L["MOUNT_RETURN_NO_FAVORITES"] = "Devolver No Favoritas"
L["MOUNT_RETURN_NO_FAVORITES_DESC"] = "Activar/Desactivar devolver monturas no favoritas"
L["MOUNT_FAVORITE_TAG"] = "Etiqueta Favoritos"
L["MOUNT_FAVORITE_TAG_DESC"] = "Cambia la etiqueta para las monturas favoritas"
L["MOUNT_HELP_ITEM"] = "Pulsa %s para invocar,\n %s para cancelar."
L["MOUNT_HELP_ITEM_DISMOUNT"] = "Pulsa %s para desmontar,\n %s para cancelar."
