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

function mod:PopulateEquippedItems()

  --options
  local token = mod.Profile.token;
  local equippedToken = mod.Profile.equippedToken;

  --local vars
  local iventoryId, itemId, icon, checkRelic, slot;
  local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, icon, vendorPrice;
  local searchableText, start, duration, enable;

  for _,slot in pairs(mod.slots) do

    iventoryId, icon, checkRelic = GetInventorySlotInfo(slot);

    itemId = GetInventoryItemID("player", iventoryId);

    if itemId then

      name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, icon, vendorPrice = GetItemInfo(itemId);

      searchableText = token .. ": " .. name .. " (" .. equippedToken .. ")";

      start, duration, enable = GetItemCooldown(itemId);

      if start and start>0 and enable==1 then
        remain = duration - (GetTime() - start);
        searchableText = searchableText .. " ["..search:SecondsToClock(remain).."]";
      end

      --add the text and function
      item = { text = searchableText , id=itemId, type = "item", icon = icon};

      --insert the result
      table.insert(mod.items,item);

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

  local item, index, numSlots;
  local name, link, itemId, slot, icon;
  local searchableText, start, duration, enable;

  --add the items in a list to avoid duplicated items
  for index = 0, _G.NUM_BAG_SLOTS do

    numSlots = GetContainerNumSlots(index);

    for slot = 1, numSlots do

      link = GetContainerItemLink(index, slot);

      if link then
        name = GetItemInfo(link);

        if name then

          savedItems[name] = link;

        end

      end

    end

  end

  local searchableText, item;

  for name, link in pairs(savedItems) do

    item = nil;

    icon = select(10,GetItemInfo(link))

    itemId = select(2, strsplit(":", link));

    searchableText = token .. ": " .. name .. " (" .. bagsToken .. ")";

    start, duration, enable = GetItemCooldown(itemId);

    if start and start>0 and enable==1 then
      remain = duration - (GetTime() - start);
      searchableText = searchableText .. " ["..search:SecondsToClock(remain).."]";
    end

    --add the text and function
    item = { text = searchableText , id=itemId, type = "item", icon = icon};

    --insert the result
    table.insert(mod.items,item);

  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing items data");

  --populate data
  if mod.Profile.equipped then
    mod:PopulateEquippedItems();
  end
  if mod.Profile.bags then
    mod:PopulateBagsItems();
  end

  debug("data refreshed");

end