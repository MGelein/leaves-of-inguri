weapons = {}

function weapons.create(x, y, dirX, dirY, owner, template)
    local weapon = entities.createForce(template.tile, x, y)
    weapon:moveTo(x + dirX * 8, y + dirY * 8)
    weapon.collider.class = 'weapon'
    weapon.age = 0
    weapon.maxAge = template.age
    weapon.fromX = x
    weapon.fromY = y
    weapon.range = template.range
    weapon.vx = dirX * template.speed
    weapon.vy = dirY * template.speed
    weapon.r = math.atan2(dirY, dirX) + math.pi / 4
    weapon.owner = owner
    weapon.friction = 1
    weapon.projectile = template.projectile
    weapon.update = weapons.update
end

function weapons.attackAt(x, y, fromX, fromY, owner, name)
    local template = entityparser.weaponTemplates[name]
    if template == nil then return end
    local dx = (x - fromX)
    local dy = (y - fromY)
    local dist = math.sqrt(dx * dx + dy * dy)
    local vx = (dx / dist)
    local vy = (dy / dist)
    weapons.create(fromX, fromY, vx, vy, owner, template)
end

function weapons.update(self)
    self.age = self.age + 1
    if self.age > self.maxAge then entities.remove(self) end

    local distance = dist(self.x, self.y, self.fromX, self.fromY)
    if distance > self.range then
        self.vx = 0
        self.vy = 0
    end

    if not self.projectile then
        self.x = self.x + self.owner.vx
        self.y = self.y + self.owner.vy
    end
end