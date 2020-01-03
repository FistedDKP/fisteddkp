local _, fisted = ...

FistedDKP_Console = FistedDKP:NewModule("FistedDKP_Console", "AceConsole-3.0")

local testraid = nil
local testvalue = 0

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

    if command == "sha" then
        print(sha1("test"))
    end

    if command == "serialize" then
        serialized = FistedDKP_Communication:SerializerTest( {
            dkp = {
                team="e3e3e3e3",
                tier='a6d7e8b1',
                raid='bb32c4a1',
                encounter='ddac1234',
                type='12353674',
                assigner='eeaef11b',
                datetime='2019-12-30.083910.010',
            }
        })
        print(sha1(serialized))
        
        serialized = FistedDKP_Communication:SerializerTest( {
            encounter = {
                team="e3e3e3e3",
                tier='a6d7e8b1',
                raid='bb32c4a1',
                encounter='ddac1234'
            }
        })
        print(sha1(serialized))

    end

    if command == "datetime" then
        print(FistedDKP:GetDateTimeWithMilliseconds())
    end

    if command == "setup" then
    end

    if command == "reinit" then
        FistedDKP_DB:Init()
    end

    if command == "init" then
        local zone = FistedDKP_DB_Zone:Set({
            name = "Molten Core",
            shortname = "MC",
            zoneid = 2717
        })

        local encounter = FistedDKP_DB_Encounter:Set({
            zone = zone,
            name = "Lucifron",
            encounterid = 663
        })

        local team = FistedDKP_DB_Team:Set({
            name = "IRONFIST",
            type = "GUILD",
            founder = "toljar",
            whitelist = {}

        })

        local tier = FistedDKP_DB_Tier:Set({
            team = team,
            name = "Tier 1"
        })

        local raid = FistedDKP_DB_Raid:Set({
            team = team,
            tier = tier,
            zone = zone,
            starttime = nil,
            endtime = nil
        })

        testraid = raid
    end

    if command == "insert" then
        local raidinfo = FistedDKP_DB_Raid:Get(testraid)
        testvalue = testvalue + 1

        local dkp = FistedDKP_DB_DKP:Set({
            team = raidinfo.team,
            tier = raidinfo.tier,
            raid = raidinfo.index,
            encounter = '1a9700b6c8f763b6337d52ee1a63a6b93b36d102',
            type = "Test",
            assigner = 'Anaximander',
            value = testvalue
        })
    end

    if command == "list" then
        local raidinfo = nil
        if not testraid and arg1 then
            raidinfo = FistedDKP_DB_Raid:Get(arg1)
        else
            raidinfo = FistedDKP_DB_Raid:Get(testraid)
        end

        FistedDKP_DB_DKP:TestSort(raidinfo.team, raidinfo.tier, raidinfo.index)
    end

    if command == "view" then
        print(FistedDKP_DB:Get())
    end

    if command == "version" then
        print(fisted.player)
        FistedDKP_Communication:SendVersionQuery()
    end
 end 