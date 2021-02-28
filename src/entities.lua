entities = {}
entities.list = managedlist.create()

function entities.create(spriteNumber, xPos, yPos)
    local entity = {
        sprite = spriteNumber,
        x = xPos,
        y = yPos,
        r = 0,
        scale = 4,
        collider = hc.rectangle(xPos, yPos, 32, 32)
    }
    entities.list:add(entity)
    return entity
end

function entities.draw()
    for i, entity in ipairs(entities.list.all) do
        assets.entities.drawSprite(entity.sprite, entity.x, entity.y, entity.r, entity.scale, entity.scale)
        if config.debug then entity.collider:draw('line') end
    end
end

function entities.update(dt)
    entities.list:update()
    for i, entity in ipairs(entities.list.all) do
        if entity.update then entity:update() end
    end
end