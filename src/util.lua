function decrease(value)
    if value <= 0 then return value
    else return value - 1 end
end

function dist(x, y, x2, y2)
    return math.sqrt((x2 - x) ^ 2 + (y2 - y) ^ 2)
end