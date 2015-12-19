----------------------------------------------------------------------------------------------------
-- localized Spanish (pets module) strings
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

--pets module
L["PETS_PET"] = "Mascota"
L["PETS_FAVORITE"] = "favorita"
L["PETS_DISMISS"] = "Retirar"
L["PETS_RANDOM"] = "Aleatoria"
L["PETS_MODULE"] = "Mascotas"
L["PETS_RETURN_FAVORITES"] = "Devolver Favoritas"
L["PETS_RETURN_FAVORITES_DESC"] = "Activar/Desactivar devolver mascotas favoritas"
L["PETS_RETURN_NO_FAVORITES"] = "Devolver No Favoritas"
L["PETS_RETURN_NO_FAVORITES_DESC"] = "Activar/Desactivar devolver mascotas no favoritas"
L["PETS_FAVORITE_TAG"] = "Etiqueta Favoritos"
L["PETS_FAVORITE_TAG_DESC"] = "Cambia la etiqueta para las mascotas favoritas"
