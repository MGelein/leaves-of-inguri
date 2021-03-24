pickups = {}

pickups.templates = {
    health = {
        tile = 1,
        onPickup = function(self, other) other:heal(5) end
    },
    mana = {
        tile = 2,
        onPickup = function(self, other) other.mana = (other.mana or 0) + 5 end
    },
    coin = {
        tile = 79,
    },
    ring = {
        tile = 80,
    },
    key = {
        tile = 81,
    },
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
    pickup.type = name
    pickup.vx = love.math.random(-5, 5)
    pickup.vy = love.math.random(-5, 5)
    pickup.onPickup = template.onPickup
    pickup.pickup = function(self, other)
        entities.remove(self)
        local result = soundfx.play('pickup_' .. self.type)
        if not result then soundfx.play('pickup') end
        if self.onPickup then self:onPickup(other) end
    end
    return pickup
end

function pickups.registerDrop(trigger)
    local tx = trigger.x * tilemap.scale
    local ty = trigger.y * tilemap.scale
    for i, ent in ipairs(entities.list.all) do
        if ent.home.x - 16 == tx and ent.home.y - 16 == ty then
            ent.trigger = trigger
            trigger.src = ent
            break
        end
    end
end

function pickups.dropChest(chest)
    chest.trigger:activate()
end