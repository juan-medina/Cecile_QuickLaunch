----------------------------------------------------------------------------------------------------
-- search module

--get the engine and create the module
local Engine = select(2,...);
local mod = Engine.AddOn:NewModule("search");

--get the locale
local L=Engine.Locale;

--debug
local debug = Engine.AddOn:GetModule("debug");

--module defaults
mod.Defaults = {
	profile = {
		disableModules = {},
		aliases = {
			cfg = "addon config",
			cql = "cecile_quickLaunch",
		},
		blacklist = {},
		twoSteps = false,
	},
};

--module options table
mod.Options = {
	order = 2,
	type = "group",
	name = L["SEARCH_NAME"],
	childGroups = "tab",
	args = {
		general = {
			name = L["SEARCH_GENERAL"],
			desc = L["SEARCH_GENERAL"],
			type = "group",
			order = 0,
			args = {
				twoSteps = {
					name = L["SEARCH_TWO_STEPS"],
					desc = L["SEARCH_TWO_STEPS_DESC"],
					type = "toggle",
					order = 1,
					get = function()
						return Engine.Profile.search.twoSteps;
					end,
					set = function(key, value)
						Engine.Profile.search.twoSteps = value;
						Engine.AddOn:OnCfgChange();
					end,
				},
				help = {
					order = 2,
					type = "description",
					name = L["SEARCH_TWO_STEPS_HELP"],
					width = "full",
				},
			},
		},
		aliases = {
			name = L["SEARCH_ALIASES"],
			type = "group",
			order = 1,
			args = {
				aliases = {
					order = 2,
					type = "select",
					name = L["SEARCH_ALIASES_DESC"],
					values = function(self)
						local k,v;

						names={};

						for k,v in pairs(Engine.Profile.search.aliases) do
							names[k] = k;
						end

						return names;
					end,
					set = function(self,value)
							mod.selectedAlias = value;
							mod.selectedAliasName = value;
							mod.selectedAliasValue = Engine.Profile.search.aliases[value];
						end,
					get = function(self)
						return mod.selectedAlias;
					end,
				},
				aliasName = {
					name = L["SEARCH_ALIAS_NAME"],
					order = 3,
					type = "input",
					width = "full",
					get = function(self)
						return mod.selectedAliasName;
					end,
					set = function(self,value)
						if value=="" then return; end
						mod.selectedAliasName=value:lower();
					end,
				},
				aliasValue = {
					name = L["SEARCH_ALIAS_VALUE"],
					order = 4,
					type = "input",
					width = "full",
					get = function(self)
						return mod.selectedAliasValue;
					end,
					set = function(self,value)
						if value=="" then return; end
						mod.selectedAliasValue = value:lower();
					end,
				},
				save = {
					name = L["SEARCH_ALIAS_SAVE"],
					desc = L["SEARCH_ALIAS_SAVE_DESC"],
					order = 6,
					type = "execute",
					func = function(self)
						if not mod.selectedAliasName then return; end
						if not mod.selectedAliasValue then return; end

						Engine.Profile.search.aliases[mod.selectedAliasName] = mod.selectedAliasValue;
						mod.selectedAlias = mod.selectedAliasName;
					end,
				},
				new = {
					name = L["SEARCH_ALIAS_NEW"],
					desc = L["SEARCH_ALIAS_NEW_DESC"],
					order = 7,
					type = "execute",
					func = function(self)
						mod.selectedAlias = nil;
						mod.selectedAliasName = nil;
						mod.selectedAliasValue = nil;
					end,
				},
				delete = {
					name = L["SEARCH_ALIAS_DELETE"],
					desc = L["SEARCH_ALIAS_DELETE_DESC"],
					order = 8,
					type = "execute",
					func = function(self)
						if not mod.selectedAliasName then return; end
						if not mod.selectedAliasValue then return; end

						Engine.Profile.search.aliases[mod.selectedAliasName] = nil;
						mod.selectedAlias = nil;
						mod.selectedAliasName = nil;
						mod.selectedAliasValue = nil;
					end,
				},
				help = {
					order = 9,
					type = "description",
					name = L["SEARCH_ALIAS_HELP"],
					width = "full",
				},
			},
		},
		blacklist = {
			name = L["SEARCH_BLACKLIST"],
			type = "group",
			order = 2,
			args = {
				blacklist = {
					order = 2,
					type = "select",
					name = L["SEARCH_BLACKLIST_DESC"],
					values = function(self)
						local k,v;

						names={};

						for k,v in pairs(Engine.Profile.search.blacklist) do
							names[k] = k;
						end

						return names;
					end,
					set = function(self,value)
							mod.selectedBlacklist = value;
							mod.selectedBlacklistName = value;
							mod.selectedBlacklistValue = Engine.Profile.search.blacklist[value];
						end,
					get = function(self)
						return mod.selectedBlacklist;
					end,
				},
				blacklistName = {
					name = L["SEARCH_BLACKLIST_NAME"],
					order = 3,
					type = "input",
					width = "full",
					get = function(self)
						return mod.selectedBlacklistName;
					end,
					set = function(self,value)
						if value=="" then return; end
						mod.selectedBlacklistName=value:lower();
					end,
				},
				blacklistValue = {
					name = L["SEARCH_BLACKLIST_VALUE"],
					order = 4,
					type = "input",
					width = "full",
					get = function(self)
						return mod.selectedBlacklistValue;
					end,
					set = function(self,value)
						if value=="" then return; end
						mod.selectedBlacklistValue = value:lower();
					end,
				},
				save = {
					name = L["SEARCH_BLACKLIST_SAVE"],
					desc = L["SEARCH_BLACKLIST_SAVE_DESC"],
					order = 6,
					type = "execute",
					func = function(self)
						if not mod.selectedBlacklistName then return; end
						if not mod.selectedBlacklistValue then return; end

						Engine.Profile.search.blacklist[mod.selectedBlacklistName] = mod.selectedBlacklistValue;
						mod.selectedBlacklist = mod.selectedBlacklistName;
					end,
				},
				new = {
					name = L["SEARCH_BLACKLIST_NEW"],
					desc = L["SEARCH_BLACKLIST_NEW_DESC"],
					order = 7,
					type = "execute",
					func = function(self)
						mod.selectedBlacklist = nil;
						mod.selectedBlacklistName = nil;
						mod.selectedBlacklistValue = nil;
					end,
				},
				delete = {
					name = L["SEARCH_BLACKLIST_DELETE"],
					desc = L["SEARCH_BLACKLIST_DELETE_DESC"],
					order = 8,
					type = "execute",
					func = function(self)
						if not mod.selectedBlacklistName then return; end
						if not mod.selectedBlacklistValue then return; end

						Engine.Profile.search.blacklist[mod.selectedBlacklistName] = nil;
						mod.selectedBlacklist = nil;
						mod.selectedBlacklistName = nil;
						mod.selectedBlacklistValue = nil;
					end,
				},
				help = {
					order = 9,
					type = "description",
					name = L["SEARCH_BLACKIST_HELP"],
					width = "full",
				},
			},
		},
		modules = {
			name = L["SEARCH_MODULES"],
			type = "group",
			order = 3,
			args = {
			}
		}
	}
};

--returna a color string for a giving color in rgba(floats)
function mod:getColorString(color)

	local result = string.format("|c%02X%02X%02X%02X",
		color.a and color.a*255 or 255,
		color.r*255,
		color.g*255,
		color.b*255)

	return result;
end


function mod:LoadProfileSettings()
	local name, module, isDisabled;

	for name,module in pairs(mod.modules) do

		isDisabled =  Engine.Profile.search.disableModules[name];

		if(isDisabled) then
			module:Disable();
		else
			module:Enable();
		end

	end

	mod.fontColors = Engine.Profile.window.font.colors;

	mod.highlight = mod:getColorString(mod.fontColors.highlight);

	mod.twoSteps = Engine.Profile.search.twoSteps;

end

--profile change
function mod:OnProfileChanged(event)

		mod:LoadProfileSettings();

end

function mod.twoStepsSelectModule(item)
	--local vars
	local name,module;

	--goes trough all the modules
	for name,module in pairs(mod.modules) do

		if module:IsEnabled() then

			--clear items
  		module.items = {};

  		--only refresh the module that we have choose
  		if name == item.id then

  			module:Refresh();

  		end

  	end

	end

	--get the window module
	local window = Engine.AddOn:GetModule("window");

	--reset UI
	window:ResetUI();

	--show the window
	window.mainFrame:Show();

end

function mod:Refresh()

	debug("refreshing search data");

	--local vars
	local name,module;

	--goes trough all the modules
	for name,module in pairs(self.modules) do

		--local vars
		local item, searchableText;

		if module:IsEnabled() then

			--clear items
  		module.items = {};

			--if we are doing two steps searchs
			if mod.twoSteps then

				--setup text
				searchableText = L["SEARCH_MODULES"] .. ": " .. module.desc;

				--setup item
				item = { text = searchableText , id=name, func = mod.twoStepsSelectModule};

				--add the item
				table.insert(module.items,item);

			else

				module:Refresh();

			end

		end

	end

	debug("data refreshed");

end

--check if we match this item with the entered text
function mod:MatchItem(item,text)

	--set to lower case
	local item = item:lower();

	--flag to control if we match every wod
	local matchAllWords = true;

	--local vars
	local word;

	--go word by word and check if we match
	for word in string.gmatch(text, "[^ ]+") do
		matchAllWords = matchAllWords and (not (string.find(item,word)==nil) );
	end

	--return all words
	return matchAllWords;

end

--color string based on match
function mod:ColorItem(item,text)

	--our result
	local result = item;

	--convert to lower
	local item = item:lower();

	--local vars
	local word;
	local positions = {};
	local pos;

	--go word by word
	for word in string.gmatch(text, "[^ ]+") do

		--if we get one store the position on the string
		local startPos,endPos = string.find(item,word);
		pos = { from = startPos, to = endPos };

		table.insert(positions,pos);

	end

	--sort the positions
	table.sort(positions, function(a,b) return a.from < b.from end);

	--more local vars
	local concatenated = "";
	local before,token, after;

	--we have not modified, yet
	local acumulated = 0;

	--loop the words
	for k,pos in pairs(positions) do

		--empty result
		concatenated = "";

		--move if we have alreayd modified something
		pos.from = pos.from + acumulated;
		pos.to = pos.to + acumulated;

		--get before token string
		if not (pos.from==1) then
			before  = string.sub(result,1,pos.from-1);
		else
			before = "";
		end

		--get the token and after string
		token = string.sub(result,pos.from,pos.to);
		after = string.sub(result,pos.to+1);

		--colorize it
		result = before..mod.highlight..token.."|r"..after;

		--we increase next positions
		acumulated = acumulated + 12;

	end

	return result;

end

--remove words that are part of other words, for example remove "mount" if you are searching as well "mo"
function mod:MergeWords(text)

	--our result
	local result = "";


	--to get our list of words
	local words={};

	--transform the string into a list of words
	for word in string.gmatch(text, "[^ ]+") do
		table.insert(words,word);
	end

	--sort them by len
	table.sort(words, function(a,b) return string.len(a) < string.len(b) end);

	--local vars
	local i,j;

	--will have the words that are required
	local newwords={};

	---loops from each word ty to find if other word cotain it.
	for i=1,#words do

		--we have not fonund any
		found = false;

		--we start in next word to where we are
		for j=i+1,#words do

			--if we could not find it
			if not (string.find(words[j],words[i])==nil) then
				found = true;
			end

		end

		--if we dont find any word this need to be added
		if not found then
			table.insert(newwords,words[i]);
		end
	end

	--create the result
	for k,word in pairs(newwords) do
		result = result .. word .. (result and " " or "");
	end

	return result;

end

--find in a module
function mod:FindInModule(module,text)

	--our result
	local result = {};

	--local vars
	local word;
	local k,item;
	local words;

	--loop al items
	for k, item in pairs(module.items) do

		--if this item match
		if mod:MatchItem(item.text,text) then

			--add color
			item.displayText = mod:ColorItem(item.text,text);

			--insert into the table
			table.insert(result,item);

		end

	end

	return result;

end

--expand aliases
function mod:ExpandAliases(text)

	local result = text;

	local k,v;

	for k,v in pairs(Engine.Profile.search.aliases) do
		result = string.gsub(result,k,v:lower());
	end

	return result;

end

--find all items using the text
function mod:searchAll(text)

	--our result
	local result = {};

	--local vars
	local items;

	--double check that we need something to search
	if (text==nil) then return result; end
	if (text=="") then return result; end

		--expand aliases
	local merged = mod:ExpandAliases(text:lower());

	--correct the text
	local corrected = mod:MergeWords(merged);

	--local vars
	local module,name, key, item;

	--goes trough all the modules
	for name,module in pairs(self.modules) do

		if module:IsEnabled() then

			--get the items for this module
			items = mod:FindInModule(module,corrected);

			--merge the tables
			for key,item in pairs(items) do
				table.insert(result,item);
			end

			--we dont need it anymore
			items = nil;

		end

	end

	return result;

end

--find all items using the text and apply blacklist
function mod:FindAll(text)

	--local vars
	local items = {};
	local blacklistItems = {};
	local key,value,item,blacklistKey,blacklistItem,blacklisted;

	--find all items
	local findItems = mod:searchAll(text);

	--search blacklist items
	for key,value in pairs(Engine.Profile.search.blacklist) do

		items = mod:searchAll(value);

			--merge the tables
			for key,item in pairs(items) do
				table.insert(blacklistItems,item);
			end

	end

	--empty result
	items = {};

	--goes trough the finded items
	for key,item in pairs(findItems) do

		--item is not blacklisted by default
		blacklisted = false;

		--goes trought the black list
		for blacklistKey,blacklistItem in pairs(blacklistItems) do

			--if the item is blacklisted mark it
			if item.text == blacklistItem.text then
				blacklisted = true;
				break;
			end

		end

		--add the item to the result
		if not blacklisted then
			table.insert(items,item);
		end

	end

	blacklistItems = nil;
	findItems = nil;

	return items;

end

--enable module
function mod:OnEnable()

end

function mod.preInitialize(module)

	--if we have vars
	if module.Vars then

		--default profile vars
		module.Defaults = { profile = {} };

		--default options ui
		module.Options = {
				type = "group",
				name = module.desc,
				args = {},
		};

		--temporary vars
		local name, options;

		--loop vars
		for name , options in pairs(module.Vars) do

			--set the default profile value
			module.Defaults.profile[name] = options.default;

			if options.type == "boolean" then
				--setup the option
				module.Options.args[name] = {
					order = options.order,
					type = "toggle",
					name = options.label,
					desc = options.desc,
					get = function()
						return module.Profile[name];
					end,
					set = function(key, value)
						module.Profile[name] = value;
					end,
		      disabled = function()
		        return not module:IsEnabled();
		      end,
				};
			elseif options.type == "string" then
				--setup the option
				module.Options.args[name] = {
					order = options.order,
					type = "input",
					name = options.label,
					desc = options.desc,
					get = function()
						return module.Profile[name];
					end,
					set = function(key, value)
						if not (value=="") then
							module.Profile[name] = value;
						end
					end,
		      disabled = function()
		        return not module:IsEnabled();
		      end,
				};
			end

		end

	end

	if module.Defaults then

	  module.DB = Engine.DB:RegisterNamespace(module:GetName(), module.Defaults);

		module.Profile = module.DB.profile;

		module.OnProfileChanged = function (event,database, newProfileKey)
				module.Profile = database.profile;
		end

		module.DB.RegisterCallback(module, "OnProfileChanged", module.OnProfileChanged);
		module.DB.RegisterCallback(module, "OnProfileCopied", module.OnProfileChanged);
		module.DB.RegisterCallback(module, "OnProfileReset", module.OnProfileChanged);

	end

	if not module.Options then

		module.Options = {
				type = "group",
				name = module.desc,
				args = {},
		};

	end

	module.Options.args["enable"] = {
		order = 0,
		type = "toggle",
		name = L["SEARCH_ENABLE_MODULE"],
		desc = L["SEARCH_ENABLE_MODULE_DESC"],
		get = function()
			return module:IsEnabled();
		end,
		set = function(key, value)

			if(value) then
				module:Enable();
			else
				module:Disable();
			end

			Engine.Profile.search.disableModules[module:GetName()] = (not value);

		end,
	};

	mod.Options.args.modules.args[module:GetName()] = module.Options;

  --we dont have items
  module.items = {};

  debug("module '"..module.desc.."' initialize");

end

function mod.preEnable(module)

  --we dont have items
  module.items = {};

  debug("module '"..module.desc.."' enabled");


end

function mod.preDisable(module)

  --clear items
  module.items = {};

  debug("module '"..module.desc.."' disabled");

end

--initialize the module
function mod:OnInitialize()

	mod.window = Engine.AddOn:GetModule("window");

	debug("search module initialize");

	mod:LoadProfileSettings();

	local prototype = { OnEnable = mod.preEnable, OnDisable = mod.preDisable, OnInitialize = mod.preInitialize };

	mod:SetDefaultModulePrototype(prototype);

end

function mod:SecondsToClock(seconds)

    result = "";

    local hours = math.floor( seconds / 3600 );
    seconds = seconds - (hours*3600);
    local mins = math.floor( seconds / 60);
    seconds = seconds - (mins*60);

    if hours>0 then
      result = string.format("%02.fh ",hours);
    end

    if mins>0 then
      result = result .. string.format("%02.fm ",mins);
    end

    result = result .. string.format("%02.fs",seconds);

    return result
end