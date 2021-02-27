key = {
    states = {}
}

function key.isdown(char)
    return key.states[char] ~= nil and key.states[char]
end

function love.keypressed(char, code, isrepeat)
    if isrepeat then return end
    if char == 'escape' and config.debug then love.event.quit() end

    key.states[char] = true
end

function love.keyreleased(char, code)
    key.states[char] = false
end