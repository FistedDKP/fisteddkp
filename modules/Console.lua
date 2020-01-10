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
        print("Opening GUI")
        FistedDKP_GUI:Toggle()
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
    elseif command == "award" then
        local item, player, value = arg1, arg2, arg3
        print(item)
        print(player)
        print(value)
    elseif command == "ginfo" then
        local total, online = GetNumGuildMembers()
        for k = 1,total do
            local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName, ap, ar, ism, isor, stand = GetGuildRosterInfo(k)
            print(k, name, status, classFileName, ap, isor, stand)
        end
    elseif command == "init" then
        local raid = self:InitDB()

        testraid = raid
    elseif command == "reinit" then
        FistedDKP_DB:Init()
        self:InitDB()
    elseif command == "insert" then
        local raidinfo, player
        if not testraid and arg1 then
            raidinfo = FistedDKP_DB_Raid:Get(arg1)
        elseif testraid then
            raidinfo = FistedDKP_DB_Raid:Get(testraid)
        else
            return
        end

        if arg2 then
            player = arg2
        else
            player = '1b978db7aef56b4426faa870889a5eff80f8fe3a'
        end

        testvalue = testvalue + 1

        local dkp = FistedDKP_DB_DKP:SetIndex({
            team = raidinfo.team,
            tier = raidinfo.tier,
            raid = raidinfo.index,
            encounter = '1a9700b6c8f763b6337d52ee1a63a6b93b36d102',
            player = player,
            type = "Test",
            assigner = 'Anaximander',
            value = testvalue
        })
    elseif command == "total" then
        if arg1 then
            print(FistedDKP_DB_DKP:GetPlayerTotal(arg1))
            return
        else
            return
        end
    elseif command == "list" then
        local raidinfo = nil
        if not testraid and arg1 then
            raidinfo = FistedDKP_DB_Raid:Get(arg1)
        elseif testraid then
            raidinfo = FistedDKP_DB_Raid:Get(testraid)
        end

        FistedDKP_DB_DKP:TestSort(raidinfo.team, raidinfo.tier, raidinfo.index)
    elseif command == "massinsert" then
        raids = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache,function (key,value) return value.raid end,function (a,b) return a.raid.raid < b.raid.raid end)
        encounters = { "fb88fd4bcd61b6aa90557b137547b84719b91808", "0e3b49ee81263d90f5fa6ccbeddb308877bc0eab", "536a5844c6f463c6b50736652b427af6298be83d", "52620ac46037b0de675cd8cddd0121cbf3d19f00", "a1cffca2122c567119fe14de16cc0a4b2a42935f", "905882d3f278c453a60a92b7de04cea9c2f1a286", "54becb3c990a57f61475b3fc1234af6c349915a1", "ed28234747d09e4e0b61fdcceceec8e99e145c76", "2d005608d7da15aed6be3001897cb6fc2f706cfe", "f2cbfd1eb2d005dbbdb16e459e5c0fece42f53a8"}
        players = getFilteredKeysSortedByValue(FistedDKP_Cache.indexCache,function (key,value) return value.player and (value.player.name == "Anaximander-Smolderweb" or value.player.name == "Darkyogi-Smolderweb") end,function (a,b) return a.player.name < b.player.name end)
        
        print(players[1], players[2])

        if players then
            return
        end

        local timestamp = time() - math.random(1000000) * 1000

        for k=1, 100 do
            testvalue = math.random(5)
            timestamp = timestamp + k

            local dkp = FistedDKP_DB_DKP:SetIndex({
                raid = FistedDKP_Cache.indexCache[raids[math.random(1,#raids)]],
                team = raid.team,
                tier = raid.tier,
                encounter = encounters[math.random(1,#encounters)],
                timestamp = timestamp,
                type = "Test",
                assigner = 'Anaximander',
                value = testvalue
            })
        end
    elseif command == "clear" then
        print(FistedDKP_DB_DKP:ClearAll())
    elseif command == "view" then
        print(FistedDKP_DB:Get())
    elseif command == "version" then
        print(fisted.player)
        FistedDKP_Communication:SendVersionQuery()
    end
 end

 function FistedDKP_Console:InitDB()
    print(fisted)
    for zone, encounters in pairs(fisted.encounters) do
        local zonehash = FistedDKP_DB_Zone:Set({
            name = zone,
            zoneid = 2717
        })

        for boss,encounterid in pairs(fisted.encounters[zone]) do
            local encounter = FistedDKP_DB_Encounter:Set({
                zone = zonehash,
                name = boss,
                encounterid = encounterid
            })
        end
    end

    local team = FistedDKP_DB_Team:Set({
        name = "IRONFIST",
        type = "GUILD",
        founder = "toljar",
        whitelist = {}

    })
    
    local total, online = GetNumGuildMembers()
    for k = 1,total do
        local name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName, ap, ar, ism, isor, stand = GetGuildRosterInfo(k)
        local player = FistedDKP_DB_Player:Set({
            team = team,
            level = level,
            class = class,
            name = name
        })
    end

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

    return raid
 end

function FistedDKP_Console:InsertDKP()
    local dkp = FistedDKP_DB_DKP:SetIndex({
        team = dkp.team,
        tier = dkp.tier,
        raid = dkp.index,
        encounter = dkp.encounter,
        player = dkp.player,
        type = "Test",
        assigner = 'Anaximander',
        value = dkp.value
    })
end