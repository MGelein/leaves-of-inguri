collisions = {}

function collisions.handleDetect(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        if shape.class == 'hero' then
            monsters.updateSeekTarget(collider.parent, shape.parent.x, shape.parent.y)
        end
    end
end

function collisions.handleTile(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        if shape.class == 'tile' or shape.class == 'trigger' or shape.class == 'detect' then
            -- do nothing
        else
            if shape.parent.move then shape.parent:move(-delta.x, -delta.y) end
        end
    end
end

function collisions.handleEntity(collider)
    local entity = collider.parent
    for shape, delta in pairs(hc.collisions(collider)) do
        local class = shape.class
        if class == 'entity' or class == 'hero' or class == 'monster' then
            local other = shape.parent
            local totalMass = shape.parent.mass + collider.parent.mass
            if totalMass > 0 then
                if other.mass == 0 then
                    entity:move(delta.x, delta.y)
                elseif entity.mass == 0 then
                    other:move(-delta.x, -delta.y)
                else
                    local otherRatio = other.mass / totalMass
                    local entityRatio = entity.mass / totalMass
                    entity:move(delta.x * otherRatio, delta.y * otherRatio)
                    other:move(-delta.x * entityRatio, -delta.y * entityRatio)
                end
            end
        end
    end
end