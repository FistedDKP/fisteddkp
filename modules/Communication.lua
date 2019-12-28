local _, fisted = ...
local _G = _G
local _L = fisted.L

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local flags = {}
local commPrefix = "FDKP-"

local commsProto = {
    Ver = {
        Query = '0001',
        Respond = '0002',
        BroadcastSend = '00FE',
        BroadcastReceived = '00FF'
    },
    DKP = {
        Query = '0001',
        Respond = '0002',
        IndexQuery = '0011',
        IndexRespond = '0012',
        IndexSend = '0021',
        IndexReceived = '0022',
        BroadcastSend = '00FE',
        BroadcastReceived = '00FF'
    },
    Loot = {
        Query = '0001',
        Respond = '0002',
        IndexQuery = '0011',
        IndexRespond = '0012',
        IndexSend = '0021',
        IndexReceived = '0022',
        BroadcastSend = '00FE',
        BroadcastReceived = '00FF'
    },
    Team = {
        Query = '0001',
        Respond = '0002'
    }
}

FistedDKP_Communication = FistedDKP:NewModule("FistedDKP_Communication", "AceComm-3.0")

function FistedDKP_Communication:CommEnable()
    self:RegisterComm(commPrefix.."Ver", "Dispatch")
    self:RegisterComm(commPrefix.."DKP", "OnCommReceived_DKP")
    self:RegisterComm(commPrefix.."Loot", "OnCommReceived_Loot")

    self:RegisterComm(commPrefix.."Team", "OnCommReceived_Settings")
end

function FistedDKP_Communication:Dispatch(prefix,message,distribution,sender)
    if sender == fisted.player then
        return
    end

    if prefix==commPrefix.."Ver" then
        command = string.sub(message,0,4)
        if command == commsProto.Ver.Query then
            self:SendVersionQueryResponse(sender)
        elseif command == commsProto.Ver.Respond then
            self:ParseVersionQueryResponse(sender,string.sub(message,5))
        end
    elseif prefix==commPrefix.."Loot" then
    elseif prefix==commPrefix.."DKP" then
    elseif prefix==commPrefix.."Team" then
    else
        print("Fatal Error")
    end
end

function FistedDKP_Communication:SendVersionQuery()
    print("Sending Query")
    self:SendCommMessage(commPrefix.."Ver",commsProto.Ver.Query,"GUILD")
end

function FistedDKP_Communication:SendVersionQueryResponse(target)
    print("Sending Response")
    self:SendCommMessage(commPrefix.."Ver",commsProto.Ver.Respond..fisted.version,"WHISPER",target)
end

function FistedDKP_Communication:ParseVersionQueryResponse(target,version)
    print("Parsing Response")
    print(target..": "..version)
end


function FistedDKP_Communication:OnCommReceived_DKP(prefix,message)
    
end
function FistedDKP_Communication:OnCommReceived_Loot()
end
function FistedDKP_Communication:OnCommReceived_Settings()
end

function FistedDKP_Communication:TestComms()
    self:SendCommMessage(commPrefix.."Ver",commsProto.Ver.Query.."test","GUILD")
end

