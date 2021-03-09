npcs = {}
npcs.list = managedlist.create()

function npcs.create(id, tile, xPos, yPos)
    local npc = entities.createForce(id, tile, xPos, yPos)
    npc.attack = 0
    npc.mass = 0
    npc.home = {x = xPos, y = yPos}
    npc.collider.class = 'npc'
    npc.collider.parent = npc
    npc.load = npcs.loadPersonalityData
    npc.update = npcs.update
    npc.talk = npcs.talk
    npcs.list:add(npc)
end

function npcs.registerTrigger(trigger)
    for i, npc in ipairs(npcs.list.all) do
        if npc.home.x - 16 == trigger.x * tilemap.scale and npc.home.y - 16 == trigger.y * tilemap.scale then
            npc.name = trigger.properties.id
            npc.trigger = trigger
            trigger.npc = npc
            npc:load()
            break
        end
    end
end

function npcs.talk(self)
    gui.showDialogue(self.dialogue)
end

function npcs.loadPersonalityData(self)
    self.dialogue = dialogues.load(self.name)
    self.name = self.dialogue.name
end

function npcs.update(self, dt)
    if self.trigger then 
        self.trigger.collider:moveTo(self.x, self.y) 
    end
end

function npcs.clear()
    npcs.list = managedlist.create()
end