dialogues = {}
dialogues.cEntry = {}
dialogues.lineTypes = {
    ['@'] = 'name',
    ['#'] = 'entry',
    ['-'] = 'response',
    [':'] = 'command',
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
    
    if lineType == 'entry' then 
        dialogues.cEntry = dialogues.finishEntry(dialogue)
        dialogues.cEntry = { id = line:sub(2), responses = {}, commands = {}}
    elseif lineType == nil then
        dialogues.cEntry.text = line
    elseif lineType == 'name' then
        dialogue.name = line:sub(2)
    elseif lineType == 'response' then
        table.insert(dialogues.cEntry.responses, dialogues.parseResponse(line))
    elseif lineType == 'command' then
        local command = dialogues.parseCommand(line:sub(2))
        if command then 
            table.insert(dialogues.cEntry.commands, command)
        end
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