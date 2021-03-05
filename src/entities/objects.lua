objects = {}

function objects.create(xPos, yPos, template)
    xPos = xPos + 16
    yPos = yPos + 16
    local object = entities.create(template.tile, xPos, yPos)
end