spells = {
    cooldown = 0,
    known = {'heal', 'blink', 'talkWithPlants'},
    selectedIndex = 1,
    selected = 'heal',
}

spells.templates = {
    heal = {
        amt = 4,
        cost = 2,
    }
}

function spells.castSelected()
    if spells.cooldown > 0 then return end 
    spells.cooldown = config.combat.spellCooldown
    local spell = spells[spells.selected]
    if not spell then print("Can't find the " .. spells.selected .. " implementation.") return end
    spell()
end

function spells.update(dt)
    if spells.cooldown > 0 then spells.cooldown = spells.cooldown - dt end
end

function spells.changeSpell(dir)
    spells.selectedIndex = spells.selectedIndex + dir
    if spells.selectedIndex > #spells.known then spells.selectedIndex = 1
    elseif spells.selectedIndex <= 0 then spells.selectedIndex = #spells.known end
    spells.selected = spells.known[spells.selectedIndex]
end

function spells.fail()
    print("Spell failed")
end

function spells.heal()
    local spell = spells.templates.heal
    if hero.entity.mana >= spell.cost then
        soundfx.play('heal')
        hero.entity.mana = hero.entity.mana - spell.cost
        hero.entity:heal(spell.amt)
    else spells.fail() end
end