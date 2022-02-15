dialogues = {}
dialogues.cEntry = {}
dialogues.lineTypes = {
    ['@'] = 'name',
    ['#'] = 'entry',
    ['-'] = 'response',
    [':'] = 'command',
    ['{'] = 'condition',
}

dialogues.operands = {
    ['<'] = function(a, b) return a < b end,
    ['>'] = function(a, b) return a > b end,
    ['<='] = function(a, b) return a <= b end,
    ['>='] = function(a, b) return a >= b end,
    ['=='] = function(a, b) return a == b end,
    ['!='] = function(a, b) return a ~= b end,
    ['~='] = function(a, b) return a ~= b end,
}

function dialogues.load(name)
    local dialogue = {entries = {}}
    dialogue.show = dialogues.show
    for line in love.filesystem.lines('assets/dialogue/' .. name .. '.dialogue') do
        if #line > 0 then dialogues.parseLine(line, dialogue) end
    end
    dialogues.finishEntry(dialogue)
    return dialogue
end

function dialogues.parseLine(line, dialogue, entry)
    local lineType = dialogues.lineTypes[line:sub(1, 1)]
    local entry = dialogues.cEntry
    
    if lineType == 'entry' then 
        dialogues.cEntry = dialogues.finishEntry(dialogue)
        dialogues.cEntry = { 
            id = line:sub(2), 
            options = {
                {text = '', responses = {}, commands = {}, condition = ''},
            }
        }
    elseif lineType == nil then
        entry.options[#entry.options].text = line
    elseif lineType == 'name' then
        dialogue.name = line:sub(2)
    elseif lineType == 'response' then
        table.insert(entry.options[#entry.options].responses, dialogues.parseResponse(line))
    elseif lineType == 'command' then
        local command = dialogues.parseCommand(line)
        if command then 
            table.insert(entry.options[#entry.options].commands, command)
        end
    elseif lineType == 'condition' then
        local cond = entry.options[#entry.options].condition
        if #cond > 1 then 
            local newOption = {text = '', responses = {}, commands = {}, condition = ''}
            table.insert(entry.options, newOption)
        end
        entry.options[#entry.options].condition = line:sub(2, line:find('}') - 1)
    end
end

function dialogues.parseCommand(line)
    if line:sub(1, 1) == ':' then line = line:sub(2) end
    line = line:gsub(' ', '')
    local argIndex = line:find('%(')
    if not argIndex then
        print("No opening parenthesis: ", line) 
        return 
    end
    local endIndex = line:find('%)')
    if not endIndex then
        print("No closing parenthesis: ", line)
        return
    end
    local commandType = line:sub(1, argIndex - 1)
    local arguments = splitstring(line:sub(argIndex + 1, endIndex - 1), ',')
    
    return {
        type = commandType,
        args = arguments,
    }
end

function dialogues.finishEntry(dialogue)
    if dialogues.cEntry.id then dialogue.entries[dialogues.cEntry.id] = dialogues.cEntry end
    return {}
end

function dialogues.parseResponse(line)
    line = line:sub(3)
    local destIndex = line:find('>')
    local res = {
        text = trimstring(line:sub(1, line:find('>') - 1)),
        dest = trimstring(line:sub(destIndex + 1))
    }
    return res
end

function dialogues.evaluateConditions(conditions)
    if conditions == 'DEFAULT' or conditions == true then return true end

    conditions = conditions:gsub(' and ', '&')
    conditions = conditions:gsub(' or ', '|');
    local conditionals = splitstring(conditions, '&')
    local evaluations = {}
    for _, condition in ipairs(conditionals) do
        local optionals = splitstring(trimstring(condition), '|')
        local foundOption = false
        for _, optional in ipairs(optionals) do
            if dialogues.evaluateCondition(optional) then foundOption = true end
        end
        if not foundOption then return false end
    end
    return true
end

function dialogues.evaluateCondition(condition)
    if condition == 'DEFAULT' then return true end
    local parts = splitstring(condition, ' ')
    if #parts == 1 then return dialogues.resolveVariable(condition) end
    if #parts ~= 3 then print("Malformed condition:", condition) return false end
    
    local varname, operand, value = unpack(parts)
    local var = dialogues.resolveVariable(varname)
    if type(var) == 'number' then value = tonumber(value)
    elseif type(var) == 'boolean' then value = value:lower() == 'true' end
    local fn = dialogues.operands[operand]
    if not fn then print('Unsupported operation: "' .. operand .. '"') return false end
    return fn(var, value)
end

function dialogues.resolveVariable(variable)
    local startChar = variable:sub(1, 1)
    local inverted = startChar == '!' or startChar == '~'
    local value = dialogues.resolveVariableName(inverted and variable:sub(2) or variable)
    if type(value) == 'boolean' and inverted then value = not value end
    return value
end

function dialogues.resolveVariableName(name)
    if hero[name] then return hero[name]
    elseif hero.entity.effects[name] then return hero.entity.effects[name]
    elseif savefile.data.quests and savefile.data.quests[name] then return savefile.data.quests[name]
    else return savefile.data[name] or false end
end

function dialogues.executeCommand(command)
    local fnName = 'execute' .. capitalize(command.type) .. 'Command'
    local fn = dialogues[fnName]
    if not fn then print('Unimplemented command type: ' .. command.type) return end
    fn(command.args)
end

function dialogues.executeCoinsCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for coins, expected 1, got " .. tostring(#args)) return end
    local startChar = args[1]:sub(1, 1)
    local amt = tonumber(args[1])
    if startChar == '+' or startChar == '-' then 
        amt = hero.coins + tonumber(args[1])
    end
    hero.setCoins(amt)
end

function dialogues.executeRingsCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for rings, expected 1, got " .. tostring(#args)) return end
    local startChar = args[1]:sub(1, 1)
    local amt = tonumber(args[1])
    if startChar == '+' or startChar == '-' then 
        amt = hero.rings + tonumber(args[1])
    end
    hero.setRings(amt)
end

function dialogues.executeKeysCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for keys, expected 1, got " .. tostring(#args)) return end
    local startChar = args[1]:sub(1, 1)
    local amt = tonumber(args[1])
    if startChar == '+' or startChar == '-' then 
        amt = hero.keys + tonumber(args[1])
    end
    hero.setKeys(amt)
end

function dialogues.executeHealthCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for health, expected 1, got " .. tostring(#args)) return end
    local startChar = args[1]:sub(1, 1)
    local amt = tonumber(args[1])
    if startChar == '+' or startChar == '-' then 
        amt = hero.maxHealth + tonumber(args[1])
    end
    hero.setStats(amt, hero.maxMana)
end

function dialogues.executeManaCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for health, expected 1, got " .. tostring(#args)) return end
    local startChar = args[1]:sub(1, 1)
    local amt = tonumber(args[1])
    if startChar == '+' or startChar == '-' then 
        amt = hero.maxMana + tonumber(args[1])
    end
    hero.setStats(hero.maxHealth, amt)
end

function dialogues.executeWeaponCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for weapon, expected 1, got " .. tostring(#args)) return end
    hero.setWeapon(args[1])
end

function dialogues.executeShieldCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for shield, expected 1, got " .. tostring(#args)) return end
    hero.setShield(args[1])
end

function dialogues.executeArmorCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for armor, expected 1, got " .. tostring(#args)) return end
    hero.setArmor(args[1])
end

function dialogues.executeQuestCommand(args)
    if #args ~= 2 then print("Wrong number of arguments for quest, expected 2, got " .. tostring(#args)) return end
    local name, state = unpack(args)
    quests.setState(name, state)
end

function dialogues.executeHealCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for heal, expected 1, got " .. tostring(#args)) return end
    local amt = tonumber(args[1])
    if not amt then print("Expected a number of hitpoints to heal, but got: " .. args[1]) return end
    hero.entity:heal(amt)
end

function dialogues.executeDamageCommand(args)
    if #args ~= 1 then print("Wrong number of arguments for damage, expected 1, got " .. tostring(#args)) return end
    local amt = tonumber(args[1])
    if not amt then print("Expected a number of hitpoints to damage, but got: " .. args[1]) return end
    hero.entity:damage(amt)
end

function dialogues.executeSetCommand(args)
    if #args > 2 or #args < 1 then print("Wrong number of arguments for set, expected 1 or 2, got " .. tostring(#args)) return end
    local value = args[2] or true
    local name = args[1]
    savefile.data[name] = value
end

function dialogues.executeKillCommand(args)
    local type = 'all'
    if #args == 1 then type = args[1] or 'all' end
    entities.removeAllMonsters(type)
end