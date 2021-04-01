game = {
    paused = false,

    timePlayed = 0,
    menu = nil,
    menuStack = {},
    menuUpdate = nil,
}

function game.load()
    savefile.load(savefile.currentSlot)
    game.timePlayed = savefile.data.timePlayed or 0
end

function game.start()
    tilemap.load(savefile.data.currentMap or 'testingcity')
    gui.createHeroWidget(0, config.height - 128)
    gui.createQuestWidget(10, 10)
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
        game.timePlayed = game.timePlayed + dt
        entities.update(dt)
        triggers.update(dt)
        pxparticles.update(dt)
        tilemap.update()
        if input.isDownOnce('menu') then game.showMenu('menu') end
        if input.isDownOnce('map') then game.showMenu('minimap') end
    else
        if input.isDownOnce('block') or input.isDownOnce('menu') then game.popMenu() end
        if game.menuUpdate then game.menuUpdate() end
    end
end

function game.showMenu(menuName)
    gui.showOverlay()
    table.insert(game.menuStack, menuName)
    if not game.paused then savefile.updateThumb() end
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
            if gui.header.ease.delay > 0 then gui.header.ease.delay = 0
            else 
                gui.header.ease:remove()
                ez.easeIn(gui.header, {y = -1000}):complete(function() gui.header:destroy() end)
            end
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
        {Quests = function() game.showMenu('quests') end},
        {Controls = function() game.showMenu('controls') end},
        {Main_Menu = function() gamestates.setNext(mainmenu) end},
        {Quit = function() love.event.quit() end},
    }
    return gui.buttongroup(menu, (config.width - 300) / 2, 150, 300, 70)
end

function game.openMinimap()
    return gui.minimap()
end

function game.openSave()
    savefile.save(savefile.currentSlot)
    local text = "Saving done!"
    return gui.textbox(text, (config.width - config.gui.textboxWidth) / 2, config.height - 10, config.gui.textboxWidth)
end

function game.openControls()
    local x = (config.width - config.gui.textboxWidth - 100) / 2
    local controldesc = {
        {"","[Keyboard]", "[Controller]"},
        {"Walk", "Arrow keys", "Left Stick/DPad"},
        {"Interact", "Enter/Return", "A"},
        {"Attack", "Space", "X"},
        {"Block", "LShift", "B"},
        {"Cast Spell", "S", "Y"},
        {"Next Spell", "D", "RT/RB"},
        {"Previous Spell", "A", "LT/LB"},
        {"Menu", "Tab/Escape", "Menu"},
        {"Map", "M", "Map/View"},
    }
    return gui.controlpanel(controldesc, x, 200, config.gui.textboxWidth + 100)
end

function  game.openQuests()
    return gui.questpanel()
end