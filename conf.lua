config = {
    window = {
        title = 'RPG Project',
        width = 1280,
        height = 720,
        fullscreen = false,
    },
    debug = false,
    width = 1280,
    height = 720,

    interactDist = 48,

    combat = {
        invulnerableFrames = 20
    },

    gui = {
        headerVisible = 2,
        moveTimeout = 0.2,
        activateTimeout = 1,
        textboxWidth = 600,
        dialogueWidth = 800,
    },

    audio = {
        masterVolume = 0.5,
        fxVolume = 0.5,
    }
}

function love.conf(t)
    t.window.width = config.window.width
    t.window.height = config.window.height
    t.window.title = config.window.title
    t.window.icon = 'assets/graphics/icon.png'

    love.filesystem.setRequirePath("?.lua;?/init.lua;src/?.lua")
end