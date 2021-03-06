spells = {
    cooldown = 0,
    known = {},
    selectedIndex = 1,
    selected = 'heal',

    healIcon = 120,
    blinkIcon = 88,
    talkWithPlantsIcon = 77,
}
spells.selectedIcon = spells.healIcon

spells.templates = {
    heal = {
        amt = 4,
        cost = 2,
    },
    blink = {
        time = 0.1,
        cost = 1,
    },
    talkWithPlants = {
        time = 5,
        cost = 4,
    }
}

function spells.save()
    savefile.data.spellsKnown = spells.known
end

function spells.load()
    spells.known = savefile.data.spellsKnown or startup.hero.spells
end

function spells.castSelected()
    if spells.cooldown > 0 or #spells.known < 1 then return end 
    spells.cooldown = config.combat.spellCooldown
    local spell = spells[spells.selected]
    if not spell then print("Can't find the " .. spells.selected .. " implementation.") return end
    spell()
end

function spells.update(dt)
    if spells.cooldown > 0 then spells.cooldown = spells.cooldown - dt end
end

function spells.changeSpell(dir)
    if #spells.known < 1 then return end
    spells.selectedIndex = spells.selectedIndex + dir
    if spells.selectedIndex > #spells.known then spells.selectedIndex = 1
    elseif spells.selectedIndex <= 0 then spells.selectedIndex = #spells.known end
    spells.selected = spells.known[spells.selectedIndex]
    spells.selectedIcon = spells[spells.selected .. 'Icon']
end

function spells.fail()
    soundfx.play('fail')
end

function spells.heal()
    local spell = spells.templates.heal
    if hero.entity.mana >= spell.cost then
        soundfx.play('heal')
        hero.entity.mana = hero.entity.mana - spell.cost
        hero.entity:heal(spell.amt)
    else spells.fail() end
end

function spells.blink()
    local spell = spells.templates.blink
    if hero.entity.mana >= spell.cost and hero.entity.speed > 0.1 then
        hero.explode()
        soundfx.play('blink')
        hero.entity.mana = hero.entity.mana - spell.cost
        hero.entity.blinkTime = spell.time
    else spells.fail() end
end

function spells.talkWithPlants()
    local spell = spells.templates.talkWithPlants
    if hero.entity.mana >= spell.cost then
        soundfx.play('talkwithplants')
        hero.entity:setEffect('talkWithPlants', spell.time)
        hero.entity.mana = hero.entity.mana - spell.cost

        for i, trigger in ipairs(triggers.byTag('plant')) do
            trigger.npc:setEffect('highlight', spell.time)
        end
    else spells.fail() end
end