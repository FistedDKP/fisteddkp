local _, fisted = ...
local _G = _G
local _L = fisted.L

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local flags = {}
local commPrefix = "FDKP-"

local commsProto = {
    Ver = {
        Query = 0001,
        Respond = 0002
    },
    DKP = {
        Query = 0001,
        Respond = 0002,
        IndexQuery = 0011,
        IndexRespond = 0012,
        IndexSend = 0021,
        IndexReceived = 0022,
        BroadcastSend = 00FE,
        BroadcastReceived = 00FF
    },
    Loot = {
        Query = 0001,
        Respond = 0002,
        IndexQuery = 0011,
        IndexRespond = 0012,
        IndexSend = 0021,
        IndexReceived = 0022,
        BroadcastSend = 00FE,
        BroadcastReceived = 00FF
    },
    Team = {
        Query = 0001,
        Respond = 0002
    }
}

FistedDKP_Communication = LibStub("AceAddon-3.0"):NewAddon("FistedDKP_Communication", "AceComm-3.0")

function FistedDKP_Communication:CommEnable()
    self:RegisterComm(commPrefix.."Ver", "OnCommReceived_Version")
    self:RegisterComm(commPrefix.."DKP", "OnCommReceived_DKP")
    self:RegisterComm(commPrefix.."Loot", "OnCommReceived_Loot")

    self:RegisterComm(commPrefix.."Team", "OnCommReceived_Settings")
end

function FistedDKP_Communication:Dispatch(prefix,message,distribution,sender)
    if prefix==commPrefix.."Ver" then
        if 
        self:ReceiveVersionQuery()
    elseif prefix==commPrefix.."Loot" then
    elseif prefix==commPrefix.."DKP" then
    elseif prefix==commPrefix.."Team" then
    else
        print("Fatal Error")
    end
end

function FistedDKP_Communication:OnCommReceived_Version()
    print(fisted.version)


end
function FistedDKP_Communication:OnCommReceived_DKP(prefix,message)
    
end
function FistedDKP_Communication:OnCommReceived_Loot()
end
function FistedDKP_Communication:OnCommReceived_Settings()
end

function FistedDKP_Communication:TestComms()
end

