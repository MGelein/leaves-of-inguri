gamestates = {
    active = nil,
    next = nil,

    overlay = {
        alpha = 1,
        deltaAlpha = 0.01,
    }
}

function gamestates.setNext(state)
    gamestates.next = state
    gamestates.next.load()
    gamestates.transitioning = true
    if gamestates.active ~= nil then
        gamestates.active.stop()
        ez.easeInOut(gamestates.overlay, {alpha = 1}):complete(function() gamestates.switchPoint() end)
    else
        gamestates.switchPoint()
    end
end

function gamestates.update(dt)
    gamestates.active.update(dt)
end

function gamestates.draw()
    gamestates.active.draw()
end

function gamestates.drawOverlay(overlay)
    if overlay.alpha < 0.01 then return end
    love.graphics.setColor(0, 0, 0, overlay.alpha)
    love.graphics.rectangle('fill', -100, -100, config.width + 200, config.height + 200)
    love.graphics.setColor(1, 1, 1, 1)
end

function gamestates.switchPoint()
    gui.clear()
    if gamestates.active then gamestates.active.stop() end
    gamestates.active = gamestates.next
    gamestates.active.start()
    gamestates.next = nil
    ez.easeInOut(gamestates.overlay, {alpha = 0}):complete(function() 
        gamestates.transitioning = false
    end)
end