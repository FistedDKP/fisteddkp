local _, fisted = ...;
local _G = _G;
local L = fisted.L;

FistedDKP = LibStub("AceAddon-3.0"):NewAddon("FistedDKP", "AceComm-3.0", "AceSerializer-3.0")

function FistedDKP:OnEnable()
    FistedDKP:CommEnable()
 end