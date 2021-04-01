saveselect = {}
saveselect.slotWidth = 350
saveselect.slotSpacing = config.width / 3
saveselect.slotPadding = (config.width - 3 * saveselect.slotWidth) / 6
saveselect.slotHeight = 500

function saveselect.load()
    savefile.data = {}
    saveselect.summaries = savefile.summaries()
end

function saveselect.start()
    mapbackground.showMap('testmap')
    music.play()
    gui.showOverlay(0)
    gui.showHeader('Choose Save Slot', 100000)
    for i, summary in ipairs(saveselect.summaries) do
        gui.saveslot((i - 1) * saveselect.slotSpacing + saveselect.slotPadding, 150, saveselect.slotWidth, saveselect.slotHeight, summary)
    end
end

function saveselect.draw()
    mapbackground.draw()
end

function saveselect.update(dt)
    mapbackground.update(dt)
end

function saveselect.stop()
    mapbackground.stop()
end