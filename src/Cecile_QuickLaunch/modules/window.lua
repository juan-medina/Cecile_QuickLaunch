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
					set = function(key, value)

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
					values = function(self)
						local k,v;

						names={};

						for k,v in pairs(mod.schemes) do
							names[k] = v.name;
						end

						return names;
					end,
					set = function(self,value)
							Engine.Profile.window.scheme = value;
							Engine.AddOn:OnCfgChange();
						end,
					get = function(self)
						return Engine.Profile.window.scheme;
					end,
				},
				font = {
					type = "select", dialogControl = 'LSM30_Font',
					order = 2,
					name = L["WINDOW_FONT"],
					desc = L["WINDOW_FONT_DESC"],
					values = AceGUIWidgetLSMlists.font,
					get = function()
						return Engine.Profile.window.font.name;
					end,
					set = function(key, value)
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
					set = function(key, value)
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
					set = function(key,r,g,b)
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
					set = function(key,r,g,b)
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
					set = function(key,r,g,b,a)
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
					set = function(key,r,g,b)
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
					set = function(key,r,g,b)
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
						return GetBindingKey("LAUNCH_CQL");
					end,
					set = function(key, value)
						mod:SafeSetBinding(value, "LAUNCH_CQL");
					end,
				},
				relaunch = {
					order = 2,
					type = "keybinding",
					name = L["WINDOW_BINDING_COMMAND"],
					desc = L["WINDOW_BINDING_COMMAND_DESC"],
					get = function()
						return GetBindingKey("CLICK Cecile_QL_IconButton:LeftButton");
					end,
						set = function(key, value)
						mod:SafeSetBinding(value, "CLICK Cecile_QL_IconButton:LeftButton");
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
		Engine.Profile.window.font = mod.schemes[scheme].font;
		Engine.Profile.window.colors = mod.schemes[scheme].colors;
	end

	--get the font
	mod.fontObject = LSM:Fetch("font", Engine.Profile.window.font.name);
	mod.fontSize = Engine.Profile.window.font.size;
	mod.fontColors = Engine.Profile.window.font.colors;

	mod.mainFrame.editBox:SetFont(mod.fontObject,mod.fontSize);
	mod.mainFrame.editBox:SetTextColor(mod.fontColors.highlight.r,mod.fontColors.highlight.g,mod.fontColors.highlight.b);
	mod.mainFrame.editBox:SetHeight(14);

	mod.colors = Engine.Profile.window.colors;

	mod.selectedColor = mod.colors.selected;
	mod.overColor = { r = mod.colors.selected.r/2 , g = mod.colors.selected.g/2 , b = mod.colors.selected.b/2  };

	--local vars
	local key,frame;

	--lopp the items
	for key,frame in pairs(mod.mainFrame.scrollContent.items) do

		--set the font
		frame.text:SetFont(mod.fontObject,mod.fontSize);
		frame.text:SetTextColor(mod.fontColors.normal.r,mod.fontColors.normal.g,mod.fontColors.normal.b);
		frame:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);
	end

	mod.mainFrame:SetSolidColor(mod.colors.frame.r, mod.colors.frame.g, mod.colors.frame.b, mod.colors.frame.a);
	mod.mainFrame:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);
	mod.mainFrame.iconButton:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);
	mod.mainFrame.editBox:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);
	mod.mainFrame.scrollArea:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);

	mod.mainFrame.sliderBox:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);
	mod.mainFrame.slider:SetSolidColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b, mod.colors.frame.a);

	mod.secureButton.help.text:SetFont(mod.fontObject,mod.fontSize);
	mod.secureButton.help.text:SetTextColor(mod.fontColors.normal.r,mod.fontColors.normal.g,mod.fontColors.normal.b);

	mod.secureButton.name.text:SetFont(mod.fontObject,mod.fontSize);
	mod.secureButton.name.text:SetTextColor(mod.fontColors.highlight.r,mod.fontColors.highlight.g,mod.fontColors.highlight.b);

	mod.secureButton:SetBorderColor(mod.colors.border.r, mod.colors.border.g, mod.colors.border.b);

end

--on escape pressed
function mod.OnEscapePressed()

	---hide the window
	mod:Show(false);

end

function mod.secureHide()
	mod.secureButton:Hide();
	mod.secureButtonClose:Hide();
	mod.secureButton.help:Hide();
	mod.secureButton.name:Hide();

	ClearOverrideBindings(mod.secureButton);
	ClearOverrideBindings(mod.secureButtonClose);
end

function mod.secureOnEnter(self)
	GameTooltip:SetOwner(mod.secureButton, "ANCHOR_RIGHT");

	mod.secureButton.addTooptipFunc(_G.GameTooltip,mod.secureButton.item.id,false,true);

end

function mod.secureOnLeave(self)
	GameTooltip:Hide();
end

--prepare the secure button
function mod:PrepareSecureButton(item,name,icon,help,start,duration,enable)

	mod.secureButton.icon:SetTexture(icon);

	mod.secureButton.help.text:SetText(string.format(help,
		mod.search:getColorString(mod.fontColors.highlight).._G.KEY_ENTER.."|r",
		mod.search:getColorString(mod.fontColors.highlight).._G.KEY_ESCAPE.."|r"));

	mod.secureButton.name.text:SetText(name);

	mod.secureButton.item = item;

	local cooldown = mod.secureButton.cooldown;
	if (cooldown and start and duration) then
		if (enable) then
			cooldown:Hide();
		else
			cooldown:Show();
		end
		CooldownFrame_SetTimer(cooldown, start, duration, enable);
	else
		cooldown:Hide();
	end

	mod.secureButton:Show();
	mod.secureButtonClose:Show();
	mod.secureButton.help:Show();
	mod.secureButton.name:Show();

  SetOverrideBindingClick(mod.secureButtonClose, true, "ESCAPE", "CQL_SECURE_BUTTON_CLOSE", "LeftClick");
	SetOverrideBindingClick(mod.secureButton, true, "ENTER", "CQL_SECURE_BUTTON", "LeftClick");

end

--use a spell
function mod:UseSpell(item)

	local name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(item.id);
	local start, duration, enable = GetSpellCooldown(name);
	local help = L["WINDOW_HELP_SPELL"];

	mod.secureButton.addTooptipFunc =_G.GameTooltip.SetSpellByID;

	mod.secureButton:SetAttribute("type","spell");
	mod.secureButton:SetAttribute("spell",item.id);

	if rank and not(rank=="") then
		name = name.." ("..rank..")";
	end

	local petIndex, petName = GetCallPetSpellInfo(spellID);
	if petIndex and petIndex and not(petName=="") then
			name = name.." ("..petName..")";
	end
	mod:PrepareSecureButton(item,name,icon,help,start,duration,enable);

end

--use a item
function mod:UseItem(item)

	local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, icon, vendorPrice = GetItemInfo(item.id);
	local start, duration, enable = GetItemCooldown(item.id);
	local help = L["WINDOW_HELP_ITEM"];

	if IsEquippableItem(name) and not IsEquippedItem(name) then
		help = L["WINDOW_HELP_ITEM_EQUIPP"];
	end

	if _G.PlayerHasToy(item.id) then
		mod.secureButton.addTooptipFunc =_G.GameTooltip.SetToyByItemID;
	else
		mod.secureButton.addTooptipFunc =_G.GameTooltip.SetItemByID;
	end

	mod.secureButton:SetAttribute("type","item");
	mod.secureButton:SetAttribute("item",name);

	mod:PrepareSecureButton(item,name,icon,help,start,duration,enable);

end

--default action on button click
function mod.OnButtonClick(object)

	--hide the the window
	mod:Show(false);

	--call the object func if we have any function
	if object.data then

		--if we have a funcion call it
		if object.data.func then
				object.data:func();
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
	--if object.SetHighlightTexture then object:SetHighlightTexture("") end
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
		border = CreateFrame("Frame", nil, object);
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
function mod:CreateUIObject(class,parent,name,template)

	local frame = CreateFrame(class, name, parent, template);

	frame.CreateBorder = mod.CreateBorder;
	frame.SetBorderColor = mod.SetBorderColor;
	frame.SetSolidColor = mod.SetSolidColor;
	frame.flattern = mod.flattern;

	return frame;
end

--get the max possible scroll
function mod:GetMaxScroll()

	--get how many items could be drown on screen
	local onScreen = math.floor(mod.mainFrame.scrollArea:GetHeight() / 20);

	--get how we could scroll using how many we have and how manny fit
	local toScroll = (mod.totalItems-1) - onScreen;

	--get in ui coords
	local maxScroll = toScroll*20;

	--clamp negative values
	maxScroll = math.max(maxScroll,0);

	--return results
	return maxScroll;

end

--helper function to set the current scroll and update slider
function mod:SetScroll(value)
	mod.mainFrame.scrollArea:SetVerticalScroll(value);
	mod:UpdateSlider();
end

--update our slider
function mod:UpdateSlider()

	--get our max scroll
	local maxScroll = mod:GetMaxScroll();

	--by default slider cover all him box
	local from = 0;
	local to = 0;

	--if we have something to scroll
	if not (maxScroll==0) then

		--get current scroll
		local currentScroll = mod.mainFrame.scrollArea:GetVerticalScroll();

		--calculcate el % of our position
		local percent = currentScroll/maxScroll;

		--calculate from-to
		from = 75*percent;
		to = 75*(1-percent);
	end

	--remve anchors
	mod.mainFrame.slider:ClearAllPoints();

	--set new anchors
	mod.mainFrame.slider:SetPoint("TOPLEFT", 		mod.mainFrame.sliderBox,	"TOPLEFT", 		4, -4-from);
	mod.mainFrame.slider:SetPoint("TOPRIGHT",		mod.mainFrame.sliderBox,	"TOPRIGHT", 	-4, -4-from);
	mod.mainFrame.slider:SetPoint("BOTTOMLEFT", 	mod.mainFrame.sliderBox,	"BOTTOMLEFT", 	4, 4+to);
	mod.mainFrame.slider:SetPoint("BOTTOMRIGHT",	mod.mainFrame.sliderBox,	"BOTTOMRIGHT", 	4, 4+to);

end

---scroll the window with mouse wheel
function mod.ScrollingFunction(self, arg)

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

function mod.OnButtonLeave(object)
end


function mod:CreateScrollItem(text)

	--get the position for this item
	local position = (#mod.mainFrame.scrollContent.items);

	--create the item
	local frame = mod:CreateUIObject("Button",mod.mainFrame.scrollContent,"LauncherButton"..position, "OptionsListButtonTemplate");

	--calculate start and end Y position
	local startY = position * -20;
	local endY = startY-20;

	--position the object
	frame:SetPoint("TOPLEFT", 		mod.mainFrame.scrollContent,"TOPLEFT", 	0, startY);
	frame:SetPoint("TOPRIGHT", 		mod.mainFrame.scrollContent,"TOPRIGHT",	0, startY);
	frame:SetPoint("BOTTOMLEFT", 	mod.mainFrame.scrollContent,"TOPLEFT", 	0, endY);
	frame:SetPoint("BOTTOMRIGHT",	mod.mainFrame.scrollContent,"TOPRIGHT", 0, endY);

	--set scripts
	frame:SetScript("OnEnter", mod.OnButtonEnter)
	frame:SetScript("OnLeave", mod.OnButtonLeave)


	--set style
	frame:CreateBorder(-1,0,0,0);

	--set the text
	frame.text:SetText(text);

	--store position
	frame.position = position+1;

	--set the hanlder
	frame:SetScript("OnClick", mod.OnButtonClick);
	frame.data = nil;

	--insert into our table
	table.insert(mod.mainFrame.scrollContent.items,frame);

	--hid this button
	frame:Hide();

end

--add a new item
function mod:AddItem(item)

	--if we are in our limit don't add
	if mod.totalItems<mod.maxItems then

		--count
		mod.totalItems = mod.totalItems + 1;

		--get the button
		local button = mod.mainFrame.scrollContent.items[mod.totalItems];

		--store the data
		button.data = item;

 		local text = format('|T%s:14:14:0:0:64:64:4:60:4:60|t %s',item.icon or "Interface\\Icons\\Temp", item.displayText);
		--set the text
		button.text:SetText(text);

		--display the button
		button:Show();

	end

end


--select a item
function mod:SelectButton(object)

	--goes trough the objects
	local key,value;

	--remove highlight and reset selected to all of them
	for key,value in pairs(mod.mainFrame.scrollContent.items) do
		value:UnlockHighlight();
		value.selected = false;

		object.highlight:SetVertexColor(mod.overColor.r,mod.overColor.g,mod.overColor.b);
	end

	--store in the edit box the one we like
	mod.mainFrame.editBox.data = object.data;
	mod.mainFrame.iconButton.data = object.data;

	--set the icon button
	local icon = object.data.icon or "Interface\\Icons\\Temp";
	mod.mainFrame.iconButton.icon:SetTexture(icon);

	--set this to selected
	object:LockHighlight();
	object.highlight:SetVertexColor(mod.selectedColor.r,mod.selectedColor.g,mod.selectedColor.b);
	object.selected = true;

end

--select a object using a index
function mod:SelectButtonByIndex(index)

	--get the button and select it
	local button = mod.mainFrame.scrollContent.items[index];
	mod:SelectButton(button);

end

--get the current selected button
function mod:GetSelectedButton()

	--if we have none by default
	local result = nil;

	--local vars
	local key,value;

	--find it
	for key,value in pairs(mod.mainFrame.scrollContent.items) do

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
	if mod.totalItems==0 then return; end

	--get the current selected item
	local selected = mod:GetSelectedButton();

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
	if new > mod.totalItems then
		new = 1;
	elseif new < 1 then
		new = mod.totalItems;
	end

	--if actualy we are going anywhere
	if not (currentSelection==new) then

		--select the new position
		mod:SelectButtonByIndex(new);

		--scroll to it
		mod:SetScroll(0);
		mod.ScrollingFunction(mod.mainFrame.scrollArea,-(4*(new-1)));

	end
end

--cursor keys pressed
function mod.OnArrowPressed(self, key)

	if (key=="UP" or key=="DOWN") then
		mod:ManageScroll(key);
	end

end

--if tab is press
function mod.OnTabPressed(object)

	--scroll up or down
	mod:ManageScroll(IsShiftKeyDown() and "UP" or "DOWN");

end

--remove all items
function mod:ClearAllItems()

	--local vars
	local key,value;

	--lopp the items
	for key,value in pairs(mod.mainFrame.scrollContent.items) do

		--reset object
		value:Hide();
		value.data=nil;
		value:UnlockHighlight();
		value.selected = false;

	end

	--we dont have items
	mod.totalItems=0;

	--reset items
	mod.mainFrame.editBox.data = nil;
	mod.mainFrame.iconButton.data = nil;

	--reset icon
	mod.mainFrame.iconButton.icon:SetTexture("Interface\\Icons\\Temp");
end

--if the text has change
function mod.OnTextChanged(self,char)

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
			items = mod.search:FindAll(text);

			--loop trough the items and add them
			local key,value;

			for key,value in pairs(items) do
				mod:AddItem(value);
			end

			--if we have any item, select the first
			if mod.totalItems > 0 then
				mod:SelectButtonByIndex(1);
			end

			--reset scroll
			mod:SetScroll(0);

		end

	end

end

--create UI
function mod:CreateUI()

	--create main frame
	mod.mainFrame = mod:CreateUIObject("Frame",UIParent);

	mod.mainFrame:SetSize(800, 200);
	mod.mainFrame:SetPoint("CENTER", 0, 0);

	mod.mainFrame:SetSolidColor(0.2, 0.2, 0.2, 0.5);
	mod.mainFrame:CreateBorder(-2,0,0,0);
	mod.mainFrame:SetScript("OnMouseWheel", mod.ScrollingFunction);

	--create icon button
	mod.mainFrame.iconButton = mod:CreateUIObject("Button",mod.mainFrame,nil,"ActionButtonTemplate");
	mod.mainFrame.iconButton:SetSize(32, 32);
	mod.mainFrame.iconButton:SetPoint("TOPLEFT", 	mod.mainFrame, "TOPRIGHT", 	6, 0);
	mod.mainFrame.iconButton.icon:SetTexture("Interface\\Icons\\Temp");
	mod.mainFrame.iconButton:flattern();
	--mod.mainFrame.iconButton:SetSolidColor(0.2, 0.2, 0.2, 0.5);
	mod.mainFrame.iconButton:CreateBorder(-3,0,0,0);
	mod.mainFrame.iconButton:Show();

	--create last action button
	mod.mainFrame.lastActionButton = mod:CreateUIObject("Button",mod.mainFrame,"Cecile_QL_IconButton","ActionButtonTemplate");
	mod.mainFrame.lastActionButton:SetSize(16, 16);
	mod.mainFrame.lastActionButton:SetPoint("TOPLEFT", 	mod.mainFrame, "TOPLEFT", 	-16, 0);
	mod.mainFrame.lastActionButton.icon:SetTexture("Interface\\Icons\\Temp");
	mod.mainFrame.lastActionButton:flattern();
	mod.mainFrame.lastActionButton:SetSolidColor(0.2, 0.2, 0.2, 0.5);
	mod.mainFrame.lastActionButton:CreateBorder(-3,0,0,0);
	mod.mainFrame.lastActionButton:Hide();

	--create edit box
	mod.mainFrame.editBox = mod:CreateUIObject("EditBox",mod.mainFrame,"Launcher_Editbox");

	mod.mainFrame.editBox:SetPoint("TOPLEFT", 	mod.mainFrame, "TOPLEFT", 	8, -8);
	mod.mainFrame.editBox:SetPoint("TOPRIGHT", 	mod.mainFrame, "TOPRIGHT", -8, -8);

	mod.mainFrame.editBox:SetSolidColor(0.0, 0.0, 0.0, 0.5);
	mod.mainFrame.editBox:CreateBorder(-2,0,0,0);

	mod.mainFrame.editBox:SetText("");
	mod.mainFrame.editBox:SetScript("OnEscapePressed", mod.OnEscapePressed);
	mod.mainFrame.editBox:SetScript("OnTextChanged", mod.OnTextChanged);
	mod.mainFrame.editBox:SetScript("OnTabPressed", mod.OnTabPressed);
	--mod.mainFrame.editBox:SetAltArrowKeyMode(true);
	mod.mainFrame.editBox:HookScript("OnArrowPressed", mod.OnArrowPressed);

	--create scroll area
	mod.mainFrame.scrollArea = mod:CreateUIObject("ScrollFrame",mod.mainFrame);

	mod.mainFrame.scrollArea:SetPoint("TOPLEFT", 		mod.mainFrame.editBox,	"BOTTOMLEFT", 	0, -10);
	mod.mainFrame.scrollArea:SetPoint("TOPRIGHT", 		mod.mainFrame.editBox,	"BOTTOMRIGHT", 	-20, -10);
	mod.mainFrame.scrollArea:SetPoint("BOTTOMLEFT", 	mod.mainFrame,			"BOTTOMLEFT", 	0, 10);
	mod.mainFrame.scrollArea:SetPoint("BOTTOMRIGHT",	mod.mainFrame,			"BOTTOMRIGHT", 	-20, 10);

	mod.mainFrame.scrollArea:SetSolidColor(0.0, 0.0, 0.0, 0.5);
	mod.mainFrame.scrollArea:CreateBorder(-2,0,0,0);

	--slider box
	mod.mainFrame.sliderBox = mod:CreateUIObject("Frame",mod.mainFrame);

	mod.mainFrame.sliderBox:SetPoint("TOPLEFT", 	mod.mainFrame.scrollArea,	"TOPRIGHT", 	5, 0);
	mod.mainFrame.sliderBox:SetPoint("TOPRIGHT",	mod.mainFrame.scrollArea,	"TOPRIGHT", 	20, 0);
	mod.mainFrame.sliderBox:SetPoint("BOTTOMLEFT", 	mod.mainFrame.scrollArea,	"BOTTOMLEFT", 	5, 0);
	mod.mainFrame.sliderBox:SetPoint("BOTTOMRIGHT",	mod.mainFrame.scrollArea,	"BOTTOMLEFT", 	20, 0);

	mod.mainFrame.sliderBox:SetSolidColor(0.0, 0.0, 0.0, 0.5);
	mod.mainFrame.sliderBox:CreateBorder(-2,0,0,0);

	--slider
	mod.mainFrame.slider = mod:CreateUIObject("Frame",mod.mainFrame.sliderBox);

	mod.mainFrame.slider:SetPoint("TOPLEFT", 		mod.mainFrame.sliderBox,	"TOPLEFT", 		4, -4);
	mod.mainFrame.slider:SetPoint("TOPRIGHT",		mod.mainFrame.sliderBox,	"TOPRIGHT", 	-4, -4);
	mod.mainFrame.slider:SetPoint("BOTTOMLEFT", 	mod.mainFrame.sliderBox,	"BOTTOMLEFT", 	4, 4);

	mod.mainFrame.slider.maxHeight = mod.mainFrame:GetHeight();

	mod.mainFrame.slider:SetPoint("BOTTOMRIGHT",	mod.mainFrame.sliderBox,	"BOTTOMRIGHT", 	4, 4);

	mod.mainFrame.slider:SetSolidColor(0.5, 0.5, 0.5, 0.5);
	--mod.mainFrame.slider:CreateBorder(1,0,0,0);

	--create scroll content
	mod.mainFrame.scrollContent = mod:CreateUIObject("Frame",mod.mainFrame.scrollArea);
	mod.mainFrame.scrollContent:SetWidth(800);
	mod.mainFrame.scrollContent:SetHeight(4000);
	mod.mainFrame.scrollContent:SetSolidColor(0.0, 0.0, 0.0, 0.5);

	--attach the scroll content to the scroll area
	mod.mainFrame.scrollArea:SetScrollChild(mod.mainFrame.scrollContent);

	--create empty items
	mod.mainFrame.scrollContent.items = {};

	--max number of items
	mod.maxItems = 200;

	local i;
	for i=1,mod.maxItems do
		mod:CreateScrollItem("test"..i);
	end

	--we dont have any item, yet
	mod.totalItems = 0;

	--hide the frame
	mod.mainFrame:Hide();

	--set the handlers
	mod.mainFrame.iconButton:SetScript("OnClick", mod.OnButtonClick);
	mod.mainFrame.lastActionButton:SetScript("OnClick",mod.OnButtonClick);
	mod.mainFrame.editBox:SetScript("OnEnterPressed", mod.OnButtonClick);

	--create secure button
	mod.secureButton = mod:CreateUIObject("Button",UIParent,"CQL_SECURE_BUTTON","ActionButtonTemplate,SecureActionButtonTemplate");
	mod.secureButton:SetSize(64, 64);
	mod.secureButton:SetPoint("CENTER", 0, 0);

	mod.secureButton:RegisterForClicks("AnyUp");
	mod.secureButton:flattern();
	mod.secureButton:CreateBorder(-3,0,0,0);

	mod.secureButton.cooldown:ClearAllPoints();

	mod.secureButton.cooldown:SetPoint('TOPLEFT', mod.secureButton, 'TOPLEFT', 0, 0)
	mod.secureButton.cooldown:SetPoint('BOTTOMRIGHT', mod.secureButton, 'BOTTOMRIGHT', 0, 0)

	mod.secureButton.cooldown:SetDrawEdge(false);
	mod.secureButton.cooldown:SetSwipeColor(0, 0, 0, 1);

	mod.secureButton:HookScript("OnClick", mod.secureHide);
	mod.secureButton:HookScript("OnEnter", mod.secureOnEnter);
	mod.secureButton:HookScript("OnLeave", mod.secureOnLeave);

	mod.secureButton.help = CreateFrame("Frame", mod.secureButton, UIParent)
	mod.secureButton.help.text = mod.secureButton.help:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	mod.secureButton.help.text:SetJustifyH("CENTER");
	mod.secureButton.help.text:SetJustifyV("TOP");
	mod.secureButton.help.text:SetText("");
	mod.secureButton.help.text:SetPoint("TOP",mod.secureButton,"BOTTOM", 0, -5);
	mod.secureButton.help:Hide();


	mod.secureButton.name = CreateFrame("Frame", mod.secureButton, UIParent)
	mod.secureButton.name.text = mod.secureButton.name:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	mod.secureButton.name.text:SetJustifyH("CENTER");
	mod.secureButton.name.text:SetJustifyV("TOP");
	mod.secureButton.name.text:SetText("");
	mod.secureButton.name.text:SetPoint("BOTTOM",mod.secureButton,"TOP", 0, 5);
	mod.secureButton.name:Hide();

	mod.secureButton:Hide();


	mod.secureButtonClose = mod:CreateUIObject("Button",UIParent,"CQL_SECURE_BUTTON_CLOSE","SecureActionButtonTemplate");
	mod.secureButtonClose:HookScript("OnClick", mod.secureHide);
	mod.secureButtonClose:Hide();

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
function mod:SafeSetBinding(key, action)
	if key == "" then
		oldkey = GetBindingKey(action)
		if oldkey then
			SetBinding(oldkey, nil)
		end
	else
		SetBinding(key, action)
	end
	SaveBindings(GetCurrentBindingSet())
end


--set a default binding if no one has it
function mod:SetDefaultBinding(key,action)

	--get our binding
	local ourkey1,ourkey2 = GetBindingKey(action);

	--if we dont have it
	if (ourkey1==nil) and (ourkey2==nil) then

		--get possible action for this binding since SHIFT-P or CTRL-SHIFT-P look the same
		local possibleAction = GetBindingByKey(key);

		--by default we could set this binding
		local okToSet = true;

		--if any action
		if possibleAction then

			--get the action keys
			local key1,key2 = GetBindingKey(possibleAction);

			--if any key match our key
			if (key1 == key) or (key2 == key) then
				okToSet = false;
			end

		end

		--if ok to set
		if okToSet then
			mod:SafeSetBinding(key,action);
			debug("default binding '%s' set to '%s'", action, key);
		end

	end

end

function mod.playerFlagChanged(event, unit)

	if (unit ~= "player") then
		return;
	end

	if UnitIsAFK(unit) then
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
	mod:CreateUI();

	--load profile settings
	mod:LoadProfileSettings();

	--save the serch module
	mod.search = Engine.AddOn:GetModule("search");

	--we are not in combat
	mod.combat = false;

	--handle in combat
	Engine.AddOn:RegisterEvent("PLAYER_REGEN_ENABLED",mod.OutOfCombat);
	Engine.AddOn:RegisterEvent("PLAYER_REGEN_DISABLED",mod.InCombat);

	Engine.AddOn:RegisterEvent("PLAYER_FLAGS_CHANGED",mod.playerFlagChanged);
	Engine.AddOn:RegisterEvent("PLAYER_ENTERING_WORLD",mod.playerEnteringWorld);


end

--enable module
function mod:OnEnable()

end

--reset the UI
function mod:ResetUI()

		mod:SetScroll(0);
		mod.mainFrame.editBox:SetText("");
		mod:ClearAllItems();

end

--show/hide the main window
function mod:Show(value)

	--if we like to show
	if(value) then

		--if we actually no shown
		if not mod.mainFrame:IsShown() then

			--if we are in combat display a message and return
			if mod.combat then
				--get version
				local Version = Engine.AddOn:GetModule("version");

				print(string.format(L["WINDOW_ERROR_IN_COMBAT"],Version.Title));
				return;
			end

			mod.search:Refresh();

			--reset UI
			mod:ResetUI();

			--show the window
			mod.mainFrame:Show();

		end
	else

		--if we actually shown, hide
		if mod.mainFrame:IsShown() then
			mod.mainFrame:Hide();
		end
	end

	--always hide the secure button
	mod.secureHide();

end

--profile has change
function mod.OnProfileChanged(event)

	--load profile settings
	mod:LoadProfileSettings();

end

--handle commands
function mod.handleCommand(args)

	--has this module handle the command?
	handleIt = false;

	--if the command is 'show'
	if args=="launch" then

		--show
		mod:Show(true);

		--this module has handle the command
		handleIt = true;

	end

	return handleIt;

end