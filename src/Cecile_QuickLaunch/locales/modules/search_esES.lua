----------------------------------------------------------------------------------------------------
-- localized Spanish (search module) strings
--

--get the add-on engine
local AddOnName = ...;

--Spanish or Latin America Spanish
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esES")
if not L then
	L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esMX");
	if not L then
		return;
	end
end

--search module
L["SEARCH_NAME"] = "Búsqueda"
L["SEARCH_ENABLE_MODULE"] = "Activado"
L["SEARCH_ENABLE_MODULE_DESC"] = "Activa/Desactiva este módulo"
L["SEARCH_ALIASES"] = "Sinónimos"
L["SEARCH_ALIASES_DESC"] = "Elije un sinónimo"
L["SEARCH_ALIAS_NAME"] = "Nombre del sinónimo"
L["SEARCH_ALIAS_VALUE"] = "Valor del sinónimo"
L["SEARCH_ALIAS_SAVE"] = "Grabar"
L["SEARCH_ALIAS_SAVE_DESC"] = "Grabar el sinónimo"
L["SEARCH_ALIAS_NEW"] = "Nuevo"
L["SEARCH_ALIAS_NEW_DESC"] = "Nuevo sinónimo"
L["SEARCH_ALIAS_DELETE"] = "Borrar"
L["SEARCH_ALIAS_DELETE_DESC"] = "Borra el sinónimo"
L["SEARCH_TOKEN"] = "Símbolo de busqueda"
L["SEARCH_TOKEN_DESC"] = "Cambia el símbolo generado por las busquedas"
L["SEARCH_BLACKLIST"] = "Lista Negra"
L["SEARCH_BLACKLIST_DESC"] = "Elije un elemento en la lista negra"
L["SEARCH_BLACKLIST_NAME"] = "Nombre"
L["SEARCH_BLACKLIST_VALUE"] = "Valor"
L["SEARCH_BLACKLIST_SAVE"] = "Salvar"
L["SEARCH_BLACKLIST_SAVE_DESC"] = "Graba el elemento en la lista negra"
L["SEARCH_BLACKLIST_NEW"] = "Nuevo"
L["SEARCH_BLACKLIST_NEW_DESC"] = "Nuevo elemento en la lista negra"
L["SEARCH_BLACKLIST_DELETE"] = "Borrar"
L["SEARCH_BLACKLIST_DELETE_DESC"] = "Borra el elemento en la lista negra"
L["SEARCH_ALIAS_HELP"] = [[

Los sinónimos funcionan como sustituciones, cuando hagas una búsqueda replanzara cualquier ocurencia de un nombre de sinónimo con su valor.

]]
L["SEARCH_BLACKIST_HELP"] = [[

La listas negra funciona como una busqueda negativa, cuando este tecleando cualquier busqueda todos los elmentos que cualquier valor de lista negra devuelva seran descartados del resultado.

]]
L["SEARCH_MODULES"] = "Módulos"
L["SEARCH_TWO_STEPS"] = "En dos pasos"
L["SEARCH_TWO_STEPS_DESC"] = "Cambia las búsquedas para funcionar en dos pasos, primero el modulo, segundo elementos del modulo"
L["SEARCH_GENERAL"] = "General"
L["SEARCH_TWO_STEPS_HELP"] = [[

Cuando se activa la busqueda 'en dos pasos' despues de usar la tecla rápida buscarás en la lista de módulos activos, depues trás selecionar un módulo buscarás en los elementos de solo ese módulo.

]]
L["SEARCH_MODULE_UP"] = "Move Arriba"
L["SEARCH_MODULE_UP_DESC"] = "Mueve este modulo hacia ARRIBA en la lista de modulos"
L["SEARCH_MODULE_DOWN"] = "Move Abajo"
L["SEARCH_MODULE_DOWN_DESC"] = "Mueve este modulo hacia ABAJO en la lista de modulos"