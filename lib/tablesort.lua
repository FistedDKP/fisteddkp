function getKeysSortedByValue(tbl, sortFunction)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b)
        return sortFunction(tbl[a], tbl[b])
    end)

    return keys
end

function getFilteredKeysSortedByValue(tbl, filterFunction, sortFunction)
    local keys = {}
    for key,value in pairs(tbl) do
        if filterFunction(key,value) then
            table.insert(keys, key)
        end
    end

    table.sort(keys, function(a, b)
        return sortFunction(tbl[a], tbl[b])
    end)

    return keys
end