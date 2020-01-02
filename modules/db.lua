local _, fisted = ...

FistedDKP_DB = FistedDKP:NewModule("FistedDKP_DB")

-- Example:
-- 
-- e3e3e3e3 = { type = 'Team', Team = 'e3e3e3e3' }
-- abcd1234 = { type = 'Item', Team = 'e3e3e3e3', Item = 'abcd1234' }
-- eeaef11b = { type = 'Players', Team = 'e3e3e3e3', Players = 'eeaef11b' }
-- a6d7e8b1 = { type = 'Tier', Team = 'e3e3e3e3', Tier = 'a6d7e8b1' }
-- ade3d3bc = { type = 'Encounters', Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Encounters = 'ade3d3bc' }
-- bb32c4a1 = { type = 'Raid', Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1' }
-- ad3eacf1 = { type = 'DKP', Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1', DKP = 'ad3eacf1' }
-- 2aa3ee12 = { type = 'Loot', Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1', Loot = '2aa3ee12' }
--

function FistedDKP_DB:Init()
    FistedDKP_Data = {}
    FistedDKP_Cache = {
        teams = {},
        indexCache = {}
    }
end

function FistedDKP_DB:QueryIndexCache(index)
    if FistedDKP_Cache.indexCache[index] then
        return FistedDKP_Cache.indexCache[index]
    end

    return nil
end

function FistedDKP_DB:SetIndexCache(index,data)
    FistedDKP_Cache.indexCache[index] = data
end

function FistedDKP_DB:Set(data)
    if data.dkp then
        if data.dkp.index then
            FistedDKP_DB_DKP:Set(data.dkp,data.dkp.index)
        else
            FistedDKP_DB_DKP:Set(data.dkp)
        end
    end
end

function FistedDKP_DB:Get(index)
    if fisted.indexCache[index] then
        indexCache = fisted.indexCache[index]
        if indexCache.type == 'Team' then
            return FistedDKP_DB_Team:Get(index)
        elseif indexCache.type == 'Item' then
            return FistedDKP_DB_Item:Get(index)
        elseif indexCache.type == 'Players' then
            return FistedDKP_DB_Players:Get(index)
        elseif indexCache.type == 'Tier' then
            return FistedDKP_DB_Tier:Get(index)
        elseif indexCache.type == 'Encounters' then
            return FistedDKP_DB_Encounters:Get(index)
        elseif indexCache.type == 'Raid' then
            return FistedDKP_DB_Raid:Get(index)
        elseif indexCache.type == 'DKP' then
            return FistedDKP_DB_DKP:Get(index)
        elseif indexCache.type == 'Loot' then
            return FistedDKP_DB_Loot:Get(index)
        else
            return nil
        end
    end
end

if FistedDKP_Data == nil then
    FistedDKP_DB:Init()
end
