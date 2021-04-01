saveselect = {}

function saveselect.load()
    savefile.data = {}
end

function saveselect.start()
    mapbackground.showMap('testmap')
    music.play()
    gui.showOverlay(0)
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