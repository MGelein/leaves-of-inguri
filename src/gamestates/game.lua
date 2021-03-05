game = {
    paused = false
}
game.menuDef = {
    {Save = function() end},
    {Return = function() game.hideMenu() end},
    {Quests = function() end},
    {Controls = function() end},
    {Main_Menu = function() end},
    {Quit = function() love.event.quit() end},
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
        if input.isDown('menu') and not game.paused then game.showMenu() end
    else
        if input.isDown('block') then game.hideMenu() end
    end
end

function game.showMenu()
    game.paused = true
    game.menu = gui.buttongroup(game.menuDef, (config.width - 300) / 2, 150, 300, 70)
end

function game.hideMenu()
    game.paused = false
    game.menu:destroy()
end

function game.stop()
    entities.removeAll()
    pxparticles.removeAll()
end