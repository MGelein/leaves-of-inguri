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
            self.collider:moveTo(x + 16, y + 16)
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

function entities.updateForce(self)
    self:move(self.vx, self.vy)
    self.vx = (self.vx + self.ax) * self.friction
    self.vy = (self.vy + self.ay) * self.friction
    self.ax = 0
    self.ay = 0
end

function entities.draw()
    for i, entity in ipairs(entities.list.all) do
        assets.entities.drawSprite(entity.sprite, entity.x, entity.y, entity.r, entity.scale, entity.scale)
        if config.debug then entity.collider:draw('line') end
    end
end

function entities.update(dt)
    entities.list:update()
    for i, entity in ipairs(entities.list.all) do
        if entity.update then entity:update() end
        if entity.updateForce then entity:updateForce() end
    end
end