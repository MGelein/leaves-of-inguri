spritesheet = {}

function spritesheet.create(url, tileWidth, tileHeight)
    local image = love.graphics.newImage(url)
    local w, h = image:getDimensions()
    local cols = math.floor(w / tileWidth)
    local rows = math.floor(h / tileHeight)
    local tiles = {}
    
    for row = 0, rows do
        for col = 0, cols do
            local x = col * tileWidth
            local y = row * tileHeight
            tiles[row * cols + col + 1] = love.graphics.newQuad(x, y, tileWidth, tileHeight, w, h)
        end
    end

    return {
        drawSprite = function(index, x, y, r, sx, sy)
            love.graphics.draw(image, tiles[index], x, y, r, sx, sy)
        end
    }
end