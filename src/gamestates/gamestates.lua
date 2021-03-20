gamestates = {
    active = nil,
    next = nil,

    overlay = {
        alpha = 0,
        deltaAlpha = 0.01,
    }
}

function gamestates.setNext(state)
    if gamestates.active ~= nil then
        gamestates.next = state
        gamestates.active.stop()
        gamestates.next.load()
        gui.clear()
        ez.easeInOut(gamestates.overlay, {alpha = 1}):complete(function() gamestates.switchPoint() end)
    else
        gamestates.active = state
        gamestates.active.load()
        gamestates.active.start()
    end
end

function gamestates.update(dt)
    gamestates.active.update(dt)
end

function gamestates.draw()
    gamestates.active.draw()
    gamestates.drawOverlay(gamestates.overlay)
end

function gamestates.drawOverlay(overlay)
    if overlay.alpha < 0.01 then return end
    love.graphics.setColor(0, 0, 0, overlay.alpha)
    love.graphics.rectangle('fill', 0, 0, config.width, config.height)
    love.graphics.setColor(1, 1, 1, 1)
end

function gamestates.switchPoint()
    gamestates.active = gamestates.next
    gamestates.active.start()
    gamestates.next = nil
    ez.easeInOut(gamestates.overlay, {alpha = 0})
end