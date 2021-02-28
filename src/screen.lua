screen = {
    canvas = love.graphics.newCanvas(config.width, config.height),
    w2 = config.width / 2,
    h2 = config.height / 2,

    x = 0,
    y = 0,
    r = 0,
    sx = 1,
    sy = 1,
    offX = 0,
    offY = 0,
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

function screen.follow(x, y, dt)
    local dx = (screen.w2 - x) * dt
    local dy = (screen.h2 - y) * dt
    screen.offX = screen.offX + dx
    screen.offY = screen.offY + dy
end

function screen.endDraw()
    love.graphics.pop()
    fps.draw()
    love.graphics.setCanvas()
    love.graphics.scale(screen.sx, screen.sy)
    love.graphics.draw(screen.canvas, screen.x, screen.y, screen.r)
end

function screen.beginDraw()
    love.graphics.setCanvas(screen.canvas)
    love.graphics.clear()
    love.graphics.push()
    love.graphics.translate(screen.offX, screen.offY)
end