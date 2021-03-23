objects = {}

function objects.create(id, xPos, yPos, template)
    local object = entities.create(id, template.tile, xPos, yPos)
    object.health = template.health or object.health
    object.mass = template.mass or 0
    object.onDeath = template.onDeath
    object.collider.class = 'object'
    object.index = i
    object.description = template.description
    if template.update then object.update = template.update end

    if template.description then
        object.interact = function(self)
            gui.showText(randomFromTable(self.description))
        end
        object.interact = template.interact or object.interact
    end
end