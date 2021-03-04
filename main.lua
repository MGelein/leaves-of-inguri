require 'imports'

function love.load()
    love.mouse.setVisible(false)
    love.graphics.setBackgroundColor(0.14, 0.14, 0.14, 1)
    
    assets.load()
    input.load()
    screen.setResolution(config.window.width, config.window.height, config.window.fullscreen)
    gamestates.setNext(game)
end

function love.draw()
    screen.beginDraw()
    gamestates.draw()
    screen.endDraw()
end

function love.update(dt)
    gamestates.update(dt)
    fps.update(dt)
    gui.update(dt)
    screen.update(dt)
end