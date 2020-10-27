----------------------------------------------------------------------------------------------------
-- debug module, based on LibDebug-1.0.lua by Alkis & Evlogimenos
--  using lib debug will make all add-ons debug lines to show in the same window.

--get the engine and create the module
local Engine = select(2,...);
local mod = Engine.AddOn:NewModule("debug");

--get the locale
local L=Engine.Locale;

--module defaults
mod.Defaults = {
  profile = {
    output = false,
  },
};

--module options table
mod.Options = {
  order = 99,
  type = "group",
  name = L["DEV_SETTINGS"],
  cmdInline = true,
  args = {
    debug = {
      order = 1,
      type = "toggle",
      name = L["DEBUGGING"],
      desc = L["DEBUGGING_DESC"],
      get = function()
        return mod.isDebugging;
      end,
      set = function( _ , value )

        mod:EnableDebugging(value);
        mod:Show(value);

      end,
    },
  }

};

--load profile settings
function mod:LoadProfileSettings()

  local outputDebug = Engine.Profile.debug.output;

  self:EnableDebugging(outputDebug);
  self:Show(outputDebug);

end

--save profile settings
function mod:SaveProfileSettings()

  Engine.Profile.debug.output = self.isDebugging;

end

---scroll the window with mouse wheel
function mod.ScrollingFunction(self, arg)

  --check if we scroll down or up and if shift is down
  if arg > 0 then
    if _G.IsShiftKeyDown() then
      self:ScrollToTop();
    else
      self:ScrollUp();
    end
  elseif arg < 0 then
    if _G.IsShiftKeyDown() then
      self:ScrollToBottom();
    else
      self:ScrollDown();
    end
  end

end

--initialize the module
function mod:OnInitialize()

  --set the call for our module
  local mt = getmetatable(self) or {};
  mt.__call = self.DebugStub;
  setmetatable(self, mt);

  --module frame
  mod.frame = _G.CreateFrame("Frame", Engine.Name.."_DBG_Frame", _G.UIParent, BackdropTemplateMixin and "BackdropTemplate");
  local frame = self.frame;

  --main window
  frame:EnableMouse();

  frame:SetMinResize(300, 100);
  frame:SetWidth(400);
  frame:SetHeight(400);

  frame:SetPoint("CENTER", _G.UIParent);
  frame:SetFrameStrata("TOOLTIP");
  frame:SetBackdrop(
    {
      bgFile = "Interface\\Tooltips\\ChatBubble-Background",
      edgeFile = "Interface\\Tooltips\\ChatBubble-BackDrop",
      tile = true,
      tileSize = 16,
      edgeSize = 16,
      insets = { left=16, right=16, top=16, bottom=16 }
    })
  frame:SetBackdropColor(0, 0, 0, 1);

  -- The title bar/drag bar.
  frame:SetMovable(true);
  frame:SetClampedToScreen(true);
  frame.title = _G.CreateFrame("Button", nil, frame);
  frame.title:SetNormalFontObject("GameFontNormal");
  frame.title:SetText(Engine.Name.." Debug");
  frame.title:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -8);
  frame.title:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -8, -8);
  frame.title:SetHeight(8);
  frame.title:SetHighlightTexture(
    "Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");

  --move main window
  frame.title:SetScript("OnMouseDown",function (object)
    object:GetParent():StartMoving();
  end);

  frame.title:SetScript("OnMouseUp",function (object)
    object:GetParent():StopMovingOrSizing();
  end);

  -- The sizing button.
  frame:SetResizable(true);
  frame.sizer = _G.CreateFrame("Button", nil, frame);
  frame.sizer:SetHeight(16);
  frame.sizer:SetWidth(16);
  frame.sizer:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT");

  --change main window size
  frame.sizer:SetScript("OnMouseDown",function (object)
    object:GetParent():StartSizing("BOTTOMRIGHT");
  end);

  frame.sizer:SetScript("OnMouseUp",function (object)
    object:GetParent():StopMovingOrSizing();
  end);

  local line1 = frame.sizer:CreateTexture(nil, "BACKGROUND");
  line1:SetWidth(14);
  line1:SetHeight(14);
  line1:SetPoint("BOTTOMRIGHT", -8, 8);
  line1:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border");
  local x = 0.1 * 14/17;
  line1:SetTexCoord(0.05 - x, 0.5, 0.05, 0.5 + x, 0.05, 0.5 - x, 0.5 + x, 0.5);

  local line2 = frame.sizer:CreateTexture(nil, "BACKGROUND");
  line2:SetWidth(8);
  line2:SetHeight(8);
  line2:SetPoint("BOTTOMRIGHT", -8, 8);
  line2:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border");
  x = 0.1 * 8/17;
  line2:SetTexCoord(0.05 - x, 0.5, 0.05, 0.5 + x, 0.05, 0.5 - x, 0.5 + x, 0.5);

  frame.bottom = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
  frame.bottom:SetJustifyH("LEFT");
  frame.bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 8, 8);
  frame.bottom:SetPoint("BOTTOMRIGHT", frame.sizer);
  frame.bottom:SetHeight(8);
  frame.bottom:SetText(L["DEBUG_WINDOW_HELP"]);

  -- The scrolling message frame with all the debug info.
  frame.msg = _G.CreateFrame("ScrollingMessageFrame", nil, frame);
  frame.msg:SetPoint("TOPLEFT", frame.title, "BOTTOMLEFT");
  frame.msg:SetPoint("TOPRIGHT", frame.title, "BOTTOMRIGHT");
  frame.msg:SetPoint("BOTTOM", frame.bottom, "TOP", 0, 8);

  frame.msg:SetMaxLines(10000);
  frame.msg:SetFading(false);
  frame.msg:SetFontObject(_G.ChatFontNormal);
  frame.msg:SetJustifyH("LEFT");
  frame.msg:EnableMouseWheel(true);

  -- Hook scrolling to scroll up down with mouse wheel. shift mouse wheel
  -- scroll all the way to the top/bottom.
  frame.msg:SetScript("OnMouseWheel", self.ScrollingFunction);

  self.isDebugging = false;
  frame:Hide();

  --load profile settings
  mod:LoadProfileSettings();

end

--stub default function when we are not debugging
function mod.DebugStub()
end

--get the time
function mod.GetTimeShort()
  return _G.GetTime() - mod.start_time;
end

--get the caller for this module
function mod.GetCaller()

  ---get the stack trace
  local trace = _G.debugstack(3, 1, 0);

  --get the add-on name
  local addon = trace:match("AddOns\\([^\\]+)\\");

  if(addon) then
    addon = addon..":";
  else
    addon = "";
  end

  --return the caller, including add-on name if we found it
  return addon..trace:match("([^\\]-): in function") or trace;

end

--write to the debug window
function mod:Debug(fmt, ...)
  if (fmt==nil) then
    self.frame.msg:AddMessage(string.format("%6.3f (%s):  nil", self.GetTimeShort(),
      self.GetCaller()));
  else
    self.frame.msg:AddMessage(string.format("%6.3f (%s):  "..fmt, self.GetTimeShort(),
      self.GetCaller(), ...));
  end

end


--returns if the module its debugging
function mod:IsDebugging()
  return self.isDebugging;
end

--enable/disable debugging
function mod:EnableDebugging(val)

  --change the default function
  local mt = getmetatable(self)
  if val == false then
    mt.__call = self.DebugStub;
    self.isDebugging = false;
  else
    mt.__call = self.Debug;
    self.isDebugging = true;
    self.start_time = _G.GetTime();
  end

  --save profile settings
  self:SaveProfileSettings();

end

--show/hide the main window
function mod:Show(value)

  if(value) then
    if not self.frame:IsShown() then
      self.frame:Show();
    end
  else
    if self.frame:IsShown() then
      self.frame:Hide();
    end
  end

end

--profile has change
function mod.OnProfileChanged()

  --load profile settings
  mod:LoadProfileSettings();

end

--handle commands
function mod.handleCommand(args)

  --has this module handle the command?
  local handleIt = false;

  --if the command is 'debug'
  if args=="debug" then

    --switch debug
    local value = not(mod.isDebugging);

    mod:EnableDebugging(value);
    mod:Show(value);

    --this module has handle the command
    handleIt = true;

  end

  return handleIt;

end

function mod.dump(...)
  _G.DevTools_Dump(...);
end
