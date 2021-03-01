game = {}

function game.load()
    tilemap.load('testmap4')
    hero.create(300, 300)
    hero.create(400, 400)
    hero.create(500, 500)
    hero.create(600, 600)
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