assets = {}

function assets.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    assets.tiles = spritesheet.create('assets/graphics/tiles.png', 8, 8)
    assets.entities = spritesheet.create('assets/graphics/entities.png', 8, 8)
end