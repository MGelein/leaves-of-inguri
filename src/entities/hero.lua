hero = {
    manaRegenCounter = 0,
    manaRegen = 1 / config.combat.manaPerSecond,
    healthRegenCounter = 0,
    healthRegen = 1 / config.combat.healthPerSecond,
}

function hero.load()
    hero.health = savefile.data.heroHealth or 1
    hero.maxHealth = savefile.data.heroMaxHealth or 20
    hero.mana = savefile.data.heroMana or 10
    hero.maxMana = savefile.data.heroMaxMana or 10
    hero.weapon = savefile.data.heroWeapon or 'club'
    hero.armor = savefile.data.heroArmor or 'cloth'
    hero.coins = savefile.data.heroCoins or 0
    hero.rings = savefile.data.heroRings or 0
    hero.keys = savefile.data.heroKeys or 0
end

function hero.save()
    local data = savefile.data
    data.currentMap = tilemap.name
    data.heroHealth = hero.health
    data.heroMaxHealth = hero.maxHealth
    data.heroMana = hero.mana
    data.heroMaxMana = hero.maxMana
    data.heroWeapon = hero.weapon
    data.heroArmor = hero.armor
    data.heroCoins = hero.coins
    data.heroRings = hero.rings
    data.heroKeys = hero.keys
end

function hero.setKeys(amt)
    hero.keys = amt
    gui.heroWidget.keyLabel.text = amt
end

function hero.setCoins(amt)
    hero.coins = amt
    gui.heroWidget.coinLabel.text = amt
end

function hero.setRings(amt)
    hero.rings = amt
    gui.heroWidget.ringLabel.text = amt
end

function hero.setStats(health, mana)
    local objs = {hero, hero.entity}
    for i, obj in ipairs(objs) do
        obj.health = health
        obj.maxHealth = health
        obj.mana = mana
        obj.maxMana = mana
    end
end

function hero.setWeapon(weapon)
    hero.weapon = weapon
    local weaponTemplate = entityparser.weaponTemplates[hero.weapon] or entityparser.weaponTemplates.club
    hero.entity.attack = weaponTemplate.attack
end

function hero.setArmor(armor)
    hero.armor = armor
    local armorTemplate = entityparser.armorTemplates[hero.armor] or entityparser.armorTemplates.cloth
    hero.entity.defence = armorTemplate.defence
    hero.entity.sprite = armorTemplate.tile
end

function hero.create(xPos, yPos)
    local weaponTemplate = entityparser.weaponTemplates[hero.weapon] or entityparser.weaponTemplates.club
    local armorTemplate = entityparser.armorTemplates[hero.armor] or entityparser.armorTemplates.cloth
    local entity = entities.createWalk(-1, armorTemplate.tile, xPos, yPos)
    entity.force = 0.3
    entity.update = hero.update
    entity.collider.class = 'hero'
    entity.attack = weaponTemplate.attack
    entity.defence = armorTemplate.defence
    entity.target = nil
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
    screen.follow(self.x, self.y, dt)
    hero.handleManaRegen(self, dt)
    hero.handleHealthRegen(self, dt)
    self.attackCooldown = self.attackCooldown - dt
    hero.handleInput(self)
    hero.health = self.health
    hero.mana = self.mana
    if hero.mana > hero.maxMana then
        hero.mana = hero.maxMana
        self.mana = hero.maxMana
    end

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

function hero.handleManaRegen(self, dt)
    if self.mana < self.maxMana then
        hero.manaRegenCounter = hero.manaRegenCounter + dt
        if hero.manaRegenCounter > hero.manaRegen then 
            hero.manaRegenCounter = hero.manaRegenCounter - hero.manaRegen
            self.mana = self.mana + 1
            if self.mana >= hero.maxMana then self.mana = hero.maxMana end
        end
    end
end

function hero.handleHealthRegen(self, dt)
    if self.health < self.maxHealth then
        hero.healthRegenCounter = hero.healthRegenCounter + dt
        if hero.healthRegenCounter > hero.healthRegen then 
            hero.healthRegenCounter = hero.healthRegenCounter - hero.healthRegen
            self:heal(1)
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

    if input.isDownOnce('attack') and self.attackCooldown <= 0 then
        if self.target == nil then 
            weapons.attackAt(self.x + self.vx, self.y + self.vy, self.x, self.y, self, hero.weapon)
        else
            weapons.attackAt(self.target.x, self.target.y, self.x, self.y, self, hero.weapon)
        end
        self.attackCooldown = entityparser.weaponTemplates[hero.weapon].cooldown
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
        if newTarget == self.target then return end
        local newTargetDist = dist(newTarget.x, newTarget.y, self.x, self.y)
        local targetDist = dist(self.x, self.y, self.target.x, self.target.y)
        if newTargetDist < targetDist and not (newTarget.collider.class == 'object' and self.target.collider.class == 'monster') then
            self.target = newTarget 
        end
    end
end