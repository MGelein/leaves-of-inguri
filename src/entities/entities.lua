entities = {}
entities.list = managedlist.create()

function entities.create(spriteNumber, xPos, yPos)
    local entity = {
        sprite = spriteNumber,
        x = xPos,
        y = yPos,
        r = 0,
        scale = 4,
        collider = hc.rectangle(xPos, yPos, 32, 32),

        moveTo = function(self, x, y)
            self.x = x
            self.y = y,
            self.collider:moveTo(x, y)
        end,

        move = function(self, dx, dy)
            self.x = self.x + dx
            self.y = self.y + dy
            self.collider:move(dx, dy)
        end
    }
    entity.collider.class = 'entity'
    entity.collider.parent = entity

    entities.list:add(entity)
    return entity
end

function entities.createForce(spriteNumber, xPos, yPos)
    local entity = entities.create(spriteNumber, xPos, yPos)
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
    entity.walkAngle = love.math.random(0, math.pi * 2)
    entity.walkAngleSpeed = 0.3 + love.math.random() / 20
    entity.speed = 0
    entity.sway = love.math.random(0.15, 0.25)
    entity.updateWalk = entities.updateWalk
    return entity
end

function entities.updateForce(self)
    self:move(self.vx, self.vy)
    self.vx = (self.vx + self.ax) * self.friction
    self.vy = (self.vy + self.ay) * self.friction
    self.ax = 0
    self.ay = 0
end

function entities.updateWalk(self)
    self.collider:rotate(-self.r)
    self.speed = math.sqrt(self.vx * self.vx + self.vy * self.vy)
    if self.speed > 0 then self.walkAngle = self.walkAngle + self.walkAngleSpeed end
    self.y = self.y - (math.sin(self.walkAngle) * self.speed / 4)
    self.r = math.sin(self.walkAngle) * self.sway
    if self.speed < 1 then self.r = self.r * self.speed end
    self.collider:moveTo(self.x, self.y)
    self.collider:rotate(self.r)
end

function entities.draw()
    for i, entity in ipairs(entities.list.all) do
        assets.entities.drawSprite(entity.sprite, entity.x, entity.y, entity.r, entity.scale, entity.scale, 4, 4)
        if config.debug then entity.collider:draw('line') end
    end
end

function entities.update(dt)
    entities.list:update()
    for i, entity in ipairs(entities.list.all) do
        if entity.update then entity:update() end
        if entity.updateForce then entity:updateForce() end
        if entity.updateWalk then entity:updateWalk() end

        collisions.handleEntity(entity.collider)
    end
end