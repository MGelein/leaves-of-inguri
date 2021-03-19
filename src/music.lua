music = {}
music.currentSource = nil
music.currentName = nil

function music.play(name)
    if name == music.currentName then return end
    music.stop()
    if name then
        music.currentName = name
        music.currentSource = love.audio.newSource('assets/audio/music/' .. name .. '.ogg', 'stream')
        music.setVolume(config.audio.masterVolume * config.audio.bgmVolume)
        music.currentSource:setLooping(true)
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
        music.currentName = ''
    end
end