fps = {
    average = 60,
    draw = function()
        if not config.debug then return end
        love.graphics.setFont(assets.fonts.debug)
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', 0, 0, 100, 100)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print(love.timer.getFPS() .. " FPS", 4, 2)
        love.graphics.print(math.floor(collectgarbage('count')) .. " kB", 4, 22)
        love.graphics.print(tostring(#entities.list.all) .. " entities", 4, 42)
        love.graphics.print(tostring(#ez.list) .. ' easings', 4, 62)
        love.graphics.print(tostring(monsters.count) .. ' monsters', 4, 82)
    end,
}