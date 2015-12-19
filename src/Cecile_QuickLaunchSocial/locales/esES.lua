----------------------------------------------------------------------------------------------------
-- localized Spanish (social module) strings
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

--social module
L["SOCIAL_MODULE"] = "Social"
L["SOCIAL_RETURN_WHISPERS"] = "Devolver Susurros"
L["SOCIAL_RETURN_WHISPERS_DESC"] = "Devuelve elementos para enviar susurros"
L["SOCIAL_WHISPER"] = "Susurrar"
L["SOCIAL_WHISPER_TOKEN"] = "Etiqueta Susurros"
L["SOCIAL_WHISPER_TOKEN_DESC"] = "Cambia la etiqueta para susurros"
L["SOCIAL_RETURN_INVITE"] = "Devolver Invitar"
L["SOCIAL_RETURN_INVITE_DESC"] = "Devuelve elementos para enviar invitaciones"
L["SOCIAL_INVITE"] = "Invitar"
L["SOCIAL_INVITE_TOKEN"] = "Etiqueta para invitar"
L["SOCIAL_INVITE_TOKEN_DESC"] = "Cambia la etiqueta para invitar"
L["SOCIAL_RETURN_CONVERT"] = "Devolver Convertir"
L["SOCIAL_RETURN_CONVERT_DESC"] = "Devuelve items para convertir a grupo y banda"
L["SOCIAL_CONVERT"] = "Convertir"
L["SOCIAL_CONVERT_TOKEN"] = "Etiqueta Convertir"
L["SOCIAL_CONVERT_TOKEN_DESC"] = "Cambia la etiqueta para convertir a grupo y banda"
L["SOCIAL_CONVERT_TO_PARTY"] = "a grupo"
L["SOCIAL_CONVERT_TO_RAID"] = "a banda"