----------------------------------------------------------------------------------------------------
-- Handle add-on configuration
--

--get the engine & Add-on
local Engine = select(2,...);
local AddOn = Engine.AddOn;

--load libraries
local AceConfig = LibStub("AceConfig-3.0");
local AceConfigDialog = LibStub("AceConfigDialog-3.0");
local AceDB = LibStub("AceDB-3.0");
local AceDBOptions = LibStub("AceDBOptions-3.0");
local LibDualSpec = LibStub('LibDualSpec-1.0');

--get locale
local L = Engine.Locale;

--defaults
Engine.DB = {};
Engine.DB.profile={};
Engine.Profile = Engine.DB.profile;

--return two slash commands from a add-on name, for example Cecile_ExampleAddon will return cea & cecile_ea
function AddOn:GetSlashFromName(name)

	local slash1 = "";
	local slash2 = "";

	local i;
	local c;
	local picknext = true;
	local pickedfirstspace = false;

	for i = 1, string.len(name) do

		c = string.sub(name,i,i);

		if (picknext) then
			slash1 = slash1 .. string.lower(c);
			if pickedfirstspace then
				slash2 = slash2 .. string.lower(c);
			end
			picknext = false;
		else
			if (c=="_") or (c==" ") then
				picknext = true;
				pickedfirstspace = true;
				slash2 =  slash2..string.lower(string.sub(name,1,i-1)).."_";
			elseif (c==string.upper(c)) then
				slash1 = slash1 .. string.lower(c);
				if pickedfirstspace then
					slash2 = slash2 .. string.lower(c);
				end
			end
		end
	end
	if not pickedfirstspace then
		slash2 = slash2 .. string.lower(name);
	end

	return slash1,slash2;
end

function AddOn:SetupDefaults(object,parent)

	--set-up module options and defaults
	local module,name;
	local databaseName,databaseTable;

	--goes trough all the modules
	for name,module in pairs(object.modules) do

		--if this module has defaults
		if(module.Defaults) then

			--get all defaults tables of the module andd add then to the global defaults
			for databaseName,databaseTable in pairs(module.Defaults) do

				if parent then
					Engine.Defaults[databaseName][parent][name] = databaseTable;

				else
					Engine.Defaults[databaseName][name] = databaseTable;
				end

			end

		end

		if not parent then
			AddOn:SetupDefaults(module,name);
		end

	end

end

--setup options
function AddOn:SetupOptions()

	--setup modules default
	AddOn:SetupDefaults(self);

	--create database
	Engine.DB = AceDB:New(Engine.Name.."DB", Engine.Defaults, true);
	Engine.GLOBAL = _G[Engine.Name.."DB"];

	--set profile
	Engine.Profile = Engine.DB.profile;

	--get the slash commands
	Engine.slash1,Engine.slash2 = AddOn:GetSlashFromName(Engine.Name);

	-- Create slash commands
	_G["SLASH_"..Engine.Name.."1"] = "/"..Engine.slash1;
	_G["SLASH_"..Engine.Name.."2"] = "/"..Engine.slash2;
	SlashCmdList[Engine.Name] = AddOn.HandleCommands;


end

--create options for blizzard ui
function AddOn:RegisterBlizzardOptions()


	--local vars
	local k,sorted;
	sorted = {};

	--get version
	local Version = AddOn:GetModule("version");

	--register the table and add it to blizzar config ui
	AceConfig:RegisterOptionsTable(Engine.Name,Engine.Options);
	AceConfigDialog:AddToBlizOptions(Engine.Name,Version.Title);

	--goes trough all the modules
	for name,module in pairs(self.modules) do

		if module.Options then
			table.insert(sorted,module.Options);
		end

	end

	--sort by order
	table.sort(sorted, function(a,b) return a.order < b.order end);

	--go trouh the table
	for k,v in pairs(sorted) do

		--register the table and add it to blizzar config ui
		AceConfig:RegisterOptionsTable(Engine.Name..k, v);
		AceConfigDialog:AddToBlizOptions(Engine.Name..k,v.name,Version.Title);

	end

	--register profile changes callbacks
	Engine.DB.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged");
	Engine.DB.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged");
	Engine.DB.RegisterCallback(self, "OnProfileReset", "OnProfileChanged");

	--create profile options
	local profileOptions = AceDBOptions:GetOptionsTable(Engine.DB);
	profileOptions.name = L["PROFILES"];

	--setup lib dual spec
	LibDualSpec:EnhanceDatabase(Engine.DB, Engine.Name);
	LibDualSpec:EnhanceOptions(profileOptions, Engine.DB);

	--register the table and add it to blizzar config ui
	AceConfig:RegisterOptionsTable(Engine.Name.."Profile", profileOptions);
	AceConfigDialog:AddToBlizOptions(Engine.Name.."Profile",L["PROFILES"],Version.Title);

end

function AddOn:OpenBlizzardConfig()
	--get version
	local Version = AddOn:GetModule("version");

	--open config twice (yes, if not does not work always)
	InterfaceOptionsFrame_OpenToCategory(Version.Title);
	InterfaceOptionsFrame_OpenToCategory(Version.Title);
end

-- Handle commands
function AddOn.HandleCommands(args)
	--if not parameters show configuration
	if args == nil then
		AddOn:OpenBlizzardConfig()
	else

		--to check if any module has handle this command
		local handleByModule = false;

		--goes trough the modules
		for name,module in pairs(AddOn.modules) do

			--if any module has a HandleCommands
			if module.handleCommand and type(module.handleCommand)=="function" then

				--call it and mark that a module has handle it
				handleByModule = handleByModule or module.handleCommand(args);

			end

		end

		--if not module has handle it, open configuration
		if not handleByModule then

			AddOn:OpenBlizzardConfig();

		end

	end
end

-- Called after profile changed
function AddOn:OnProfileChanged(event, database, newProfileKey)

	--set new profile
	Engine.Profile = database.profile;

	--notify modules profile change
	local module,name;

	--if any module has a OnProfileChange trigger it
	for name,module in pairs(self.modules) do

		if module.OnProfileChanged and type(module.OnProfileChanged)=="function" then
			module.OnProfileChanged(event);
		end

	end

end

function AddOn:NotifyChange(object)

	--notify module
	local module,name;

	--if any module has a OnProfileChange trigger it
	for name,module in pairs(object.modules) do

		if module.LoadProfileSettings and type(module.LoadProfileSettings)=="function" then
			module:LoadProfileSettings();
		end

		AddOn:NotifyChange(module);
	end

end

function AddOn:OnCfgChange()

	AddOn:NotifyChange(self);

	local LDBIcon = LibStub("LibDBIcon-1.0", true);

	LDBIcon:Refresh(Engine.Name);

end

function AddOn:SetupMinimapIcon()

	--get version
	local label = string.format(L["MINIMAP_LABEL"],GetAddOnMetadata(Engine.Name, "Title"),GetAddOnMetadata(Engine.Name, "Version"));
	local icon_file = GetAddOnMetadata(Engine.Name, "X-Icon");

	--get libraries
	local LDB = LibStub("LibDataBroker-1.1", true);
	local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true);

	if LDB then

		local databroker = LDB:NewDataObject(Engine.Name, {
			type = "data source",
			icon = icon_file,
			text = "0",

			HotCornerIgnore = true,

			OnClick = function (self, button)

				if (button == "LeftButton") then

					AddOn.HandleCommands("launch");

				elseif (button == "RightButton") then

					AddOn.HandleCommands();

				end

			end,
			OnTooltipShow = function (tooltip)
				tooltip:AddLine(label, 1, 1, 1);
				tooltip:AddLine(L["MINIMAP_HELP_1"]);
				tooltip:AddLine(L["MINIMAP_HELP_2"]);
			end,
		})

		if (databroker and not LDBIcon:IsRegistered(Engine.Name)) then
			LDBIcon:Register(Engine.Name, databroker, Engine.Profile.minimap);
		end

		AddOn.databroker = databroker;

	end

end