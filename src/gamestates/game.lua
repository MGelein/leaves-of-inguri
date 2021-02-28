game = {}

function game.load()
    local hero = entities.create(5, 100, 100)
    hero.update = function(self)
        self.x = self.x + 1
        self.collider:moveTo(self.x + 16, self.y + 16)
    end
end

function game.start()

end

function game.draw()
    tilemap.draw()
    entities.draw()
end

function game.update(dt)
    entities.update(dt)
end

function game.stop()

end