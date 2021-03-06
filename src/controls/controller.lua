controller = {}
controller.requireRegistration = false
controller.unregistered = {}
controller.newlyRegistered = {}
controller.deadzone = 0.2

function love.joystickadded(joystick)
    if controller.requireRegistration then
        table.insert(controller.unregistered, joystick)
    else
        controller.register(joystick)
    end
end

function love.joystickremoved(joystick)
    local foundIndex = -1
    for i, unregisteredJoystick in ipairs(controller.unregistered) do
        if unregisteredJoystick == joystick then
            foundIndex = i
            break
        end
    end
    if foundIndex > -1 then 
        table.remove(controller.unregistered, foundIndex)
        return
    end

    for letter, control in pairs(controller) do
        if #letter == 1 then
            if control.joystick == joystick then
                controller[letter] = nil
            end
        end
    end
end

function controller.register(js)
    local letter = 'A'
    for i = 1, 26 do
        if controller[letter] == nil then break end
        letter = string.char(64 + i)
    end
    
    controller[letter] = {
        joystick = js,
        getLeftX = function() return js:getAxis(1) end,
        getLeftY = function() return js:getAxis(2) end,
        getLeftTrigger = function() return js:getAxis(3) end,
        getRightX = function() return js:getAxis(4) end,
        getRightY = function() return js:getAxis(5) end,
        getRightTrigger = function() return js:getAxis(6) end,

        isLXNegative = function() return js:getAxis(1) < -controller.deadzone end,
        isLXPositive = function() return js:getAxis(1) > controller.deadzone end,
        isLYNegative = function() return js:getAxis(2) < -controller.deadzone end,
        isLYPositive = function() return js:getAxis(2) > controller.deadzone end,

        isLTDown = function() return js:getAxis(3) > 0 end,
        isRTDown = function() return js:getAxis(6) > 0 end,

        isRXNegative = function() return js:getAxis(4) < -controller.deadzone end,
        isRXPositive = function() return js:getAxis(4) > controller.deadzone end,
        isRYNegative = function() return js:getAxis(5) < -controller.deadzone end,
        isRYPositive = function() return js:getAxis(5) > controller.deadzone end,
        
        isADown = function() return js:isDown(1) end,
        isBDown = function() return js:isDown(2) end,
        isXDown = function() return js:isDown(3) end,
        isYDown = function() return js:isDown(4) end,
        isLeftShoulderDown = function() return js:isDown(5) end,
        isRightShoulderDown = function() return js:isDown(6) end,
        isViewDown = function() return js:isDown(7) end,
        isMenuDown = function() return js:isDown(8) end,
        isLeftStickDown = function() return js:isDown(9) end,
        isRightStickDown = function() return js:isDown(10) end,
        
        isDPUp = function() return js:getHat(1):find('u') ~= nil end,
        isDPLeft = function() return js:getHat(1):find('l') ~= nil end,
        isDPRight = function() return js:getHat(1):find('r') ~= nil end,
        isDPDown = function() return js:getHat(1):find('d') ~= nil end,
    }
    input.mapController()
end

function love.joystickpressed(joystick, button)
    if #controller.unregistered < 1 then return end

    for letter, control in pairs(controller) do
        if #letter == 1 then
            if control.joystick == joystick then return end
        end
    end

    controller.register(joystick)
    local foundIndex = -1
    for j, unregisteredJoystick in ipairs(controller.unregistered) do
        if joystick == unregisteredJoystick then
            foundIndex = j
            break
        end
    end
    if foundIndex ~= -1 then table.remove(controller.unregistered, foundIndex) end
end

function controller.exists(letter)
    return controller[letter] ~= nil
end