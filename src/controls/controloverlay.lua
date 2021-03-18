controloverlay = {}
controloverlay.text = {
    keyboard = 'This is just some testing text',
    controller = 'This is just some other text'
}

function controloverlay.draw()
    love.graphics.setFont(assets.fonts.normal)
    love.graphics.printf(controloverlay.text[input.lastMethod], 0, config.height - 32, config.width, 'center')
end

function controloverlay.setKeyboard(text)
    controloverlay.text.keyboard = text
end

function controloverlay.setController(text)
    controloverlay.text.controller = text
end