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
        width = w,
        height = h,

        drawSprite = function(index, x, y, r, sx, sy, ox, oy)
            love.graphics.draw(image, tiles[index], x, y, r, sx, sy, ox, oy)
        end,
        drawQuad = function(quad, x, y, r, sx, sy, ox, oy)
            love.graphics.draw(image, quad, x, y, r, sx, sy, ox, oy)
        end,
        getQuad = function(index)
            return tiles[index]
        end
    }
end