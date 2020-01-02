local _, fisted = ...
local _G = _G
local L = fisted.L

FistedDKP = LibStub("AceAddon-3.0"):NewAddon("FistedDKP","AceConsole-3.0")

fisted.version = '1.0.0-alpha'
fisted.player = UnitName('player')
fisted.serializer = LibStub:GetLibrary("AceSerializer-3.0")