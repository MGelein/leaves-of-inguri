npcs = {}
npcs.list = managedlist.create()

function npcs.create(id, tile, xPos, yPos)
    local npc = entities.createForce(id, tile, xPos, yPos)
    npc.attack = 0
    npc.mass = 0
    npc.collider.class = 'npc'
    npc.collider.parent = npc
    npc.update = npcs.update
    npcs.list:add(npc)
end

function npcs.registerTrigger(trigger)
    local tx = trigger.x * tilemap.scale
    local ty = trigger.y * tilemap.scale
    for i, npc in ipairs(entities.list.all) do
        if npc.home.x - 16 == tx and npc.home.y - 16 == ty then
            npc.name = trigger.properties.id
            npc.trigger = trigger
            npc.talk = npcs.talk
            trigger.npc = npc
            npcs.loadPersonalityData(npc)
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