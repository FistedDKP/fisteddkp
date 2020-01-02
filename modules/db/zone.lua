local _, fisted = ...

FistedDKP_DB_Zone = FistedDKP_DB:NewModule("FistedDKP_DB_Zone")

function FistedDKP_DB_Zone:Get(index)
end

function FistedDKP_DB_Zone:Set(data)
    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))
    if FistedDKP_Data.zones == nil then
        FistedDKP_Data.zones = {}
    end

    if FistedDKP_Data.zones[index] then
        FistedDKP_Debug:Message("Zone Set: Exists")
        FistedDKP_Data.zones[index].index = index
        FistedDKP_Data.zones[index].id = data.id
        FistedDKP_Data.zones[index].name = data.name
        FistedDKP_Data.zones[index].shortname = data.shortname
        
    else
        FistedDKP_Debug:Message("Zone Set: Creating")
        FistedDKP_Data.zones[index] = {
            index = index,
            id = data.id,
            name = data.name,
            shortname = data.shortname,
            encounters = {}
        }
    end

    return index
end

function FistedDKP_DB_Zone:Verify(index)
    if FistedDKP_Data.zones ~= nil then
        if FistedDKP_Data.zones[index] ~= nil then
            FistedDKP_Debug:Message("Zone Verify: Exists")
            return true
        end
    end

    FistedDKP_Debug:Message("Zone Verify: Creating")
    self:Set({
        index = index,
        id = nil,
        name = "",
        shortname = ""
    })

    return true
end

function FistedDKP_DB_Zone:BuildHash(data)
    return {
        zone = {
            id = data.id,
            name = data.name,
            shortname = data.shortname
        }
    }
end