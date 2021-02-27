require 'imports'

function love.load()
    gamestates.setNext(game)
end

function love.draw()
    gamestates.draw()
    fps.draw()
end

function love.update(dt)
    gamestates.update(dt)
    fps.update(dt)
end