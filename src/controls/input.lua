input = {
    methods = {'keyboard', 'controller', 'touch'}
}

function input.load()
    input.mapKeyboard()
end

function input.mapKeyboard()
    input.keyboard = {
        mapping = {
            up = 'w', 
            left = 'a', 
            down = 's', 
            right = 'd',
            attack = 'space',
            block = 'lshift',
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
            attack = controller.A.isADown,
            block = controller.A.isBDown,
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