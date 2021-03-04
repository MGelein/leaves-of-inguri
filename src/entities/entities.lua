entities = {
    shield = 95,
    hero = 5,
    campfire = 122,
}
entities.list = managedlist.create()

function entities.create(spriteNumber, xPos, yPos)
    local entity = {
        sprite = spriteNumber,
        particleTint = {r = 1, g = 1, b = 1},
        x = xPos,
        y = yPos,
        r = 0,
        scale = 4,
        sx = 1,
        sy = 1,
        health = -100,
        maxHealth = -100,
        collider = hc.rectangle(xPos, yPos, 32, 32),
        colliderR = 0,
        mass = 0,
        blocking = false,
        invulnerableFrames = 0,
        removed = false,

        moveTo = function(self, x, y)
            self.x = x
            self.y = y
        end,

        move = function(self, dx, dy)
            self.x = self.x + dx
            self.y = self.y + dy
        end,

        damage = function(self, amt)
            if self.health == -100 or self.invulnerableFrames > 0 then return end
            if self.blocking then amt = amt / 2 end
            amt = amt - self.defence
            if amt < 0 then return end

            self.invulnerableFrames = config.combat.invulnerableFrames

            self.health = self.health - amt
            if self.health <= 0 then
                soundfx.play('die')
                self.health = 0
                entities.remove(self)
                local shakeTime = 0.2
                if self.collider.class == 'hero' then shakeTime = 0.5 end
                pxparticles.fromSprite(self.sprite, self.x, self.y, self.particleTint, shakeTime)
            else
                if self.collider.class == 'hero' then soundfx.play('hurt')
                else soundfx.play('hit') end
            
            end
        end
    }
    entity.collider.class = 'entity'
    entity.collider.parent = entity

    entities.list:add(entity)
    return entity
end

function entities.createForce(spriteNumber, xPos, yPos)
    local entity = entities.create(spriteNumber, xPos, yPos)
    entity.mass = 0.1
    entity.vx = 0
    entity.vy = 0
    entity.ax = 0
    entity.ay = 0
    entity.friction = 0.9
    entity.updateForce = entities.updateForce
    return entity
end

function entities.createWalk(spriteNumber, xPos, yPos)
    local entity = entities.createForce(spriteNumber, xPos, yPos)
    entity.mass = 1
    entity.walkAngle = love.math.random()
    entity.walkAngleSpeed = 0.3 + love.math.random() / 20
    entity.speed = 0
    entity.sway = 0.2
    entity.tsx = 1
    entity.updateWalk = entities.updateWalk
    entity.attackCooldown = 0
    return entity
end

function entities.updateForce(self)
    self:move(self.vx, self.vy)
    self.vx = (self.vx + self.ax) * self.friction
    self.vy = (self.vy + self.ay) * self.friction
    self.ax = 0
    self.ay = 0

    if self.blocking then
        self.vx = self.vx * 0.8
        self.vy = self.vy * 0.8
    end
end

function entities.updateWalk(self, dt)
    self.speed = math.sqrt(self.vx * self.vx + self.vy * self.vy)

    if self.speed > 0 then 
        self.walkAngle = self.walkAngle + self.walkAngleSpeed 
        if self.walkAngle > math.pi * 2 then self.walkAngle = self.walkAngle - math.pi * 2 end
    end

    self.y = self.y - (math.sin(self.walkAngle) * self.speed / 4)
    self.r = math.sin(self.walkAngle) * self.sway
    if self.speed < 1 then self.r = self.r * self.speed end
    
    if self.vx < 0 then self.tsx = 1
    else self.tsx = -1 end
    self.sx = (self.tsx - self.sx) * (dt * 10) + self.sx
end

function entities.draw()
    for i, ent in ipairs(entities.list.all) do
        if ent.invulnerableFrames > 0 then love.graphics.setColor(1, 0.5, 0.5)
        else love.graphics.setColor(1, 1, 1, 1) end
        assets.entities.drawSprite(ent.sprite, ent.x, ent.y, ent.r, ent.scale * ent.sx, ent.scale * ent.sy, 4, 4)
        if ent.blocking then
            assets.entities.drawSprite(entities.shield, ent.x, ent.y, ent.r, ent.scale * ent.sx, ent.scale * ent.sy, 4, 4)
        end
        if config.debug then 
            ent.collider:draw('line') 
            if ent.detectCollider then ent.detectCollider:draw('line') end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function entities.update(dt)
    entities.list:update()
    for i, entity in ipairs(entities.list.all) do
        entity.invulnerableFrames = decrease(entity.invulnerableFrames)
        if entity.update then entity:update(dt) end
        if entity.updateForce then entity:updateForce() end
        if entity.updateWalk then entity:updateWalk(dt) end
        if entity.updateBehaviour then entity:updateBehaviour() end
        if entity.detectCollider then collisions.handleDetect(entity) end

        if entity.health ~= 0 then
            entities.updateColliders(entity)
        else
            entities.remove(entity)
        end
    end
end

function entities.updateColliders(entity)
    if entity.removed then return end
    entity.collider:moveTo(entity.x, entity.y)
    if entity.colliderR ~= entity.r then
        entity.collider:rotate(-entity.colliderR)
        entity.collider:rotate(entity.r)
        entity.colliderR = entity.r

        if entity.detectCollider then entity.detectCollider:moveTo(entity.x, entity.y) end
    end
    collisions.handleEntity(entity, entity.collider)
end

function entities.remove(entity)
    if entity.removed then return end
    entities.list:remove(entity)
    hc.remove(entity.collider)
    entity.removed = true
end

function entities.removeAll()
    for i, entity in ipairs(entities.list.all) do entities.remove(entity) end
end