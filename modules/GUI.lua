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

    local row = AceGUI:Create("InlineGroup")
    row:SetLayout("Flow")
    row:SetFullWidth("fill")


    local cola = AceGUI:Create("Label")
    cola:SetText("Test 1")
    cola:SetWidth("50")
    local colb = AceGUI:Create("Label")
    colb:SetText("Test 2")
    colb:SetWidth("50")
    local colc = AceGUI:Create("Label")
    colc:SetText("Test 3")

    row:AddChild(cola)
    row:AddChild(colb)

    --local ilabel = AceGUI:Create("ListRow")
    --ilabel:SetLayout("Flow")
    --ilabel:SetWidth(600)
    --ilabel:SetHighlight(193,66,66,1.0)
    --ilabel:AddColumn(cola)
    --ilabel:AddColumn(colb)

    --frame:AddChild(ilabel)
    frame:AddChild(row)
    frame:AddChild(colc)

    return frame
end
