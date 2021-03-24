pickups = {}

pickups.templates = {
    health = {
        tile = 1,
        onPickup = function(self, other) other:heal(5) end
    },
    mana = {
        tile = 2,
        onPickup = function(self, other) other.mana = (other.mana or 0) + 5 end
    }
}

function pickups.dropList(items, x, y)
    for i, item in ipairs(items) do pickups.create(item, x, y) end
end

function pickups.create(name, x, y)
    local template = pickups.templates[name]
    if not template then return end
    local pickup = entities.createForce(-2, template.tile, x, y)
    hc.remove(pickup.collider)
    pickup.collider = hc.circle(x, y, 3.5 * tilemap.scale)
    pickup.collider.class = 'pickup'
    pickup.collider.parent = pickup
    pickup.vx = love.math.random(-5, 5)
    pickup.vy = love.math.random(-5, 5)
    pickup.onPickup = template.onPickup
    pickup.pickup = function(self, other)
        entities.remove(self)
        if self.onPickup then self:onPickup(other) end
    end
    return pickup
end

function pickups.dropChest(chest)
    print(chest)
end