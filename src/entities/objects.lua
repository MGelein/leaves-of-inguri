objects = {}

function objects.create(xPos, yPos, template)
    local object = entities.create(template.tile, xPos, yPos)
    object.health = template.health or object.health
    object.collider.class = 'object'
    object.description = template.description

    if template.description then
        object.interact = function(self)
            gui.showText(randomFromTable(self.description))
        end
    end
end