function decrease(value)
    if value <= 0 then return value
    else return value - 1 end
end

function zeropad(num)
    if num >= 10 or num < 0 then return tostring(num)
    else return '0' .. tostring(num) end
end

function dist(x, y, x2, y2)
    return math.sqrt((x2 - x) ^ 2 + (y2 - y) ^ 2)
end

function randomFromTable(list)
    return list[math.floor(love.math.random(1, #list))]
end

function splitstring(str, delim)
    delim = delim or '%s'
    local parts = {}
    for part in str:gmatch('([^' .. delim .. ']+)') do table.insert(parts, part) end
    return parts
end

function trimstring(str)
    local index = 1
    while str:sub(index, index) == ' ' do index = index + 1 end
    local endIndex = #str
    while str:sub(endIndex, endIndex) == ' ' do endIndex = endIndex - 1 end
    return str:sub(index, endIndex)
end

function capitalize(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

function ucfirst(str)
    return str:sub(1, 1):upper() .. str:sub(2)
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

function HSV(h, s, v)
    if s <= 0 then return v, v, v end
    h = h / 60
    local c = v * s
    local x = (1 - math.abs((h % 2) - 1)) * c
    local m, r, g, b = (v - c), 0, 0, 0 
    if h < 1     then r, g, b = c, x, 0
    elseif h < 2 then r, g, b = x, c, 0
    elseif h < 3 then r, g, b = 0, c, x
    elseif h < 4 then r, g, b = 0, x, c
    elseif h < 5 then r, g, b = x, 0, c
    else              r, g, b = c, 0, x
    end return {(r+m), (g+m), (b+m)}
end