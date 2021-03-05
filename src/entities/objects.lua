objects = {}

function objects.create(xPos, yPos, template)
    local object = entities.create(template.tile, xPos, yPos)
    object.health = template.health or object.health
    object.collider.class = 'object'
    object.description = template.description
    if template.update then object.update = template.update end

    if template.description then
        object.interact = function(self)
            gui.showText(randomFromTable(self.description))
        end
        object.interact = template.interact or object.interact
    end
end