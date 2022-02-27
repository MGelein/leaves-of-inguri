vector = {}

function vector.create(x, y)
    return {x = x, y = y}
end

function vector.normalize(vec)
    local length = vector.length(vec)
    return {x = vec.x / length, y = vec.y / length}
end

function vector.dot(vectorA, vectorB)
    return vectorA.x * vectorB.x + vectorA.y * vectorB.y
end

function vector.length(vec)
    return math.sqrt(vec.x * vec.x + vec.y * vec.y)
end