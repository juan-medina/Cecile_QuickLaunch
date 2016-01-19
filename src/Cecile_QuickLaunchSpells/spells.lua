----------------------------------------------------------------------------------------------------
-- search spells module

--get the engine and create the module
local Engine = _G.Cecile_QuickLaunch;

--create the modules as submodule of search
local search = Engine.AddOn:GetModule("search");
local mod = search:NewModule("spells");

--debug
local debug = Engine.AddOn:GetModule("debug");

--get the locale
local L=Engine.Locale;

mod.desc = L["SPELLS_MODULE"];

--module vars
mod.Vars = {
  token =  {
    type = "string",
    default = L["SPELLS"],
    order = 1,
    label = L["SPELLS_TOKEN"],
    desc = L["SPELLS_TOKEN_DESC"],
  },
};

--set the mount tooltip
function mod.setTooltip(tooltip,item)

  tooltip:SetSpellByID(item.id);

end

--populate flyouts spells
function mod:PopulateFlyouts()

  --options
  local token = mod.Profile.token;

  --local vars
  local numFlyouts,flyoutID,flyoutName, numSlots, isFlyoutKnown,item;
  local isKnown, spellName;
  local name, rank, icon, spellID;
  local petIndex, petName;
  local searchableText, remain, start, duration, shortText;
  local _;

  numFlyouts = _G.GetNumFlyouts();

  for flyoutNumber=1,numFlyouts do

    flyoutID = _G.GetFlyoutID(flyoutNumber);
    flyoutName, _ , numSlots, isFlyoutKnown = _G.GetFlyoutInfo(flyoutID);

    if isFlyoutKnown then

      for slot=1,numSlots do

        spellID, _, isKnown, spellName = _G.GetFlyoutSlotInfo(flyoutID, slot);

        if isKnown then

          name, rank, icon, _, _, _, spellID = _G.GetSpellInfo(spellID);

          if(name) then

            searchableText = "";

            petIndex, petName = _G.GetCallPetSpellInfo(spellID);

            if not (petIndex and (not petName or petName == "")) then

              --complete the text
              if petName then
                searchableText = searchableText .. flyoutName .. " " ..petName;
              else
                if rank and not(rank=="") then
                  searchableText = searchableText .. spellName .. " (" ..rank..")";
                else
                  searchableText = searchableText .. spellName ;
                end
              end

              --get short text
              shortText = searchableText;

              --get the cooldown
              start, duration = _G.GetSpellCooldown(spellID);

              if start and start>0 then
                remain = duration - (_G.GetTime() - start);
                searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
              end

              --base text
              searchableText = token .. ": " .. searchableText;

              --add the text and function
              item = { name = shortText, text = searchableText , id=spellID, type = "spell", icon=icon, tooltipFunc = mod.setTooltip, help = L["SPELLS_HELP_ITEM"] };

              --insert the result
              table.insert(self.items,item);

            end

          end

        end

      end

    end

  end

end

--populate
function mod:PopulateNormalSpells()

  --options
  local token = mod.Profile.token;

  --local vars
  local name, rank, icon, spellID, offset, numEntries, offspecID;
  local searchableText, remain, start, duration, enable, item, shortText;

  --get all spell tabs
  local numTabs = _G.GetNumSpellTabs();
  local _;

  for tabID=1,numTabs do

    _, _, offset, numEntries, _, offspecID = _G.GetSpellTabInfo(tabID)

    if offspecID == 0 then

      for index = offset + 1, offset + numEntries do

        if not _G.IsPassiveSpell(index, _G.BOOKTYPE_SPELL) then

          name, rank, icon, _, _, _, spellID = _G.GetSpellInfo(index, _G.BOOKTYPE_SPELL);

          if(name) then

            searchableText = "";

            --complete the text
            if rank and not(rank=="") then
              searchableText = searchableText .. name.." ("..rank..")";
            else
              searchableText = searchableText .. name;
            end

            shortText = searchableText;

            --get the cooldown
            start, duration, enable = _G.GetSpellCooldown(index, _G.BOOKTYPE_SPELL);

            if start and start>0 and enable==1 then

              remain = duration - (_G.GetTime() - start);
              searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
            end

            --base text
            searchableText = token .. ": " .. searchableText;

            --add the text and function
            item = { name = shortText, text = searchableText , id=spellID, type = "spell", icon=icon, tooltipFunc = mod.setTooltip, help = L["SPELLS_HELP_ITEM"] };

            --insert the result
            table.insert(self.items,item);
          end
        end

      end

    end

  end

end



--refresh the data
function mod:Refresh()

  debug("refreshing spells data");

  --populate data
  self:PopulateFlyouts();
  self:PopulateNormalSpells();

  debug("data refreshed");

end
