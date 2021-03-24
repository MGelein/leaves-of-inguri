monsters = {}
monsters.count = 0

function monsters.create(id, xPos, yPos, template)
    monsters.count = monsters.count + 1
    local monster = entities.createWalk(id, template.tile, xPos, yPos)
    monster.health = template.health
    monster.maxHealth = template.health
    monster.onDeath = template.onDeath
    monster.attack = template.attack
    monster.defence = template.defence
    monster.weapon = template.weapon
    monster.dropTable = template.dropTable
    monster.dropAmt = template.dropAmt
    monster.particleTint = template.bloodTint
    monster.collider.class = 'monster'
    monster.walkAngleSpeed = template.walkAngleSpeed or monster.walkAngleSpeed
    
    monster.wanderForce = 0.1 * template.speedMult
    monster.wanderTime = 0
    monster.wanderDir = {x = 0, y = 0}
    monster.wanderRadius = 100
    
    monster.detectCollider = hc.circle(xPos, yPos, template.detectRadius)
    monster.detectCollider.class = 'detect'
    monster.activity = 'wandering'
    
    monster.seekForce = 0.3 * template.speedMult
    monster.updateBehaviour = template.behaviour
    return monster
end

function monsters.zombieBehaviour(self, dt)
    if self.target ~= nil then self.activity = 'seeking'
    else self.activity = 'wandering' end

    if self.activity == 'wandering' then monsters.wander(self, dt)
    elseif self.activity == 'seeking' then monsters.seek(self, self.target.x, self.target.y) end
end

function monsters.rangedBehaviour(self, dt)
    self.attackCooldown = self.attackCooldown - dt
    if self.target ~= nil then self.activity = 'shooting'
    else self.activity = 'wandering' end

    if self.activity == 'wandering' then monsters.wander(self, dt)
    elseif self.activity == 'shooting' then 

        local targetDist = dist(self.target.x, self.target.y, self.x, self.y)
        if targetDist < 100 then 
            monsters.avoid(self, self.target.x, self.target.y)
        end
        if self.attackCooldown <= 0 then
            weapons.attackAt(self.target.x, self.target.y, self.x, self.y, self, self.weapon)
            self.attackCooldown = entityparser.weaponTemplates[self.weapon].cooldown
        end
    end
end

function monsters.seek(self, x, y)
    local dx = x - self.x
    local dy = y - self.y
    local length = math.sqrt(dx * dx + dy * dy)
    dx = dx / length
    dy = dy / length
    self.ax = self.ax + dx * self.seekForce
    self.ay = self.ax + dy * self.seekForce
end

function monsters.avoid(self, x, y)
    local dx = x - self.x
    local dy = y - self.y
    local length = math.sqrt(dx * dx + dy * dy)
    dx = dx / length
    dy = dy / length
    self.ax = self.ax - dx * self.seekForce
    self.ay = self.ax - dy * self.seekForce
end

function monsters.wander(self, dt)
    self.wanderTime = self.wanderTime - dt
    if self.wanderTime <= 0 then
        self.wanderTime = love.math.random(1, 2)
        local homeDelta = {x = self.home.x - self.x, y = self.home.y - self.y}
        local homeDist = math.sqrt(homeDelta.x * homeDelta.x + homeDelta.y * homeDelta.y)
        if homeDist < self.wanderRadius then
            if self.wanderDir.x == self.wanderDir.y and self.wanderDir.y == 0 then
                local dir = love.math.random() * math.pi * 2
                self.wanderDir.x = math.cos(dir) * self.wanderForce
                self.wanderDir.y = math.sin(dir) * self.wanderForce
            else
                self.wanderDir.x = 0
                self.wanderDir.y = 0
            end
        else
            homeDelta.x = homeDelta.x / homeDist
            homeDelta.y = homeDelta.y / homeDist
            self.wanderDir.x = homeDelta.x * self.wanderForce
            self.wanderDir.y = homeDelta.y * self.wanderForce
        end
    end
    self.ax = self.ax + self.wanderDir.x
    self.ay = self.ay + self.wanderDir.y
end