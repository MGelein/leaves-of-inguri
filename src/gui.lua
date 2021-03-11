gui = {
    heartSpacing = 36,
    mapNameWidth = config.gui.textboxWidth,
}
gui.list = managedlist.create()
gui.emptyHeart = 89
gui.halfHeart = 90
gui.fullHeart = 91
gui.manaCrystal = 99

function gui.element(xPos, yPos, rPos, scaleX, scaleY)
    if rPos == nil then rPos = 0 end
    local el = {
        x = xPos,
        y = yPos,
        r = rPos,
        sx = 1,
        sy = 1,
        visible = true,
        wasVisible = true,

        animAngle = 0,
        draw = function(self) end,
        update = function(self, dt) end,
        destroy = function(self)
            gui.list:remove(self)
        end
    }
    gui.list:add(el)
    return el
end

function gui.panel(xPos, yPos, w, h, rPos, sx, sy)
    local panel = gui.element(xPos, yPos, rPos, sx, sy)
    panel.w = w
    panel.h = h
    panel.backgroundColor = {0, 0, 0, 0.8}
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

function gui.progressbar(value, max, xPos, yPos, width, height, color, rPos, sx, sy)
    local bar = gui.element(xPos, yPos, rPos, sx, sy)
    bar.maxValue = max
    bar.lastMax = max
    bar.value = value
    bar.lastVal = value
    bar.text  = tostring(bar.value) .. '/' .. tostring(bar.maxValue)
    bar.ratio = bar.value / bar.maxValue
    bar.w = width
    bar.adjustedW = bar.w * bar.ratio
    bar.diffW = 0
    bar.actualW = bar.adjustedW
    bar.h = height
    bar.c = color
    bar.rgb = {r = color[1], g = color[2], b = color[3]}
    bar.shadowHeight = bar.h / 6
    bar.font = assets.fonts.normal
    bar.textHeight = (bar.h - bar.font:getHeight()) / 2
    bar.draw = function(self)
        love.graphics.push()
        
        love.graphics.translate(self.x, self.y)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', 0, 0, self.w, self.h)
        love.graphics.setColor(unpack(self.c))
        love.graphics.rectangle('fill', 0, 0, self.actualW, self.h)
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle('fill', 0, 0, self.actualW, self.shadowHeight)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', 0, self.h - self.shadowHeight, self.actualW, self.shadowHeight)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.rectangle('line', 0, 0, self.w, self.h)
        
        love.graphics.setFont(self.font)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(self.text, 0, self.textHeight, self.w, 'center')
        love.graphics.pop()
    end
    bar.update = function(self, dt)
        if self.value ~= self.lastValue or self.maxValue ~= self.lastMax then
            self.lastValue = self.value
            self.ratio = self.value / self.maxValue
            self.adjustedW = self.w * self.ratio
            self.text  = tostring(self.value) .. '/' .. tostring(self.maxValue)
            self.diffW = self.adjustedW - self.actualW
        end
        if self.diffW ~= 0 then
            self.actualW = self.actualW + (self.diffW * dt * 2)
            if self.actualW >= self.adjustedW and self.diffW > 0 then 
                self.diffW = 0
                self.actualW = self.adjustedW
            elseif self.actualW <= self.adjustedW and self.diffW < 0 then
                self.diffW = 0
                self.actualW = self.adjustedW
            end
        end
    end
    return bar
end

function gui.buttongroup(definitions, xPos, yPos, width, verticalSpacing, font)
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
            text = text:gsub('_', ' ')
            local button = gui.button(text, xPos, yPos, width - 40, onActivate, font)
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
                self:setSelected(self.selectedIndex + 1)
            elseif input.isDown('up') or input.isDown('previous') then
                self:setSelected(self.selectedIndex - 1)
            end
        end
        if self.activateTimeout <= 0 then
            if input.isDownOnce('attack') or input.isDownOnce('interact') then
                self.buttons[self.selectedIndex].activate()
                soundfx.play('positive')
                self.activateTimeout = config.gui.activateTimeout
            end
        end
    end
    buttonGroup.setSelected = function(self, index)
        if index < 1 then index = #self.buttons
        elseif index > #self.buttons then index = 1 end
        
        if index ~= self.selectedIndex then 
            soundfx.play('select') 
            self.selectedIndex = index
        end
        for i, button in ipairs(self.buttons) do
            self.buttons[i].selected = false
        end
        self.buttons[index].selected = true
        self.moveTimeout = config.gui.moveTimeout
        self.activateTimeout = 0
    end
    buttonGroup.destroy = function(self)
        for i, button in ipairs(self.buttons) do button:destroy() end
        self.panel:destroy()
        gui.list:remove(self)
    end
    buttonGroup:setSelected(buttonGroup.selectedIndex)
    return buttonGroup
end

function gui.button(text, xPos, yPos, width, onActivate, font)
    local button = gui.element(xPos, yPos)
    button.text = text
    button.w = width
    button.h = 48
    button.selected = false
    button.panel = gui.panel(xPos, yPos, width, button.h)
    button.label = gui.label(text, xPos, yPos, width, 'center')
    button.label.font = font or assets.fonts.button
    button.update = function(self, dt)
        button.panel.visible = self.visible and button.selected
        button.label.visible = self.visible
        button.panel.x = self.x
        button.panel.y = self.y
        button.label.x = self.x
        button.label.y = self.y
    end
    button.destroy = function(self)
        self.panel:destroy()
        self.label:destroy()
        gui.list:remove(self)
    end
    button.activate = onActivate
    return button
end

function gui.dialogue(data)
    local dialogue = gui.element((config.width - config.gui.dialogueWidth) / 2, config.height / 4)
    dialogue.w = config.gui.dialogueWidth
    dialogue.entries = data.entries
    dialogue.destroy = function(self)
        if self.textbox then self.textbox:destroy() end
        if self.buttons then self.buttons:destroy() end
        gui.list:remove(self)
    end
    dialogue.showEntry = function(self, name)
        if self.textbox then self.textbox:destroy() end
        if self.buttons then self.buttons:destroy() end
        
        local entry = self.entries[name]
        if not entry then 
            game.hideMenu()
            return
        end
        for i, option in ipairs(entry.options) do
            if dialogues.evaluateCondition(option.condition) then
                entry = option
                break
            end
        end

        for i, command in ipairs(entry.commands) do dialogues.executeCommand(command) end
        self.textbox = gui.textbox(entry.text, self.x, self.y, self.w)
        self.textbox.partOfDialogue = true
        local buttonDefs = {}
        for i, response in ipairs(entry.responses) do
            local def = {}
            local res = response.text:gsub(' ', '_')
            def[response.text] = function()
                dialogue:showEntry(response.dest)
            end
            table.insert(buttonDefs, def)
        end
        
        self.buttons = gui.buttongroup(buttonDefs, self.x, self.y + 10, self.w, 70, assets.fonts.normal)
    end
    dialogue:showEntry('greeting')
    return dialogue
end

function gui.textbox(text, xPos, yPos, w)
    local width, lines = assets.fonts.normal:getWrap(text, w - 20)
    local height = #lines * assets.fonts.normal:getHeight() + 20
    yPos = yPos - height
    local box = gui.element(xPos, yPos)
    box.text = text
    box.width = w
    box.height = height
    box.font = assets.fonts.normal
    box.numLines = #lines
    box.panel = gui.panel(xPos, yPos, w, box.height)
    box.char = 1
    box.partOfDialogue = false
    box.interactLetGo = false
    box.attackLetGo = false
    box.label = gui.label(text:sub(1, 1), xPos + 10, yPos + 10, w - 20)

    box.update = function(self)
        if not input.isDown('interact') then self.interactLetGo = true end
        if not input.isDown('attack') then self.attackLetGo = true end

        if self.char < #self.text then
            box.label.text = self.text:sub(1, self.char)
            local amount = math.floor(love.math.random() + 0.3)
            if input.isDown('attack') or (input.isDown('interact') and self.interactLetGo) then amount = 4 end
            self.char = self.char + amount

            if self.char >= #self.text then 
                box.label.text = self.text 
                self.interactLetGo = false
                self.attackLetGo = false
            end
        else
            if not self.partOfDialogue then
                if (input.isDownOnce('interact') and self.interactLetGo) or (input.isDownOnce('attack') and self.attackLetGo) then
                    game.hideMenu()
                end
            end
        end
    end

    box.destroy = function(self)
        box.panel:destroy()
        box.label:destroy()
        gui.list:remove(self)
    end
    return box
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

function gui.createHealthWidget(x, y)
    local resetX = x
    local padding = 10
    local widget = gui.element(x, y)
    x = x + padding
    widget.healthIcon = gui.icon(gui.fullHeart, x + 16, y + padding + 16)
    x = x + padding + 32
    widget.healthBar = gui.progressbar(hero.entity.health, hero.entity.maxHealth, x, y + padding, 256, 32, {0.9, 0, 0})
    
    x = resetX + padding
    y = y + 32 + padding
    widget.manaIcon = gui.icon(gui.manaCrystal, x + 16, y + padding + 16)
    x = x + padding + 32
    widget.manaBar = gui.progressbar(hero.mana, hero.maxMana, x, y + padding, 256, 32, {0.4, 0.48, 0.9})
    
    widget.update = function(self)
        self.healthBar.value = hero.entity.health
        self.healthBar.maxValue = hero.entity.maxHealth
        self.manaBar.value = hero.entity.mana
        self.manaBar.maxValue = hero.entity.maxMana
    end

    widget.destroy = function(self)
        self.healthBar:destroy()
        self.healthIcon:destroy()
        self.manaBar:destroy()
        self.manaIcon:destroy()
        gui.list:remove(self)
    end
    return widget
end

function gui.showHeader(name, duration)
    duration = duration or config.gui.headerVisible
    local headerWidth = assets.fonts.header:getWidth(name)
    local xPos = (config.width - (headerWidth + 40)) / 2
    name = name or 'Unnamed'

    local header = gui.element(0, -1000)
    header.targetY = -4
    header.waitTime = duration
    header.panel = gui.panel(xPos, 0, headerWidth + 40, 100)
    header.label = gui.label(name, xPos + 20, 16, headerWidth, 'center')
    header.label.font = assets.fonts.header
    header.destroy = function(self)
        self.panel:destroy()
        self.label:destroy()
        gui.list:remove(self)
    end
    header.update = function(self, dt)
        if self.waitTime < 0 then 
            self.targetY = self.y
            self.y = self.y - math.abs(self.y) / 10

            if self.y < -1000 then
                self:destroy()
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
    if gui.header then gui.header:destroy() end
    gui.header = header
end

function gui.showText(text)
    text = text or '...'
    game.paused = true
    game.menu = gui.textbox(text, (config.width - config.gui.textboxWidth) / 2, config.height - 10, config.gui.textboxWidth)
end

function gui.showDialogue(data)
    if not data then return end
    game.paused = true
    game.menu = gui.dialogue(data)
end