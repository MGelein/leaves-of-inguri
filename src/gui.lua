gui = {
    heartSpacing = 36,
    mapNameWidth = 600,
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
        visible = true,

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
    panel.lineWidth = 4
    panel.draw = function(self)
        love.graphics.setColor(unpack(self.backgroundColor))
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        love.graphics.setColor(unpack(self.lineColor))
        love.graphics.setLineWidth(self.lineWidth)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
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

function gui.buttongroup(definitions, xPos, yPos, width, verticalSpacing)
    local buttonGroup = gui.element(xPos, yPos)
    buttonGroup.numButtons = #definitions
    buttonGroup.buttons = {}
    buttonGroup.selectedIndex = 1
    buttonGroup.moveTimeout = config.gui.moveTimeout
    buttonGroup.activateTimeout = config.gui.activateTimeout
    buttonGroup.panel = gui.panel(xPos, yPos, width, buttonGroup.numButtons * verticalSpacing + 20)
    yPos = yPos + 20
    xPos = xPos + 20
    for i, def in ipairs(definitions) do
        for text, onActivate in pairs(def) do
            local button = gui.button(text, xPos, yPos, width - 40, onActivate)
            table.insert(buttonGroup.buttons, button)
            yPos = yPos + verticalSpacing
        end
    end
    buttonGroup.update = function(self, dt)
        if not self.visible then return end
        if self.moveTimeout > 0 then self.moveTimeout = self.moveTimeout - dt end
        if self.activateTimeout > 0 then self.activateTimeout = self.activateTimeout - dt end

        if self.moveTimeout <= 0 then
            if input.isDown('down') or input.isDown('next') then
                self.selectedIndex = self.selectedIndex + 1
                if self.selectedIndex > #self.buttons then self.selectedIndex = 1 end
                self:setSelected(self.selectedIndex)
            elseif input.isDown('up') or input.isDown('previous') then
                self.selectedIndex = self.selectedIndex - 1
                if self.selectedIndex < 1 then self.selectedIndex = #self.buttons end
                self:setSelected(self.selectedIndex)
            end
        end
        if self.activateTimeout <= 0 then
            if input.isDown('attack') or input.isDown('interact') then
                self.buttons[self.selectedIndex].activate()
                self.activateTimeout = config.gui.activateTimeout
            end
        end
    end
    buttonGroup.setSelected = function(self, index)
        for i, button in ipairs(self.buttons) do
            self.buttons[i].selected = false
        end
        self.buttons[index].selected = true
        self.moveTimeout = config.gui.moveTimeout
        self.activateTimeout = 0
    end
    buttonGroup:setSelected(buttonGroup.selectedIndex)
end

function gui.button(text, xPos, yPos, width, onActivate)
    local button = gui.element(xPos, yPos)
    button.text = text
    button.w = width
    button.h = 48
    button.selected = false
    button.panel = gui.panel(xPos, yPos, width, button.h)
    button.label = gui.label(text, xPos, yPos, width, 'center')
    button.label.font = assets.fonts.button
    button.draw = function(self)
        button.panel.visible = self.visible and button.selected
        button.label.visible = self.visible
        button.panel.x = self.x
        button.panel.y = self.y
        button.label.x = self.x
        button.label.y = self.y
    end
    button.activate = onActivate
    return button
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
        if el.visible then el:draw() end
    end
end

function gui.update(dt)
    gui.list:update()
    for i, el in ipairs(gui.list.all) do
        el:update(dt)
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

function gui.showMapname(name)
    local xPos = (config.width - gui.mapNameWidth) / 2
    name = name or 'Unnamed'

    local mapHolder = gui.element(0, -1000)
    mapHolder.targetY = -4
    mapHolder.waitTime = config.gui.mapNameVisible
    mapHolder.panel = gui.panel(xPos, 0, gui.mapNameWidth, 100)
    mapHolder.label = gui.label(name, xPos, 16, gui.mapNameWidth, 'center')
    mapHolder.label.font = assets.fonts.mapName
    mapHolder.update = function(self, dt)
        if self.waitTime < 0 then 
            self.targetY = self.y
            self.y = self.y - math.abs(self.y) / 10

            if self.y < -1000 then
                gui.list:remove(mapHolder)
                gui.list:remove(mapHolder.panel)
                gui.list:remove(mapHolder.label)
            end
        end

        local diffY = self.targetY - self.y
        self.y = diffY * .1 + self.y

        if diffY < 0.01 and diffY > 0 then 
            self.waitTime = self.waitTime - dt
        end

        self.panel.y = self.y
        self.label.y = self.panel.y + 16
    end
end