hero = {}

function hero.create(xPos, yPos)
    local entity = entities.create(5, xPos, yPos)
    entity.vx = 0
    entity.vy = 0
    entity.ax = 0
    entity.ay = 0
    entity.friction = 0.9
    entity.force = 0.3
    entity.update = hero.update

    hero.entity = entity
end

function hero.update(self)
    self:move(self.vx, self.vy)
    self.vx = (self.vx + self.ax) * self.friction
    self.vy = (self.vy + self.ay) * self.friction
    self.ax = 0
    self.ay = 0

    hero.handleInput(self)
end

function hero.handleInput(self)
    if input.isDown('left') then self.ax = self.ax - self.force end
    if input.isDown('right') then self.ax = self.ax + self.force end
    if input.isDown('up') then self.ay = self.ay - self.force end
    if input.isDown('down') then self.ay = self.ay + self.force end
end