assets = {}

function assets.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    assets.tiles = spritesheet.create('assets/graphics/tiles.png', 8, 8)
    assets.entities = spritesheet.create('assets/graphics/entities.png', 8, 8)

    assets.fonts = {}
    assets.fonts.debug = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 20)
    assets.fonts.normal = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 32)
end