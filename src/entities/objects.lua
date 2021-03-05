objects = {}

function objects.create(xPos, yPos, template)
    local object = entities.create(template.tile, xPos, yPos)
    object.health = template.health or object.health
end