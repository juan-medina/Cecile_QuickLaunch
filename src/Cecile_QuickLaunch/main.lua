----------------------------------------------------------------------------------------------------
-- Main file, create the main add-on
--

--create the add-on and store in the engine
local AddOnName, Engine = ...;
local AddOn = LibStub("AceAddon-3.0"):NewAddon( AddOnName,
  "AceEvent-3.0", 'AceTimer-3.0', 'AceHook-3.0', "AceComm-3.0" );

Engine.Name  = AddOnName;
Engine.AddOn = AddOn;

--store locale in the engine
local L = LibStub("AceLocale-3.0"):GetLocale(Engine.Name);
Engine.Locale = L;

--store the engine global
_G[AddOnName] = Engine;

--register entering the world
function AddOn:OnEnable()
  self:RegisterEvent("PLAYER_ENTERING_WORLD");
end


--on entering the world we show the load message, including version and slash commands
function AddOn:PLAYER_ENTERING_WORLD()

  --get version
  local Version = AddOn:GetModule("version");

  print(string.format(L["LOAD_MESSAGE"],Version.Title,Version.Label,Engine.slash1,Engine.slash2));

  --define key bindings
  _G.BINDING_HEADER_Cecile_QuickLauncher = Version.Title
  _G.BINDING_NAME_LAUNCH_CQL = L["BINDING_DESC"]
  _G["BINDING_NAME_CLICK Cecile_QL_IconButton:LeftButton"] = L["LAUNCH_BINDING_DESC"]

  --get Window
  local Window = AddOn:GetModule("window");

  --set the default binding
  Window:SetDefaultBinding("CTRL-SHIFT-P","LAUNCH_CQL");

  --set the default binding
  Window:SetDefaultBinding("CTRL-ENTER","CLICK Cecile_QL_IconButton:LeftButton");

  --register blizzard options
  AddOn:RegisterBlizzardOptions();

  self:UnregisterEvent("PLAYER_ENTERING_WORLD");

end

--initialise the add-on
function AddOn:OnInitialize()

  --set-up options
  self:SetupOptions();

  --set-up minimap icon
  self:SetupMinimapIcon();

end

--this function is actually the one showing the window
function AddOn:DelayShow()

  --get the window module
  local window = self:GetModule("window");

  --show the launcher
  window:Show(true);

end

--binding function
function AddOn:Launch()

  --delay the opening of the window 1 millisecond
  self:ScheduleTimer("DelayShow", 0.1);

end
