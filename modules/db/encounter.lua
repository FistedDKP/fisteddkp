local _, fisted = ...

FistedDKP_DB_Encounter = FistedDKP_DB:NewModule("FistedDKP_DB_Encounter")

function FistedDKP_DB_Encounter:Get(index)
end

function FistedDKP_DB_Encounter:Set(data)
    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))
    local zone = data.zone or nil

    if data.zone then
        FistedDKP_DB_Zone:Verify(zone)
    end

    if FistedDKP_Data.zones[zone].encounters == nil then
        FistedDKP_Data.zones[zone].encounters = {}
    end

    if FistedDKP_Data.zones[zone].encounters[index] then
        FistedDKP_Debug:Message("Encounter Set: Exists")
        FistedDKP_Data.zones[zone].encounters[index].index = index
        FistedDKP_Data.zones[zone].encounters[index].zone = data.zone
        FistedDKP_Data.zones[zone].encounters[index].name = data.name
        FistedDKP_Data.zones[zone].encounters[index].encounterid = data.encounterid
    else
        FistedDKP_Debug:Message("Encounter Set: Creating")
        FistedDKP_Data.zones[zone].encounters[index] = {
            index = index,
            zone = zone,
            name = data.name,
            encounterid = data.encounterid
        }
    end

    return index
end

function FistedDKP_DB_Encounter:Verify(zone,index)
    if FistedDKP_DB_Zone:Verify(zone) ~= nil then
        if FistedDKP_Data.zones[zone].encounters ~= nil then
            if FistedDKP_Data.zones[zone].encounters[index] ~= nil then
                FistedDKP_Debug:Message("Encounter Verify: Exists")
                return true
            end
        end
    end

    FistedDKP_Debug:Message("Encounter Verify: Creating")
    self:Set({
        index = index,
        zone = zone,
        name = "",
        encounterid = nil
    })

    return true
end

function FistedDKP_DB_Encounter:BuildHash(data)
    return {
        encounter = {
            name = data.name,
            shortname = data.shortname
        }
    }
end