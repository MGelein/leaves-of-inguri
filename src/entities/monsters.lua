monsters = {}

function monsters.create(spriteNumber, xPos, yPos, detectRadius)
    local monster = entities.createWalk(spriteNumber, xPos, yPos)
    monster.health = 1
    monster.collider.class = 'monster'
    monster.home = {x = xPos, y = yPos}
    monster.wanderForce = 0.1
    monster.wanderFrames = 0
    monster.wanderDir = {x = 0, y = 0}
    monster.wanderRadius = 100
    monster.detectCollider = hc.circle(xPos, yPos, detectRadius)
    monster.detectCollider.class = 'detect'
    monster.detectCollider.parent = monster
    monster.activity = 'wandering'
    
    monster.seekForce = 0.3
    monster.seekTarget = {x = 0, y = 0}
    monster.seekCooldown = 0 
    monster.updateBehaviour = monsters.updateBehaviour
    return monster
end

function monsters.updateBehaviour(self)
    if self.activity == 'wandering' then monsters.wander(self)
    elseif self.activity == 'seeking' then monsters.seek(self, self.seekTarget.x, self.seekTarget.y) end
    
    self.seekCooldown = decrease(self.seekCooldown)
    if self.seekCooldown == 0 then self.activity = 'wandering' end

    collisions.handleDetect(self.detectCollider)
end

function monsters.updateSeekTarget(self, x, y)
    self.seekCooldown = 10
    self.seekTarget.x = x
    self.seekTarget.y = y
    self.activity = 'seeking'
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

function monsters.wander(self)
    self.wanderFrames = decrease(self.wanderFrames)
    if self.wanderFrames <= 0 then
        self.wanderFrames = love.math.random(50, 100)
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