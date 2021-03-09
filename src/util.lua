function decrease(value)
    if value <= 0 then return value
    else return value - 1 end
end

function dist(x, y, x2, y2)
    return math.sqrt((x2 - x) ^ 2 + (y2 - y) ^ 2)
end

function randomFromTable(list)
    return list[math.floor(love.math.random(1, #list))]
end

function splitstring(str, delim)
    if not delim then delim = '%s' end
    local parts = {}
    for part in str:gmatch('([^' .. delim .. ']+)') do table.insert(parts, part) end
    return parts
end

function capitalize(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

function printtable(toprint, indent)
    indent = indent or ''
    for name, value in pairs(toprint) do
        if type(value) == 'table' then 
            print(table.concat({indent, name, ' = {'}), '')
            printtable(toprint[name], indent .. '  ')
            print(table.concat({indent, '}'}), '')
        else
            print(table.concat({indent, name, ' = ', tostring(value)}, ''))
        end
    end
end