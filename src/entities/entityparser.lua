entityparser = {}
entityparser.monsterTemplates = {
    mage = {
        tile = 10,
        health = 5,
        attack = 4,
        defence = 0.5,
        detectRadius = 200,
        behaviour = monsters.rangedBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
        weapon = 'firebolt',
        speedMult = 1,
    },
    ghost = {
        tile = 24,
        health = 4,
        attack = 2,
        defence = 0.0,
        detectRadius = 150,
        behaviour = monsters.rangedBehaviour,
        bloodTint = {r = 0.5, g = 0.5, b = 1},
        weapon = 'acid',
        walkAngleSpeed = 0.05,
        speedMult = 0.5,
    },
    skeleton = {
        tile = 11,
        health = 3,
        attack = 2,
        defence = 0.2,
        detectRadius = 200,
        behaviour = monsters.rangedBehaviour,
        bloodTint = {r = 1, g = 1, b = 1},
        weapon = 'arrow',
        speedMult = 0.8,
    },
    zombie = {
        tile = 12,
        health = 4,
        attack = 1,
        defence = 0.4,
        detectRadius = 100,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 0.5, g = 1, b = 0.5},
        speedMult = 0.6
    },
    shrubber = {
        tile = 27,
        health = 6,
        attack = 1,
        defence = 0.7,
        detectRadius = 60,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 0.5, g = 1, b = 0.5},
        speedMult = 0.9
    },
    snake = {
        tile = 19,
        health = 2,
        attack = 2,
        defence = 0.1,
        detectRadius = 80,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 0.5, g = 1, b = 0.5},
        speedMult = 0.9
    },
    dog = {
        tile = 20,
        health = 2,
        attack = 1,
        defence = 0.3,
        detectRadius = 120,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
        speedMult = 1.1
    },
    rat = {
        tile = 21,
        health = 1,
        attack = 1,
        defence = 0.0,
        detectRadius = 50,
        behaviour = monsters.zombieBehaviour,
        bloodTint = {r = 1, g = 0.5, b = 0.5},
        speedMult = 1,
    },
}

entityparser.weaponTemplates = {
    club = {
        tile = 53,
        speed = 3,
        range = 20,
        age = 10,
        cooldown = 0.8,
        projectile = false,
        attack = 1,
    },
    sword = {
        tile = 63,
        speed = 5,
        range = 20,
        age = 10,
        cooldown = 0.3,
        projectile = false,
        attack = 4,
    },
    axe = {
        tile = 64,
        speed = 4,
        range = 30,
        age = 10,
        cooldown = 0.5,
        projectile = false,
        attack = 3,
    },
    arrow = {
        tile = 66,
        speed = 5,
        range = 300,
        age = 100,
        cooldown = 2,
        projectile = true,
        attack = 2,
    },
    trident = {
        tile = 67,
        speed = 5,
        range = 40,
        age = 10,
        cooldown = 0.5,
        projectile = false,
        attack = 2,
    },
    firebolt = {
        tile = 119,
        speed = 5,
        range = 300,
        age = 100,
        cooldown = 2,
        projectile = true,
        attack = 5,
    },
    acid = {
        tile = 114,
        speed = 5,
        range = 200,
        age = 50,
        cooldown = 1,
        projectile = true,
        attack = 4,
    }
}

entityparser.armorTemplates = {
    cloth = {tile = 4, defence = 0.1},
    leather = {tile = 5, defence = 0.3},
    chain = {tile = 6, defence = 0.6},
    plate = {tile = 7, defence = 0.8},
}

entityparser.objectTemplates = {
    door = {
        tile = 33,
        health = 2,
        description = {'A simple wooden door'},
    },
    campfire = {
        tile = 122,
        health = 1,
        description = {'A beautiful campfire with embers that softly glow, welcoming you closer with a familiar warmth and protection.'},
    },
    gravestone = {
        tile = 108,
        health = 4,
        description = {'An ornate gravestone.'},
    },
    well = {
        tile = 96,
        health = 50,
        description = {'A well filled with water.'},
    }
}

function entityparser.parse(i, tile, x, y)
    x = x + 16
    y = y + 16
    if entityparser.isHero(tile) then 
        if tilemap.nextHeroPos then hero.create(tilemap.nextHeroPos.x, tilemap.nextHeroPos.y)
        else hero.create(x, y) end
    elseif entityparser.getMonsterTemplate(tile) then 
        local template = entityparser.getMonsterTemplate(tile)
        monsters.create(i, x, y, template)
    elseif entityparser.getObjectTemplate(tile) then
        local template = entityparser.getObjectTemplate(tile)
        objects.create(i, x, y, template)
    elseif entityparser.isNPC(tile) then
        npcs.create(i, tile, x, y)
    else
        entities.create(i, tile, x, y) 
    end
end

function entityparser.isHero(tile)
    return tile == 6
end

function entityparser.isNPC(tile)
    return tile == 5 or tile == 8 or tile == 9
end

function entityparser.getObjectTemplate(tile)
    for name, template in pairs(entityparser.objectTemplates) do
        if template.tile == tile then return template end
    end
end

function entityparser.getMonsterTemplate(tile)
    for name, template in pairs(entityparser.monsterTemplates) do
        if template.tile == tile then return template end
    end
end