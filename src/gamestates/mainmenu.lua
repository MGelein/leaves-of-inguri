mainmenu = {}
mainmenu.buttons = {
    {Play = function() gamestates.setNext(saveselect) end},
    {Settings = function() gamestates.setNext(settings) end},
    {Quit = function() love.event.quit() end},
}
mainmenu.buttonWidth = 300

function mainmenu.load()
    savefile.data = {}
end

function mainmenu.start()
    mapbackground.showMap('testmap')
    music.play()
    local title = gui.title(config.window.title, -200)
    ez.easeOut(title, {y = 100}, {delay = 1})
    gui.showOverlay(0)
    
    local x = (config.width - mainmenu.buttonWidth) / 2
    local w = mainmenu.buttonWidth
    gui.buttongroup(mainmenu.buttons, x, 300, w, 70, assets.fonts.button, {time = 1, delay = 2})
    screen.resetPosition()
end

function mainmenu.draw()
    mapbackground.draw()
end

function mainmenu.update(dt)
    mapbackground.update(dt)
end

function mainmenu.stop()
    mapbackground.stop()
end