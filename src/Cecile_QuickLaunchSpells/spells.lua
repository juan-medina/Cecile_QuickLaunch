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
  local numFlyouts,flyoutNumber,flyoutID,flyoutName, description, numSlots, isFlyoutKnown,item;
  local spellID, overrideSpellID, isKnown, spellName, slotSpecID;
  local name, rank, icon, castingTime, minRange, maxRange, spellID;
  local petIndex, petName;
  local searchableText, start, duration, enable, slot;

  numFlyouts = GetNumFlyouts();

  for flyoutNumber=1,numFlyouts do

    flyoutID = GetFlyoutID(flyoutNumber);
    flyoutName, description, numSlots, isFlyoutKnown = GetFlyoutInfo(flyoutID);

    if isFlyoutKnown then

      for slot=1,numSlots do

          spellID, overrideSpellID, isKnown, spellName, slotSpecID = GetFlyoutSlotInfo(flyoutID, slot);

          if isKnown then

            name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(spellID);

            if(name) then

              item = nil;
              petIndex, petName = GetCallPetSpellInfo(spellID);

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
                start, duration, enable = GetSpellCooldown(spellID);

                if start and start>0 then
                  remain = duration - (GetTime() - start);
                  searchableText = searchableText .. " ["..search:SecondsToClock(remain).."]";
                end

                --add the text and function
                item = { text = searchableText , id=spellID, type = "spell", icon=icon};

                --insert the result
                table.insert(mod.items,item);

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
  local name, rank, icon, castingTime, minRange, maxRange, spellID, offset, numEntries, isGuild, offspecID;
  local index, searchableText, start, duration, enable;

  --get all spell tabs
  local numTabs = GetNumSpellTabs();

  for tabID=1,numTabs do

    name, icon, offset, numEntries, isGuild, offspecID = GetSpellTabInfo(tabID)

    if offspecID == 0 then

      for index = offset + 1, offset + numEntries do

        if not IsPassiveSpell(index, BOOKTYPE_SPELL) then

          name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(index, BOOKTYPE_SPELL);

          if(name) then

            item = nil;

            --base text
            searchableText = token .. ": ";

            --complete the text
            if rank and not(rank=="") then
              searchableText = searchableText .. name.." ("..rank..")";
            else
              searchableText = searchableText .. name;
            end

            --get the cooldown
            start, duration, enable = GetSpellCooldown(index, BOOKTYPE_SPELL);

            if start and start>0 and enable==1 then

              remain = duration - (GetTime() - start);
              searchableText = searchableText .. " ["..search:SecondsToClock(remain).."]";
            end

            --add the text and function
            item = { text = searchableText , id=spellID, type = "spell", icon=icon};

            --insert the result
            table.insert(mod.items,item);
          end
        end

      end

    end

  end

end

--populate
function mod:PopulateProfession(profession)

  if profession == nil then
    return
  end

  --local vars
  local item , searchableText, start, duration, enable;

  local prefessionName, icon, rank, maxRank, numEntries, offset, skillLine, rankModifier, specializationIndex, specializationOffset;

  local castingTime, minRange, maxRange, spellID;

  prefessionName, icon, rank, maxRank, numEntries, offset, skillLine, rankModifier, specializationIndex, specializationOffset = GetProfessionInfo(profession);

  for index = offset + 1, offset + numEntries do

    if not IsPassiveSpell(index, BOOKTYPE_PROFESSION) then

      name, rank, icon, castingTime, minRange, maxRange, spellID = GetSpellInfo(index, BOOKTYPE_PROFESSION);

      if(name) then

        item = nil;

        --base text
        searchableText = prefessionName .. ": ";

        --complete the text
        if rank and not(rank=="") then
          searchableText = searchableText .. name.." ("..rank..")";
        else
          searchableText = searchableText .. name;
        end

        --get the cooldown
        start, duration, enable = GetSpellCooldown(index, BOOKTYPE_PROFESSION);

        if start and start>0 and enable==1 then

          remain = duration - (GetTime() - start);
          searchableText = searchableText .. " ["..search:SecondsToClock(remain).."]";
        end

        --add the text and function
        item = { text = searchableText , id=spellID, type = "spell", icon=icon};

        --insert the result
        table.insert(mod.items,item);
      end
    end

  end

end

function mod:PopulateProfessions(...)

  local i;
  local n = select('#', ...);

  for i = 1, n do
    mod:PopulateProfession(select(i, ...));
  end

end

--refresh the data
function mod:Refresh()

  debug("refreshing spells data");

  --populate data
  mod:PopulateFlyouts();
  mod:PopulateNormalSpells();
  mod:PopulateProfessions(_G.GetProfessions());

  debug("data refreshed");

end