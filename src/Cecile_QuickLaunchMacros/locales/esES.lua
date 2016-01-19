----------------------------------------------------------------------------------------------------
-- localized Spanish ((Macros module) strings
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

--Macros module
L["MACROS"] = "Macros"
L["MACROS_NAME"] = "Macro"
L["MACROS_MODULE"] = "Macros"
L["MACROS_TOKEN"] = "Macros Token"
L["MACROS_TOKEN_DESC"] = "Change the Macros Token"
L["MACROS_HELP_ITEM"] = "Pulsa %s para usar,\n %s para cancelar."

