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
    else
        gamestates.active = state
    end
end

function gamestates.update(dt)
    gamestates.active.update(dt)
    gamestates.updateOverlay(gamestates.overlay)
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

function gamestates.updateOverlay(overlay)
    if gamestates.next ~= nil and overlay.alpha < 1 then
        overlay.alpha = overlay.alpha + overlay.deltaAlpha
        if overlay.alpha >= 1 then
            overlay.alpha = 1
            gamestates.active = gamestates.next
            gamestates.next = nil
        end
    elseif gamestates.next == nil and overlay.alpha > 0 then
        overlay.alpha = overlay.alpha - overlay.deltaAlpha
        if overlay.alpha <= 0 then
            overlay.alpha = 0
        end
    end
end