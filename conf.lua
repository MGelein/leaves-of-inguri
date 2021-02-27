config = {
    window = {
        title = 'RPG Project',
        width = 1280,
        height = 720
    },
    showFPS = true
}

function love.conf(t)
    t.window.width = config.window.width
    t.window.height = config.window.height
    t.window.title = config.window.title

    love.filesystem.setRequirePath("?.lua;?/init.lua;src/?.lua")
end