collisions = {}

function collisions.handleDetect(entity)
    local foundTarget = false
    local classA = entity.collider.class
    for shape, delta in pairs(hc.collisions(entity.detectCollider)) do
        if classA == 'monster' and shape.class == 'hero' then
            foundTarget = true
            entity.target = shape.parent
        elseif classA == 'hero' and (shape.class == 'monster' or shape.class == 'object') then
            foundTarget = true
            hero.setTarget(entity, shape.parent)
        end
    end
    if not foundTarget then entity.target = nil end
end

function collisions.handleTile(collider)
    local ownClass = collider.class
    for shape, delta in pairs(hc.collisions(collider)) do
        local class = shape.class
        if class == 'tile' or class == 'trigger' or class == 'detect' or class == 'water' then
            -- do nothing
        elseif class == 'weapon' then
            if ownClass == 'tile' then weapons.stop(shape.parent) end
        else
            if shape.parent.move then shape.parent:move(-delta.x, -delta.y) end
        end
    end
end

function collisions.handleTrigger(trigger, collider)
    local activated = false
    if trigger.method == 'collide' then 
        for shape, delta in pairs(hc.collisions(collider)) do
            if shape.class == 'hero' then
                if not trigger.activated then trigger:activate() end
                activated = true
            end
        end
    end
    trigger.activated = activated
end

function collisions.handleEntity(entA, collider)
    local classA = collider.class
    if entA.ignoreCollision then return end
    for shape, delta in pairs(hc.collisions(collider)) do
        local classB = shape.class
        local entB = shape.parent
        if classA == classB and classA == 'pickup' then goto continue end
        if entB == nil or classB == 'trigger' or entB.ignoreCollision then goto continue end
        
        if entA == hero.entity and classB == 'pickup' then
            entB:pickup(entA)
            goto continue
        elseif classA ~= 'weapon' and classB ~= 'weapon' then
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

                    if classA ~= 'npc' and classB ~= 'npc' then
                        if classA == classB and entA.name == entB.name then goto continue end
                        if classA ~= 'hero' then entB:damage(entA.attack) end
                        if classB ~= 'hero' then entA:damage(entB.attack) end
                    end
                end
            end
        else
            if classA == classB and classA == 'weapon' then goto continue end
            local weapon = entA
            local target = entB
            if classB == 'weapon' then
                weapon = entB
                target = entA
            end
            if weapon.owner == target then goto continue
            else
                target:damage(weapon.owner.attack, weapon.dirX, weapon.dirY)
                weapons.stop(weapon)
            end
        end
        ::continue::
    end
end