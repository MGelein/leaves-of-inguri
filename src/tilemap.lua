tilemap = {
    x = 0,
    y = 0,
    r = 0,
    scale = 4,
    colliders = {}
}

function tilemap.load(name)
    tilemap.unload()
    tilemap.data = require('maps.' .. name)

    tilemap.cols = tilemap.data.width
    tilemap.rows = tilemap.data.height
    tilemap.tileWidth = tilemap.data.tilewidth
    tilemap.tileHeight = tilemap.data.tileheight
    tilemap.width = tilemap.cols * tilemap.tileWidth
    tilemap.height = tilemap.rows * tilemap.tileHeight
    tilemap.canvas = love.graphics.newCanvas(tilemap.width, tilemap.height)

    for i, layer in ipairs(tilemap.data.layers) do
        if layer.name == 'tiles' then tilemap.renderCanvas(layer.data)
        elseif layer.name == 'collision' then tilemap.createCollisionShapes(layer.objects)
        elseif layer.name == 'entities' then tilemap.createEntities(layer.data)
        end
    end

    local paddingX = config.width - tilemap.width * tilemap.scale
    local paddingY = config.height - tilemap.height * tilemap.scale
    screen.setBounds(paddingX, paddingY)
    gui.showMapname(tilemap.data.properties.named)
end

function tilemap.createEntities(tiles)
    for i, tile in ipairs(tiles) do
        if tile > 0 then
            local x = (i - 1) % tilemap.cols
            local y = math.floor((i - 1) / tilemap.cols)
            entityparser.parse(tile, x * tilemap.tileWidth * tilemap.scale, y * tilemap.tileHeight * tilemap.scale)
        end
    end
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
            collider.class = 'tile'
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