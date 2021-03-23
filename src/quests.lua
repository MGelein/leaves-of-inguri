quests = {}
quests.lineTypes = {
    ['@'] = 'title',
    ['#'] = 'entry',
    ['>'] = 'summary',
}
quests.cache = {}
quests.complete = {}

function quests.load(name)
    quests.current = {state = 'start'}
    for line in love.filesystem.lines('assets/quests/' .. name .. '.txt') do
        if #line > 0 then quests.parseLine(line) end
    end
    quests.cache[name] = quests.current
    return quests.cache[name]
end

function quests.setState(name, state)
    local quest = quests.get(name)
    if not savefile.data.quests then savefile.data.quests = {} end
    if not quest.state == 'end'  then quest.state = state end
    savefile.data.quests[name] = state
    if quest.state == 'end' then
        quests.cache[name] = nil
        quests.complete[name] = quest
    end
end

function quests.parseLine(line)
    local lineType = quests.lineTypes[line:sub(1, 1)]
    
    if lineType == 'title' then quests.current.title = line:sub(2)
    elseif lineType == 'entry' then
        quests.cState = line:sub(2)
        quests.current[quests.cState] = {}
    elseif lineType == 'summary' then 
        quests.current[quests.cState].summary = line:sub(2)
    else
        local text = quests.current[quests.cState].text
        if not text then quests.current[quests.cState].text = line
        else quests.current[quests.cState].text = text .. line end
    end
end

function quests.restoreFromSave()
    if not savefile.data.quests then return end
    for name, state in pairs(savefile.data.quests) do
        quests.setState(name, state)
    end
end

function quests.get(name)
    return quests.cache[name] or quests.complete[name] or quests.load(name)
end