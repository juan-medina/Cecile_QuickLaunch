----------------------------------------------------------------------------------------------------
-- localized English (Spells module) strings
--

--get the add-on engine
local Engine = _G.Cecile_QuickLaunch;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(Engine.Name, "enUS", true);
if not L then return; end

--Spells module
L["SPELLS"] = "Spell"
L["SPELLS_MODULE"] = "Spells"
L["SPELLS_TOKEN"] = "Spells Token"
L["SPELLS_TOKEN_DESC"] = "Change the Spells Token"
L["SPELLS_HELP_ITEM"] = "Press %s to cast,\n %s to cancel."
