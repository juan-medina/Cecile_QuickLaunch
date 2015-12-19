----------------------------------------------------------------------------------------------------
-- localized Spanish (main) strings
--

--get the AddOn engine
local AddOnName, Engine = ...;

--Spanish or Latin America Spanish
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esES")
if not L then
	L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "esMX");
	if not L then
		return;
	end
end

--main strings
L["LOAD_MESSAGE"] = "%s (versión |cff0070de%s|r) cargado, escribe /%s o /%s para opciones."
L["CONFIG_WINDOW"] = "%s (version |cff0070de%s|r) creado por |cffffffffCecile|r - |cff0070deEU|r - |cffff2020Zul'jin|r"
L["MINIMAP_LABEL"] = "%s (|cff0070de%s|r)"
L["MINIMAP_HELP_1"] = "|cFFCFCFCFClick Izquierdo|r: Abre el lanzador"
L["MINIMAP_HELP_2"] = "|cFFCFCFCFClick Derecho|r: Abre la configuración"
L["PROFILES"] = "Perfiles"
L["BINDING_DESC"] = "Abrir Lanzador Rápido"
L["LAUNCH_BINDING_DESC"] = "Lanzar Último Comando"
L["ABOUT"] = [[

|cff0070deUso:|r

Primero tienes que configurar un |cff82c5ffatajo de teclado|r en las opciones de ventana para abrir el lanzador, por defecto es |cff82c5ffCONTROL+MAYUSCULAS+P|r.

Cuando se muestre la ventana puedes empezar a escribir para buscar.

Puedes pulsar |cff82c5ffINTRO|r para selecionar la primera opción o usar |cff82c5ffTABULADOR o MAYUSCULAS-TABULADOR|r para navegar por los resultados.

Alternativamente puedes usar los |cff82c5ffcursores|r y la |cff82c5ffrueda del ratón|r.

Puedes definir |cff82c5ffSinónimos|r y |cff82c5ffuna lista negra|r en las opciones de Búsqueda.

Los diversos |cff82c5ffmódulos de busqueda|r se pueden personalizar en la lista de módulos dentro de las opciones de búsqueda.

Se puede cambiar la |cff82c5ffapariencia|r de la ventana en las opciones de la misma.

Este AddOn incluye un |cff82c5fficono en el minimapa|r y algunos |cff82c5ffcommandos|r.

|cff82c5ffAbrir la ventana de configuración:|r /cql

|cff82c5ffAbrir el lanzador:|r /cql launch

|cff0070deMódulos de Búsqueda:|r

|cff82c5ffLogros:|r
- Explorar logros completados y sin completar y abrir la interfaz de logros.
|cff82c5ffAddOns:|r
- Abrir las ventanas de configuración de AddOns.
|cff82c5ffMonturas:|r
- Invocar a una montura aleatoria o cualquier montura en particular.
|cff82c5ffMascotas:|r
- Invocar a tus mascotas de compañia aleatoria o cualquier otra en particular.
|cff82c5ffEspecialización y conjuntos:|r
- Cambiar de especialización o conjuntos de equipo.
|cff82c5ffSocial:|r
- Invitar a grupo o banda o susurrar a tus amigos. Coventir a banda o grupo.
|cff82c5ffJuguetes:|r
- Use any favorite or not favorite toys.
|cff82c5ffEchizos:|r
- Lanza habilidates, teleportaciones, portales, invocaciones, bufos, etc.
|cff82c5ffObjetos:|r
- Usa cualquier de los objetos en tus bolsas o que lleves equipados.

|cff0070deEjemplos:|r

Invocar una mascota aleatoria:
|cff82c5ffCONTROL+MAYUSCULAS+P|r masco |cff82c5ffESPACIO|r aleat |cff82c5ffINTRO|r

Invocar tu segunda montura favorita:
|cff82c5ffCONTROL+MAYUSCULAS+P|r mont |cff82c5ffESPACIO|r favo |cff82c5ffTABULADOR|r |cff82c5ffTABULADOR|r |cff82c5ffTABULADOR|r |cff82c5ffINTRO|r

Abrir la configruación de este AddOn:
|cff82c5ffCONTROL+MAYUSCULAS+P|r cql |cff82c5ffINTRO|r

Abrir el logro de Gloria del héroe de Draenor:
|cff82c5ffCONTROL+MAYUSCULAS+P|r glor |cff82c5ffSPACE|r drae |cff82c5ffINTRO|r

Use tu piedra de hogar:
|cff82c5ffCONTROL+MAYUSCULAS+P|r hogar |cff82c5ffINTRO|r

Teleportate a dalaran:
|cff82c5ffCONTROL+MAYUSCULAS+P|r tele |cff82c5ffSPACE|r dala |cff82c5ffINTRO|r

Use el juguete Trenza de Gammon:
|cff82c5ffCONTROL+MAYUSCULAS+P|r gammon |cff82c5ffINTRO|r]]