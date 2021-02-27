screen = {
    canvas = love.graphics.newCanvas(config.width, config.height),
    sx = 1,
    sy = 1,
}

function screen.setResolution(width, height, fullscreen)
    screen.sx = width / config.width
    screen.sy = height / config.height
    love.window.setMode(width, height)
    love.window.setFullscreen(fullscreen, 'desktop')
    config.window.fullscreen = fullscreen
    config.window.width = love.graphics:getWidth()
    config.window.height = love.graphics:getHeight()
    if config.window.width ~= width or config.window.height ~= height then
        screen.setResolution(config.window.width, config.window.height, config.window.fullscreen)
    end
end

function screen.endDraw()
    love.graphics.setCanvas()
    love.graphics.scale(screen.sx, screen.sy)
    love.graphics.draw(screen.canvas)
end

function screen.beginDraw()
    love.graphics.setCanvas(screen.canvas)
    love.graphics.clear()
end