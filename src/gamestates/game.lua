game = {}

function game.load()
    tilemap.load('testmap')
end

function game.start()
    gui.createHealthWidget(10, config.height - 36, hero.entity)
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