assets = {}

function assets.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    
    assets.tiles = spritesheet.create('assets/graphics/tiles.png', 8, 8)
    assets.entities = spritesheet.create('assets/graphics/entities.png', 8, 8)
    assets.minimap = love.graphics.newImage('assets/graphics/minimap.png')
    pxparticles.defaultQuad = love.graphics.newQuad(1, 0, 1, 1, assets.entities.width, assets.entities.height)

    assets.fonts = {}
    assets.fonts.debug = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 20)
    assets.fonts.quest = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 24)
    assets.fonts.normal = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 32)
    assets.fonts.button = love.graphics.newFont('assets/graphics/rainyhearts.ttf', 48)
    assets.fonts.header = love.graphics.newFont('assets/graphics/alagard.ttf', 64)
    assets.fonts.title = love.graphics.newFont('assets/graphics/alagard.ttf', 128)
end