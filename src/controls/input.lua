input = {
    methods = {'keyboard', 'controller', 'touch'}
}

function input.load()
    input.mapKeyboard()
end

function input.mapKeyboard()
    input.keyboard = {
        mapping = {
            up = 'up', 
            left = 'left', 
            down = 'down', 
            right = 'right',
            attack = 'space',
            block = 'lshift',
            special = 's',
            interact = 'enter',

            menu = 'tab',
            map = 'm',
            next = 'd',
            previous = 'a',

        },
        isDown = function(name)
            return key.isDown(input.keyboard.mapping[name])
        end,
    }
end

function input.mapController()
    input.controller = {
        mapping = {
            up = controller.A.isDPUp, 
            left = controller.A.isDPLeft, 
            down = controller.A.isDPDown, 
            right = controller.A.isDPRight,
            attack = controller.A.isXDown,
            block = controller.A.isBDown,
            special = controller.A.isYDown,
            interact = controller.A.isADown,

            menu = controller.A.isMenuDown,
            map = controller.A.isViewDown,
            next = controller.A.isRightShoulderDown,
            previous = controller.A.isLeftShoulderDown,
        },
        isDown = function(name)
            return input.controller.mapping[name]()
        end,
    }
end

function input.isDown(name)
    for i, method in ipairs(input.methods) do
        if input[method] then
            if input[method].isDown(name) then
                return true
            end
        end
    end
    return false
end