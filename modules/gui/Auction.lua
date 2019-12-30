local _, fisted = ...

FistedDKP_GUI_Auction = FistedDKP_GUI:NewModule("FistedDKP_GUI_Auction")

local frame = nil

function FistedDKP_GUI_Auction:()
    frame = AceGUI:Create("Frame")
    frame:SetTitle("Auction")
    frame:SetStatusText("")
end