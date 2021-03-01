collisions = {}

function collisions.handleTile(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        if shape.class == 'tile' or shape.class == 'trigger' then
            -- do nothing
        else
            if shape.parent.move then shape.parent:move(-delta.x, -delta.y) end
        end
    end
end

function collisions.handleEntity(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        local class = shape.class
        if class == 'entity' or class == 'hero' or class == 'monster' then
            shape.parent:move(-delta.x / 2, -delta.y / 2)
            collider.parent:move(delta.x / 2, delta.y / 2)
        end
    end
end