local _, fisted = ...

FistedDKP_DBMGR = FistedDKP:NewModule("FistedDKP_DBMGR")

-- Example:
-- 
-- e3e3e3e3 = { Team = 'e3e3e3e3' }
-- abcd1234 = { Team = 'e3e3e3e3', Item = 'abcd1234' }
-- eeaef11b = { Team = 'e3e3e3e3', Players = 'eeaef11b' }
-- a6d7e8b1 = { Team = 'e3e3e3e3', Tier = 'a6d7e8b1' }
-- ade3d3bc = { Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Encounters = 'ade3d3bc' }
-- bb32c4a1 = { Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1' }
-- ad3eacf1 = { Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1', DKP = 'ad3eacf1' }
-- 2aa3ee12 = { Team = 'e3e3e3e3', Tier = 'a6d7e8b1', Raid = 'bb32c4a1', Loot = '2aa3ee12' }
--
fisted.indexCache = {}

function FistedDKP_DBMGR:QueryIndex(index)
end

function FistedDKP_DBMGR:Set(data)
    
end

function FistedDKP_DBMGR:Get(index)

end
