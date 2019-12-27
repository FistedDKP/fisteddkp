local _, fisted = ...;
local _G = _G;
local _L = fisted.L;

local LibAceSerializer = LibStub:GetLibrary("AceSerializer-3.0")
local LibCompress = LibStub:GetLibrary("LibCompress")
local LibCompressAddonEncodeTable = LibCompress:GetAddonEncodeTable()

local flags = {}

fisted.comms = LibStub("AceAddon-3.0"):NewAddon("MonDKPComms", "AceComm-3.0")

local commPrefix = "FistedDKP-"

function FistedDKP:CommEnable()
    self:RegisterComm(commPrefix.."DKP", "OnCommReceived_DKP")
    self:RegisterComm(commPrefix.."Loot", "OnCommReceived_Loot")

    self:RegisterComm(commPrefix.."Settings", "OnCommReceived_Settings")

    -- DigitalSorcerwess :: Adding in a post-hook for TakeTaxiNode
    hooksecurefunc("TakeTaxiNode",TakeTaxiNodeHook)
end