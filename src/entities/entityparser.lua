entityparser = {}
entityparser.monsterTemplates = {
    mage = {
        tile = 10,
        health = 5,
        damage = 4,
        detectRadius = 200,
    },
    skeleton = {
        tile = 11,
        health = 3,
        damage = 2,
        detectRadius = 150,
    },
    zombie = {
        tile = 12,
        health = 4,
        damage = 1,
        detectRadius = 100,
    },
    snake = {
        tile = 19,
        health = 2,
        damage = 2,
        detectRadius = 80,
    },
    dog = {
        tile = 20,
        health = 2,
        damage = 1,
        detectRadius = 120,
    },
    rat = {
        tile = 21,
        health = 1,
        damage = 1,
        detectRadius = 50,
    },
}

function entityparser.parse(tile, x, y)
    if tile == hero.symbolTile then 
        hero.create(x, y)
    elseif entityparser.isMonsterTile(tile) then 
        local template = entityparser.getMonsterTemplate(tile)
        monsters.create(x, y, template)
    else 
        entities.create(tile, x, y) 
    end
end

function entityparser.isMonsterTile(tile)
    if tile >= 10 and tile <= 15 then return true
    elseif tile >= 19 and tile <= 27 then return true
    else return false end
end

function entityparser.getMonsterTemplate(tile)
    for name, template in pairs(entityparser.monsterTemplates) do
        if template.tile == tile then return template end
    end
end