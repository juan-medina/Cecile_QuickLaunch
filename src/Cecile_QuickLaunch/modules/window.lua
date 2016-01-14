----------------------------------------------------------------------------------------------------
-- window module

--get the engine and create the module
local Engine = select(2,...);
local mod = Engine.AddOn:NewModule("window");

--get the locale
local L=Engine.Locale;

--debug
local debug = Engine.AddOn:GetModule("debug");

--sharemedia
local LSM = LibStub("LibSharedMedia-3.0");

--color schemes
mod.schemes = {
  newblue = {
    name = L["WINDOW_SCHEME_NEONBLUE"],
    font = {
      name = "Cecile",
      size = 12,
      colors = {
        normal = {
          r = 1,
          g = 1,
          b = 1,
        },
        highlight = {
          r = 0,
          g = 1,
          b = 1,
        },
      },
    },
    colors = {
      frame = {
        r = 0,
        g = 0.5,
        b = 0.5,
        a = 0.5,
      },
      border = {
        r = 0,
        g = 0.5,
        b = 0.5,
      },
      selected = {
        r = 0,
        g = 0.5,
        b = 1,
      },
    },
  },
  sunburst = {
    name = L["WINDOW_SCHEME_SUNBURST"],
    font = {
      name = "Cecile",
      size = 12,
      colors = {
        normal = {
          r = 1,
          g = 0,
          b = 0,
        },
        highlight = {
          r = 1,
          g = 1,
          b = 0,
        },
      },
    },
    colors = {
      frame = {
        r = 1,
        g = 0,
        b = 0,
        a = 0.5,
      },
      border = {
        r = 1,
        g = 1,
        b = 0,
      },
      selected = {
        r = 1,
        g = 0.5,
        b = 0,
      },
    },
  },
  classic = {
    name = L["WINDOW_SCHEME_CLASSIC"],
    font = {
      name = "Cecile",
      size = 12,
      colors = {
        normal = {
          r = 0.5,
          g = 0.5,
          b = 0.5,
        },
        highlight = {
          r = 1,
          g = 1,
          b = 1,
        },
      },
    },
    colors = {
      frame = {
        r = 0.2,
        g = 0.2,
        b = 0.2,
        a = 0.5,
      },
      border = {
        r = 0,
        g = 0,
        b = 0,
      },
      selected = {
        r = 0.6,
        g = 0.6,
        b = 0.6,
      },
    },
  },
  custom = {
    name = L["WINDOW_SCHEME_CUSTOM"]
  },
};

--module defaults
mod.Defaults = {
  profile = {
    scheme = "newblue",
    font = {
      name = "Cecile",
      size = 12,
      colors = {
        normal = {
          r = 1,
          g = 1,
          b = 1,
        },
        highlight = {
          r = 0,
          g = 1,
          b = 1,
        },
      },
    },
    colors = {
      frame = {
        r = 0,
        g = 0.5,
        b = 0.5,
        a = 0.5,
      },
      border = {
        r = 0,
        g = 0.5,
        b = 0.5,
      },
      selected = {
        r = 0,
        g = 0.5,
        b = 1,
      },
    },
  },
};

--module options table
mod.Options = {
  order = 4,
  type = "group",
  name = L["WINDOW_SETTINGS"],
  childGroups = "tab",
  args = {
    general = {
      type = "group",
      name = "General",
      order = 0,
      args = {
        minimap = {
          order = 1,
          type = "toggle",
          name = L["WINDOW_SHOW_MINIMAP_ICON"],
          desc = L["WINDOW_SHOW_MINIMAP_ICON_DESC"],
          get = function()
            return not(Engine.Profile.minimap.hide);
          end,
          set = function(_,value)

            Engine.Profile.minimap.hide = not(value);

            Engine.AddOn:OnCfgChange();

          end,
        },
      },
    },
    appearance = {
      type = "group",
      name = L["WINDOW_APPEARANCE"],
      order = 1,
      args = {
        schemes = {
          order = 1,
          type = "select",
          name = L["WINDOW_SCHEMES"],
          desc = L["WINDOW_SCHEMES_DESC"],
          width = "full",
          values = function()

            local names={};

            for k,v in pairs(mod.schemes) do
              names[k] = v.name;
            end

            return names;
          end,
          set = function(_,value)
            Engine.Profile.window.scheme = value;
            Engine.AddOn:OnCfgChange();
          end,
          get = function()
            return Engine.Profile.window.scheme;
          end,
        },
        font = {
          type = "select", dialogControl = 'LSM30_Font',
          order = 2,
          name = L["WINDOW_FONT"],
          desc = L["WINDOW_FONT_DESC"],
          values = _G.AceGUIWidgetLSMlists.font,
          get = function()
            return Engine.Profile.window.font.name;
          end,
          set = function(_, value)
            Engine.Profile.window.font.name = value;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        fontSize = {
          order = 3,
          name = L["WINDOW_FONT_SIZE"],
          desc = L["WINDOW_FONT_SIZE_DESC"],
          type = "range",
          min = 6, max = 22, step = 1,
          get = function()
            return Engine.Profile.window.font.size;
          end,
          set = function(_,value)
            Engine.Profile.window.font.size = value;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        normalColor = {
          order = 4,
          name = L["WINDOW_NORMAL_COLOR"],
          desc = L["WINDOW_NORMAL_COLOR_DESC"],
          type = "color",
          get = function()
            return 	Engine.Profile.window.font.colors.normal.r,
              Engine.Profile.window.font.colors.normal.g,
              Engine.Profile.window.font.colors.normal.b
          end,
          set = function(_,r,g,b)
            Engine.Profile.window.font.colors.normal.r = r;
            Engine.Profile.window.font.colors.normal.g = g;
            Engine.Profile.window.font.colors.normal.b = b;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        highlightColor = {
          order = 5,
          name = L["WINDOW_HIGHLIGHT_COLOR"],
          desc = L["WINDOW_HIGHLIGHT_COLOR_DESC"],
          type = "color",
          get = function()
            return 	Engine.Profile.window.font.colors.highlight.r,
              Engine.Profile.window.font.colors.highlight.g,
              Engine.Profile.window.font.colors.highlight.b
          end,
          set = function(_,r,g,b)
            Engine.Profile.window.font.colors.highlight.r = r;
            Engine.Profile.window.font.colors.highlight.g = g;
            Engine.Profile.window.font.colors.highlight.b = b;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        frameColor = {
          order = 6,
          name = L["WINDOW_FRAME_COLOR"],
          desc = L["WINDOW_FRAME_COLOR_DESC"],
          type = "color",
          hasAlpha = true,
          get = function()
            return 	Engine.Profile.window.colors.frame.r,
              Engine.Profile.window.colors.frame.g,
              Engine.Profile.window.colors.frame.b,
              Engine.Profile.window.colors.frame.a
          end,
          set = function(_,r,g,b,a)
            Engine.Profile.window.colors.frame.r = r;
            Engine.Profile.window.colors.frame.g = g;
            Engine.Profile.window.colors.frame.b = b;
            Engine.Profile.window.colors.frame.a = a;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        borderColor = {
          order = 7,
          name = L["WINDOW_BORDER_COLOR"],
          desc = L["WINDOW_BORDER_COLOR_DESC"],
          type = "color",
          get = function()
            return 	Engine.Profile.window.colors.border.r,
              Engine.Profile.window.colors.border.g,
              Engine.Profile.window.colors.border.b
          end,
          set = function(_,r,g,b)
            Engine.Profile.window.colors.border.r = r;
            Engine.Profile.window.colors.border.g = g;
            Engine.Profile.window.colors.border.b = b;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
        selectedColor = {
          order = 8,
          name = L["WINDOW_SELECTED_COLOR"],
          desc = L["WINDOW_SELECTED_COLOR_DESC"],
          type = "color",
          get = function()
            return 	Engine.Profile.window.colors.selected.r,
              Engine.Profile.window.colors.selected.g,
              Engine.Profile.window.colors.selected.b
          end,
          set = function(_,r,g,b)
            Engine.Profile.window.colors.selected.r = r;
            Engine.Profile.window.colors.selected.g = g;
            Engine.Profile.window.colors.selected.b = b;
            Engine.AddOn:OnCfgChange();
          end,
          disabled = function()
            return not(Engine.Profile.window.scheme=="custom");
          end,
        },
      },
    },
    keybindings = {
      type = "group",
      name = "Keybindings",
      order = 2,
      args ={
        launch = {
          order = 1,
          type = "keybinding",
          name = L["WINDOW_BINDING_LAUNCH"],
          desc = L["WINDOW_BINDING_LAUNCH_DESC"],
          get = function()
            return _G.GetBindingKey("LAUNCH_CQL");
          end,
          set = function(_,value)
            mod.SafeSetBinding(value, "LAUNCH_CQL");
          end,
        },
        relaunch = {
          order = 2,
          type = "keybinding",
          name = L["WINDOW_BINDING_COMMAND"],
          desc = L["WINDOW_BINDING_COMMAND_DESC"],
          get = function()
            return _G.GetBindingKey("CLICK Cecile_QL_IconButton:LeftButton");
          end,
          set = function(_, value)
            mod.SafeSetBinding(value, "CLICK Cecile_QL_IconButton:LeftButton");
          end,
        },
      }
    },
  }
};

--load profile settings
function mod:LoadProfileSettings()

  local scheme = Engine.Profile.window.scheme;

  if not(scheme=="custom") then
    Engine.Profile.window.font = self.schemes[scheme].font;
    Engine.Profile.window.colors = self.schemes[scheme].colors;
  end

  --get the font
  self.fontObject = LSM:Fetch("font", Engine.Profile.window.font.name);
  self.fontSize = Engine.Profile.window.font.size;
  self.fontColors = Engine.Profile.window.font.colors;

  self.mainFrame.editBox:SetFont(self.fontObject,self.fontSize);
  self.mainFrame.editBox:SetTextColor(self.fontColors.highlight.r,self.fontColors.highlight.g,self.fontColors.highlight.b);
  self.mainFrame.editBox:SetHeight(14);

  self.colors = Engine.Profile.window.colors;

  self.selectedColor = self.colors.selected;
  self.overColor = { r = self.colors.selected.r/2 , g = self.colors.selected.g/2 , b = self.colors.selected.b/2  };

  --lopp the items
  for _,frame in pairs(self.mainFrame.scrollContent.items) do

    --set the font
    frame.text:SetFont(self.fontObject,self.fontSize);
    frame.text:SetTextColor(self.fontColors.normal.r,self.fontColors.normal.g,self.fontColors.normal.b);
    frame:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);
  end

  self.mainFrame:SetSolidColor(self.colors.frame.r, self.colors.frame.g, self.colors.frame.b, self.colors.frame.a);
  self.mainFrame:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);
  self.mainFrame.iconButton:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);
  self.mainFrame.editBox:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);
  self.mainFrame.scrollArea:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);

  self.mainFrame.sliderBox:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);
  self.mainFrame.slider:SetSolidColor(self.colors.border.r, self.colors.border.g, self.colors.border.b, self.colors.frame.a);

  self.secureButton.help.text:SetFont(self.fontObject,self.fontSize);
  self.secureButton.help.text:SetTextColor(self.fontColors.normal.r,self.fontColors.normal.g,self.fontColors.normal.b);

  self.secureButton.name.text:SetFont(self.fontObject,self.fontSize);
  self.secureButton.name.text:SetTextColor(self.fontColors.highlight.r,self.fontColors.highlight.g,self.fontColors.highlight.b);

  self.secureButton:SetBorderColor(self.colors.border.r, self.colors.border.g, self.colors.border.b);

end

--on escape pressed
function mod.OnEscapePressed()

  ---hide the window
  mod:Show(false);

end

function mod.secureClick(button)
  if type(button.item.func)=="function" then
    button.item.func(button.item);
  end
  mod.secureHide();
end

function mod.secureHide()
  mod.secureButton:Hide();
  mod.secureButtonClose:Hide();
  mod.secureButton.help:Hide();
  mod.secureButton.name:Hide();

  _G.ClearOverrideBindings(mod.secureButton);
  _G.ClearOverrideBindings(mod.secureButtonClose);
end

function mod.secureOnEnter()

  _G.GameTooltip:SetOwner(mod.secureButton, "ANCHOR_RIGHT");
  if not (mod.secureButton.tooltipFunc == nil) then
    mod.secureButton.tooltipFunc(_G.GameTooltip,mod.secureButton.item);
  else
    _G.GameTooltip:AddLine(mod.secureButton.item.name or mod.secureButton.item.text);
    _G.GameTooltip:Show();
  end

end

function mod.secureOnLeave()
  _G.GameTooltip:Hide();
  _G.BattlePetTooltip:Hide();
end

--prepare the secure button
function mod:PrepareSecureButton(item,start,duration,enable)

  --local vars
  local name, icon, help = item.name or item.text, item.icon or "Interface\\Icons\\Temp", item.help or "";

  --if we are in combat display a message and return
  if self.combat then
    --get version
    local Version = Engine.AddOn:GetModule("version");

    print(string.format(L["WINDOW_ERROR_IN_COMBAT"],Version.Title));
    return;
  end

  self.secureButton.icon:SetTexture(icon);

  if type(item.help) == "function" then
    help = item:help();
  end

  self.secureButton.help.text:SetText(string.format(help,
    self.search.getColorString(self.fontColors.highlight).._G.KEY_ENTER.."|r",
    self.search.getColorString(self.fontColors.highlight).._G.KEY_ESCAPE.."|r"));

  self.secureButton.name.text:SetText(name);

  self.secureButton.item = item;

  local cooldown = self.secureButton.cooldown;
  if (cooldown and start and duration) then
    if (enable) then
      cooldown:Hide();
    else
      cooldown:Show();
    end
    _G.CooldownFrame_SetTimer(cooldown, start, duration, enable);
  else
    cooldown:Hide();
  end

  self.secureButton:Show();
  self.secureButtonClose:Show();
  self.secureButton.help:Show();
  self.secureButton.name:Show();

  _G.SetOverrideBindingClick(self.secureButtonClose, true, "ESCAPE", "CQL_SECURE_BUTTON_CLOSE", "LeftClick");
  _G.SetOverrideBindingClick(self.secureButton, true, "ENTER", "CQL_SECURE_BUTTON", "LeftClick");

end

--use a spell
function mod:UseSpell(item)

  local name, rank, icon, _, _, _, spellID = _G.GetSpellInfo(item.id);
  local start, duration, enable = _G.GetSpellCooldown(name);
  local help = L["WINDOW_HELP_SPELL"];

  self.secureButton.tooltipFunc = item.tooltipFunc;

  self.secureButton:SetAttribute("type","spell");
  self.secureButton:SetAttribute("spell",item.id);

  if rank and not(rank=="") then
    name = name.." ("..rank..")";
  end

  local petIndex, petName = _G.GetCallPetSpellInfo(spellID);
  if petIndex and petIndex and not(petName=="") then
    name = name.." ("..petName..")";
  end
  self:PrepareSecureButton(item,name,icon,help,start,duration,enable);

end

--use a item
function mod:UseItem(item)

  local start, duration, enable = _G.GetItemCooldown(item.id);

  self.secureButton.tooltipFunc = item.tooltipFunc;

  self.secureButton:SetAttribute("type","item");
  self.secureButton:SetAttribute("item",item.name);

  self:PrepareSecureButton(item,start,duration,enable);

end

--use a function
function mod:useFunc(item)

  self.secureButton:SetAttribute("type","");

  self.secureButton.tooltipFunc = item.tooltipFunc;

  self:PrepareSecureButton(item,0,0,true);

end


--default action on button click
function mod.OnButtonClick(object)

  --hide the the window
  mod:Show(false);

  --call the object func if we have any function
  if object.data then

    --if we have a funcion call it
    if object.data.func then
      --object.data:func();
      mod:useFunc(object.data);
    --if we have type
    elseif object.data.type then
      if object.data.type == "item" then
        mod:UseItem(object.data);
      elseif object.data.type == "spell" then
        mod:UseSpell(object.data);
      end
    end

    --set last action binding
    mod.mainFrame.lastActionButton.data = object.data;

  end

end

--flattern a ui object removing regions
function mod.flattern(object)

  local BlizzardRegions = {
    'Left',
    'Middle',
    'Right',
    'Mid',
    'LeftDisabled',
    'MiddleDisabled',
    'RightDisabled',
  }

  local name = object:GetName()

  if name then
    for _, Region in pairs(BlizzardRegions) do
      if _G[name..Region] then
        _G[name..Region]:SetAlpha(0)
      end
    end
  end

  for _, Region in pairs(BlizzardRegions) do
    if object[Region] then
      object[Region]:SetAlpha(0)
    end
  end

  if object.SetNormalTexture then object:SetNormalTexture("") end
  if object.SetPushedTexture then object:SetPushedTexture("") end
  if object.SetDisabledTexture then object:SetDisabledTexture("") end

end


--create a border in a direction,size, and color
function mod.CreateBorder(object,direction,r,g,b)

  --the size does not have direction
  local size = math.abs(direction);

  --get the frame border if its has it
  local border = object.border;

  --if has not border create it
  if border == nil then
    border = _G.CreateFrame("Frame", nil, object);
  end

  --if has anchors remove them
  if border:GetPoint() then
    border:ClearAllPoints();
  end

  --set the anchors base on our direction
  border:SetPoint('TOPLEFT', object, 'TOPLEFT', direction, -direction)
  border:SetPoint('BOTTOMRIGHT', object, 'BOTTOMRIGHT', -direction, direction)

  --se the right frame level
  border:SetFrameLevel(object:GetFrameLevel() + 1)

  --set a solid backdrop with right insets
  border:SetBackdrop({
    edgeFile = [[Interface\BUTTONS\WHITE8X8]],
    edgeSize = size,
    insets = { left = size, right = size, top = size, bottom = size }
  });

  --set the backdrop color
  border:SetBackdropBorderColor(r, g, b, 1)

  --store border
  object.border = border;
end

function mod.SetBorderColor(object,r,g,b)

  if object.border then
    object.border:SetBackdropBorderColor(r, g, b, 1)
  end

end

--se the frame to be just a single color frame
function mod.SetSolidColor(object, r,g,b,a)

  --if does not have a texture, create it
  if object.texture == nil then
    object.texture = object:CreateTexture(nil, "BACKGROUND");
    object.texture:SetAllPoints(true);
  end

  object.texture:SetTexture(r,g,b,a);

end

--create a UI object and inject our functions
function mod.CreateUIObject(class,parent,name,template)

  local frame = _G.CreateFrame(class, name, parent, template);

  frame.CreateBorder = mod.CreateBorder;
  frame.SetBorderColor = mod.SetBorderColor;
  frame.SetSolidColor = mod.SetSolidColor;
  frame.flattern = mod.flattern;

  return frame;
end

--get the max possible scroll
function mod:GetMaxScroll()

  --get how many items could be drown on screen
  local onScreen = math.floor(self.mainFrame.scrollArea:GetHeight() / 20);

  --get how we could scroll using how many we have and how manny fit
  local toScroll = (self.totalItems-1) - onScreen;

  --get in ui coords
  local maxScroll = toScroll*20;

  --clamp negative values
  maxScroll = math.max(maxScroll,0);

  --return results
  return maxScroll;

end

--helper function to set the current scroll and update slider
function mod:SetScroll(value)
  self.mainFrame.scrollArea:SetVerticalScroll(value);
  self:UpdateSlider();
end

--update our slider
function mod:UpdateSlider()

  --get our max scroll
  local maxScroll = self:GetMaxScroll();

  --by default slider cover all him box
  local from = 0;
  local to = 0;

  --if we have something to scroll
  if not (maxScroll==0) then

    --get current scroll
    local currentScroll = self.mainFrame.scrollArea:GetVerticalScroll();

    --calculcate el % of our position
    local percent = currentScroll/maxScroll;

    --calculate from-to
    from = 75*percent;
    to = 75*(1-percent);
  end

  --remve anchors
  self.mainFrame.slider:ClearAllPoints();

  --set new anchors
  self.mainFrame.slider:SetPoint("TOPLEFT", 		self.mainFrame.sliderBox,	"TOPLEFT", 		4, -4-from);
  self.mainFrame.slider:SetPoint("TOPRIGHT",		self.mainFrame.sliderBox,	"TOPRIGHT", 	-4, -4-from);
  self.mainFrame.slider:SetPoint("BOTTOMLEFT", 	self.mainFrame.sliderBox,	"BOTTOMLEFT", 	4, 4+to);
  self.mainFrame.slider:SetPoint("BOTTOMRIGHT",	self.mainFrame.sliderBox,	"BOTTOMRIGHT", 	4, 4+to);

end

---scroll the window with mouse wheel
function mod.ScrollingFunction(_, arg)

  --get how much we could scroll
  local maxScroll = mod:GetMaxScroll();

  --get current scroll
  local currentScroll = mod.mainFrame.scrollArea:GetVerticalScroll();

  --get how much we want to scroll
  local scroll = currentScroll + (arg*-5);

  --clamp value
  scroll = math.min(scroll,maxScroll);
  scroll = math.max(scroll,0);

  --if actualy we are going to scroll
  if not (currentScroll == scroll) then
    mod:SetScroll(scroll);
  end
end

--on mouse over a button
function mod.OnButtonEnter(object)

  --if the object is not selected set the hightligh color
  if object.selected==false then
    object:UnlockHighlight();
    object.highlight:SetVertexColor(mod.overColor.r,mod.overColor.g,mod.overColor.b);
  end

end

function mod:CreateScrollItem(text)

  --get the position for this item
  local position = (#self.mainFrame.scrollContent.items);

  --create the item
  local frame = self.CreateUIObject("Button",self.mainFrame.scrollContent,"LauncherButton"..position, "OptionsListButtonTemplate");

  --calculate start and end Y position
  local startY = position * -20;
  local endY = startY-20;

  --position the object
  frame:SetPoint("TOPLEFT", 		self.mainFrame.scrollContent,"TOPLEFT", 	0, startY);
  frame:SetPoint("TOPRIGHT", 		self.mainFrame.scrollContent,"TOPRIGHT",	0, startY);
  frame:SetPoint("BOTTOMLEFT", 	self.mainFrame.scrollContent,"TOPLEFT", 	0, endY);
  frame:SetPoint("BOTTOMRIGHT",	self.mainFrame.scrollContent,"TOPRIGHT", 0, endY);

  --set scripts
  frame:SetScript("OnEnter", self.OnButtonEnter)
  frame:SetScript("OnLeave", self.OnButtonLeave)


  --set style
  frame:CreateBorder(-1,0,0,0);

  --set the text
  frame.text:SetText(text);

  --store position
  frame.position = position+1;

  --set the hanlder
  frame:SetScript("OnClick", self.OnButtonClick);
  frame.data = nil;

  --insert into our table
  table.insert(self.mainFrame.scrollContent.items,frame);

  --hid this button
  frame:Hide();

end

--add a new item
function mod:AddItem(item)

  --if we are in our limit don't add
  if self.totalItems<self.maxItems then

    --count
    self.totalItems = self.totalItems + 1;

    --get the button
    local button = self.mainFrame.scrollContent.items[self.totalItems];

    --store the data
    button.data = item;

    local text = _G.format('|T%s:14:14:0:0:64:64:4:60:4:60|t %s',item.icon or "Interface\\Icons\\Temp", item.displayText);
    --set the text
    button.text:SetText(text);

    --display the button
    button:Show();

  end

end


--select a item
function mod:SelectButton(object)

  --remove highlight and reset selected to all of them
  for _,value in pairs(self.mainFrame.scrollContent.items) do
    value:UnlockHighlight();
    value.selected = false;

    object.highlight:SetVertexColor(self.overColor.r,self.overColor.g,self.overColor.b);
  end

  --store in the edit box the one we like
  self.mainFrame.editBox.data = object.data;
  self.mainFrame.iconButton.data = object.data;

  --set the icon button
  local icon = object.data.icon or "Interface\\Icons\\Temp";
  self.mainFrame.iconButton.icon:SetTexture(icon);

  --set this to selected
  object:LockHighlight();
  object.highlight:SetVertexColor(mod.selectedColor.r,mod.selectedColor.g,mod.selectedColor.b);
  object.selected = true;

end

--select a object using a index
function mod:SelectButtonByIndex(index)

  --get the button and select it
  local button = self.mainFrame.scrollContent.items[index];
  self:SelectButton(button);

end

--get the current selected button
function mod:GetSelectedButton()

  --if we have none by default
  local result = nil;

  --find it
  for _,value in pairs(self.mainFrame.scrollContent.items) do

    if value.selected then
      result = value;
      break;
    end
  end

  --return value
  return result;

end

--manage scroll UP/DOWN
function mod:ManageScroll(direction)

  --if we dont have item return
  if self.totalItems==0 then return; end

  --get the current selected item
  local selected = self:GetSelectedButton();

  --if we dont have return
  if(not selected) then return; end

  --go to the new position
  local currentSelection = selected.position;
  local new;

  --reverse with shift
  if direction=="UP" then
    new = currentSelection-1;
  else
    new = currentSelection+1;
  end

  --loop position
  if new > self.totalItems then
    new = 1;
  elseif new < 1 then
    new = self.totalItems;
  end

  --if actualy we are going anywhere
  if not (currentSelection==new) then

    --select the new position
    self:SelectButtonByIndex(new);

    --scroll to it
    self:SetScroll(0);
    self.ScrollingFunction(self.mainFrame.scrollArea,-(4*(new-1)));

  end
end

--cursor keys pressed
function mod.OnArrowPressed(_, key)

  if (key=="UP" or key=="DOWN") then
    mod:ManageScroll(key);
  end

end

--if tab is press
function mod.OnTabPressed()

  --scroll up or down
  mod:ManageScroll(_G.IsShiftKeyDown() and "UP" or "DOWN");

end

--remove all items
function mod:ClearAllItems()

  --lopp the items
  for _,value in pairs(self.mainFrame.scrollContent.items) do

    --reset object
    value:Hide();
    value.data=nil;
    value:UnlockHighlight();
    value.selected = false;

  end

  --we dont have items
  self.totalItems=0;

  --reset items
  self.mainFrame.editBox.data = nil;
  self.mainFrame.iconButton.data = nil;

  --reset icon
  self.mainFrame.iconButton.icon:SetTexture("Interface\\Icons\\Temp");
end

--if the text has change
function mod.OnTextChanged(self)

  --get the text
  local text = self:GetText();

  --if has change from the previous text
  if not (self.lastText == text) then

    --clear all items
    mod:ClearAllItems();

    --store as last text
    self.lastText = text;

    --if actually we have any text
    if(text) then

      --find items for it
      local items = mod.search:FindAll(text);

      for _,value in pairs(items) do
        mod:AddItem(value);
      end

      --if we have any item, select the first
      if mod.totalItems > 0 then
        mod:SelectButtonByIndex(1);
      end

      --reset scroll
      mod:SetScroll(0);

      _G.wipe(items);

    end

  end

end

--create UI
function mod:CreateUI()

  --create main frame
  self.mainFrame = self.CreateUIObject("Frame",_G.UIParent);

  self.mainFrame:SetSize(800, 200);
  self.mainFrame:SetPoint("CENTER", 0, 0);

  self.mainFrame:SetSolidColor(0.2, 0.2, 0.2, 0.5);
  self.mainFrame:CreateBorder(-2,0,0,0);
  self.mainFrame:SetScript("OnMouseWheel", self.ScrollingFunction);

  --create icon button
  self.mainFrame.iconButton = self.CreateUIObject("Button",self.mainFrame,nil,"ActionButtonTemplate");
  self.mainFrame.iconButton:SetSize(32, 32);
  self.mainFrame.iconButton:SetPoint("TOPLEFT",  self.mainFrame, "TOPRIGHT",  6, 0);
  self.mainFrame.iconButton.icon:SetTexture("Interface\\Icons\\Temp");
  self.mainFrame.iconButton:flattern();
  --self.mainFrame.iconButton:SetSolidColor(0.2, 0.2, 0.2, 0.5);
  self.mainFrame.iconButton:CreateBorder(-3,0,0,0);
  self.mainFrame.iconButton:Show();

  --create last action button
  self.mainFrame.lastActionButton = self.CreateUIObject("Button",self.mainFrame,"Cecile_QL_IconButton","ActionButtonTemplate");
  self.mainFrame.lastActionButton:SetSize(16, 16);
  self.mainFrame.lastActionButton:SetPoint("TOPLEFT",  self.mainFrame, "TOPLEFT",   -16, 0);
  self.mainFrame.lastActionButton.icon:SetTexture("Interface\\Icons\\Temp");
  self.mainFrame.lastActionButton:flattern();
  self.mainFrame.lastActionButton:SetSolidColor(0.2, 0.2, 0.2, 0.5);
  self.mainFrame.lastActionButton:CreateBorder(-3,0,0,0);
  self.mainFrame.lastActionButton:Hide();

  --create edit box
  self.mainFrame.editBox = self.CreateUIObject("EditBox",self.mainFrame,"Launcher_Editbox");

  self.mainFrame.editBox:SetPoint("TOPLEFT",   self.mainFrame, "TOPLEFT",   8, -8);
  self.mainFrame.editBox:SetPoint("TOPRIGHT",  self.mainFrame, "TOPRIGHT", -8, -8);

  self.mainFrame.editBox:SetSolidColor(0.0, 0.0, 0.0, 0.5);
  self.mainFrame.editBox:CreateBorder(-2,0,0,0);

  self.mainFrame.editBox:SetText("");
  self.mainFrame.editBox:SetScript("OnEscapePressed", self.OnEscapePressed);
  self.mainFrame.editBox:SetScript("OnTextChanged", self.OnTextChanged);
  self.mainFrame.editBox:SetScript("OnTabPressed", self.OnTabPressed);
  --self.mainFrame.editBox:SetAltArrowKeyMode(true);
  self.mainFrame.editBox:HookScript("OnArrowPressed", self.OnArrowPressed);

  --create scroll area
  self.mainFrame.scrollArea = self.CreateUIObject("ScrollFrame",self.mainFrame);

  self.mainFrame.scrollArea:SetPoint("TOPLEFT",    self.mainFrame.editBox,  "BOTTOMLEFT",   0, -10);
  self.mainFrame.scrollArea:SetPoint("TOPRIGHT",     self.mainFrame.editBox,  "BOTTOMRIGHT",  -20, -10);
  self.mainFrame.scrollArea:SetPoint("BOTTOMLEFT",   self.mainFrame,      "BOTTOMLEFT",   0, 10);
  self.mainFrame.scrollArea:SetPoint("BOTTOMRIGHT",  self.mainFrame,      "BOTTOMRIGHT",  -20, 10);

  self.mainFrame.scrollArea:SetSolidColor(0.0, 0.0, 0.0, 0.5);
  self.mainFrame.scrollArea:CreateBorder(-2,0,0,0);

  --slider box
  self.mainFrame.sliderBox = self.CreateUIObject("Frame",self.mainFrame);

  self.mainFrame.sliderBox:SetPoint("TOPLEFT",   self.mainFrame.scrollArea, "TOPRIGHT",   5, 0);
  self.mainFrame.sliderBox:SetPoint("TOPRIGHT",  self.mainFrame.scrollArea, "TOPRIGHT",   20, 0);
  self.mainFrame.sliderBox:SetPoint("BOTTOMLEFT",  self.mainFrame.scrollArea, "BOTTOMLEFT",   5, 0);
  self.mainFrame.sliderBox:SetPoint("BOTTOMRIGHT", self.mainFrame.scrollArea, "BOTTOMLEFT",   20, 0);

  self.mainFrame.sliderBox:SetSolidColor(0.0, 0.0, 0.0, 0.5);
  self.mainFrame.sliderBox:CreateBorder(-2,0,0,0);

  --slider
  self.mainFrame.slider = self.CreateUIObject("Frame",self.mainFrame.sliderBox);

  self.mainFrame.slider:SetPoint("TOPLEFT",    self.mainFrame.sliderBox,  "TOPLEFT",    4, -4);
  self.mainFrame.slider:SetPoint("TOPRIGHT",   self.mainFrame.sliderBox,  "TOPRIGHT",   -4, -4);
  self.mainFrame.slider:SetPoint("BOTTOMLEFT",   self.mainFrame.sliderBox,  "BOTTOMLEFT",   4, 4);

  self.mainFrame.slider.maxHeight = self.mainFrame:GetHeight();

  self.mainFrame.slider:SetPoint("BOTTOMRIGHT",  self.mainFrame.sliderBox,  "BOTTOMRIGHT",  4, 4);

  self.mainFrame.slider:SetSolidColor(0.5, 0.5, 0.5, 0.5);
  --self.mainFrame.slider:CreateBorder(1,0,0,0);

  --create scroll content
  self.mainFrame.scrollContent = self.CreateUIObject("Frame",self.mainFrame.scrollArea);
  self.mainFrame.scrollContent:SetWidth(800);
  self.mainFrame.scrollContent:SetHeight(4000);
  self.mainFrame.scrollContent:SetSolidColor(0.0, 0.0, 0.0, 0.5);

  --attach the scroll content to the scroll area
  self.mainFrame.scrollArea:SetScrollChild(self.mainFrame.scrollContent);

  --create empty items
  self.mainFrame.scrollContent.items = {};

  --max number of items
  self.maxItems = 200;

  for i=1,self.maxItems do
    mod:CreateScrollItem("test"..i);
  end

  --we dont have any item, yet
  self.totalItems = 0;

  --hide the frame
  self.mainFrame:Hide();

  --set the handlers
  self.mainFrame.iconButton:SetScript("OnClick", self.OnButtonClick);
  self.mainFrame.lastActionButton:SetScript("OnClick",self.OnButtonClick);
  self.mainFrame.editBox:SetScript("OnEnterPressed", self.OnButtonClick);

  --create secure button
  self.secureButton = self.CreateUIObject("Button",_G.UIParent,"CQL_SECURE_BUTTON","ActionButtonTemplate,SecureActionButtonTemplate");
  self.secureButton:SetSize(64, 64);
  self.secureButton:SetPoint("CENTER", 0, 0);

  self.secureButton:RegisterForClicks("AnyUp");
  self.secureButton:flattern();
  self.secureButton:CreateBorder(-3,0,0,0);

  self.secureButton.cooldown:ClearAllPoints();

  self.secureButton.cooldown:SetPoint('TOPLEFT', self.secureButton, 'TOPLEFT', 0, 0)
  self.secureButton.cooldown:SetPoint('BOTTOMRIGHT', self.secureButton, 'BOTTOMRIGHT', 0, 0)

  self.secureButton.cooldown:SetDrawEdge(false);
  self.secureButton.cooldown:SetSwipeColor(0, 0, 0, 1);

  self.secureButton:HookScript("OnClick", self.secureClick);
  self.secureButton:HookScript("OnEnter", self.secureOnEnter);
  self.secureButton:HookScript("OnLeave", self.secureOnLeave);

  self.secureButton.help = _G.CreateFrame("Frame", self.secureButton, _G.UIParent)
  self.secureButton.help.text = self.secureButton.help:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  self.secureButton.help.text:SetJustifyH("CENTER");
  self.secureButton.help.text:SetJustifyV("TOP");
  self.secureButton.help.text:SetText("");
  self.secureButton.help.text:SetPoint("TOP",self.secureButton,"BOTTOM", 0, -5);
  self.secureButton.help:Hide();


  self.secureButton.name = _G.CreateFrame("Frame", self.secureButton, _G.UIParent)
  self.secureButton.name.text = self.secureButton.name:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
  self.secureButton.name.text:SetJustifyH("CENTER");
  self.secureButton.name.text:SetJustifyV("TOP");
  self.secureButton.name.text:SetText("");
  self.secureButton.name.text:SetPoint("BOTTOM",self.secureButton,"TOP", 0, 5);
  self.secureButton.name:Hide();

  self.secureButton:Hide();


  self.secureButtonClose = self.CreateUIObject("Button",_G.UIParent,"CQL_SECURE_BUTTON_CLOSE","SecureActionButtonTemplate");
  self.secureButtonClose:HookScript("OnClick", self.secureHide);
  self.secureButtonClose:Hide();

  debug("UI created");

end

--event when we enter combat
function mod.InCombat()
  mod.combat = true;
  mod:Show(false);
  mod.secureHide();
end

--event when we exit combat
function mod.OutOfCombat()
  mod.combat = false;
end

--save & remove a binding
function mod.SafeSetBinding(key, action)
  if key == "" then
    local oldkey = _G.GetBindingKey(action)
    if oldkey then
      _G.SetBinding(oldkey, nil)
    end
  else
    _G.SetBinding(key, action)
  end
  _G.SaveBindings(_G.GetCurrentBindingSet())
end


--set a default binding if no one has it
function mod:SetDefaultBinding(key,action)

  --get our binding
  local ourkey1,ourkey2 = _G.GetBindingKey(action);

  --if we dont have it
  if (ourkey1==nil) and (ourkey2==nil) then

    --get possible action for this binding since SHIFT-P or CTRL-SHIFT-P look the same
    local possibleAction = _G.GetBindingByKey(key);

    --by default we could set this binding
    local okToSet = true;

    --if any action
    if possibleAction then

      --get the action keys
      local key1,key2 = _G.GetBindingKey(possibleAction);

      --if any key match our key
      if (key1 == key) or (key2 == key) then
        okToSet = false;
      end

    end

    --if ok to set
    if okToSet then
      self.SafeSetBinding(key,action);
      debug("default binding '%s' set to '%s'", action, key);
    end

  end

end

function mod.playerFlagChanged(_, unit)

  if (unit ~= "player") then
    return;
  end

  if _G.UnitIsAFK(unit) then
    debug("triggering garbage collector");
    collectgarbage("collect");
  end

end

function mod.playerEnteringWorld()
  debug("triggering garbage collector");
  collectgarbage("collect");
end

--initialize the module
function mod:OnInitialize()

  --create the UI
  self:CreateUI();

  --load profile settings
  self:LoadProfileSettings();

  --save the serch module
  self.search = Engine.AddOn:GetModule("search");

  --we are not in combat
  self.combat = false;

  --handle in combat
  Engine.AddOn:RegisterEvent("PLAYER_REGEN_ENABLED",self.OutOfCombat);
  Engine.AddOn:RegisterEvent("PLAYER_REGEN_DISABLED",self.InCombat);

  Engine.AddOn:RegisterEvent("PLAYER_FLAGS_CHANGED",self.playerFlagChanged);
  Engine.AddOn:RegisterEvent("PLAYER_ENTERING_WORLD",self.playerEnteringWorld);


end

--reset the UI
function mod:ResetUI()

  self:SetScroll(0);
  self.mainFrame.editBox:SetText("");
  self:ClearAllItems();

end

--show/hide the main window
function mod:Show(value)

  --if we like to show
  if(value) then

    --if we actually no shown
    if not self.mainFrame:IsShown() then

      --if we are in combat display a message and return
      if self.combat then
        --get version
        local Version = Engine.AddOn:GetModule("version");

        print(string.format(L["WINDOW_ERROR_IN_COMBAT"],Version.Title));
        return;
      end

      self.search:Refresh();

      --reset UI
      self:ResetUI();

      --show the window
      self.mainFrame:Show();

    end
  else

    --if we actually shown, hide
    if self.mainFrame:IsShown() then
      self.mainFrame:Hide();
      self.search:Wipe();
    end
  end

  --always hide the secure button
  self.secureHide();

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

  --if the command is 'show'
  if args=="launch" then

    --show
    mod:Show(true);

    --this module has handle the command
    handleIt = true;

  end

  return handleIt;

end
