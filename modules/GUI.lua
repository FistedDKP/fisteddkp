local _, fisted = ...

FistedDKP_GUI = FistedDKP:NewModule("FistedDKP_GUI")

local frame = nil

function FistedDKP_GUI:Main()
    frame = AceGUI:Create("Frame")
    frame:SetTitle("FistedDKP")
    frame:SetStatusText("")
end
