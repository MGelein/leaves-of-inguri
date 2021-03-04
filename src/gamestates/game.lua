game = {}

function game.load()
    tilemap.load('testmap')
end

function game.start()
    gui.label(assets.fonts.normal, "test", 100, 100, 200, "center")
end

function game.draw()
    tilemap.draw()
    pxparticles.draw()
    entities.draw()
end

function game.update(dt)
    entities.update(dt)
    pxparticles.update(dt)
    tilemap.update()
end

function game.stop()
    entities.removeAll()
    pxparticles.removeAll()
end