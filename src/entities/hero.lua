hero = {}

function hero.create(xPos, yPos)
    local entity = entities.createWalk(12, xPos, yPos)
    entity.force = 0.3
    entity.update = hero.update
    hero.entity = entity
end

function hero.update(self)
    local x, y = love.mouse.getPosition()
    local dx = x - self.x
    local dy = y - self.y
    local length = math.sqrt(dx * dx + dy * dy)
    dx = dx / length
    dy = dy / length
    self.ax = dx * self.force
    self.ay = dy * self.force
    -- hero.handleInput(self)
end

function hero.handleInput(self)
    if input.isDown('left') then self.ax = self.ax - self.force end
    if input.isDown('right') then self.ax = self.ax + self.force end
    if input.isDown('up') then self.ay = self.ay - self.force end
    if input.isDown('down') then self.ay = self.ay + self.force end
end