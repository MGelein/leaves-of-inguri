weapons = {}

function weapons.create(x, y, vx, vy, owner, name)
    local template = entityparser.weaponTemplates[name]
    if template == nil then return end
    local weapon = entities.createForce(template.tile, x, y)
    weapon.collider.class = 'weapon'
    weapon.vx = vx
    weapon.vy = vy
    weapon.owner = owner
end