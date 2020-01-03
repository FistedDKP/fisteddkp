local _, fisted = ...

FistedDKP_DB_Tier = FistedDKP_DB:NewModule("FistedDKP_DB_Tier")

function FistedDKP_DB_Tier:Get(index)
end

function FistedDKP_DB_Tier:Set(data)
    assert(data.team and FistedDKP_DB_Team:VerifyCreate(data.team), "Invalid team or team not set")

    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))

    if FistedDKP_Data.teams[data.team].tiers == nil then
        FistedDKP_Data.teams[data.team].tiers = {}
    end

    if FistedDKP_Data.teams[data.team].tiers[index] then
        FistedDKP_Debug:Message("Tier Set: Exists")
        FistedDKP_Data.teams[data.team].tiers[index].index = index
        FistedDKP_Data.teams[data.team].tiers[index].team = data.team
        FistedDKP_Data.teams[data.team].tiers[index].name = data.name
        FistedDKP_Data.teams[data.team].tiers[index].encounters = data.encounters
    else
        FistedDKP_Debug:Message("Tier Set: Creating")
        FistedDKP_Data.teams[data.team].tiers[index] = {
            index = index,
            team = data.team,
            name = data.name,
            encounters = {},
            raids = {}
        }
    end

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.teams[data.team].tiers[index]))

    return index
end

function FistedDKP_DB_Tier:VerifyCreate(team, index)
    if not self:Verify(team, index) then
        FistedDKP_Debug:Message("Tier Verify: Creating (" .. team .. "," .. index ")")
        self:Set({
            index = index,
            team = team,
            name = ""
        })
        return self:Verify(team, index)
    else
        return true
    end
end

function FistedDKP_DB_Tier:Verify(team, index)
    if FistedDKP_DB_Team:Verify(team) then
        if FistedDKP_Data.teams[team].tiers ~= nil then
            if FistedDKP_Data.teams[team].tiers[index] ~= nil then
                FistedDKP_Debug:Message("Tier Verify: Exists")
                return true
            end
        end
    end

    return false
end

function FistedDKP_DB_Tier:BuildCache(data)
    return {
        tier = {
            team = data.team,
            tier = data.index
        }
    }
end

function FistedDKP_DB_Tier:BuildHash(data)
    return {
        tier = {
            team = data.team,
            tier = data.name
        }
    }
end