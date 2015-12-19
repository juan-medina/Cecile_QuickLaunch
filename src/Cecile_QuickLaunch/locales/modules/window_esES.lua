----------------------------------------------------------------------------------------------------
-- localized Spanish (window module) strings
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

--window module
L["WINDOW_ERROR_IN_COMBAT"] = "%s |cffff0000:no se puede abrir en combate.|r"
L["WINDOW_SETTINGS"] = "Ventana"
L["WINDOW_BINDING_LAUNCH"] = "Tecla rápida de Abrir Ventana"
L["WINDOW_BINDING_LAUNCH_DESC"] = "Cambia la tecla rápida para abrir la ventana"
L["WINDOW_BINDING_COMMAND"] = "Tecla rápida de Ejecutar Último Comando"
L["WINDOW_BINDING_COMMAND_DESC"] = "Cambia la tecla rápida para ejecutar el último comando"
L["WINDOW_SCHEME_NEONBLUE"] = "Cecile Neón Azul"
L["WINDOW_SCHEME_SUNBURST"] = "Cecile Explosión Solar"
L["WINDOW_SCHEME_CLASSIC"] = "Clásico Negro y Gris"
L["WINDOW_SCHEME_CUSTOM"] = "Esquema Personalizado"
L["WINDOW_APPEARANCE"] = "Apariencia"
L["WINDOW_SCHEMES"] = "Esquemas de Apariencia"
L["WINDOW_SCHEMES_DESC"] = "Cambia el esquema de apariencia de la ventana"
L["WINDOW_FONT"] = "Fuente de Texto"
L["WINDOW_FONT_DESC"] = "Cambia el tipo de fuente de texto"
L["WINDOW_FONT_SIZE"] = "Tamaño del Texto"
L["WINDOW_FONT_SIZE_DESC"] = "Cambia el tamaño de la fuente de texto"
L["WINDOW_NORMAL_COLOR"] = "Color Texto Normal"
L["WINDOW_NORMAL_COLOR_DESC"] = "Cambia el color del texto normal"
L["WINDOW_HIGHLIGHT_COLOR"] = "Color Texto Resaltado"
L["WINDOW_HIGHLIGHT_COLOR_DESC"] = "Cambi el color del texto resaltado"
L["WINDOW_FRAME_COLOR"] = "Color del Marco"
L["WINDOW_FRAME_COLOR_DESC"] = "Cambia el color del marco"
L["WINDOW_BORDER_COLOR"] = "Color del Borde"
L["WINDOW_BORDER_COLOR_DESC"] = "Cambia el color del borde"
L["WINDOW_SELECTED_COLOR"] = "Color Seleccionado"
L["WINDOW_SELECTED_COLOR_DESC"] = "Cambia el color de los elementos seleccionados"
L["WINDOW_HELP_ITEM"] = "Pulsa %s para usar,\n %s para cancelar."
L["WINDOW_HELP_ITEM_EQUIPP"] = "Pulsa %s para equipar,\n %s para cancelar."
L["WINDOW_HELP_SPELL"] = "Pulsa %s para lanzar,\n %s para cancelar."
L["WINDOW_SHOW_MINIMAP_ICON"] = "Mostra Icono en Minimapa"
L["WINDOW_SHOW_MINIMAP_ICON_DESC"] = "Activa/Desactiva el mostrar el icono en el minimap"
