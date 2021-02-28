game = {}

function game.load()
    hero.create(100, 100)
end

function game.start()

end

function game.draw()
    tilemap.draw()
    entities.draw()
end

function game.update(dt)
    entities.update(dt)
    tilemap.update()
end

function game.stop()

end