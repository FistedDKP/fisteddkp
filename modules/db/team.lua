local _, fisted = ...

FistedDKP_DB_Team = FistedDKP_DB:NewModule("FistedDKP_DB_Team")

function FistedDKP_DB_Team:Get(index)
end

function FistedDKP_DB_Team:Set(data)
    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))
    if FistedDKP_Data.teams == nil then
        FistedDKP_Data.teams = {}
    end

    if FistedDKP_Data.teams[index] then
        FistedDKP_Debug:Message("Team Set: Exists")
        FistedDKP_Data.teams[index].index = index
        FistedDKP_Data.teams[index].name = data.name
        FistedDKP_Data.teams[index].founder = data.founder
        FistedDKP_Data.teams[index].type = data.type
        FistedDKP_Data.teams[index].whitelist = data.whitelist
    else
        FistedDKP_Debug:Message("Team Set: Creating")
        FistedDKP_Data.teams[index] = {
            index = index,
            name = data.name,
            founder = data.founder,
            type = data.type,
            whitelist = data.whitelist,
            items = {},
            players = {},
            tiers = {}
        }
    end

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.teams[index]))

    return index
end

function FistedDKP_DB_Team:VerifyCreate(index)
    if not self:Verify(index) then
        FistedDKP_Debug:Message("Team Verify: Creating")
        self:Set({
            index = index,
            name = "",
            founder = "",
            type = "",
            whitelist = {}
        })
        return self:Verify(index)
    else
        return true
    end
end

function FistedDKP_DB_Team:Verify(index)
    if FistedDKP_Data.teams ~= nil then
        if FistedDKP_Data.teams[index] ~= nil then
            FistedDKP_Debug:Message("Team Verify: Exists")
            return true
        end
    end

    return false
end

function FistedDKP_DB_Team:BuildCache(data)
    return {
        team = {
            team = data.index
        }
    }
end

function FistedDKP_DB_Team:BuildHash(data)
    return {
        team = {
            team = data.name,
            founder = data.founder,
            type = data.type
        }
    }
end