ez = {}
ez.list = {}
ez.toRem = {}
ez.elasticConst = (math.pi * 2) / 3
ez.elasticConst2 = (math.pi * 2) / 4.5
ez.shape = 'Cubic'

function ez.easeLinear(object, attribute, targetValue, easeTime, onComplete)
    return ez.ease(object, attribute, targetValue, easeTime, 'linear', onComplete)
end

function ez.easeIn(object, attribute, targetValue, easeTime, onComplete)
    return ez.ease(object, attribute, targetValue, easeTime, 'in', onComplete)
end

function ez.easeOut(object, attribute, targetValue, easeTime, onComplete)
    return ez.ease(object, attribute, targetValue, easeTime, 'out', onComplete)
end

function ez.easeInOut(object, attribute, targetValue, easeTime, onComplete)
    return ez.ease(object, attribute, targetValue, easeTime, 'inOut', onComplete)
end

function ez.ease(object, attribute, targetValue, easeTime, easeFn, onComplete)
    if type(attribute) ~= 'string' then
        print('Attribute must be a string describing the attribute name.') 
        return
    elseif type(object[attribute]) ~= 'number' then
        print('Only numbers can be eased.')
        return
    elseif ez[easeFn .. ez.shape] == nil then
        print('Could not find easing implementation for function', (easeFn .. ez.shape))
        return
    end

    local e = {
        obj = object,
        attr = attribute,
        target = targetValue,
        start = object[attribute],
        time = easeTime or 1,
        fn = ez[easeFn .. ez.shape],
        elapsed = 0,
        timeRatio = 0,
        valueRatio = 0,
        complete = onComplete,

        remove = ez.remove,
    }
    e.delta = (e.target - e.start)
    ez.add(e)
    return e
end

function ez.update(dt)
    for i, e in ipairs(ez.list) do
        e.obj[e.attr] = e.start + e.valueRatio * e.delta
        e.elapsed = e.elapsed + dt
        e.timeRatio = e.elapsed / e.time
        e.valueRatio = e.fn(e.timeRatio)
        if e.elapsed >= e.time then 
            e.obj[e.attr] = e.target
            if e.complete then e.complete() end
            e:remove() 
        end
    end

    if #ez.toRem > 0 then
        for i, obj in ipairs(ez.toRem) do
            local foundIndex = -1
            for j, object in ipairs(ez.list) do
                if object == obj then 
                    foundIndex = j
                    break
                end
            end
            if foundIndex > -1 then table.remove(ez.list, foundIndex) end
        end
        ez.toRem = {}
    end
end

function ez.setShape(shape)
    shape = shape:lower()
    ez.shape = shape:sub(1, 1):upper() .. shape:sub(2)
end

function ez.remove(self)
    table.insert(ez.toRem, self)
end

function ez.add(self)
    table.insert(ez.list, self)
end

function ez.linearCubic(timeRatio)
    return timeRatio
end
ez.linearElastic = ez.linearCubic
ez.linearSine = ez.linearCubic

function ez.inOutCubic(t)
    if t < 0.5 then return 4 * t * t * t
    else return 1 - math.pow(-2 * t + 2, 3) / 2 end
end

function ez.inOutSine(t)
    return -(math.cos(math.pi * t) - 1) / 2;
end

function ez.inOutElastic(t)
    if t == 0 then return 0
    elseif t == 1 then return 1
    elseif t <= 0.5 then return -(math.pow(2, 20 * t - 10) * math.sin((20 * t - 11.125) * ez.elasticConst2)) / 2
    else return (math.pow(2, -20 * t + 10) * math.sin((20 * t - 11.125) * ez.elasticConst2)) / 2 + 1 end
end

function ez.inCubic(t)
    return t * t * t
end

function ez.inSine(t)
    return 1 - math.cos((t * math.pi) / 2)
end

function ez.inElastic(t)
    if t == 0 then return 0
    elseif t == 1 then return 1
    else return -math.pow(2, 10 * t - 10) * math.sin((t * 10 - 10.75) * ez.elasticConst); end
end

function ez.outCubic(t)
    local invTime = 1 - t
    return 1 - invTime * invTime * invTime
end

function ez.outSine(t)
    return math.sin((t * math.pi) / 2)
end

function ez.outElastic(t)
    if t == 0 then return 0
    elseif t == 1 then return 1
    else return math.pow(2, -10 * t) * math.sin((t * 10 - 0.75) * ez.elasticConst) + 1 end
end