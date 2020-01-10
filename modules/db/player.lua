local _, fisted = ...

FistedDKP_DB_Player = FistedDKP_DB:NewModule("FistedDKP_DB_Player")



function FistedDKP_DB_Player:Get(index)
    if FistedDKP_Cache.indexCache[index] and FistedDKP_Cache.indexCache[index].player then
        local indexCache = FistedDKP_Cache.indexCache[index].player
        if indexCache.team and indexCache.player then
            return FistedDKP_Data.teams[indexCache.team].players[indexCache.player]
        else
            return nil
        end
    else
        return nil
    end
end

function FistedDKP_DB_Player:Set(data)
    assert(data.team and FistedDKP_DB_Team:VerifyCreate(data.team), "Invalid team or team not set")

    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))

    if FistedDKP_Data.teams[data.team].players == nil then
        FistedDKP_Data.teams[data.team].players = {}
    end

    if FistedDKP_Data.teams[data.team].players[index] then
        FistedDKP_Debug:Message("Player Set: Exists")
        FistedDKP_Data.teams[data.team].players[index].index = index
        FistedDKP_Data.teams[data.team].players[index].team = data.team
        FistedDKP_Data.teams[data.team].players[index].level = data.level
        FistedDKP_Data.teams[data.team].players[index].class = data.class
        FistedDKP_Data.teams[data.team].players[index].name = data.name
    else
        FistedDKP_Debug:Message("Player Set: Creating")
        FistedDKP_Data.teams[data.team].players[index] = {
            index = index,
            team = data.team,
            level = data.level,
            class = data.class,
            name = data.name
        }
    end

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.teams[data.team].players[index]))

    return index
end

function FistedDKP_DB_Player:VerifyCreate(team, index)
    if not self:Verify(team, index) then
        FistedDKP_Debug:Message("Player Verify: Creating")
        self:Set({
            index = index,
            team = team
        })
        return self:Verify(team, index)
    else
        return true
    end
end

function FistedDKP_DB_Player:Verify(team, index)
    if FistedDKP_DB_Team:Verify(team) then
        if FistedDKP_Data.teams[team].players ~= nil then
            if FistedDKP_Data.teams[team].players[index] ~= nil then
                FistedDKP_Debug:Message("Player Verify: Exists")
                return true
            end
        end
    end
    return false
end

function FistedDKP_DB_Player:BuildCache(data)
    return {
        player = {
            team = data.team,
            class = data.class,
            level = data.level,
            name = data.name
        }
    }
end

function FistedDKP_DB_Player:BuildHash(data)
    return {
        player = {
            team = data.team,
            name = data.name
        }
    }
end