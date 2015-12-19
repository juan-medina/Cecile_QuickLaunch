----------------------------------------------------------------------------------------------------
-- Add-on Default Const, Options & Options UI
--

--get the engine & Locale
local AddOnName,Engine = ...;
local L = Engine.Locale;

--create the module
local mod = Engine.AddOn:NewModule("options");

--defaults
Engine.Defaults = {
	profile = {
			minimap = {
				hide = false,
			},
	},
	global = {
	},
};

--options table for the options UI
Engine.Options = {
	order = 1,
	type = "group",
	name = string.format(L["CONFIG_WINDOW"],GetAddOnMetadata(AddOnName, "Title"),GetAddOnMetadata(AddOnName, "Version")),
	cmdInline = true,
	args = {
		about = {
			order = 1,
			type = "description",
			name = L["ABOUT"],
			width = "full",
		},
	}
};

--initialize module
function mod:OnInitialize()
end