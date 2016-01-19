----------------------------------------------------------------------------------------------------
-- search items module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("items");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["ITEMS_MODULE"];

--module vars
mod.Vars = {
  token =  {
    type = "string",
    default = L["ITEMS"],
    order = 1,
    label = L["ITEMS_TOKEN"],
    desc = L["ITEMS_TOKEN_DESC"],
  },
  equipped =  {
    type = "boolean",
    default = true,
    order = 2,
    label = L["ITEMS_RETURN_EQUIPPED"],
    desc = L["ITEMS_RETURN_EQUIPPED_DESC"]
  },
  equippedToken =  {
    type = "string",
    default = L["ITEMS_EQUIPPED"],
    order = 3,
    label = L["ITEMS_EQUIPPED_TOKEN"],
    desc = L["ITEMS_EQUIPPED_TOKEN_DESC"],
  },
  bags =  {
    type = "boolean",
    default = true,
    order = 4,
    label = L["ITEMS_RETURN_BAGS"],
    desc = L["ITEMS_RETURN_BAGS_DESC"]
  },
  bagsToken =  {
    type = "string",
    default = L["ITEMS_BAGS"],
    order = 5,
    label = L["ITEMS_BAGS_TOKEN"],
    desc = L["ITEMS_BAGS_TOKEN_DESC"],
  },
};


mod.slots = {"HeadSlot",
  "NeckSlot",
  "ShoulderSlot",
  "BackSlot",
  "ChestSlot",
  "WristSlot",
  "HandsSlot",
  "WaistSlot",
  "LegsSlot",
  "FeetSlot",
  "Finger0Slot",
  "Finger1Slot",
  "Trinket0Slot",
  "Trinket1Slot",
  "MainHandSlot",
  "SecondaryHandSlot"
};

--return the help for this item
function mod.help(item)

  local name = _G.GetItemInfo(item.id);
  local help;

  if _G.IsEquippableItem(name) and not _G.IsEquippedItem(name) then
    help = L["ITEM_HELP_ITEM_EQUIPP"];
  else
    help = L["ITEM_HELP_ITEM"];
  end

  return help;

end

--set the item tooltip
function mod.setTooltip(tooltip,item)
  tooltip:SetItemByID(item.id);
end

function mod:PopulateEquippedItems()

  --options
  local token = mod.Profile.token;
  local equippedToken = mod.Profile.equippedToken;

  --local vars
  local iventoryId, itemId, name, icon, searchableText, remain, start, duration, enable, item;

  for _,slot in pairs(mod.slots) do

    iventoryId = _G.GetInventorySlotInfo(slot);

    itemId = _G.GetInventoryItemID("player", iventoryId);

    if itemId then

      name, _, _, _, _, _, _, _, _, icon = _G.GetItemInfo(itemId);

      searchableText = token .. ": " .. name .. " (" .. equippedToken .. ")";

      start, duration, enable = _G.GetItemCooldown(itemId);

      if start and start>0 and enable==1 then
        remain = duration - (_G.GetTime() - start);
        searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
      end

      --add the text and function
      item = { name = name, text = searchableText , id=itemId, type = "item", icon = icon, help = mod.help, tooltipFunc = mod.setTooltip };

      --insert the result
      table.insert(self.items,item);

    end

  end

end

--populate
function mod:PopulateBagsItems()

  --options
  local token = mod.Profile.token;
  local bagsToken = mod.Profile.bagsToken;

  --local vars
  local savedItems = {}

  local numSlots;
  local name, link, itemId, icon;
  local remain, start, duration, enable;

  --add the items in a list to avoid duplicated items
  for index = 0, _G.NUM_BAG_SLOTS do

    numSlots = _G.GetContainerNumSlots(index);

    for slot = 1, numSlots do

      link = _G.GetContainerItemLink(index, slot);

      if link then
        name = _G.GetItemInfo(link);

        if name then

          savedItems[name] = link;

        end

      end

    end

  end

  local searchableText, item;

  for savedName, savedLink in pairs(savedItems) do

    icon = select(10,_G.GetItemInfo(savedLink))

    itemId = select(2, _G.strsplit(":", savedLink));

    searchableText = token .. ": " .. savedName .. " (" .. bagsToken .. ")";

    start, duration, enable = _G.GetItemCooldown(itemId);

    if start and start>0 and enable==1 then
      remain = duration - (_G.GetTime() - start);
      searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
    end

    --add the text and function
    item = { name = savedName, text = searchableText , id=itemId, type = "item", icon = icon, help = mod.help, tooltipFunc = mod.setTooltip};

    --insert the result
    table.insert(self.items,item);

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing items data");

  --populate data
  if self.Profile.equipped then
    self:PopulateEquippedItems();
  end
  if self.Profile.bags then
    self:PopulateBagsItems();
  end

  debug("data refreshed");

end
