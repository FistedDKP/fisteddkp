local _, fisted = ...

FistedDKP_DB_DKP = FistedDKP:NewModule("FistedDKP_DB_DKP")

function FistedDKP_DB_DKP:Get(filters)
    local sortedKeys
    if filters and filters.tier and filters.player then
        local tier, player = filters.tier, filters.player
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.tier and value.dkp.tier == tier and value.dkp.player == player end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    elseif filters and filters.player then
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.player == player end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    else
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    end
    
    local sorted = {}

    for _, key in ipairs(sortedKeys) do
        tinsert(sorted,FistedDKP_Cache.indexCache[sortedKeys])
    end
    return sorted
end

function FistedDKP_DB_DKP:GetTotal(filters)
    sorted = self:GetPlayer(filters)

    local total = 0
    if #sorted > 0 then
        for _, value in ipairs(sorted) do
            total = total + value.value
        end
    end

    return total
end

function FistedDKP_DB_DKP:ClearAll(filters)
    local sortedKeys = nil
    if filters and filters.tier then
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.tier and value.dkp.tier == tier end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    elseif filters and filters.team then
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.team and value.dkp.team == team end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    elseif filters and filters.player then
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.player and value.dkp.player == player end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    else
        sortedKeys = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    end

    for _, key in ipairs(sortedKeys) do
        self:DeleteIndex(key)
    end
end

function FistedDKP_DB_DKP:GetIndex(index)
    if fisted.indexCache[index] then
        local indexCache = fisted.indexCache[index]
        if indexCache.team and indexCache.tier and indexCache.raid and indexCache.dkp then
            local dkp = FistedDKP_Data.teams[indexCache.team].tier[indexCache.tier].raids[indexCache.raid].dkp[index]
            return {
                index = { 
                    dkp = {
                        index = index,
                        team = indexCache.team,
                        tier = indexCache.tier,
                        raid = indexCache.raid,
                        zone = dkp.zone,
                        encounter = dkp.encounter,
                        type = dkp.type,
                        assigner = dkp.assigner,
                        value = dkp.value,
                        reason = dkp.reason,
                        datetime = dkp.timestamp,
                        player = dkp.player,
                        related = dkp.related
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

function FistedDKP_DB_DKP:SetIndex(data, index)
    assert(data.team, "Team is required")
    assert(data.tier, "Tier is required")
    assert(data.raid, "Raid is required")
    assert(data.encounter, "Encounter is required")
    assert(data.type, "DKP Type is Required")
    assert(data.assigner, "Assigner is required")
    assert(data.value, "Value is required")

    assert(FistedDKP_DB_Raid:VerifyCreate(data.team, data.tier, data.raid),"Invalid raid or raid not set")
    if data.timestamp == nil then
        data.timestamp = time()
    end

    local index = index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))

    if FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp == nil then
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp = {}
    end

    if FistedDKP_Data.teams[data.team].tiers[data.tier].raids[index] then
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].index = index
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].team = data.team
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].tier = data.tier
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].raid =  data.raid
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].assigner = data.assigner
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].encounter = data.encounter
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].value = data.value
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].reason = data.reason
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].timestamp = data.timestamp
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].players = data.players
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index].related = data.related
    else
        FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index] = {
            index = index,
            team = data.team,
            tier = data.tier,
            raid = data.raid,
            assigner = data.assigner,
            encounter = data.encounter,
            value = data.value,
            reason = data.reason,
            timestamp = data.timestamp,
            player = data.player,
            related = data.related
        }
    end

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.teams[data.team].tiers[data.tier].raids[data.raid].dkp[index]))

    return index
end

function FistedDKP_DB_DKP:DeleteIndex(index)
    local indexCache = FistedDKP_DB:GetIndexCache(index)
    if indexCache.dkp then
        local team, tier, raid = indexCache.dkp.team, indexCache.dkp.tier, indexCache.dkp.raid
        if FistedDKP_DB_Raid:Verify(team, tier, raid) then
            FistedDKP_Data.teams[team].tiers[tier].raids[raid].dkp[index]=nil
            FistedDKP_Cache.indexCache[index]=nil
        end
    end
end

function FistedDKP_DB_DKP:BuildCache(data)
    return {
        dkp = data
    }
end

function FistedDKP_DB_DKP:BuildHash(data)
    return {
        dkp = {
            team = data.team,
            tier = data.tier,
            raid = data.raid,
            encounter = data.encounter,
            player = data.player,
            type = data.type,
            timestamp = data.timestamp
        }
    }
end

function FistedDKP_DB_DKP:TestSort(team, tier, raid)
    print(team, tier, raid)

    for key,value in ipairs(FistedDKP_Data.teams[team].tiers[tier].raids[raid].dkp) do
        print(key, value.timestamp, value.value)
    end

    local testsort = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.raid and raid and value.dkp.raid == raid end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)
    for _, key in ipairs(testsort) do
        print(key, FistedDKP_Data.teams[team].tiers[tier].raids[raid].dkp[key].timestamp, FistedDKP_Data.teams[team].tiers[tier].raids[raid].dkp[key].value)
    end

    print(#testsort)

    local testsort = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache, function (key,value) return value.dkp and value.dkp.raid and raid and value.dkp.raid == raid and value.dkp.encounter and value.dkp.encounter == 'fb88fd4bcd61b6aa90557b137547b84719b91808' end,function (a,b) return a.dkp.timestamp < b.dkp.timestamp end)

    print(#testsort)
end