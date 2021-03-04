entityparser = {}
entityparser.monsterTemplates = {
    mage = {
        tile = 10,
        health = 5,
        attack = 4,
        defence = 2,
        detectRadius = 200,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
    },
    skeleton = {
        tile = 11,
        health = 3,
        attack = 2,
        defence = 1,
        detectRadius = 200,
        behaviour = monsters.rangedBehaviour,
        bloodTint = {r = 1, g = 1, b = 1},
        weapon = 'arrow'
    },
    zombie = {
        tile = 12,
        health = 4,
        attack = 1,
        defence = 1,
        detectRadius = 100,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 0.5, g = 1, b = 0.5},
    },
    snake = {
        tile = 19,
        health = 2,
        attack = 2,
        defence = 1,
        detectRadius = 80,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 0.5, g = 1, b = 0.5},
    },
    dog = {
        tile = 20,
        health = 2,
        attack = 1,
        defence = 0,
        detectRadius = 120,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
    },
    rat = {
        tile = 21,
        health = 1,
        attack = 1,
        defence = 0,
        detectRadius = 50,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
    },
}

entityparser.weaponTemplates = {
    club = {
        tile = 53,
        speed = 3,
        range = 20,
        age = 10,
        cooldown = 40,
        projectile = false,
    },
    sword = {
        tile = 63,
        speed = 5,
        range = 20,
        age = 10,
        cooldown = 20,
        projectile = false,
    },
    axe = {
        tile = 64,
        speed = 4,
        range = 30,
        age = 10,
        cooldown = 30,
        projectile = false,
    },
    bow = {
        tile = 65,
    },
    arrow = {
        tile = 66,
        speed = 5,
        range = 300,
        age = 100,
        cooldown = 60,
        projectile = true,
    },
    trident = {
        tile = 67
    },
    firebolt = {
        tile = 118
    }
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