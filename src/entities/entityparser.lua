entityparser = {}

function entityparser.parse(tile, x, y)
    if tile == hero.symbolTile then hero.create(x, y)
    elseif entityparser.isMonsterTile(tile) then monsters.create(tile, x, y, 100)
    else entities.create(tile, x, y) 
    end
end

function entityparser.isMonsterTile(tile)
    if tile >= 10 and tile <= 15 then return true
    elseif tile >= 19 and tile <= 27 then return true
    else return false end
end