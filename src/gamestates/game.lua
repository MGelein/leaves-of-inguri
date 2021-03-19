game = {
    paused = false,
    menuStack = {},
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
        if input.isDownOnce('menu') then game.showMenu('menu') end
        if input.isDownOnce('map') then game.showMenu('minimap') end
    else
        if input.isDownOnce('block') then
            game.popMenu()
        end
    end
end

function game.showMenu(menuName)
    gui.showOverlay()
    table.insert(game.menuStack, menuName)
    printtable(game.menuStack)
    if game.menu then 
        game.menu:destroy()
    else
        gui.showHeader(config.window.title, 1000)
        soundfx.play('ui_open')
        game.paused = true
    end
    game.menu = game['open' .. capitalize(menuName)]()
end

function game.popMenu()
    table.remove(game.menuStack, #game.menuStack)
    if #game.menuStack < 1 then 
        game.paused = false
        if gui.header then gui.header.ease.delay = 0 end
        if game.menu then game.menu:destroy() end
        game.menuStack = {}
        game.menu = nil
        gui.hideOverlay()
        soundfx.play('ui_close')
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

function game.openMenu()
    local menu = {
        {Save = function() game.showMenu(game.saveMenuDef) end},
        {Return = function() game.popMenu() end},
        {Quests = function() end},
        {Controls = function() end},
        {Main_Menu = function() end},
        {Quit = function() love.event.quit() end},
    }
    return gui.buttongroup(menu, (config.width - 300) / 2, 150, 300, 70)
end

function game.openMinimap()
    return gui.imgbox(assets.minimap, tilemap.scale)
end