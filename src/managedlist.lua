managedlist = {}

function managedlist.create()
    return {
        all = {},
        toRem = {},

        update = managedlist.update,
        remove = managedlist.remove,
        add = managedlist.add,
    }
end

function managedlist.update(self)
    if #self.toRem < 1 then return end
    for i, obj in ipairs(self.toRem) do
        local foundIndex = -1
        for j, object in ipairs(self.all) do
            if object == obj then 
                foundIndex = j
                break
            end
        end
        if foundIndex > -1 then table.remove(self.all, j) end
    end
    self.toRem = {}
end

function managedlist.remove(self, obj)
    table.insert(self.toRem, obj)
end

function managedlist.add(self, obj)
    table.insert(self.all, obj)
end