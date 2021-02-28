require 'imports'

function love.load()
    assets.load()
    input.load()
    screen.setResolution(config.window.width, config.window.height, config.window.fullscreen)
    gamestates.setNext(game)

    tilemap.load('testmap4')
end

function love.draw()
    screen.beginDraw()
    gamestates.draw()
    screen.endDraw()
end

function love.update(dt)
    gamestates.update(dt)
    fps.update(dt)
end