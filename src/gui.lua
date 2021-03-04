gui = {}
gui.list = managedlist.create()

function gui.element(xPos, yPos, rPos)
    if rPos == nil then rPos = 0 end
    local el = {
        x = xPos,
        y = yPos,
        r = rPos,

        draw = function(self) end,
        update = function(self, dt) end,
    }
    gui.list:add(el)
    return el
end

function gui.label(font, string, xPos, yPos, limit, align, rPos, sx, sy)
    local label = gui.element(xPos, yPos, rPos)
    label.text = string
    label.limit = limit
    label.align = align
    label.font = font
    label.draw = function(self)
        love.graphics.setFont(self.font)
        love.graphics.printf(self.text, self.x, self.y, self.limit, self.align, self.r, self.sx, self.sy)
    end
end

function gui.draw()
    for i, el in ipairs(gui.list.all) do
        el:draw()
    end
end

function gui.update(dt)
    gui.list:update()
    for i, el in ipairs(gui.list.all) do
        el:update()
    end
end

function gui.clear()
    gui.list = managedlist.create()
end