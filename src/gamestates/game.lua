game = {
    paused = false,
    menuStack = {}
}

game.menuDef = {
    {Save = function() game.showMenu(game.saveMenuDef) end},
    {Return = function() game.popMenu() end},
    {Quests = function() end},
    {Controls = function() end},
    {Main_Menu = function() end},
    {Quit = function() love.event.quit() end},
}

game.saveMenuDef = {
    {Slot_1 = function() savefile.save(1) end},
    {Slot_2 = function() savefile.save(2) end},
    {Slot_3 = function() savefile.save(3) end},
}

function game.load()
    tilemap.load('testingcity')
end

function game.start()
    gui.createHealthWidget(0, config.height - 96)
end

function game.draw()
    tilemap.draw()
    triggers.draw()
    pxparticles.draw()
    entities.draw()
end

function game.update(dt)
    if not game.paused then
        entities.update(dt)
        triggers.update(dt)
        pxparticles.update(dt)
        tilemap.update()
        if input.isDownOnce('menu') then game.showMenu(game.menuDef) end
        if input.isDownOnce('map') then gui.showImage(assets.minimap) end
    else
        if input.isDownOnce('block') then
            soundfx.play('ui_close')
            game.popMenu() 
        end
    end
end

function game.showMenu(menuDef)
    table.insert(game.menuStack, menuDef)
    if game.menu then 
        game.menu:destroy()
    end
    soundfx.play('ui_open')
    game.paused = true
    gui.showHeader(config.window.title, 1000)
    game.menu = gui.buttongroup(menuDef, (config.width - 300) / 2, 150, 300, 70)
end

function game.popMenu()
    table.remove(game.menuStack, #game.menuStack)
    if #game.menuStack < 1 then 
        game.paused = false
        if gui.header then gui.header.waitTime = 0 end
        if game.menu then game.menu:destroy() end
        game.menuStack = {}
    else
        local prevMenu = game.menuStack[#game.menuStack]
        table.remove(game.menuStack, #game.menuStack)
        game.showMenu(prevMenu)
    end
end

function game.stop()
    entities.removeAll()
    pxparticles.removeAll()
end