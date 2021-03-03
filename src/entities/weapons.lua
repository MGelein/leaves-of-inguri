weapons = {}

function weapons.create(x, y, vx, vy, owner, template)
    local weapon = entities.createForce(template.tile, x, y)
    weapon.collider.class = 'weapon'
    weapon.age = 0
    weapon.maxAge = template.age
    weapon.fromX = x
    weapon.fromY = y
    weapon.range = template.range
    weapon.vx = vx
    weapon.vy = vy
    weapon.r = math.atan2(vy, vx) + math.pi / 4
    weapon.owner = owner
    weapon.friction = 1
    weapon.update = weapons.update
end

function weapons.update(self)
    self.age = self.age + 1
    if self.age > self.maxAge then entities.remove(self) end

    local distance = dist(self.x, self.y, self.fromX, self.fromY)
    if distance > self.range then
        self.vx = 0
        self.vy = 0
    end
end

function weapons.attackAt(x, y, fromX, fromY, owner, name)
    local template = entityparser.weaponTemplates[name]
    if template == nil then return end
    local dx = (x - fromX)
    local dy = (y - fromY)
    local dist = math.sqrt(dx * dx + dy * dy)
    local vx = (dx / dist) * template.speed
    local vy = (dy / dist) * template.speed
    weapons.create(fromX, fromY, vx, vy, owner, template)
end