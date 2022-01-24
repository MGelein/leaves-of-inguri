quests = {}
quests.lineTypes = {
    ['@'] = 'title',
    ['#'] = 'entry',
    ['>'] = 'summary',
}
quests.cache = {}
quests.complete = {}
quests.active = 'none'

function quests.known()
    local known = {}
    for name, quest in pairs(quests.cache) do known[name] = quest end
    for name, quest in pairs(quests.complete) do known[name] = quest end
    return known
end

function quests.load(name)
    local url = 'assets/quests/' .. name .. '.quest'
    if not love.filesystem.getInfo(url) then return end
    quests.current = {state = 'start'}
    for line in love.filesystem.lines(url) do
        if #line > 0 then quests.parseLine(line) end
    end
    quests.cache[name] = quests.current
    return quests.cache[name]
end

function quests.setState(name, state)
    local quest = quests.get(name)
    if quests.complete[name] then return end
    if not savefile.data.quests then savefile.data.quests = {} end
    savefile.data.quests[name] = state
    quest.state = state
    quests.active = name
    if state == 'end' then
        quests.complete[name] = quest
        quests.cache[name] = nil
        quests.active = ''
    end
    if gui.questWidget then
        if state == 'end' then
            gui.questWidget:hide()
        else
            gui.questWidget:setState(quest.title, quest[state].summary)
        end
    end
end

function quests.save()
    savefile.data.activeQuest = quests.active
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
    quests.active = savefile.data.activeQuest
end

function quests.get(name)
    return quests.cache[name] or quests.complete[name] or quests.load(name)
end