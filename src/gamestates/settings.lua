settings = {}

function settings.load()
end

function settings.start()
    mapbackground.showMap('testmap')
    music.play()
    gui.showOverlay(0)
    gui.showHeader('Settings', 100000)
end

function settings.draw()
    mapbackground.draw()
end

function settings.update(dt)
    mapbackground.update(dt)
end

function settings.stop()
    mapbackground.stop()
end