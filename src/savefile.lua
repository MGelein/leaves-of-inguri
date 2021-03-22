savefile = {}
savefile.data = {}
savefile.url = 'savefile'
savefile.currentSlot = 1

function savefile.exists(slot)
    if love.filesystem.getInfo(savefile.url .. tostring(slot)) then return true
    else return false end
end

function savefile.save(slot)
    hero.save()
    savefile.write(savefile.url .. tostring(slot), savefile.data)
end

function savefile.load(slot)
    savefile.data = savefile.read(savefile.url .. tostring(slot)) or {}
    hero.load()
    quests.restoreFromSave()
end

function savefile.delete(slot)
    love.filesystem.remove(savefile.url .. tostring(slot))
end

function savefile.write(url, data)
    love.filesystem.write(url, savefile.serialize(data))
end

function savefile.serialize(data, prefix)
    prefix = prefix or ''
    local parts = {}
    for key, value in pairs(data) do
        local valType = type(value)
        if valType == 'string' or valType == 'number' or valType == 'boolean' then
            local typePrefix = valType:sub(1, 1)
            table.insert(parts, table.concat({prefix, typePrefix, ucfirst(key), ' = ', tostring(value)}))
        elseif valType == 'table' then
            table.insert(parts, savefile.serialize(value, key .. '.'))
        end
    end
    return table.concat(parts, "\n")
end

function savefile.read(url)
    local data = {}
    if not love.filesystem.getInfo(url) then return nil end
    for line in love.filesystem.lines(url) do
        local parts = splitstring(line, '=')
        if #parts == 2 then
            local name, value = unpack(parts)
            local nameParts = splitstring(name, '.')
            if #nameParts == 1 then 
                savefile.createTableEntry(data, name, value)
            else
                local tab = data
                for i, name in ipairs(nameParts) do 
                    if i ~= #nameParts then 
                        if not tab[name] then tab[name] = {} end
                        tab = tab[name]
                    else      
                        savefile.createTableEntry(tab, name, value)         
                    end
                end
            end
        end
    end
    return data
end

function savefile.createTableEntry(data, key, value)
    value = trimstring(value)
    key = trimstring(key)
    if key:sub(1, 1) == 'n' then value = tonumber(value)
    elseif key:sub(1, 1) == 'b' then value = value:lower() == 'true' end
    
    key = key:sub(2, 2):lower() .. key:sub(3)
    data[key] = value
end