local _, fisted = ...

FistedDKP_GUI = FistedDKP:NewModule("FistedDKP_GUI")
FistedDKP_GUI.frame = nil

local AceGUI = LibStub("AceGUI-3.0")

function FistedDKP_GUI:Toggle()
    if not self.frame then
        self.frame = self:Create()
        self.frame:Show()
    elseif not self.frame:IsShown() then
        self.frame:Show()
    else
        self.frame:Hide()
    end
end

local function SelectedTab(container, event, group)
    FistedDKP_GUI:SelectTab(container, event, group)
end

function FistedDKP_GUI:Create()
    if not self.frame then
        local frame = AceGUI:Create("Frame")
        frame:SetTitle("FistedDKP")
        frame:SetStatusText("")
        frame:SetCallback("OnClose", function (widget) AceGUI:Release(widget); self.frame = nil end)
        frame:SetLayout("Fill")

        local tabgroup = AceGUI:Create("TabGroup")
        tabgroup:SetLayout("Flow")
        tabgroup:SetTitle("FistedDKP")
        tabgroup:SetTabs(
            {
                {text="Main", value="main"},
                {text="Summary", value="summary"},
                {text="DKP", value="dkp"},
                {text="Loot", value="loot"},
                {text="Team", value="team"},
                {text="Options", value="option"},
                {text="Import/Export", value="impexp"}
            }
        )
        tabgroup:SetCallback("OnGroupSelected", SelectedTab)
        tabgroup:SelectTab('main')

        frame:AddChild(tabgroup)

        return frame
    else
        return self.frame
    end
end

function FistedDKP_GUI:SelectTab(container, event, group)
    container:ReleaseChildren()
    if group == 'main' then
        container:AddChild(FistedDKP_GUI:Main())
    elseif group == 'summary' then
        container:AddChild(FistedDKP_GUI_Summary:Toggle())
    elseif group == 'dkp' then
        --container:AddChild(FistedDKP_GUI_DKP:Toggle())
    elseif group == 'loot' then
    elseif group == 'team' then
    elseif group == 'options' then
    elseif group == 'impexp' then
    end
end

function FistedDKP_GUI:Main()
    local frame = AceGUI:Create("SimpleGroup")


    local cola = AceGUI:Create("Label")
    cola:SetText("Test")
    local colb = AceGUI:Create("Label")
    colb:SetText("Test")
    local colc = AceGUI:Create("Label")
    colc:SetText("Test")

    local ilabel = AceGUI:Create("ListRow")
    ilabel:SetHighlight(193,66,66,1.0)
    ilabel:SetFullWidth(true)
    ilabel:AddColumn(cola)
    --ilabel:AddColumn(colb)

    frame:AddChild(ilabel)
    frame:AddChild(colc)

    return frame
end
