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

--populate flyouts spells
function mod:PopulateFlyouts()

  --options
  local token = mod.Profile.token;

  --local vars
  local numFlyouts,flyoutID,flyoutName, numSlots, isFlyoutKnown,item;
  local isKnown, spellName;
  local name, rank, icon, spellID;
  local petIndex, petName;
  local searchableText, remain, start, duration;
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

            petIndex, petName = _G.GetCallPetSpellInfo(spellID);

            if not (petIndex and (not petName or petName == "")) then

              --base text
              searchableText = token .. ": ";

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

              --get the cooldown
              start, duration = _G.GetSpellCooldown(spellID);

              if start and start>0 then
                remain = duration - (_G.GetTime() - start);
                searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
              end

              --add the text and function
              item = { text = searchableText , id=spellID, type = "spell", icon=icon};

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
  local searchableText, remain, start, duration, enable, item;

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

            --base text
            searchableText = token .. ": ";

            --complete the text
            if rank and not(rank=="") then
              searchableText = searchableText .. name.." ("..rank..")";
            else
              searchableText = searchableText .. name;
            end

            --get the cooldown
            start, duration, enable = _G.GetSpellCooldown(index, _G.BOOKTYPE_SPELL);

            if start and start>0 and enable==1 then

              remain = duration - (_G.GetTime() - start);
              searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
            end

            --add the text and function
            item = { text = searchableText , id=spellID, type = "spell", icon=icon};

            --insert the result
            table.insert(self.items,item);
          end
        end

      end

    end

  end

end

--populate
function mod:PopulateProfession(profession)

  if profession == nil then
    return;
  end

  --local vars
  local item , searchableText, remain, start, duration, enable;

  local prefessionName, icon, rank, numEntries, offset, name;

  local spellID, _;

  prefessionName, _, _, _, numEntries, offset, _, _, _, _ = _G.GetProfessionInfo(profession);

  for index = offset + 1, offset + numEntries do

    if not _G.IsPassiveSpell(index, _G.BOOKTYPE_PROFESSION) then

      name, rank, icon, _, _, _, spellID = _G.GetSpellInfo(index, _G.BOOKTYPE_PROFESSION);

      if(name) then

        --base text
        searchableText = prefessionName .. ": ";

        --complete the text
        if rank and not(rank=="") then
          searchableText = searchableText .. name.." ("..rank..")";
        else
          searchableText = searchableText .. name;
        end

        --get the cooldown
        start, duration, enable = _G.GetSpellCooldown(index, _G.BOOKTYPE_PROFESSION);

        if start and start>0 and enable==1 then

          remain = duration - (_G.GetTime() - start);
          searchableText = searchableText .. " ["..search.SecondsToClock(remain).."]";
        end

        --add the text and function
        item = { text = searchableText , id=spellID, type = "spell", icon=icon};

        --insert the result
        table.insert(self.items,item);
      end
    end

  end

end

function mod:PopulateProfessions(...)

  local n = select('#', ...);

  for i = 1, n do
    self:PopulateProfession(select(i, ...));
  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing spells data");

  --populate data
  self:PopulateFlyouts();
  self:PopulateNormalSpells();
  self:PopulateProfessions(_G.GetProfessions());

  debug("data refreshed");

end
