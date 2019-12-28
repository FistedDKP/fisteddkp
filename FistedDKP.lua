local _, fisted = ...
local _G = _G
local L = fisted.L

fisted.version = '1.0.0-alpha'

FistedDKP = LibStub("AceAddon-3.0"):NewAddon("FistedDKP","AceConsole-3.0")

FistedDKP_DB = {}

function FistedDKP:OnEnable()
    print("FistedDKP Loading")
    print(fisted.version)

    FistedDKP_Communication:CommEnable()
 end