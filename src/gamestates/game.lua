game = {
    paused = false,

    menu = nil,
    menuStack = {},
    menuUpdate = nil,
}

function game.load(slot)
    savefile.load(savefile.currentSlot)
end

function game.start()
    tilemap.load(savefile.data.currentMap or 'testingcity')
    gui.createHealthWidget(0, config.height - 96)
    game.paused = false
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
        if input.isDownOnce('block') then game.popMenu() end
        if game.menuUpdate then game.menuUpdate() end
    end
end

function game.showMenu(menuName)
    gui.showOverlay()
    table.insert(game.menuStack, menuName)
    game.paused = true
    if game.menu then 
        game.menu:destroy()
    else
        gui.showHeader(config.window.title, 1000)
        soundfx.play('ui_open')
    end
    game.menu = game['open' .. capitalize(menuName)]()
end

function game.popMenu()
    table.remove(game.menuStack, #game.menuStack)
    game.menuUpdate = nil
    if #game.menuStack < 1 then 
        game.paused = false
        if gui.header and gui.header.ease then 
            if gui.header.ease.onCompletion then gui.header.ease:onCompletion() end
            gui.header.ease.delay = 0
        end
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
    pxparticles.removeAll()
end

function game.openMenu()
    local menu = {
        {Save = function() game.showMenu('save') end},
        {Return = function() game.popMenu() end},
        {Quests = function() end},
        {Controls = function() end},
        {Main_Menu = function() gamestates.setNext(mainmenu) end},
        {Quit = function() love.event.quit() end},
    }
    return gui.buttongroup(menu, (config.width - 300) / 2, 150, 300, 70)
end

function game.openMinimap()
    game.menuUpdate = game.updateMinimap
    return gui.imgbox(assets.minimap, tilemap.scale)
end

function game.updateMinimap()
    if input.isDownOnce('map') then game.popMenu() end
end

function game.openSave()
    savefile.save(savefile.currentSlot)
    local text = "Saving done!"
    return gui.textbox(text, (config.width - config.gui.textboxWidth) / 2, config.height - 10, config.gui.textboxWidth)
end