local _, fisted = ...;
local _G = _G;
local _L = fisted.L;

function FistedDKP:CheckTeamRank(team, sender)
    if fisted.teams[team].owner == sender then
        return true
    end

    if #fisted.teams[team].officers > 0 then
        for k,v in pairs(fisted.teams[team].officers) do
            if k == sender then
                return true
            end
        end
    end

    return false
end
