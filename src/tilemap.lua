tilemap = {
    x = 0,
    y = 0,
    r = 0,
    scale = 4,
}

function tilemap.load(name)
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

end

function tilemap.draw()
    love.graphics.draw(tilemap.canvas, tilemap.x, tilemap.y, tilemap.r, tilemap.scale, tilemap.scale)
end