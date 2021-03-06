pxparticles = {}
pxparticles.scale = 4
pxparticles.force = 3
pxparticles.list = managedlist.create()
pxparticles.defaultQuad = nil
pxparticles.startDir = {x = 0, y = 0}

function pxparticles.setStartDir(x, y)
    if x and y then
        local len = math.sqrt(x * x + y * y)
        pxparticles.startDir.x = x / len
        pxparticles.startDir.y = y / len
    else
        pxparticles.startDir.x = 0
        pxparticles.startDir.y = 0
    end
end

function pxparticles.fromSprite(spriteNumber, xPos, yPos, particleTint, shakeTime)
    if shakeTime > 0 then screen.shake(shakeTime) end
    local quad = assets.entities.getQuad(spriteNumber)
    local qx, qy, qw, qh = quad:getViewport()
    local s = pxparticles.scale
    for x = 0, qw do
        for y = 0, qh do
            local newQuad = love.graphics.newQuad(x + qx, y + qy, 1, 1, assets.entities.width, assets.entities.height)
            local floor = yPos + love.math.random() * qh
            pxparticles.new(newQuad, x * s + xPos - (qw / 2) * s, y * s + yPos - (qh / 2) * s, floor, particleTint)
        end
    end
end

function pxparticles.new(particleQuad, xPos, yPos, floorLevel, particleTint)
    local p = {
        quad = particleQuad or pxparticles.defaultQuad,
        x = xPos,
        y = yPos,
        vx = pxparticles.startDir.x * pxparticles.force,
        vy = pxparticles.startDir.y * pxparticles.force,
        s = 4,
        floor = floorLevel,
        alpha = 1,
        tint = particleTint,
        gravity = 0.3
    }

    local angle = love.math.random() * math.pi * 2
    p.vx = p.vx + math.cos(angle) * pxparticles.force
    p.vy = p.vy + math.sin(angle) * pxparticles.force
    p.update = pxparticles.updateParticle
    pxparticles.list:add(p)
end

function pxparticles.update(dt)
    for i, p in ipairs(pxparticles.list.all) do
        p:update()
    end
    pxparticles.list:update()
end

function pxparticles.updateParticle(self)
    self.x = self.vx + self.x
    self.y = self.vy + self.y
    self.vx = self.vx * 0.95
    self.vy = self.vy * 0.95 + self.gravity

    if self.y > self.floor then
        self.y = self.floor
        self.vy = self.vy * -0.6
        self.vx = self.vx * 0.95
    end

    self.alpha = self.alpha * 0.95
    if self.alpha < 0.01 then pxparticles.list:remove(self) end
end

function pxparticles.draw()
    for i, p in ipairs(pxparticles.list.all) do
        love.graphics.setColor(p.tint.r, p.tint.g, p.tint.b, p.alpha)
        assets.entities.drawQuad(p.quad, p.x, p.y, 0, p.s, p.s)
        love.graphics.setColor(1, 1, 1, 1)
    end 
end

function pxparticles.removeAll()
    for i, p in ipairs(pxparticles.list.all) do pxparticles.list:remove(p) end
end