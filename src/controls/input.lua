input = {
    methods = {'keyboard', 'controller', 'touch'},
    history = {},
    lastMethod = 'keyboard'
}

function input.load()
    input.mapKeyboard()
end

function input.mapKeyboard()
    input.keyboard = {
        mapping = {
            up = {'up', 'i'}, 
            left = {'left', 'j'}, 
            down = {'down', 'k'}, 
            right = {'right', 'l'},
            attack = {'space'},
            block = {'lshift', 'x'},
            special = {'s', 'c'},
            interact = {'return', 'z'},

            menu = {'tab', 'escape'},
            map = {'m', '\\'},
            next = {'d'},
            previous = {'a'},

        },
        isDown = function(name)
            for i, keyName in ipairs(input.keyboard.mapping[name]) do
                if key.isDown(keyName) then return true end
            end
            return false
        end,
    }
end

function input.mapController()
    input.controller = {
        mapping = {
            up = {controller.A.isDPUp, controller.A.isLYNegative}, 
            left = {controller.A.isDPLeft, controller.A.isLXNegative}, 
            down = {controller.A.isDPDown, controller.A.isLYPositive}, 
            right = {controller.A.isDPRight, controller.A.isLXPositive},
            attack = {controller.A.isXDown},
            block = {controller.A.isBDown},
            special = {controller.A.isYDown},
            interact = {controller.A.isADown},

            menu = {controller.A.isMenuDown},
            map = {controller.A.isViewDown},
            next = {controller.A.isRightShoulderDown, controller.A.isRTPositive},
            previous = {controller.A.isLeftShoulderDown, controller.A.isLTPositive},
        },
        isDown = function(name)
            for i, fn in ipairs(input.controller.mapping[name]) do
                if fn() then return true end
            end
            return false
        end,
    }
end

function input.isDown(name)
    for i, method in ipairs(input.methods) do
        if input[method] then
            if input[method].isDown(name) then
                input.lastMethod = method
                return true
            end
        end
    end
    return false
end

function input.isDownOnce(name)
    if input.isDown(name) then
        if not input.history[name] then
            input.history[name] = true
            return true
        else
            return false
        end
    else
        input.history[name] = false
    end
end