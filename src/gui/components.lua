components = {}

function components.element(xPos, yPos, rPos, scaleX, scaleY)
    local el = {
        x = xPos or 0,
        y = yPos or 0,
        r = rPos or 0,
        sx = scaleX or 1,
        sy = scaleY or scaleX or 1,
        visible = true,
        wasVisible = true,

        draw = function(self) end,
        update = function(self, dt) end,
        destroy = function(self) gui.list:remove(self) end
    }
    gui.list:add(el)
    return el
end

function components.panel(xPos, yPos, w, h)
    local panel = components.element(xPos, yPos)
    panel.w = w
    panel.h = h
    panel.backgroundColor = {0, 0, 0, 0.8}
    panel.lineColor = {1, 1, 1, 1}
    panel.draw = function(self)
        love.graphics.setColor(unpack(self.backgroundColor))
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
        love.graphics.setColor(unpack(self.lineColor))
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setLineWidth(1)
    end
    return panel
end

function components.label(string, xPos, yPos, limit, align, rPos, sx, sy)
    local label = components.element(xPos, yPos, rPos, sx, sy)
    label.text = string
    label.limit = limit or 100000
    label.align = align or 'left'
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

function components.button(text, xPos, yPos, width, onActivate, font)
    local w, lines = (font or assets.fonts.button):getWrap(text, width)
    local button = components.element(xPos, yPos)
    button.text = text
    button.w = width
    button.h = (font or assets.fonts.button):getHeight() * #lines
    button.selected = false
    button.panel = components.panel(xPos, yPos, width, button.h)
    button.label = components.label(text, xPos, yPos, width, 'center')
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

function components.line(x1, y1, x2, y2, thickness)
    local line = components.element(x1, y1)
    line.thickness = thickness or 1
    line.x2 = x2
    line.y2 = y2
    line.draw = function(self)
        love.graphics.setLineWidth(self.thickness)
        love.graphics.line(self.x, self.y, self.x2, self.y2)
        love.graphics.setLineWidth(1)
    end
    return line
end

function components.icon(tile, xPos, yPos, rPos, sx, sy)
    local icon = components.element(xPos, yPos, rPos, sx, sy)
    icon.tile = tile
    icon.ox = 4
    icon.oy = 4
    icon.draw = function(self)
        assets.entities.drawSprite(self.tile, self.x, self.y, self.r, self.sx * 4, self.sy * 4, self.ox, self.oy)
    end
    return icon
end

function components.title(text, y)
    local title = components.element(0, -200)
    title.text = text
    title.draw = function(self)
        love.graphics.setFont(assets.fonts.title)
        love.graphics.printf(self.text, 0, self.y, config.width, 'center')
    end
    return title
end

function components.image(img, scale)
    local imgbox = components.element(0, 0, 0, scale, scale)
    imgbox.w = img:getWidth() * scale
    imgbox.h = img:getHeight() * scale
    imgbox.x = (config.width - imgbox.w) / 2
    imgbox.y = (config.height -imgbox.h) / 2
    imgbox.img = img
    imgbox.draw = function(self)
        love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy)
        love.graphics.setLineWidth(tilemap.scale)
        love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
        love.graphics.setLineWidth(1)
    end
    return imgbox
end