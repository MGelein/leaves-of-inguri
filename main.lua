require 'imports'

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    screen.setResolution(config.window.width, config.window.height, config.window.fullscreen)
    gamestates.setNext(game)
    input.load()
end

function love.draw()
    screen.beginDraw()
    gamestates.draw()
    fps.draw()
    screen.endDraw()

end

function love.update(dt)
    gamestates.update(dt)
    fps.update(dt)
    if input.isDown('block') then print(dt) end
end