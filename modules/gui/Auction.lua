local _, fisted = ...

FistedDKP_GUI_Auction = FistedDKP_GUI:NewModule("FistedDKP_GUI_Auction")
FistedDKP_GUI_Auction.frame = nil

function FistedDKP_GUI_Auction:Create()
    self.frame = AceGUI:Create("Frame")
    self.frame:SetTitle("Auction")
    self.frame:SetStatusText("")
end