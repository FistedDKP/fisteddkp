local _, fisted = ...

FistedDKP_DB_Encounter = FistedDKP_DB:NewModule("FistedDKP_DB_Encounter")

function FistedDKP_DB_Encounter:Get(index)
end

function FistedDKP_DB_Encounter:Set(data)
    assert(data.zone and FistedDKP_DB_Zone:VerifyCreate(zone), "Invalid zone or zone not set")

    local index = data.index or sha1(fisted.serializer:Serialize(self:BuildHash(data)))
    local zone = data.zone

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

    FistedDKP_DB:SetIndexCache(index,self:BuildCache(FistedDKP_Data.zones[zone].encounters[index]))

    return index
end

function FistedDKP_DB_Encounter:VerifyCreate(zone, index)
    if self:Verify(zone, index) then
        FistedDKP_Debug:Message("Encounter Verify: Creating")
        self:Set({
            index = index,
            zone = zone,
            name = "",
            encounterid = nil
        })
        return self:Verify(zone, index)
    else
        return true
    end
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

    return false
end

function FistedDKP_DB_Encounter:BuildCache(data)
    return {
        encounter = {
            zone = data.zone,
            encounter = data.index
        }
    }
end

function FistedDKP_DB_Encounter:BuildHash(data)
    return {
        encounter = {
            name = data.name,
            shortname = data.shortname
        }
    }
end
