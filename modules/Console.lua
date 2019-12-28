local _, fisted = ...

FistedDKP_Console = LibStub("AceAddon-3.0"):NewAddon("FistedDKP_Console", "AceConsole-3.0")

function FistedDKP_Console:OnEnable()
    self:RegisterChatCommand("fdkp","HandleSlashCommands")
end

 function FistedDKP_Console:HandleSlashCommands(str)
    if( #str == 0 ) then
        -- Open GUI
        return
    end

    local command, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, position = self:GetArgs(str,10)

    if command == "help" then
        self:Print('Fisted DKP')
        self:Print('Version: ' .. fisted.version)
        self:Print('---')
        self:Print('/fdkp help - This help')
        self:Print('/fdkp loot <item> [player [value]]')
        self:Print('/fdkp award [player [value]]')
    end

    if command == "award" then
        local item, player, value = arg1, arg2, arg3
        print(item)
        print(player)
        print(value)
    end

    if command == "test" then
        FistedDKP_Communications:TestComms()
    end
 end