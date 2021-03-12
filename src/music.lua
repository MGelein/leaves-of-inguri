music = {}
music.currentSource = nil

function music.play(name)
    music.stop()
    if name then
        music.currentSource = love.audio.newSource('assets/audio/music/' .. name .. '.ogg', 'stream')
        music.setVolume(config.audio.masterVolume * config.audio.bgmVolume)
        music.currentSource:play()
    end
end

function music.setVolume(vol)
    if music.currentSource then
        music.currentSource:setVolume(vol)
    end
end

function music.stop()
    if music.currentSource then 
        music.currentSource:stop() 
        music.currentSource = nil
    end
end