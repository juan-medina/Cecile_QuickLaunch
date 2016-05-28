----------------------------------------------------------------------------------------------------
-- localized English (main) strings
--

--get the AddOn engine
local AddOnName = ...;

--force localization to Spanish (only for testing)
--_G.GAME_LOCALE = "esES"

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true);
if not L then return; end

--main strings
L["LOAD_MESSAGE"] = "%s (version |cff0070de%s|r) loaded, type /%s or /%s for options."
L["CONFIG_WINDOW"] = "%s (version |cff0070de%s|r) by |cffffffffCecile|r - |cff0070deEU|r - |cffff2020Zul'jin|r"
L["MINIMAP_LABEL"] = "%s (|cff0070de%s|r)"
L["MINIMAP_HELP_1"] = "|cFFCFCFCFleft click|r: Open the Launcher"
L["MINIMAP_HELP_2"] = "|cFFCFCFCFRight click|r: Open the Configuration"
L["PROFILES"] = "Profiles"
L["BINDING_DESC"] = "Open Quick Launch"
L["LAUNCH_BINDING_DESC"] = "Launch Last Command"
L["ABOUT"] = [[|cff0070deSpecial thanks to:|r
|cff82c5ffLaodice|r, |cff82c5ffHalloran|r, |cff82c5fficyblade|r.

|cff0070deUsage:|r

First you need to set-up a |cff82c5ffkeybinding|r in the window settings to open the launcher, by default it's |cff82c5ffCTRL+SHIFT+P|r.

When the window pop-up you could start typing to search.

You could press |cff82c5ffENTER|r to select the first option or use |cff82c5ffTAB or SHIFT-TAB|r to navigate trough the results.

Alternatively you could use |cff82c5ffarrow keys|r or |cff82c5ffmouse wheel|r.

You could define |cff82c5ffAliases|r and |cff82c5ffBlacklist|r items in the search options.

The different |cff82c5ffsearch modules|r could be customized in the module list within the search options.

The window |cff82c5ffappearance|r could be change in the windows options.

This AddOn include a |cff82c5ffminimap icon|r and some |cff82c5ffslash commands|r.

|cff82c5ffOpen the configuration window:|r /cql

|cff82c5ffOpen the launcher window:|r /cql launch

|cff0070deSearch Modules:|r

|cff82c5ffAchievements:|r
- Browse complete and uncompleted achievements and open achievements interface UI.
|cff82c5ffAddOns:|r
- Open AddOns configurations windows.
|cff82c5ffMacros:|r
- Use any of your character or account macros.
|cff82c5ffMounts:|r
- Summon random or any favorite or not favorite mount.
|cff82c5ffPets:|r
- Summon random or any favorite or not favorite companion pet.
|cff82c5ffProfessions:|r
- Open your professions book or use your professions skills.
|cff82c5ffSpecialization and Gear Sets:|r
- Change Specialization and gear sets.
|cff82c5ffSocial:|r
- Friends whisper and invite to party/raid. Convert to party/raid.
|cff82c5ffToys:|r
- Use any favorite or not favorite toys.
|cff82c5ffSpells:|r
- Cast your abilities, teleports, portals, summons, buffs, etc.
|cff82c5ffItems:|r
- Use any object in your bags or equipped by your character.

|cff0070deExamples:|r

Summon a random pet:
|cff82c5ffCTRL+SHIFT+P|r pet |cff82c5ffSPACE|r rando |cff82c5ffENTER|r

Summon your second favorite mount:
|cff82c5ffCTRL+SHIFT+P|r mou |cff82c5ffSPACE|r favo |cff82c5ffTAB|r |cff82c5ffTAB|r |cff82c5ffTAB|r |cff82c5ffENTER|r

Open this AddOn configuration:
|cff82c5ffCTRL+SHIFT+P|r cql |cff82c5ffENTER|r

Open this AddOn configuration:
|cff82c5ffCTRL+SHIFT+P|r cql |cff82c5ffENTER|r

Open the Glory of the Draenor Hero achievement:
|cff82c5ffCTRL+SHIFT+P|r glor |cff82c5ffSPACE|r drae |cff82c5ffENTER|r

Use your Hearthstone:
|cff82c5ffCTRL+SHIFT+P|r hearths |cff82c5ffENTER|r

Teleport to dalaran:
|cff82c5ffCTRL+SHIFT+P|r tele |cff82c5ffSPACE|r dala |cff82c5ffENTER|r

Use your Gammon's Braid toy:
|cff82c5ffCTRL+SHIFT+P|r gammon |cff82c5ffENTER|r

Use your cooking fire:
|cff82c5ffCTRL+SHIFT+P|r coo |cff82c5ffSPACE|r fir |cff82c5ffENTER|r

Use your macro "mail":
|cff82c5ffCTRL+SHIFT+P|r macr |cff82c5ffSPACE|r mai |cff82c5ffENTER|r]]