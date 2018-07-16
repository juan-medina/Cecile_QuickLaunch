----------------------------------------------------------------------------------------------------
-- search module

--get the engine and create the module
local Engine = select(2,...);
local mod = Engine.AddOn:NewModule("search");

--get the locale
local L=Engine.Locale;

--debug
local debug = Engine.AddOn:GetModule("debug");

local AceConfigDialog = LibStub("AceConfigDialog-3.0");

--module defaults
mod.Defaults = {
  profile = {
    disableModules = {},
    moduleOrder ={},
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
          set = function( _ , value )
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
          values = function()

            local names={};

            for k,_ in pairs(Engine.Profile.search.aliases) do
              names[k] = k;
            end

            return names;
          end,
          set = function(_,value)
            mod.selectedAlias = value;
            mod.selectedAliasName = value;
            mod.selectedAliasValue = Engine.Profile.search.aliases[value];
          end,
          get = function()
            return mod.selectedAlias;
          end,
        },
        aliasName = {
          name = L["SEARCH_ALIAS_NAME"],
          order = 3,
          type = "input",
          width = "full",
          get = function()
            return mod.selectedAliasName;
          end,
          set = function(_,value)
            if value=="" then return; end
            mod.selectedAliasName=value:lower();
          end,
        },
        aliasValue = {
          name = L["SEARCH_ALIAS_VALUE"],
          order = 4,
          type = "input",
          width = "full",
          get = function()
            return mod.selectedAliasValue;
          end,
          set = function(_,value)
            if value=="" then return; end
            mod.selectedAliasValue = value:lower();
          end,
        },
        save = {
          name = L["SEARCH_ALIAS_SAVE"],
          desc = L["SEARCH_ALIAS_SAVE_DESC"],
          order = 6,
          type = "execute",
          func = function()
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
          func = function()
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
          func = function()
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
          values = function()
            local names={};

            for k,_ in pairs(Engine.Profile.search.blacklist) do
              names[k] = k;
            end

            return names;
          end,
          set = function(_,value)
            mod.selectedBlacklist = value;
            mod.selectedBlacklistName = value;
            mod.selectedBlacklistValue = Engine.Profile.search.blacklist[value];
          end,
          get = function()
            return mod.selectedBlacklist;
          end,
        },
        blacklistName = {
          name = L["SEARCH_BLACKLIST_NAME"],
          order = 3,
          type = "input",
          width = "full",
          get = function()
            return mod.selectedBlacklistName;
          end,
          set = function(_,value)
            if value=="" then return; end
            mod.selectedBlacklistName=value:lower();
          end,
        },
        blacklistValue = {
          name = L["SEARCH_BLACKLIST_VALUE"],
          order = 4,
          type = "input",
          width = "full",
          get = function()
            return mod.selectedBlacklistValue;
          end,
          set = function(_,value)
            if value=="" then return; end
            mod.selectedBlacklistValue = value:lower();
          end,
        },
        save = {
          name = L["SEARCH_BLACKLIST_SAVE"],
          desc = L["SEARCH_BLACKLIST_SAVE_DESC"],
          order = 6,
          type = "execute",
          func = function()
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
          func = function()
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
          func = function()
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
function mod.getColorString(color)

  local result = string.format("|c%02X%02X%02X%02X",
    color.a and color.a*255 or 255,
    color.r*255,
    color.g*255,
    color.b*255)

  return result;
end


function mod:LoadProfileSettings()

  self.fontColors = Engine.Profile.window.font.colors;

  self.highlight = self.getColorString(self.fontColors.highlight);

  self.twoSteps = Engine.Profile.search.twoSteps;

end

--profile change
function mod.OnProfileChanged()

  mod:LoadProfileSettings();
  mod.loadModuleOrder();

end

function mod.twoStepsSelectModule(item)

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

function mod:Wipe()

  debug("wiping data");

  --goes trough all the modules
  for _,module in pairs(self.modules) do
    if module:IsEnabled() then
      --clear items
      --_G.wipe(module.items);
      module.items = {}
    end
  end

  debug("data wiped");

end

function mod:Refresh()

  --wipe data
  self:Wipe();

  debug("refreshing search data");

  --goes trough all the modules
  for name,module in pairs(self.modules) do

    --local vars
    local item, searchableText;

    if module:IsEnabled() then

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
function mod.MatchItem(_item,text)

  --set to lower case
  local item = _item:lower();

  --flag to control if we match every wod
  local matchAllWords = true;

  --go word by word and check if we match
  for word in string.gmatch(text, "[^ ]+") do
    matchAllWords = matchAllWords and (not (string.find(item,word)==nil) );
  end

  --return all words
  return matchAllWords;

end

--color string based on match
function mod:ColorItem(_item,text)

  --our result
  local result = _item;

  --convert to lower
  local item = _item:lower();

  --local vars
  local positions = {};

  --go word by word
  for word in string.gmatch(text, "[^ ]+") do

    --if we get one store the position on the string
    local startPos,endPos = string.find(item,word);

    table.insert(positions,{ from = startPos, to = endPos });

  end

  --sort the positions
  table.sort(positions, function(a,b) return a.from < b.from end);

  --more local vars
  local before,token, after;

  --we have not modified, yet
  local acumulated = 0;

  --loop the words
  for _,pos in pairs(positions) do



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
    result = before..self.highlight..token.."|r"..after;

    --we increase next positions
    acumulated = acumulated + 12;

  end

  return result;

end

--remove words that are part of other words, for example remove "mount" if you are searching as well "mo"
function mod.MergeWords(text)

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

  --will have the words that are required
  local newwords={};
  local found;

  ---loops from each word ty to find if other word cotain it.
  for i=1,#words do

    --we have not found any
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
  for _,word in pairs(newwords) do
    result = result .. word .. (result and " " or "");
  end

  return result;

end

--find in a module
function mod:FindInModule(module,text)

  --our result
  local result = {};

  --loop al items
  for _, item in pairs(module.items) do

    --if this item match
    if self.MatchItem(item.text,text) then

      --add color
      item.displayText = mod:ColorItem(item.text,text);

      --insert into the table
      table.insert(result,item);

    end

  end

  return result;

end

--expand aliases
function mod.ExpandAliases(text)

  local result = text;

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
  local merged = mod.ExpandAliases(text:lower());

  --correct the text
  local corrected = mod.MergeWords(merged);

  --goes trough all the modules
  local module,name;
  local orderTable = Engine.Profile.search.moduleOrder;
  for i=1,#orderTable do

    name = orderTable[i];
    module = self.modules[name];

    if module:IsEnabled() then

      --get the items for this module
      items = mod:FindInModule(module,corrected);

      --merge the tables
      for _,item in pairs(items) do
        table.insert(result,item);
      end

      --we dont need it anymore
      --_G.wipe(items);
      items = {}

    end

  end

  return result;

end

--find all items using the text and apply blacklist
function mod:FindAll(text)

  --local vars
  local items;
  local blacklistItems = {};
  local blacklisted;

  --find all items
  local findItems = self:searchAll(text);

  --search blacklist items
  for _,value in pairs(Engine.Profile.search.blacklist) do

    items = self:searchAll(value);

    --merge the tables
    for _,item in pairs(items) do
      table.insert(blacklistItems,item);
    end

  end

  --empty result
  items = {};

  --goes trough the finded items
  for _,item in pairs(findItems) do

    --item is not blacklisted by default
    blacklisted = false;

    --goes trought the black list
    for _,blacklistItem in pairs(blacklistItems) do

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

  --_G.wipe(blacklistItems);
  --_G.wipe(findItems);
  blacklistItems={}
  findItems={}

  return items;

end

function mod.sortModuleOrderName(a,b)

  local result;

  local a_order = mod.modules[a].order;
  local b_order = mod.modules[b].order;

  if(a_order==b_order) then
    result = a<b;
  else
    result = a_order<b_order;
  end

  return result;

end

function mod.loadModuleOrder()
  for name,module in pairs(mod.modules) do
    module.order = mod.getModuleOrder(name);
  end
  mod.resortModules();
end

function mod.resortModules()

  local orderTable = {};

  for name,_ in pairs(mod.modules) do
    table.insert(orderTable, name);
  end

  table.sort(orderTable, mod.sortModuleOrderName);

  Engine.Profile.search.moduleOrder = orderTable;

  for i=1,#orderTable do
     mod.modules[orderTable[i]].order=i;
     mod.Options.args.modules.args[orderTable[i]].order=i;
  end

end

function mod.moveModule(name,direction)

  local currentOrder = mod.modules[name].order;
  local newOrder = currentOrder + direction;

  for _,module in pairs(mod.modules) do
    if module.order == newOrder then
      module.order = currentOrder;
      break;
    end
  end

  mod.modules[name].order = newOrder;

  mod.resortModules();

end

function mod.getModuleOrder(name)
  local orderTable = Engine.Profile.search.moduleOrder;
  for i=1,#orderTable do
    if orderTable[i]==name then
      return i;
    end
  end
  return -1;
end

function mod.preInitialize(module)

  local isDisabled =  Engine.Profile.search.disableModules[module:GetName()];

  if(isDisabled) then
    module:Disable();
  end

  --if we have vars
  if module.Vars then

    module.order = mod.getModuleOrder(module:GetName());

    --default profile vars
    module.Defaults = { profile = {} };

    --default options ui
    module.Options = {
      type = "group",
      name = module.desc,
      args = {},
      order = module.order;
    };

    --loop vars
    for name , options in pairs(module.Vars) do

      --set the default profile value
      module.Defaults.profile[name] = options.default;

      if options.type == "boolean" then
        --setup the option
        module.Options.args[name] = {
          order = options.order+2,
          type = "toggle",
          name = options.label,
          desc = options.desc,
          get = function()
            return module.Profile[name];
          end,
          set = function(_,value)
            module.Profile[name] = value;
          end,
          disabled = function()
            return not module:IsEnabled();
          end,
        };
      elseif options.type == "string" then
        --setup the option
        module.Options.args[name] = {
          order = options.order+2,
          type = "input",
          name = options.label,
          desc = options.desc,
          get = function()
            return module.Profile[name];
          end,
          set = function(_,value)
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

    module.OnProfileChanged = function (_, database, _)
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
    width = "full",
    type = "toggle",
    name = L["SEARCH_ENABLE_MODULE"],
    desc = L["SEARCH_ENABLE_MODULE_DESC"],
    get = function()
      return module:IsEnabled();
    end,
    set = function(_,value)

      if(value) then
        module:Enable();
      else
        module:Disable();
      end

      Engine.Profile.search.disableModules[module:GetName()] = (not value);

    end
  };

  module.Options.args["down"] = {
    order = 1,
    type = "execute",
    name = L["SEARCH_MODULE_DOWN"],
    desc = L["SEARCH_MODULE_DOWN_DESC"],
    func = function(self)
      mod.moveModule(module:GetName(),1);
      AceConfigDialog:SelectGroup(self.appName,"modules");
    end
  };

  module.Options.args["up"] = {
    order = 2,
    type = "execute",
    name = L["SEARCH_MODULE_UP"],
    desc = L["SEARCH_MODULE_UP_DESC"],

    func = function(self)
      mod.moveModule(module:GetName(),-1);
      AceConfigDialog:SelectGroup(self.appName,"modules");
    end
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

  self.window = Engine.AddOn:GetModule("window");

  debug("search module initialize");

  mod:LoadProfileSettings();

  local prototype = { OnEnable = mod.preEnable, OnDisable = mod.preDisable, OnInitialize = mod.preInitialize };

  mod:SetDefaultModulePrototype(prototype);

end

function mod.SecondsToClock(seconds)

  local result = "";

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

function mod:OnEnable()
  self.loadModuleOrder();
end