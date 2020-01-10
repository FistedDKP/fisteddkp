local _, fisted = ...

FistedDKP_GUI_Summary = FistedDKP:NewModule("FistedDKP_GUI_Summary")
FistedDKP_GUI.frame = nil

local AceGUI = LibStub("AceGUI-3.0")

function FistedDKP_GUI_Summary:Toggle()
    self.frame = self:Create()
    return self.frame
end

function FistedDKP_GUI_Summary:Create()
    
    local frame = AceGUI:Create("ScrollFrame")
    frame:SetFullWidth(true)
    frame:SetFullHeight(true)
    frame:SetLayout("List")

    -- local dkp = FistedDKP_DB_DKP:FetchDKP()

    return frame
end