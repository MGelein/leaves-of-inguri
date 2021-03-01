game = {}

function game.load()
    tilemap.load('testmap4')
    monsters.create(12, 300, 300, 200)
    hero.create(500, 500)
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