saveselect = {}
saveselect.slotWidth = 350
saveselect.slotSpacing = config.width / 3
saveselect.slotPadding = (config.width - 3 * saveselect.slotWidth) / 6
saveselect.slotY = 250
saveselect.slotHeight = 320
saveselect.slot = 1

function saveselect.load()
    savefile.data = {}
    saveselect.summaries = savefile.summaries()
end

function saveselect.start()
    mapbackground.showMap('mainmenu')
    music.play()
    gui.showOverlay(0)
    gui.showHeader('Choose Save Slot', 100000)
    saveselect.slots = {}
    for i, summary in ipairs(saveselect.summaries) do
        local slot = gui.saveslot((i - 1) * saveselect.slotSpacing + saveselect.slotPadding, saveselect.slotY, saveselect.slotWidth, saveselect.slotHeight, summary)
        table.insert(saveselect.slots, slot)
    end
    saveselect.changeSlot(0)
end

function saveselect.draw()
    mapbackground.draw()
end

function saveselect.update(dt)
    mapbackground.update(dt)
    
    if input.isDownOnce('left') or input.isDownOnce('previous') then saveselect.changeSlot(-1)
    elseif input.isDownOnce('right') or input.isDownOnce('next') then saveselect.changeSlot(1)
    elseif input.isDownOnce('menu') or input.isDownOnce('block') then gamestates.setNext(mainmenu)
    elseif input.isDownOnce('attack') or input.isDownOnce('interact') then
        gamestates.setNext(game)
    end
end

function saveselect.changeSlot(dir)
    local prevSlot = saveselect.slots[saveselect.slot]
    if prevSlot then prevSlot.selected = false end
    saveselect.slot = saveselect.slot + dir
    if saveselect.slot < 1 then saveselect.slot = 1
    elseif saveselect.slot > 3 then saveselect.slot = 3 end

    local newSlot = saveselect.slots[saveselect.slot]
    newSlot.selected = true

    if prevSlot ~= newSlot then
        if prevSlot then ez.easeInOut(prevSlot, {y = saveselect.slotY}, {time = 0.5}) end
        ez.easeInOut(newSlot, {y = saveselect.slotY - 50}, {time = 0.5})
    end
    savefile.currentSlot = saveselect.slot
end

function saveselect.stop()
    mapbackground.stop()
end