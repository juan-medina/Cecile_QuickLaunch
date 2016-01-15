----------------------------------------------------------------------------------------------------
-- localized English (social module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--social module
L["SOCIAL_MODULE"] = "Social"
L["SOCIAL_RETURN_WHISPERS"] = "Return Whispers"
L["SOCIAL_RETURN_WHISPERS_DESC"] = "Return items to send whispers"
L["SOCIAL_WHISPER"] = "Whisper"
L["SOCIAL_WHISPER_TOKEN"] = "Whisper Token"
L["SOCIAL_WHISPER_TOKEN_DESC"] = "Change the whisper token"
L["SOCIAL_RETURN_INVITE"] = "Return Invite"
L["SOCIAL_RETURN_INVITE_DESC"] = "Return items to send invites"
L["SOCIAL_INVITE"] = "Invite"
L["SOCIAL_INVITE_TOKEN"] = "Invite Token"
L["SOCIAL_INVITE_TOKEN_DESC"] = "Change the invite token"
L["SOCIAL_RETURN_CONVERT"] = "Return Convert"
L["SOCIAL_RETURN_CONVERT_DESC"] = "Return items for convert to party and raid"
L["SOCIAL_CONVERT"] = "Convert"
L["SOCIAL_CONVERT_TOKEN"] = "Convert Token"
L["SOCIAL_CONVERT_TOKEN_DESC"] = "Change the convert to party and raid token"
L["SOCIAL_CONVERT_TO_PARTY"] = "to party"
L["SOCIAL_CONVERT_TO_RAID"] = "to raid"
L["SOCIAL_HELP_WHISPER"] = "Press %s to whisper,\n %s to cancel."
L["SOCIAL_HELP_INVITE"] = "Press %s to invite,\n %s to cancel."
L["SOCIAL_HELP_CONVERT"] = "Press %s to convert,\n %s to cancel."