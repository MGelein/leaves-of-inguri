soundfx = {}
soundfx.lib = {}
soundfx.root = 'assets/audio/fx/'

function soundfx.play(name)
    local source = soundfx.lib[name]
    if not source then 
        source = love.audio.newSource(soundfx.root .. name .. '.wav', 'static') 
        soundfx.lib[name] = source
    else
        source:stop()
    end
    source:setVolume(config.audio.fxVolume * config.audio.masterVolume)
    source:play()
end