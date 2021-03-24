soundfx = {}
soundfx.lib = {}
soundfx.root = 'assets/audio/fx/'

function soundfx.play(name)
    local source = soundfx.lib[name]
    if not source then 
        local url = soundfx.root .. name .. '.wav'
        if not love.filesystem.getInfo(url) then 
            if config.debug then print("Could not find file: " .. url) end
            return false
        end
        source = love.audio.newSource(url, 'static') 
        soundfx.lib[name] = source
    else
        source:stop()
    end
    source:setVolume(config.audio.fxVolume * config.audio.masterVolume)
    source:play()
    return true
end