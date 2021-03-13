hero = {
    symbolTile = 6,
    health = 1,
    maxHealth = 20,
    mana = 10,
    maxMana = 10,

    attack = 2,
    defence = 0,
    weapon = 'sword'
}

function hero.create(xPos, yPos)
    local entity = entities.createWalk(-1, 6, xPos, yPos)
    entity.force = 0.3
    entity.update = hero.update
    entity.collider.class = 'hero'
    entity.attack = hero.attack
    entity.defence = hero.defence
    entity.target = nil
    entity.weapon = hero.weapon
    entity.prevWalkAngle = entity.walkAngle

    entity.health = hero.health
    entity.maxHealth = hero.maxHealth
    entity.mana = hero.mana
    entity.maxMana = hero.maxMana
    entity.blinkTime = 0

    entity.detectCollider = hc.circle(xPos, yPos, 50)
    entity.detectCollider.class = 'detect'
    hero.entity = entity
end

function hero.moveTo(x, y)
    hero.entity:moveTo(x, y)
    hero.entity.detectCollider:moveTo(x, y)
end

function hero.update(self, dt)
    self.attackCooldown = decrease(self.attackCooldown)
    hero.handleInput(self)
    screen.follow(self.x, self.y, dt)
    hero.health = self.health
    hero.mana = self.mana
    if self.prevWalkAngle > self.walkAngle then soundfx.play('step') end
    self.prevWalkAngle = self.walkAngle
    
    spells.update(dt)
    if self.blinkTime > 0 then 
        self.blinkTime = self.blinkTime - dt
        for i = 0, 20 do
            self.x = self.x + self.vx
            self.y = self.y + self.vy
            tilemap.update()
            entities.updateColliders(self)
        end
    end
end

function hero.explode()
    pxparticles.fromSprite(hero.entity.sprite, hero.entity.x, hero.entity.y, hero.entity.particleTint, 0.3) 
end

function hero.handleInput(self)
    if input.isDown('left') then self.ax = self.ax - self.force end
    if input.isDown('right') then self.ax = self.ax + self.force end
    if input.isDown('up') then self.ay = self.ay - self.force end
    if input.isDown('down') then self.ay = self.ay + self.force end

    if input.isDownOnce('special') then spells.castSelected() end
    if input.isDownOnce('next') then spells.changeSpell(1) end
    if input.isDownOnce('previous') then spells.changeSpell(-1) end
     
    if input.isDown('block') then self.blocking = true
    else self.blocking = false end

    if input.isDownOnce('attack') and self.attackCooldown == 0 then
        if self.target == nil then 
            weapons.attackAt(self.x + self.vx, self.y + self.vy, self.x, self.y, self, self.weapon)
        else
            weapons.attackAt(self.target.x, self.target.y, self.x, self.y, self, self.weapon)
        end
        self.attackCooldown = entityparser.weaponTemplates[self.weapon].cooldown
    end
    if input.isDownOnce('interact') then
        local trigger = hero.findInteractTrigger(self)
        if trigger then trigger:activate() end

        if not trigger and self.target and self.target.interact then
            if dist(self.target.x, self.target.y, self.x, self.y) < config.interactDist then
                self.target:interact()
            end
        end
    end
end

function hero.findInteractTrigger(self)
    for shape, delta in pairs(hc.collisions(self.detectCollider)) do    	
        if shape.class == 'trigger' and shape.parent.method == 'interact' then
            local x, y = shape:center()
            if dist(self.x, self.y, x, y) < config.interactDist then
                return shape.parent
            end
        end
    end
end

function hero.setTarget(self, newTarget)
    if self.target == nil then 
        self.target = newTarget
    elseif self.target.collider.class == 'object' and newTarget.collider.class == 'monster' then
        self.target = newTarget
    else
        local newTargetDist = dist(newTarget.x, newTarget.y, self.x, self.y)
        local targetDist = dist(self.x, self.y, self.target.x, self.target.y)
        if newTargetDist < targetDist and not (newTarget.collider.class == 'object' and self.target.collider.class == 'monster') then
            self.target = newTarget 
        end
    end
end