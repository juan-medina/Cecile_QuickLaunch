----------------------------------------------------------------------------------------------------
-- localized English (window module) strings
--

--get the add-on engine
local AddOnName = ...;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true);
if not L then return; end

--window module
L["WINDOW_ERROR_IN_COMBAT"] = "%s |cffff0000: could not be open in combat.|r"
L["WINDOW_SETTINGS"] = "Window"
L["WINDOW_BINDING_LAUNCH"] = "Open Launcher Keybinding"
L["WINDOW_BINDING_LAUNCH_DESC"] = "Change the Keybinding for opening the launcher"
L["WINDOW_BINDING_COMMAND"] = "Last Command Keybinding"
L["WINDOW_BINDING_COMMAND_DESC"] = "Change the Keybinding for launching the last command"
L["WINDOW_SCHEME_NEONBLUE"] = "Cecile Neon Blue"
L["WINDOW_SCHEME_SUNBURST"] = "Cecile Sun Burst"
L["WINDOW_SCHEME_CLASSIC"] = "Classic Black & Gray"
L["WINDOW_SCHEME_CUSTOM"] = "Custom Scheme"
L["WINDOW_APPEARANCE"] = "Appearance"
L["WINDOW_SCHEMES"] = "Windows Schemes"
L["WINDOW_SCHEMES_DESC"] = "Change the window appearance scheme"
L["WINDOW_FONT"] = "Text Font"
L["WINDOW_FONT_DESC"] = "Change the text font type"
L["WINDOW_FONT_SIZE"] = "Text Size"
L["WINDOW_FONT_SIZE_DESC"] = "Change the text font size"
L["WINDOW_NORMAL_COLOR"] = "Normal Text color"
L["WINDOW_NORMAL_COLOR_DESC"] = "Change the color for normal text"
L["WINDOW_HIGHLIGHT_COLOR"] = "Highlight Text Color"
L["WINDOW_HIGHLIGHT_COLOR_DESC"] = "Change the highlight text color"
L["WINDOW_FRAME_COLOR"] = "Frame Color"
L["WINDOW_FRAME_COLOR_DESC"] = "Change the frame color"
L["WINDOW_BORDER_COLOR"] = "Border Color"
L["WINDOW_BORDER_COLOR_DESC"] = "Change the border color"
L["WINDOW_SELECTED_COLOR"] = "Selected Color"
L["WINDOW_SELECTED_COLOR_DESC"] = "Change the selected items color"
L["WINDOW_HELP_SPELL"] = "Press %s to cast,\n %s to cancel."
L["WINDOW_SHOW_MINIMAP_ICON"] = "Show Minimap Icon"
L["WINDOW_SHOW_MINIMAP_ICON_DESC"] = "Enable/Disable showing the minimap icon"



