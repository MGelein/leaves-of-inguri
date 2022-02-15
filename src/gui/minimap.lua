minimap = {}
minimap.markers = {
    {
        town = {x = 416, y = 448, label = 'The Fringe', destination = 'fringe_town'},
    },{
        fields = {x = 352, y = 416, label = 'The Fields', destination = 'testmap'},
    },{  
        abbey = {x = 320, y = 352, label = 'Abandoned Abbey'},
    },{
        outskirts = {x = 320, y = 192, label = 'Lost City Outskirts'},
    },{
        palace = {x = 288, y = 160, label = 'Lost City Palace'},
    },{
        gardens = {x = 224, y = 160, label = 'Lost City Gardens'},
    },{
        outersanctum = {x = 224, y = 64, label = 'Outer Sanctum'},
    },{
        temple = {x = 128, y = 64, label = 'Inguri Temple'},
    },{
        inguri = {x = 32, y = 32, label = 'Inguri'},
    },
}
minimap.activeMarker = 'none'

function minimap.open()
    local map = components.element(0, -1000)
    map.img = components.image(assets.minimap, tilemap.scale)
    local targetY = map.img.y
    map.img.y = config.height + map.img.h
    map.labelText = ''
    map.img.visible = false
    map.drawOffset = 0
    map.offDir = 1
    map.markers = minimap.markers

    map.destroy = minimap.destroy
    map.draw = minimap.draw
    map.drawCursor = minimap.drawCursor
    map.update = minimap.update
    map.updateCursor = minimap.updateCursor
    map.locationMarker = minimap.getMarker(minimap.activeMarker)
    map.cursorIndex = minimap.getMarkerIndex(minimap.activeMarker)
    map.cursorMarker = minimap.getMarker(minimap.activeMarker)
    map:updateCursor(0)
    ez.easeInOut(map.img, {y = targetY})
    return map
end

function minimap.draw(self)
    love.graphics.push()
    self.img:draw()
    love.graphics.translate(self.img.x, self.img.y)
    self:drawCursor(self.locationMarker, 2, {1, 0, 0})
    self:drawCursor(self.cursorMarker, 4, {1, 0.65, 0}, true)
    
    love.graphics.setFont(assets.fonts.normal)
    love.graphics.setLineWidth(tilemap.scale)
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle('fill', self.labelX - 24, self.labelY - 32, self.labelW, 32)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle('line', self.labelX - 24, self.labelY - 32, self.labelW, 32)
    love.graphics.print(self.labelText, self.labelX - 16, self.labelY - 32)
    love.graphics.setLineWidth(1)

    if game.allowFastTravel then
        love.graphics.setFont(assets.fonts.normal)
        love.graphics.printf('Press ATTACK/INTERACT to fast travel to location.', 0, self.img.h + 10, self.img.w, 'center')
    end
    love.graphics.pop()
end

function minimap.update(self, dt)
    self.drawOffset = self.drawOffset + dt * 4 * self.offDir
    if self.drawOffset > 2 then 
        self.offDir = -1
        self.drawOffset = 2
    elseif self.drawOffset < 0 then
        self.offDir = 1
        self.drawOffset = 0
    end

    if input.isDownOnce('map') then game.popMenu() end
    if input.isDownOnce('previous') or input.isDownOnce('left') or input.isDownOnce('up') then
        self:updateCursor(1)
    elseif input.isDownOnce('next') or input.isDownOnce('right') or input.isDownOnce('down') then
        self:updateCursor(-1)
    elseif input.isDownOnce('interact') or input.isDownOnce('attack') then
        local destination = self.cursorMarker.destination
        if destination and game.allowFastTravel then
            local heroY = hero.entity.y
            game.popMenu()
            soundfx.play('travel')
            ez.easeIn(hero.entity, {sy = 10, sx = 0.01, y = heroY - 500}, {time = 0.3}):complete(function() 
                tilemap.load(destination)
                heroY = hero.entity.y
                hero.entity.y = heroY - 500
                hero.entity.sy = 10
                hero.entity.sx = 0.01
                ez.easeOut(hero.entity, {sy = 1, sx = 1, y = heroY}, {time = 0.3})
            end)
        end
    end
end

function minimap.updateCursor(self, dir)
    local cursorBackup = self.cursorIndex
    self.cursorIndex = self.cursorIndex + dir
    if self.cursorIndex > #self.markers then self.cursorIndex = #self.markers
    elseif self.cursorIndex < 1 then self.cursorIndex = 1 end
    for name, data in pairs(self.markers[self.cursorIndex]) do
        if name then 
            if savefile.isLocationDiscovered(name) then
                self:setCursorMarker(name) 
                if dir ~= 0 then soundfx.play('ui_select') end
            else
                self.cursorIndex = cursorBackup
                if dir ~= 0 then soundfx.play('ui_error') end
            end
            break 
        end
    end
    self.labelText = self.cursorMarker.label
    self.labelW = assets.fonts.normal:getWidth(self.labelText) + 16
    self.labelX = self.cursorMarker.x
    self.labelY = self.cursorMarker.y
    if self.labelX + self.labelW > self.img.w - 8 then
        self.labelX = self.img.w - 8 - self.labelW
    elseif self.labelX < 8 then
        self.labelX = 8
    end
end

function minimap.drawCursor(self, marker, lineWidth, color, useOffset)
    if not marker then return end
    local off = useOffset and self.drawOffset or -0.5 * self.drawOffset
    love.graphics.setColor(unpack(color))
    love.graphics.setLineWidth(lineWidth)
    love.graphics.rectangle('line', marker.x - off, marker.y - off, 32 + off * 2, 32 + off * 2)
    love.graphics.setLineWidth(1)
    love.graphics.setColor(1, 1, 1)
end

function minimap.getMarker(name)
    for i, marker in ipairs(minimap.markers) do
        for markerName, markerData in pairs(marker) do
            if name == markerName then return markerData end
        end
    end
end

function minimap.getMarkerIndex(name)
    for i, marker in ipairs(minimap.markers) do
        for markerName, data in pairs(marker) do
            if markerName == minimap.activeMarker then
                return i
            end
        end
    end
end

function minimap.destroy(self)
    self.img:destroy()
    gui.list:remove(self)
end