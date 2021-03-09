dialogues = {}
dialogues.cEntry = {}
dialogues.lineTypes = {
    ['@'] = 'name',
    ['#'] = 'entry',
    ['-'] = 'response',
    [':'] = 'command',
    ['{'] = 'condition',
}

function dialogues.load(name)
    local dialogue = {entries = {}}
    dialogue.show = dialogues.show
    for line in love.filesystem.lines('assets/dialogue/' .. name .. '.txt') do
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
        local command = dialogues.parseCommand(line:sub(2))
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
        text = line:sub(1, line:find('>') - 1),
        dest = line:sub(destIndex + 1)
    }
    return res
end

function dialogues.evaluateCondition(condition)
    print(condition)
    return true
end

function dialogues.executeCommand(command)
    local fnName = 'execute' .. capitalize(command.type) .. 'Command'
    local fn = dialogues[fnName]
    if not fn then print('Unimplemented command type: ' .. command.type) return end
    fn(command.args)
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