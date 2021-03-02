hero = {
    symbolTile = 5
}

function hero.create(xPos, yPos)
    local entity = entities.createWalk(6, xPos, yPos)
    entity.force = 0.3
    entity.update = hero.update
    entity.collider.class = 'hero'
    hero.entity = entity
end

function hero.update(self, dt)
    hero.handleInput(self)
    screen.follow(self.x, self.y, dt)
end

function hero.handleInput(self)
    if input.isDown('left') then self.ax = self.ax - self.force end
    if input.isDown('right') then self.ax = self.ax + self.force end
    if input.isDown('up') then self.ay = self.ay - self.force end
    if input.isDown('down') then self.ay = self.ay + self.force end
end