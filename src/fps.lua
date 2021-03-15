fps = {
    average = 60,
    draw = function()
        if not config.debug then return end
        love.graphics.setFont(assets.fonts.debug)
        love.graphics.setColor(0, 0, 0, 0.4)
        love.graphics.rectangle('fill', 0, 0, 100, 60)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(math.floor(fps.average + .5) .. " FPS", 4, 2)
        love.graphics.print(math.floor(collectgarbage('count')) .. " kB", 4, 22)
        love.graphics.print(tostring(#entities.list.all) .. " entities", 4, 42)
    end,

    update = function(dt)
        fps.average = fps.average + ((1 / dt) - fps.average) * .1
    end
}