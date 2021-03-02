screen = {
    canvas = love.graphics.newCanvas(config.width, config.height),
    w2 = config.width / 2,
    h2 = config.height / 2,

    x = 0,
    y = 0,
    vx = 0,
    vy = 0,
    r = 0,
    sx = 1,
    sy = 1,
    offX = 0,
    offY = 0,
    shakeTime = 0,
    shakeForce = 4,
    bounds = {x1 = 0, y1 = 0, x2 = config.width, y2 = config.height}
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

function screen.setBounds(x1, y1, x2, y2)
    screen.bounds.x1 = x1
    screen.bounds.y1 = y1
    if x2 < x1 then x2 = x1 end
    if y2 < y1 then y2 = y1 end
    screen.bounds.x2 = x2
    screen.bounds.y2 = y2
end

function screen.follow(x, y, dt)
    x = x - screen.w2
    y = y - screen.h2
    local dx = (-x - screen.offX) * dt
    local dy = (-y - screen.offY) * dt
    screen.offX = screen.offX + dx
    screen.offY = screen.offY + dy

    local bounds = screen.bounds
    if screen.offX < bounds.x1 then screen.offX = bounds.x1
    elseif screen.offX > bounds.x2 then screen.offX = bounds.x2 end

    if screen.offY < bounds.y1 then screen.offY = bounds.y1
    elseif screen.offY > bounds.y2 then screen.offY = bounds.y2 end
end

function screen.update(dt)
    if screen.shakeTime > 0 then 
        screen.shakeTime = screen.shakeTime - dt
        screen.vx = screen.vx + love.math.random() * screen.shakeForce - screen.shakeForce / 2
        screen.vy = screen.vx + love.math.random() * screen.shakeForce - screen.shakeForce / 2
    end
    screen.vx = screen.vx * 0.95
    screen.vy = screen.vy * 0.95
    screen.x = (screen.vx + screen.x) * 0.95
    screen.y = (screen.vy + screen.y) * 0.95
end

function screen.shake(time)
    if time > screen.shakeTime then screen.shakeTime = time end
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