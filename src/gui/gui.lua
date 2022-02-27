gui = {
    heartSpacing = 36,
    mapNameWidth = config.gui.textboxWidth,
}
gui.list = managedlist.create()
gui.emptyHeart = 89
gui.halfHeart = 90
gui.fullHeart = 91
gui.manaCrystal = 99
gui.key = 81
gui.ring = 80
gui.coin = 79
gui.overlay = {
    alpha = 0,
    ease = nil,
    visible = false,
}

function gui.progressbar(value, max, xPos, yPos, width, height, color)
    local bar = components.element(xPos, yPos)
    bar.maxValue = max
    bar.lastMax = max
    bar.value = value
    bar.lastVal = value - 1
    bar.text  = tostring(bar.value) .. '/' .. tostring(bar.maxValue)
    bar.ratio = bar.value / bar.maxValue
    bar.w = width
    bar.barW = 0
    bar.h = height
    bar.c = color
    bar.shadowHeight = bar.h / 6
    bar.font = assets.fonts.normal
    bar.textHeight = (bar.h - bar.font:getHeight()) / 2
    bar.draw = function(self)
        love.graphics.push()
        love.graphics.translate(self.x, self.y)
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', 0, 0, self.w, self.h)
        love.graphics.setColor(unpack(self.c))
        love.graphics.rectangle('fill', 0, 0, self.barW, self.h)
        love.graphics.setColor(1, 1, 1, 0.5)
        love.graphics.rectangle('fill', 0, 0, self.barW, self.shadowHeight)
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', 0, self.h - self.shadowHeight, self.barW, self.shadowHeight)
        love.graphics.setColor(1, 1, 1)
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.rectangle('line', 0, 0, self.w, self.h)
        
        love.graphics.setFont(self.font)
        love.graphics.setColor(1, 1, 1)
        love.graphics.printf(self.text, 0, self.textHeight, self.w, 'center')
        love.graphics.pop()
        love.graphics.setLineWidth(1)
    end
    bar.update = function(self, dt)
        if self.value ~= self.lastValue or self.maxValue ~= self.lastMax then
            if self.value > self.maxValue then self.value = self.maxValue
            elseif self.value < 0 then self.value = 0 end
            self.lastValue = self.value
            self.ratio = self.value / self.maxValue
            self.text  = tostring(math.floor(self.value)) .. '/' .. tostring(math.floor(self.maxValue))
            ez.easeOut(self, {barW = self.w * self.ratio})
        end
    end
    return bar
end

function gui.buttongroup(definitions, xPos, yPos, width, verticalSpacing, font, easeProps)
    local easeTime = easeProps and easeProps.time or 1
    local easeDelay = easeProps and easeProps.delay or 0
    local buttonGroup = components.element(xPos, yPos)
    buttonGroup.buttons = {}
    buttonGroup.selectedIndex = 1
    buttonGroup.panel = components.panel(xPos, -500, width, #definitions * verticalSpacing + 20)
    ez.easeOut(buttonGroup.panel, {y = yPos}, {time = easeTime, delay = easeDelay})
    yPos = yPos + 20
    xPos = xPos + 20
    for i, def in ipairs(definitions) do
        for text, onActivate in pairs(def) do
            text = text:gsub('_', ' ')
            local button = components.button(text, xPos, -500, width - 40, onActivate, font)
            ez.easeOut(button, {y = yPos}, {time = easeTime, delay = easeDelay})
            table.insert(buttonGroup.buttons, button)
            local verticalInc = verticalSpacing > button.h and verticalSpacing or button.h
            yPos = yPos + verticalSpacing
        end
    end
    buttonGroup.update = function(self, dt)
        if input.isDownOnce('down') or input.isDownOnce('next') then
            self:setSelected(self.selectedIndex + 1)
        elseif input.isDownOnce('up') or input.isDownOnce('previous') then
            self:setSelected(self.selectedIndex - 1)
        end

        if input.isDownOnce('attack') or input.isDownOnce('interact') then
            self.buttons[self.selectedIndex].activate()
        end
    end
    buttonGroup.setSelected = function(self, index)
        if index < 1 then index = #self.buttons
        elseif index > #self.buttons then index = 1 end
        
        if index ~= self.selectedIndex then 
            soundfx.play('ui_select') 
            self.selectedIndex = index
        end
        for i, button in ipairs(self.buttons) do
            self.buttons[i].selected = false
        end
        self.buttons[index].selected = true
    end
    buttonGroup.destroy = function(self)
        for i, button in ipairs(self.buttons) do button:destroy() end
        self.panel:destroy()
        gui.list:remove(self)
    end
    buttonGroup:setSelected(buttonGroup.selectedIndex)
    return buttonGroup
end

function gui.dialogue(data)
    local dialogue = components.element((config.width - config.gui.dialogueWidth) / 2, config.height / 3)
    dialogue.w = config.gui.dialogueWidth
    dialogue.entries = data.entries
    dialogue.destroy = function(self)
        if self.textbox then self.textbox:destroy() end
        if self.buttons then self.buttons:destroy() end
        if self.header then self.header:destroy() end
        gui.list:remove(self)
    end
    dialogue.showEntry = function(self, name)
        if self.textbox then self.textbox:destroy() end
        if self.buttons then self.buttons:destroy() end
        if self.header then self.header:destroy() end
        
        local entry = self.entries[name]
        if not entry then game.popMenu() return end

        for i, option in ipairs(entry.options) do
            if dialogues.evaluateConditions(option.condition) then
                entry = option
                break
            end
        end

        dialogues.executeCommands(entry.commands)
        self.textbox = gui.textbox(entry.text, self.x, self.y, self.w)
        self.textbox.partOfDialogue = true

        local header = ' -' .. data.name .. '- '
        local offsetX = (assets.fonts.normal:getWidth(header) + 20) / 2
        local offsetY = assets.fonts.normal:getHeight() * self.textbox.lineAmount + 30
        local headerX = self.x + self.w / 2 - offsetX
        local headerY = self.y - offsetY
        self.header = gui.textbox(header, headerX, headerY, offsetX * 2)
        self.header.partOfDialogue = true

        local buttonDefs = {}
        for i, response in ipairs(entry.responses) do
            local def = {}
            local res = response.text:gsub(' ', '_')
            def[response.text] = function()
                dialogue:showEntry(response.dest)
            end
            table.insert(buttonDefs, def)
        end
        
        self.buttons = gui.buttongroup(buttonDefs, self.x, self.y + 10, self.w, 70, assets.fonts.normal, {time = 0, delay = 0})
    end
    dialogue:showEntry('greeting')
    return dialogue
end

function gui.textbox(text, xPos, yPos, w)
    local width, lines = assets.fonts.normal:getWrap(text, w - 20)
    local height = #lines * assets.fonts.normal:getHeight() + 20
    yPos = yPos - height
    local box = components.element(xPos, yPos)
    box.lineAmount = #lines
    box.text = text
    box.width = w
    box.height = height
    box.font = assets.fonts.normal
    box.panel = components.panel(xPos, yPos, w, box.height)
    box.char = 1
    box.partOfDialogue = false
    box.interactLetGo = false
    box.attackLetGo = false
    box.label = components.label(text:sub(1, 1), xPos + 10, yPos + 10, w - 20)

    box.update = function(self)
        if not input.isDown('interact') then self.interactLetGo = true end
        if not input.isDown('attack') then self.attackLetGo = true end

        if self.char < #self.text then
            box.label.text = self.text:sub(1, self.char)
            local amount = math.floor(love.math.random() + 0.4)
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
                    game.popMenu()
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

function gui.controlpanel(lines, x, y, w)
    local h = #lines * assets.fonts.normal:getHeight()
    local control = components.element(x, y)
    control.lines = lines
    control.inc = w / #lines[1]
    control.w = w
    control.h = h
    control.padding = 10
    control.lineHeight = assets.fonts.normal:getHeight()
    for i = 1, #lines do control['col' .. tostring(i)] = control.inc * (i - 1) end

    control.draw = function(self)
        love.graphics.setFont(assets.fonts.normal)
        love.graphics.push()
        love.graphics.translate(self.x, self.y)

        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', -self.padding, -self.padding, self.w + self.padding * 2, self.h + self.padding * 2)
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle('line', -self.padding, -self.padding, self.w + self.padding * 2, self.h + self.padding * 2)
        love.graphics.setLineWidth(1)
        for row, line in ipairs(self.lines) do
            for col, cell in ipairs(line) do
                local x = control['col' .. col]
                local y = (row - 1) * self.lineHeight
                love.graphics.print(cell, x, y)
            end
        end
        love.graphics.pop()
    end

    return control
end

function gui.saveslot(x, y, w, h, summary)
    local slot = components.element(x, 2000)
    slot.w = w
    slot.h = h
    slot.thumb = summary.thumb
    slot.thumbS = (w / config.width) * 0.9
    slot.thumbX = w * 0.05
    slot.thumbY = 72
    slot.thumbW = w * 0.9
    slot.thumbH = (slot.thumbW / 16) * 9
    slot.time = summary.time
    slot.title = summary.mapName
    slot.selected = false
    slot.draw = function(self)
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.setColor(0, 0, 0, 0.6)
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        if not self.selected then love.graphics.setColor(0.5, 0.5, 0.5)
        else love.graphics.setColor(1, 1, 1) end
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)

        love.graphics.setFont(assets.fonts.button)
        love.graphics.printf(self.title, self.x, self.y + 10, self.w, 'center')
        
        if self.thumb then
            love.graphics.draw(self.thumb, self.thumbX + self.x, self.thumbY + self.y, 0, self.thumbS, self.thumbS)
        end
        love.graphics.setFont(assets.fonts.normal)
        love.graphics.printf('Time: ' .. slot.time, self.x, self.y + self.thumbY + self.thumbH + 16, self.w, 'center')
        love.graphics.rectangle('line', self.thumbX + self.x, self.thumbY + self.y, self.thumbW, self.thumbH)
        love.graphics.setColor(1, 1, 1)
    end
    ez.easeOut(slot, {y = y}, {delay = x / 5000}):complete(function()
        if slot.selected then ez.easeInOut(slot, {y = y - 50}, {time = 0.5}) end
    end)
    return slot
end

function gui.draw()
    if gui.overlay.visible then
        love.graphics.setColor(0, 0, 0, gui.overlay.alpha)
        love.graphics.rectangle('fill', 0, 0, config.width, config.height)
        love.graphics.setColor(1, 1, 1)
    end
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

function gui.showOverlay(fadeTime)
    fadeTime = fadeTime or 1
    if gui.overlay.ease then 
        gui.overlay.ease:remove() 
        gui.overlay.ease = nil
    end
    gui.overlay.visible = true
    gui.overlay.ease = ez.easeInOut(gui.overlay, {alpha = 0.8}, {time = fadeTime})
end

function gui.hideOverlay()
    if gui.overlay.ease then 
        gui.overlay.ease:remove() 
        gui.overlay.ease = nil
    end
    gui.overlay.ease = ez.easeInOut(gui.overlay, {alpha = 0}, {complete = function() 
        gui.overlay.visible = false
        if gui.overlay.ease then gui.overlay.ease:remove() end
        gui.overlay.ease = nil
    end})
end

function gui.clear()
    gui.hideOverlay()
    if game.menu and game.menu.destroy then game.menu:destroy() end
    gui.list = managedlist.create()
end

function gui.questpanel()
    local pages = {}
    local activePage = 1
    for name, quest in pairs(quests.known()) do
        table.insert(pages, {['name'] = name, ['quest'] = quest})
        if name == quests.active then activePage = #pages end
    end
    local x = 200
    local y = 150
    local w = config.width - x * 2
    local h = config.height - y * 2
    local explanation = 'LEFT and RIGHT to navigate, ATTACK or INTERACT to set active, BLOCK to go back.'
    local qpanel = components.element(x, y)
    qpanel.w = w
    qpanel.h = h
    qpanel.pages = pages
    qpanel.panel = components.panel(x, y, w, h)
    qpanel.currentPage = 1
    qpanel.pageHeader = components.label(qpanel.currentPage .. '/' .. #pages, 0, y + 4, config.width, 'center')
    qpanel.questHeader = components.label('No Quests Available', x + 32, y + 48, config.width, 'left')
    qpanel.questHeader.font = assets.fonts.button
    qpanel.statusHeader = components.label('status: --', config.width - x * 3 - 32, y + 64, x * 2, 'right')
    qpanel.explanation = components.label('Get some quests from people to fill your quest log!', x + 32, y + 112, qpanel.w - 64, 'left')
    qpanel.controls = components.label(explanation, 0, config.height - y - 32, config.width, 'center')
    qpanel.controls.font = assets.fonts.quest
    
    qpanel.loadPage = function(self, num)
        local page = self.pages[num]
        if not page then 
            soundfx.play('ui_error')
            return 
        end
        soundfx.play('ui_select')
        self.currentPage = num
        self.pageHeader.text = self.currentPage .. '/' .. #self.pages
        self.questHeader.text = page.quest.title
        
        local statusText = 'status: '
        if page.name == quests.active then statusText = statusText .. 'ACTIVE'
        elseif page.quest.state == 'end' then statusText = statusText .. 'COMPLETED'
        else statusText = statusText .. 'WAITING' end
        self.statusHeader.text = statusText
        self.explanation.text = page.quest[page.quest.state].text
    end

    qpanel.update = function(self)
        if input.isDownOnce('left') or input.isDownOnce('previous') then
            self:loadPage(self.currentPage - 1)
        elseif input.isDownOnce('right') or input.isDownOnce('next') then
            self:loadPage(self.currentPage + 1)
        elseif input.isDownOnce('interact') or input.isDownOnce('attack') then
            local page = self.pages[self.currentPage]
            local questState = page.quest.state
            if questState == 'end' then
                soundfx.play('ui_error')
            else
                soundfx.play('ui_action')
                quests.setState(page.name, questState)
            end
        end
    end

    qpanel.destroy = function(self)
        self.panel:destroy()
        self.pageHeader:destroy()
        self.questHeader:destroy()
        self.statusHeader:destroy()
        self.explanation:destroy()
        self.controls:destroy()
        gui.list:remove(self)
    end
    qpanel:loadPage(activePage)
    return qpanel
end

function gui.createHeroWidget(x, y)
    local resetX = x
    local padding = 10
    local iconSpacing = 80
    local widget = components.element(x, y)
    
    x = resetX + 32 + padding
    widget.keyIcon = components.icon(gui.key, x + 32, y + 16)
    widget.keyLabel = components.label(hero.keys, x + 48 + padding, y + 4)
    x = x + iconSpacing
    widget.ringIcon = components.icon(gui.ring, x + 32, y + 16)
    widget.ringLabel = components.label(hero.rings, x + 48 + padding, y + 4)
    x = x + iconSpacing
    widget.coinIcon = components.icon(gui.coin, x + 32, y + 16)
    widget.coinLabel = components.label(hero.coins, x + 48 + padding, y + 4)

    if #spells.known > 1 then
        y = y + 32
        x = resetX + padding
        widget.manaIcon = components.icon(gui.manaCrystal, x + 16, y + padding + 16)
        x = x + padding + 32
        widget.manaBar = gui.progressbar(hero.mana, hero.maxMana, x, y + padding, 256, 32, {0.4, 0.48, 0.9})
    else x = x + padding + 32 end
    
    x = resetX + padding
    y = y + 32 + padding
    widget.healthIcon = components.icon(gui.fullHeart, x + 16, y + padding + 16)
    x = x + padding + 32
    widget.healthBar = gui.progressbar(hero.entity.health, hero.entity.maxHealth, x, y + padding, 256, 32, {0.9, 0, 0})
    widget.update = function(self)
        self.healthBar.value = hero.entity.health
        self.healthBar.maxValue = hero.entity.maxHealth
        if not self.manaBar then return end
        self.manaBar.value = hero.entity.mana
        self.manaBar.maxValue = hero.entity.maxMana
        self.manaIcon.tile = spells.selectedIcon
    end

    widget.destroy = function(self)
        self.healthBar:destroy()
        self.healthIcon:destroy()
        self.keyIcon:destroy()
        self.keyLabel:destroy()
        self.coinIcon:destroy()
        self.coinLabel:destroy()
        self.ringIcon:destroy()
        self.rinLabel:destroy()
        if self.manaBar then self.manaBar:destroy() end
        if self.manaIcon then self.manaIcon:destroy() end
        gui.list:remove(self)
    end
    gui.heroWidget = widget
    return widget
end

function gui.showHeader(name, duration)
    duration = duration or config.gui.headerVisible
    name = name or 'Unnamed'
    local headerWidth = assets.fonts.header:getWidth(name)
    local xPos = (config.width - (headerWidth + 40)) / 2

    local header = components.element(0, -1000)
    header.panel = components.panel(xPos, 0, headerWidth + 40, 100)
    header.label = components.label(name, xPos + 20, 16, headerWidth, 'center')
    header.label.font = assets.fonts.header
    header.destroy = function(self)
        self.panel:destroy()
        self.label:destroy()
        gui.list:remove(self)
        if gui.header == self then gui.header = nil end
    end
    header.update = function(self, dt)
        self.panel.y = self.y
        self.label.y = self.panel.y + 16
    end
    
    if gui.header then gui.header:destroy() end
    gui.header = header
    header.ease = ez.easeOut(header, {y = -4}):complete(function() 
        header.ease = ez.easeIn(header, {y = -1000}, {delay = duration}):complete(function() 
            header:destroy()
        end)
    end)
end

function gui.createQuestWidget(x, y)
    local widget = components.element(x, y)
    widget.homeX = x
    widget.header = components.label('', -400, y, config.width, 'left')
    widget.label = components.label('', -400, y + assets.fonts.normal:getHeight(), config.width / 4, 'left')
    widget.label.font = assets.fonts.quest

    widget.setState = function(self, state, questName)
        self:hide(state, questName)
    end

    widget.show = function(self, delay)
        ez.easeOut(self.header, {x = self.x})
        ez.easeOut(self.label, {x = self.x})
        self.visible = true
        self.label.visible = true
        self.header.visible = true
    end

    widget.hide = function(self, nextName, nextState)
        if self.nextName == nextName and self.nextState == nextState then return end
        self.hidden = true
        ez.easeIn(self.header, {x = -400})
        ez.easeIn(self.label, {x = -400}):complete(function()
            self.nextState = nextState
            self.nextName = nextName 
            if nextState then self.header.text = trimstring(nextName) end
            if nextState then self.label.text = '- ' .. trimstring(nextState) end
            self.header.visible = false
            self.label.visible = false
            self.visible = false
            if nextName and nextState then self:show() end
        end)
    end

    widget.destroy = function(self)
        widget.header:destroy()
        widget.label:destroy()
        gui.list:remove(self)
    end
    gui.questWidget = widget
    local quest = quests.get(quests.active)
    if quest then
        widget:setState(quest.title, quest[quest.state].summary)
    else
        widget:hide()
    end
    return widget
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

function gui.showImage(img)
    if not img then return end
    game.paused = true
    game.menu = components.image(img, tilemap.scale)
end

function gui.showQuestStatus(status)
    if not status then return end
    gui.questLabel = components.label(status, -300, 10, 100, 'left')
    gui.questLabel.font = assets.fonts.quest
    ez.easeOut(gui.questLabel, {x = 10})
end