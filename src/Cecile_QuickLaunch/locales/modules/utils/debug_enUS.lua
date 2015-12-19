----------------------------------------------------------------------------------------------------
-- localized English (debug module) strings
--

--get the add-on engine
local AddOnName, Engine = ...;

--prepare locale
local L = LibStub("AceLocale-3.0"):NewLocale(AddOnName, "enUS", true);
if not L then return; end

--debug module
L["DEV_SETTINGS"] = "Debugging"
L["DEBUGGING"] = "Enable Debugging"
L["DEBUGGING_DESC"] = "Enable AddOn debugging and show the debug window."
L["DEBUG_WINDOW_HELP"] = "Mouse wheel to scroll (with shift scroll top/bottom). Title bar drags. Bottom-right corner resizes."
