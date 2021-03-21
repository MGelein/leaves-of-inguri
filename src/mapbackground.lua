mapbackground = {}
mapbackground.moveDirs = {
    left = {x = 1, y = 0},
    right = {x = -1, y = 0},
    up = {x = 0, y = -1},
    down = {x = 0, y = 1},
    stop = {x = 0, y = 0}, 
}
mapbackground.moveDir = 'left'
mapbackground.moveSpeed = 16
mapbackground.movePos = {x = screen.w2, y = screen.h2}

function mapbackground.showMap(mapName)
    mapbackground.moveDir = 'left'
    tilemap.load(mapName)
    if hero.entity then entities.remove(hero.entity) end
end

function mapbackground.stop()
    mapbackground.moveDir = 'stop'
end

function mapbackground.update(dt)
    tilemap.update(dt)
    entities.update(dt)
    mapbackground.moveMap(dt)
end

function mapbackground.draw()
    tilemap.draw()
    entities.draw()
end

function mapbackground.moveMap(dt)
    local dir = mapbackground.moveDirs[mapbackground.moveDir]
    local pos = mapbackground.movePos
    pos.x = pos.x + (dir.x * mapbackground.moveSpeed) * dt
    pos.y = pos.y + (dir.y * mapbackground.moveSpeed) * dt

    if pos.x > -screen.bounds.x2 + screen.w2 then
        pos.x = -screen.bounds.x2 + screen.w2
        mapbackground.moveDir = 'down'
    elseif pos.y > -screen.bounds.y2 + screen.h2 then 
        pos.y = -screen.bounds.y2 + screen.h2
        mapbackground.moveDir = 'right'
    elseif pos.x < screen.bounds.x1 + screen.w2 then
        pos.x = screen.bounds.x1 + screen.w2
        mapbackground.moveDir = 'up'
    elseif pos.y < screen.bounds.y1 + screen.h2 then
        pos.y = screen.bounds.y1 + screen.h2
        mapbackground.moveDir = 'left'
    end

    screen.follow(mapbackground.movePos.x, mapbackground.movePos.y, dt)
end