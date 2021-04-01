tilemap = {
    x = 0,
    y = 0,
    r = 0,
    scale = 4,
    colliders = {},
    nextHeroPos = nil,
}

function tilemap.load(name)
    tilemap.unload()
    tilemap.x = 0
    tilemap.y = 0
    tilemap.data = require('assets.maps.' .. name)
    
    tilemap.name = name
    tilemap.cols = tilemap.data.width
    tilemap.rows = tilemap.data.height
    tilemap.tileWidth = tilemap.data.tilewidth
    tilemap.tileHeight = tilemap.data.tileheight
    tilemap.width = tilemap.cols * tilemap.tileWidth
    tilemap.height = tilemap.rows * tilemap.tileHeight
    tilemap.canvas = love.graphics.newCanvas(tilemap.width, tilemap.height)

    local tileLayer = tilemap.getLayerByName('tiles')
    tilemap.renderCanvas(tileLayer.data)
    local collisionLayer = tilemap.getLayerByName('collision')
    tilemap.createCollisionShapes(collisionLayer.objects)
    local entityLayer = tilemap.getLayerByName('entities')
    tilemap.createEntities(entityLayer.data)
    local triggerLayer = tilemap.getLayerByName('triggers')
    tilemap.createTriggers(triggerLayer.objects)

    local paddingX = config.width - tilemap.width * tilemap.scale
    local paddingY = config.height - tilemap.height * tilemap.scale
    screen.setBounds(paddingX, paddingY)
    if gamestates.active == game then gui.showHeader(tilemap.data.properties.name) end
    savefile.data.currentMapName = tilemap.data.properties.name
    music.play(tilemap.data.properties.bgm)
    gui.minimapMarker = tilemap.data.properties.minimap or 'none'
    tilemap.nextHeroPos = nil
    screen.snapToFollow = true
end

function tilemap.getLayerByName(name)
    for i, layer in ipairs(tilemap.data.layers) do
        if layer.name == name then return layer end
    end
end

function tilemap.createTriggers(objects)
    for i, triggerDef in ipairs(objects) do
        local trigger = triggers.create(triggerDef)
    end
    entities.processDead()
end

function tilemap.createEntities(tiles)
    for i, tile in ipairs(tiles) do
        if tile > 0 then
            local x = (i - 1) % tilemap.cols
            local y = math.floor((i - 1) / tilemap.cols)
            local ent = entityparser.parse(i, tile, x * tilemap.tileWidth * tilemap.scale, y * tilemap.tileHeight * tilemap.scale)
            if not tilemap.isAlive(i) then entities.markAsDead(ent) end
        end
    end
end

function tilemap.setNextHeroPos(xPos, yPos)
    tilemap.nextHeroPos = {
        x = xPos,
        y = yPos,
    }
end

function tilemap.renderCanvas(tiles)
    local oldCanvas = love.graphics.getCanvas()
    love.graphics.setCanvas(tilemap.canvas)

    for i, tile in ipairs(tiles) do
        local x = (i - 1) % tilemap.cols
        local y = math.floor((i - 1) / tilemap.cols)
        assets.tiles.drawSprite(tile, x * tilemap.tileWidth, y * tilemap.tileHeight) 
    end

    love.graphics.setCanvas(oldCanvas)
end

function tilemap.createCollisionShapes(shapes)
    for i, shape in ipairs(shapes) do
        local collider = tilemap.createCollider(shape)
        if collider then
            collider.class = shape.properties.class or 'tile'
            table.insert(tilemap.colliders, collider)
        end
    end
end

function tilemap.createCollider(object)
    local scale = tilemap.scale
    if object.shape == 'rectangle' then 
        return hc.rectangle(object.x * scale, object.y * scale, object.width * scale, object.height * scale)
    elseif object.shape == 'polygon' then
        local points = {}
        local off = {x = object.x * scale, y = object.y * scale}
        for i, coord in ipairs(object.polygon) do
            table.insert(points, coord.x * scale + off.x)
            table.insert(points, coord.y * scale + off.y)
        end
        return hc.polygon(unpack(points))
    elseif object.shape == 'ellipse' then
        local radius = ((object.width + object.height) / 2) * scale / 2
        return hc.circle(object.x * scale + radius, object.y * scale + radius, radius)
    end
end

function tilemap.draw()
    love.graphics.draw(tilemap.canvas, tilemap.x, tilemap.y, tilemap.r, tilemap.scale, tilemap.scale)
    
    if config.debug then 
        for i, collider in ipairs(tilemap.colliders) do collider:draw('line') end
    end
end

function tilemap.update()
    for i, collider in ipairs(tilemap.colliders) do
        collisions.handleTile(collider)
    end
end

function tilemap.unload()
    entities.removeAll()
    triggers.clear()
    npcs.clear()
    if not tilemap.colliders then return end
    for i, collider in ipairs(tilemap.colliders) do
        hc.remove(collider)
    end
    tilemap.data = nil
    tilemap.x = 0
    tilemap.y = 0
    tilemap.r = 0
    tilemap.colliders = {}
end

function tilemap.recordEntityDeath(entity)
    if entity.id < 1 then return end
    local key = tilemap.name .. 'Entity' .. entity.id .. 'Dead'
    savefile.data[key] = true
end

function tilemap.isAlive(id)
    if id < 1 then return true end
    local key = tilemap.name .. 'Entity' .. id .. 'Dead'
    return not savefile.data[key]
end