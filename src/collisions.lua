collisions = {}

function collisions.handleDetect(entity)
    local foundHero = false
    for shape, delta in pairs(hc.collisions(entity.detectCollider)) do
        if shape.class == 'hero' then
            foundHero = true
            entity.target = shape.parent
        end
    end
    if not foundHero then entity.target = nil end
end

function collisions.handleTile(collider)
    for shape, delta in pairs(hc.collisions(collider)) do
        local class = shape.class
        if class == 'tile' or class == 'trigger' or class == 'detect' then
            -- do nothing
        else
            if shape.parent.move then shape.parent:move(-delta.x, -delta.y) end
        end
    end
end

function collisions.handleEntity(entA, collider)
    local classA = collider.class
    for shape, delta in pairs(hc.collisions(collider)) do
        local classB = shape.class
        local entB = shape.parent
        if entB == nil then goto continue end

        if classA ~= 'weapon' and classB ~= 'weapon' then
            local totalMass = entA.mass + entB.mass
            if totalMass > 0 then
                if entB.mass == 0 then
                    entA:move(delta.x, delta.y)
                elseif entA.mass == 0 then
                    entB:move(-delta.x, -delta.y)
                else
                    local ratioB = entB.mass / totalMass
                    local ratioA = entA.mass / totalMass
                    entA:move(delta.x * ratioB, delta.y * ratioB)
                    entB:move(-delta.x * ratioA, -delta.y * ratioA)
                end
            end
        else
            local weapon = entA
            local target = entB
            if classB == 'weapon' then
                weapon = entB
                target = entA
            end
            if weapon.owner == target then goto continue end
            target:damage(weapon.owner.attack)
        end

        ::continue::
    end
end