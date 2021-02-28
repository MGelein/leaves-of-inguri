collisions = {}

function collisions.handleTile(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        if shape.class == 'tile' or shape.class == 'trigger' then
            -- do nothing
        else
            shape.parent.x = shape.parent.x - delta.x
            shape.parent.y = shape.parent.y - delta.y
        end
    end
end