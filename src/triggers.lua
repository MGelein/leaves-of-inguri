triggers = {}
triggers.list = managedlist.create()

function triggers.create(def)
    local trigger = {
        type = def.properties.type,
        method = def.properties.method,
        activated = false,
        properties = def.properties,
        collider = tilemap.createCollider(def),
        activate = triggers.activate,
    }
    trigger.collider.class = 'trigger'
    trigger.collider.parent = trigger
    triggers.list:add(trigger)
    return trigger
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
    triggers[self.type](self)
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