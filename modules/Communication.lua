local _, fisted = ...
local _G = _G
local _L = fisted.L

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibDeflate = LibStub:GetLibrary("LibDeflate")

local flags = {}
local commPrefix = "FDKP-"

--
-- Packet Format:
-- 
-- { index = { Team = '', Tier = '', Raid = '', Encounter = '', Assigner = '', Member = '', DKP = '', Reason = '', datetime = '' } }
-- { index = { Team = '', Tier = '', Raid = '', Encounter = '', Player = '', Loot = '' } }
-- { index = { Team = '', Player = '', Level = 60, Race = Troll, Class = Priest, Role = nil, Permission = nil } }

local commsProto = {
    Ver = {
        Query = {
            Prefix='0001',
            Receiver = 'Ver_Query'
        },
        Respond = {
            Prefix = '0002',
            Receiver = 'Ver_Respond'
        },
        BroadcastSend = {
            Prefix = '00FE',
            Receiver = 'Ver_BroadcastSend'
        },
        BroadcastReceived = {
            Prefix = '00FF',
            Receiver = 'Ver_BroadcastReceived'
        }
    },
    Team = {
        Query = {
            Prefix = '3001',
            Receiver = 'Team_Query'
        },
        Respond = {
            Prefix = '3002',
            Receiver = 'Team_Respond'
        },
        IndexQuery = {
            Prefix = '3011'
        },
        IndexRespond = {
            Prefix = '3012'
        },
        IndexRequest = {
            Prefix = '3021'
        },
        IndexSend = {
            Prefix = '3022'
        },
        IndexReceived = {
            Prefix = '3023'
        }
    },
    DKP = {
        Query = {
            Prefix = '4001',
            Receiver = 'DKP_Query'
        },
        Respond = {
            Prefix = '4002',
            Receiver = 'DKP_Respond'
        },
        IndexQuery = {
            Prefix = '4011',
            Receiver = 'DKP_IndexQuery'
        },
        IndexRespond = {
            Prefix = '4012',
            Receiver = 'DKP_IndexRespond'
        },
        IndexRequest = {
            Prefix = '4021'
        },
        IndexSend = {
            Prefix = '4022',
            Receiver = 'DKP_IndexSend'
        },
        IndexReceived = {
            Prefix = '4023',
            Receiver = 'DKP_IndexReceived'
        },
        BroadcastSend = {
            Prefix = '40FE',
            Receiver = 'DKP_BroadcastSend'
        },
        BroadcastReceived = {
            Prefix = '40FF',
            Receiver = 'DKP_BroadcastReceived'
        }
    },
    Loot = {
        Query = {
            Prefix = '6001',
            Receiver = 'Loot_Query'
        },
        Respond = {
            Prefix = '6002',
            Receiver = 'Loot_Respond'
        },
        IndexQuery = {
            Prefix = '6011',
            Receiver = 'Loot_IndexQuery'
        },
        IndexRespond = {
            Prefix = '6012',
            Receiver = 'Loot_IndexRespond'
        },
        IndexRequest = {
            Prefix = '6021'
        },
        IndexSend = {
            Prefix = '6022',
            Receiver = 'Loot_IndexSend'
        },
        IndexReceived = {
            Prefix = '6023',
            Receiver = 'Loot_IndexReceived'
        },
        BroadcastSend = {
            Prefix = '60FE',
            Receiver = 'Loot_BroadcastSend'
        },
        BroadcastReceived = {
            Prefix = '60FF',
            Receiver = 'Loot_BroadcastReceived'
        },
    },
    Raid = {
        RaidStartSend = {
            Prefix = '8001'
        },
        RaidStartReceived = {
            Prefix = '8002'
        },
        RaidEndSend = {
            Prefix = '8011'
        },
        RaidEndReceived = {
            Prefix = '8012'
        },
    },
    Bid = {
        SendBid = {
            Prefix = 'A001'
        },
        ReceiveBid = {
            Prefix = 'A002'
        },
        CancelBid = {
            Prefix = 'A011'
        },
        ReceiveCancel = {
            Prefix = 'A012'
        },
        BroadcastBid = {
            Prefix = 'A0FF'
        },
    }
}

FistedDKP_Communication = FistedDKP:NewModule("FistedDKP_Communication", "AceComm-3.0")

function FistedDKP_Communication:CommEnable()
    for k,v in pairs(commsProto) do
        for ik,iv in pairs(v) do
            if iv.Prefix ~= nil and iv.Receiver ~= nil then
                self:RegisterComm(commPrefix .. iv.Prefix, iv.Receiver)
            end
        end
    end
end

function FistedDKP_Communication:SendVersionQuery(target)
    target = target or 'GUILD'
    print("Sending Query")
    self:SendCommMessage(commPrefix .. commsProto.Ver.Query.Prefix,"VERSION","GUILD")
end

function FistedDKP_Communication:Ver_Query(prefix,message,distribution,sender)
    print("Sending Response: " .. sender)
    self:SendCommMessage(commPrefix .. commsProto.Ver.Respond.Prefix,fisted.version,"WHISPER",sender)
end

function FistedDKP_Communication:Ver_Respond(prefix,message,distribution,sender)
    print(sender..": "..message)
end

function FistedDKP_Communication:Ver_BroadcastSend(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Ver_BroadcastReceived(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Team_Query(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Team_Respond(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_Query(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_Respond(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_IndexQuery(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_IndexRespond(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_IndexSend(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_IndexReceived(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_BroadcastSend(prefix,message,distribution,sender)
end
function FistedDKP_Communication:DKP_BroadcastReceived(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_Query(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_Respond(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_IndexQuery(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_IndexRespond(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_IndexSend(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_IndexReceived(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_BroadcastSend(prefix,message,distribution,sender)
end
function FistedDKP_Communication:Loot_BroadcastReceived(prefix,message,distribution,sender)
end

--function FistedDKP_Communication:(prefix,message,distribution,sender)
--end


function FistedDKP_Communication:OnCommReceived_DKP(prefix,message)
end
function FistedDKP_Communication:OnCommReceived_Loot()
end
function FistedDKP_Communication:OnCommReceived_Settings()
end

function FistedDKP_Communication:TestComms()
    self:SendCommMessage(commPrefix.."Ver",commsProto.Ver.Query.."test","GUILD")
end

