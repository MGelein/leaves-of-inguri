gui = {
    heartSpacing = 36
}
gui.list = managedlist.create()
gui.emptyHeart = 89
gui.halfHeart = 90
gui.fullHeart = 91

function gui.element(xPos, yPos, rPos, scaleX, scaleY)
    if rPos == nil then rPos = 0 end
    local el = {
        x = xPos,
        y = yPos,
        r = rPos,
        sx = 1,
        sy = 1,

        animAngle = 0,
        draw = function(self) end,
        update = function(self, dt) end,
    }
    gui.list:add(el)
    return el
end

function gui.panel(xPos, yPos, w, h, rPos, sx, sy)
    local panel = gui.element(xPos, yPos, rPos, sx, sy)
    panel.w = w
    panel.h = h
    panel.backgroundColor = {0, 0, 0, 0.5}
    panel.lineColor = {1, 1, 1, 1}
    panel.draw = function(self)
        love.graphics.setColor(unpack(panel.backgroundColor))
        love.graphics.rectangle('fill', panel.x, panel.y, panel.w, panel.h)
        love.graphics.setColor(unpack(panel.lineColor))
        love.graphics.setLineWidth(4)
        love.graphics.rectangle('line', panel.x, panel.y, panel.w, panel.h)
        love.graphics.setColor(1, 1, 1, 1)
    end
    return panel
end

function gui.label(string, xPos, yPos, limit, align, rPos, sx, sy)
    local label = gui.element(xPos, yPos, rPos, sx, sy)
    limit = limit or 10000
    align = align or 'left'
    label.text = string
    label.limit = limit
    label.align = align
    label.font = assets.fonts.normal
    label.color = {1, 1, 1}
    label.draw = function(self)
        love.graphics.setFont(self.font)
        love.graphics.setColor(0, 0, 0)
        love.graphics.printf(self.text, self.x + 1, self.y + 1, self.limit + 1, self.align, self.r, self.sx, self.sy)
        love.graphics.setColor(unpack(label.color))
        love.graphics.printf(self.text, self.x, self.y, self.limit, self.align, self.r, self.sx, self.sy)
    end
    return label
end

function gui.hearts(xPos, yPos, entity)
    local hearts = gui.element(xPos, yPos)
    hearts.entity = entity
    hearts.lastHealth = 0
    hearts.lastMax = 0
    hearts.invalidated = true
    hearts.fullHearts = 0
    hearts.emptyHearts = 0
    hearts.halfHearts = 0
    hearts.draw = function(self)
        love.graphics.push()
        love.graphics.translate(self.x, self.y)
        local counter = self.fullHearts
        while counter > 0 do
            assets.entities.drawSprite(gui.fullHeart, 0, 0, 0, 4, 4)
            love.graphics.translate(gui.heartSpacing, 0)
            counter = counter - 1
        end
        if self.halfHearts > 0 then
            assets.entities.drawSprite(gui.halfHeart, 0, 0, 0, 4, 4)
            love.graphics.translate(gui.heartSpacing, 0)
        end
        counter = self.emptyHearts
        while counter > 0 do
            assets.entities.drawSprite(gui.emptyHeart, 0, 0, 0, 4, 4)
            love.graphics.translate(gui.heartSpacing, 0)
            counter = counter - 1
        end
        love.graphics.pop()
    end
    hearts.update = gui.updateHearts
end

function gui.icon(tile, xPos, yPos, rPos, sx, sy)
    local icon = gui.element(xPos, yPos, rPos, sx, sy)
    icon.tile = tile
    icon.ox = 4
    icon.oy = 4
    icon.calcSx = icon.sx
    icon.calcSy = icon.sy
    icon.breathing = false
    icon.draw = function(self)
        assets.entities.drawSprite(self.tile, self.x, self.y, self.r, self.calcSx * 4, self.calcSy * 4, self.ox, self.oy)
    end
    icon.update = function(self)
        if not breathing then return end
        self.animAngle = self.animAngle + 0.1
        if self.animAngle >= math.pi * 2 then self.animAngle = self.animAngle - math.pi * 2 end

        self.calcSx = self.sx + math.sin(self.animAngle) * 0.1
        self.calcSy = self.sy + math.sin(self.animAngle) * 0.1
    end
    return icon
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

function gui.updateHearts(self)
    if self.lastMax ~= self.entity.maxHealth then
        self.invalidated = true
        self.lastMax = self.entity.maxHealth
    end
    if self.lastHealth ~= self.entity.health then 
        self.invalidated = true
        self.lastHealth = self.entity.health
    end

    if self.invalidated then
        self.invalidated = false
        self.fullHearts = math.floor(self.lastHealth / 2)
        self.halfHearts = 0
        if self.lastHealth - self.fullHearts * 2 > 0 then
            self.halfHearts = 1
        end
        self.emptyHearts = (self.lastMax / 2) - (self.halfHearts + self.fullHearts)
    end
end

function gui.createHealthWidget(x, y, entity)
    local healthWidget = {
        panel = gui.panel(x - 20, y - 10, 310, 60),
        label = gui.label("Health: ", x, y),
        hearts = gui.hearts(x + 100, y, entity),
    }
    return healthWidget
end