dialogues = {}
dialogues.cEntry = {}
dialogues.lineTypes = {
    ['@'] = 'name',
    ['#'] = 'entry',
    ['-'] = 'response'
}

function dialogues.show(self, entry)
    gui.showText(self.entries[entry].text)
end

function dialogues.load(name)
    local dialogue = {entries = {}}
    dialogue.show = dialogues.show
    for line in love.filesystem.lines('src/dialogue/' .. name .. '.txt') do
        if #line > 0 then dialogues.parseLine(line, dialogue) end
    end
    return dialogue
end

function dialogues.parseLine(line, dialogue, entry)
    local lineType = dialogues.lineTypes[line:sub(1, 1)]
    
    if lineType == 'entry' then 
        if dialogues.cEntry.id then dialogue.entries[dialogues.cEntry.id] = dialogues.cEntry end
        dialogues.cEntry = { id = line:sub(2), responses = {}}
    elseif lineType == nil then
        dialogues.cEntry.text = line
    elseif lineType == 'name' then
        dialogue.name = line:sub(2)
    elseif lineType == 'response' then
        table.insert(dialogues.cEntry.responses, dialogues.parseResponse(line))
    end
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