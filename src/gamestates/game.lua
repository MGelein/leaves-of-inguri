game = {}

function game.load()
    tilemap.load('testmap')
end

function game.start()
    gui.createHealthWidget(10, config.height - 36, hero.entity)
    gui.buttongroup({
        {Test = function() print('test') end},
        {Bla = function() print('bla') end},
        {Quit = function() print('quit!') end},
        {Inventory = function() print('Inventory!') end}
    }, 100, 100, 300, 70)
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