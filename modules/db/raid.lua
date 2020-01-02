local _, fisted = ...

FistedDKP_DB_Raid = FistedDKP_DB:NewModule("FistedDKP_DB_Raid")

function FistedDKP_DB_Raid:Get(index)
    if fisted.indexCache[index] then
        local indexCache = fisted.indexCache[index]
        if indexCache.team and indexCache.tier and indexCache.raid then
            return { 
                index = { 
                    team = indexCache.team,
                    tier = indexCache.tier,
                    raid = {
                        index = indexCache.raid,
                        starttime = FistedDKP_DB.teams[indexCache.team].tiers[indexCache.tier].raids[indexCache.raid].starttime,
                        endtime = FistedDKP_DB.teams[indexCache.team].tiers[indexCache.tier].raids[indexCache.raid].endtime
                    }
                }
            }
        else
            return nil
        end
    else
        return nil
    end
end

function FistedDKP_DB_Raid:Set(data)
    assert(data.team and data.tier and FistedDKP_DB_Tier:VerifyCreate(data.team, data.tier), "Invalid tier or tier not set")

    if data.starttime == nil and data.index == nil then
        data.starttime = time()
    end

    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))

    if FistedDKP_Data.teams[data.team].tiers[data.tier].raids == nil then
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids = {}
    end

    if FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index] then
        FistedDKP_Debug:Message("Raid Set: Exists")
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].index = index
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].team = data.team
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].tier = data.tier
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].zone = data.zone
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].starttime = data.starttime
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index].endtime = data.endtime
    else
        FistedDKP_Debug:Message("Raid Set: Creating")
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index] = {
            index = index,
            team = data.team,
            tier = data.tier,
            zone = data.zone,
            starttime = data.starttime,
            endtime = data.endtime,
            encounters = {},
            raids = {}
        }
    end

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index]))

    return index
end

function FistedDKP_DB_Raid:VerifyCreate(team, tier, index)
    if self:Verify(team, tier, index) then
        FistedDKP_Debug:Message("Raid Verify: Creating")
        self:Set({
            index = index,
            team = team,
            tier = tier,
            zone = nil,
            starttime = nil,
            endtime = nil
        })
        return self:Verify(team, tier, index)
    else
        return true
    end
end

function FistedDKP_DB_Raid:Verify(team, tier, index)

    if FistedDKP_DB_Tier:Verify(team, tier) then
        if FistedDKP_Data.teams[team].tiers[tier].raids ~= nil then
            if FistedDKP_Data.teams[team].tiers[tier].raids[index] ~= nil then
                FistedDKP_Debug:Message("Raid Verify: Exists")
                return true
            end
        end
    end

    return false
end

function FistedDKP_DB_Raid:BuildCache(data)
    return {
        raid = {
            team = data.team,
            tier = data.tier,
            raid = data.index
        }
    }
end

function FistedDKP_DB_Raid:BuildHash(data)
    return {
        raid = {
            team = data.team,
            tier = data.name,
            zone = data.zone,
            starttime = data.starttime
        }
    }
end