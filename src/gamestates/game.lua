game = {
    paused = false
}

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
    if not game.paused then
        entities.update(dt)
        pxparticles.update(dt)
        tilemap.update()
    else
        if input.isDown('block') then 
            game.paused = false 
            game.menu:destroy()
        end
    end

    if input.isDown('menu') then
        game.paused = true
        if not game.menu then 
            game.menu = gui.buttongroup({
                {Test = function() print('test') end},
                {Bla = function() print('bla') end},
                {Quit = function() print('quit!') end},
                {Inventory = function() print('Inventory!') end}
            }, (config.width - 300) / 2, 200, 300, 70)
        end
    end
end

function game.stop()
    entities.removeAll()
    pxparticles.removeAll()
end