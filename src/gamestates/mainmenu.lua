mainmenu = {}
mainmenu.moveDirs = {
    left = {x = 1, y = 0},
    right = {x = -1, y = 0},
    up = {x = 0, y = -1},
    down = {x = 0, y = 1},
    stop = {x = 0, y = 0}, 
}
mainmenu.moveDir = 'left'
mainmenu.moveSpeed = 16
mainmenu.movePos = {x = screen.w2, y = screen.h2}
mainmenu.buttons = {
    {Play = function() gamestates.setNext(game) end},
    {Settings = function() gamestates.setNext(settings) end},
    {Quit = function() love.event.quit() end},
}
mainmenu.buttonWidth = 300

function mainmenu.load()
    savefile.data = {}
end

function mainmenu.start()
    mainmenu.showMap('testmap')
    local title = gui.title(config.window.title, -200)
    ez.easeOut(title, {y = 100}, {delay = 1})
    gui.showOverlay(0)
    
    local x = (config.width - mainmenu.buttonWidth) / 2
    local w = mainmenu.buttonWidth
    gui.buttongroup(mainmenu.buttons, x, 300, w, 70, assets.fonts.button, {time = 1, delay = 2})
    screen.resetPosition()
end

function mainmenu.draw()
    tilemap.draw()
    entities.draw()
end

function mainmenu.update(dt)
    tilemap.update(dt)
    entities.update(dt)
    mainmenu.moveMap(dt)
end

function mainmenu.stop()
    mainmenu.moveDir = 'stop'
end

function mainmenu.showMap(mapName)
    tilemap.load(mapName)
    if hero.entity then entities.remove(hero.entity) end
end

function mainmenu.moveMap(dt)
    local dir = mainmenu.moveDirs[mainmenu.moveDir]
    local pos = mainmenu.movePos
    pos.x = pos.x + (dir.x * mainmenu.moveSpeed) * dt
    pos.y = pos.y + (dir.y * mainmenu.moveSpeed) * dt

    if pos.x > -screen.bounds.x2 + screen.w2 then
        pos.x = -screen.bounds.x2 + screen.w2
        mainmenu.moveDir = 'down'
    elseif pos.y > -screen.bounds.y2 + screen.h2 then 
        pos.y = -screen.bounds.y2 + screen.h2
        mainmenu.moveDir = 'right'
    elseif pos.x < screen.bounds.x1 + screen.w2 then
        pos.x = screen.bounds.x1 + screen.w2
        mainmenu.moveDir = 'up'
    elseif pos.y < screen.bounds.y1 + screen.h2 then
        pos.y = screen.bounds.y1 + screen.h2
        mainmenu.moveDir = 'left'
    end

    screen.follow(mainmenu.movePos.x, mainmenu.movePos.y, dt)
end