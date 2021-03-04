hero = {
    symbolTile = 5,
    health = 10,
}

function hero.create(xPos, yPos)
    local entity = entities.createWalk(6, xPos, yPos)
    entity.force = 0.3
    entity.update = hero.update
    entity.collider.class = 'hero'
    entity.releasedAttack = true
    entity.attack = 2
    entity.defence = 0
    entity.target = 0
    entity.weapon = 'sword'
    entity.health = hero.health
    entity.maxHealth = hero.health
    entity.detectCollider = hc.circle(xPos, yPos, 100)
    entity.detectCollider.class = 'detect'
    hero.entity = entity
end

function hero.update(self, dt)
    self.attackCooldown = decrease(self.attackCooldown)
    hero.handleInput(self)
    screen.follow(self.x, self.y, dt)
end

function hero.handleInput(self)
    if input.isDown('left') then self.ax = self.ax - self.force end
    if input.isDown('right') then self.ax = self.ax + self.force end
    if input.isDown('up') then self.ay = self.ay - self.force end
    if input.isDown('down') then self.ay = self.ay + self.force end
    
    if input.isDown('block') then self.blocking = true
    else self.blocking = false end

    if input.isDown('attack') and self.releasedAttack and self.attackCooldown == 0 then
        self.releasedAttack = false
        if self.target == nil then 
            weapons.attackAt(self.x + self.vx, self.y + self.vy, self.x, self.y, self, self.weapon)
        else
            weapons.attackAt(self.target.x, self.target.y, self.x, self.y, self, self.weapon)
        end
        self.attackCooldown = entityparser.weaponTemplates[self.weapon].cooldown
    elseif not input.isDown('attack') then
        self.releasedAttack = true
    end
end

function hero.setTarget(self, monster)
    if self.target == nil then 
        self.target = monster
    else
        local monsterDist = dist(monster.x, monster.y, self.x, self.y)
        local targetDist = dist(self.x, self.y, self.target.x, self.target.y)
        if monsterDist < targetDist then self.target = monster end
    end
end