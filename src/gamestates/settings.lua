settings = {}

function settings.load()
    settings.selectedRow = 1
    settings.prevSelected = 1
end

function settings.start()
    mapbackground.showMap('mainmenu')
    music.play()
    gui.showOverlay(0)
    gui.showHeader('Settings', 100000)

    local header = components.label('Graphics', 300, 150, config.width - 600, 'center')
    header.font = assets.fonts.button
    components.label('Fullscreen: ', 300, 220, 200, 'right')
    settings.fullscreen = components.label(config.window.fullscreen and 'Enabled' or 'Disabled', 520, 220, 256, 'center')

    header = components.label('Audio', 300, 350, config.width - 600, 'center')
    header.font = assets.fonts.button
    components.label('Master: ', 300, 420, 200, 'right')
    settings.masterVol = gui.progressbar(config.audio.masterVolume * 100, 100, 520, 420, 256, 36, {0.6, 0, 0.6})
    components.label('Music: ', 300, 470, 200, 'right')
    settings.bgmVol = gui.progressbar(config.audio.bgmVolume * 100, 100, 520, 470, 256, 36, {0.6, 0, 0.6})
    components.label('FX: ', 300, 520, 200, 'right')
    settings.fxVol = gui.progressbar(config.audio.fxVolume * 100, 100, 520, 520, 256, 36, {0.6, 0, 0.6})

    settings.applyButton = components.button('Apply', (config.width / 2) - 200, 620, 180, function() 
        soundfx.play('ui_action')
        settings.apply() 
    end)
    settings.cancelButton = components.button('Back', (config.width / 2) + 20, 620, 180, function() 
        soundfx.play('ui_close')
        gamestates.setNext(mainmenu) 
    end)
    
    settings.controls = {
        settings.fullscreen, 
        settings.masterVol, 
        settings.bgmVol, 
        settings.fxVol, 
        settings.applyButton,
        settings.cancelButton
    }
    settings.selectorLine = components.line((config.width / 2) - 300, 0, (config.width / 2) + 300, 0, 2)
    settings.current = settings.controls[settings.selectedRow]
end

function settings.draw()
    mapbackground.draw()

    if settings.selectedRow <= #settings.controls - 2 then
        local lineY = settings.current.y + assets.fonts.normal:getHeight() + 8
        settings.selectorLine.y = lineY
        settings.selectorLine.y2 = lineY
    else
        settings.current.selected = true
        settings.selectorLine.y = -100
        settings.selectorLine.y2 = -100
    end
end

function settings.update(dt)
    mapbackground.update(dt)
    
    if input.isDownOnce('next') or input.isDownOnce('down') then
        settings.selectedRow = settings.selectedRow + 1
    elseif input.isDownOnce('previous') or input.isDownOnce('up') then
        settings.selectedRow = settings.selectedRow - 1
    elseif input.isDownOnce('interact') or input.isDownOnce('attack') then
        if settings.current.activate then settings.current:activate() end
    end

    if input.isDown('left') then
        settings.change(-1)
    elseif input.isDown('right') then
        settings.change(1)
    end

    for i, control in ipairs(settings.controls) do control.selected = false end
    if settings.selectedRow < 1 then settings.selectedRow = 1
    elseif settings.selectedRow > #settings.controls then settings.selectedRow = #settings.controls end
    if settings.selectedRow ~= settings.prevSelected then
        settings.prevSelected = settings.selectedRow
        soundfx.play('ui_select')
    end
    settings.current = settings.controls[settings.selectedRow]
    settings.current.selected = true
end

function settings.stop()
    mapbackground.stop()
end

function settings.apply()
    screen.setResolution(config.width, config.height, settings.fullscreen.text == 'Enabled')
    config.audio.masterVolume = settings.masterVol.value / settings.masterVol.maxValue
    config.audio.fxVolume = settings.fxVol.value / settings.fxVol.maxValue
    config.audio.bgmVolume = settings.fxVol.value / settings.fxVol.maxValue
    savefile.write('settings.ini', config)
    gamestates.setNext(settings)
end

function settings.change(dir)
    if settings.current == settings.cancelButton and dir < 0 then settings.selectedRow = settings.selectedRow + dir
    elseif settings.current == settings.applyButton and dir > 0 then settings.selectedRow = settings.selectedRow + dir
    elseif settings.current == settings.fxVol or settings.current == settings.bgmVol or settings.current == settings.masterVol then 
        settings.current.value = settings.current.value + dir
    elseif settings.current == settings.fullscreen then
        settings.fullscreen.text = dir == -1 and 'Disabled' or 'Enabled'
    end
end