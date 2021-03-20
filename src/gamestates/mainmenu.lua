mainmenu = {}

function mainmenu.load()

end

function mainmenu.start()
    screen.resetPosition()
end

function mainmenu.draw()
    love.graphics.setFont(assets.fonts.title)
    love.graphics.printf(config.window.title, 0, 100, config.width, 'center')
end

function mainmenu.update(dt)

end

function mainmenu.stop()

end