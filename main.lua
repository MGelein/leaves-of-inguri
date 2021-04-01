require 'imports'

function love.load()
    if config.forceSettingsOverwrite then savefile.write('settings.ini', config) end
    config = savefile.read('settings.ini') or config
    
    love.mouse.setVisible(false)
    love.graphics.setLineStyle('rough')
    assets.load()
    input.load()
    screen.setResolution(config.window.width, config.window.height, config.window.fullscreen)
    gamestates.setNext(saveselect)
end

function love.draw()
    screen.beginDraw()
    gamestates.draw()
    screen.endDraw()
end

function love.update(dt)
    gamestates.update(dt)
    gui.update(dt)
    screen.update(dt)
    ez.update(dt)
end