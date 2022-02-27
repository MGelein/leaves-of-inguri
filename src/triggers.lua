triggers = {}
triggers.list = managedlist.create()

function triggers.create(def)
    local trigger = {
        x = def.x,
        y = def.y,
        type = def.properties.type,
        method = def.properties.method,
        tag = def.properties.tag or '',
        condition = def.properties.condition or '',
        activated = false,
        properties = def.properties,
        activate = triggers.activate,
    }
    if trigger.type == 'npc' then npcs.registerTrigger(trigger)
    elseif trigger.type == 'drop' then pickups.registerDrop(trigger) end

    trigger.collider = tilemap.createCollider(def)
    trigger.collider.class = 'trigger'
    trigger.collider.parent = trigger
    triggers.list:add(trigger)
    return trigger
end

function triggers.text(self)
    gui.showText(self.properties.text)
end

function triggers.warp(self)
    local destinationString = self.properties.destination
    if not destinationString then return end

    local dest = triggers.parseDestination(destinationString)
    if not dest then return end

    if dest.name == tilemap.name then 
        hero.moveTo(dest.x, dest.y)
    else
        tilemap.setNextHeroPos(dest.x, dest.y)
        tilemap.load(dest.name)
    end
end

function triggers.byTag(tag)
    local filtered = {}
    for i, trigger in ipairs(triggers.list.all) do
        if trigger.tag == tag then table.insert(filtered, trigger) end
    end
    return filtered
end

function triggers.npc(self)
    if self.npc then self.npc:talk()
    else print('Could not find dialogue file for "' .. self.properties.id .. '"') end
end

function triggers.command(self)
    self.properties.command = self.properties.command:gsub(':', '')
    local command = dialogues.parseCommand(self.properties.command or '')
    dialogues.executeCommand(command)
    game.saveProgress()
end

function triggers.draw()
    if not config.debug then return end
    for i, trigger in ipairs(triggers.list.all) do
        trigger.collider:draw('line')
    end
end

function triggers.update(dt)
    for i, trigger in ipairs(triggers.list.all) do
        collisions.handleTrigger(trigger, trigger.collider)
    end
    triggers.list:update()
end

function triggers.clear()
    for i, trigger in ipairs(triggers.list.all) do
        hc.remove(trigger.collider)
    end
    triggers.list = managedlist.create()
end

function triggers.activate(self)
    if not dialogues.evaluateConditions(self.condition or true) then return end

    if triggers[self.type] then triggers[self.type](self)
    else print('unrecognized trigger type', self.type) end
end

function triggers.drop(self)
    local contents = self.properties.contents
    local entries = splitstring(contents, ',')
    local drops = {}
    for i, entry in ipairs(entries) do
        local type, amt = unpack(splitstring(trimstring(entry), ':'))
        for j = 1, amt do table.insert(drops, type) end
    end
    pickups.dropList(drops, self.src.x, self.src.y)
    triggers.list:remove(self)
end

function triggers.parseDestination(dest)
    local mapName, coord = unpack(splitstring(dest, '@'))
    if not coord then
        print('Unrecognized destination: ', dest)
        return
    end

    local tileX, tileY = unpack(splitstring(coord, ','))
    if not tileX or not tileY then
        print('Malformed coord: ', coord)
        return
    end
    tileX = tonumber(tileX)
    tileY = tonumber(tileY)

    return {
        name = mapName,
        x = (tileX + 0.5) * tilemap.tileWidth * tilemap.scale,
        y = (tileY + 0.5) * tilemap.tileHeight * tilemap.scale,
    }
end

function triggers.monstersGone()
    for i, trigger in ipairs(triggers.list.all) do
        if trigger.method == 'monstersGone' then
            trigger:activate()
            if #entities.dead == 0 then soundfx.play('triumph') end
        end
    end
end

function triggers.onLoad()
    for i, trigger in ipairs(triggers.list.all) do
        if trigger.method == 'load' then
            trigger:activate()
        end
    end
end