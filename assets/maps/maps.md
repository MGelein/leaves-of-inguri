# Maps
This document briefly describes some of the more outlandish concepts that I have introduced by creating my own engine. First of all, all maps are made with the Tiled map editor, exported to a `.lua` file. These files should have the map-id as the name of the file. This is the name that is used internally to reference this map.

## Map Properties
Every map has the option to set some custom variables. On the map level, it's just two options:
- __bgm__: Sets the backgroundmusic track that plays when you are on this map. __Does not need an extension!__
- __name__: The name of the map that will be shown in the UI, so make this one prettier!
- __minimap__: The name of the minimap marker that will be active when you are in this area

## Map Layers
Every map has 4 layers:
- __tiles__: This is a static layer of tiles that will get compiled to one big image. This image is immutable at runtime to improve performance.
- __entities__: This layer spawns entities using the tile images. On this layer you can add things like doors, monsters, npcs and other objects.
- __collisions__: The first object layer contains all the collision geometry. This gets parsed to make the colliders. Setting a collider's class to `water` will make the collider ignore weapons, since they can fly over it.
- __triggers__: The final layer contains all the colliders for various triggers, even if they might not strictly need a collider. For more informtion on triggers, you might want to read the `Triggers` subsection.

## Triggers
A trigger is a collider that can do something with the world of the game. Every trigger __must__ at least have the following two properties:
- __type__: Sets the type of the trigger, this determines what it does when it gets triggered.
- __method__: Sets the method by which this trigger can be activated, or triggered.

### Trigger Methods
We have various ways of triggering a trigger:
- __collide__: When the hero collider collides with the trigger collider this trigger will activate. It will only activate again if the hero has stopped colliding with the trigger at least once.
- __interact__: When the player presses the `interact` button close enough to this collider it will activate.
- __monstersGone__: This trigger will run everytime it detects that all monsters on the map have been slain.
- __chest__: This trigger will run when the chest that is on its tile will be destroyed

### Trigger Types
Besides various trigger methods we also have loads of different types. Some of these types might require additional properties (described in between the brackets):
- __npc (id)__: denotes that this trigger is the position of an npc. Needs an `id` property that links it to an npc
- __text (text)__: shows the specified text in a UI box, great for popups and exposition. The text property contains the text to show.
- __warp (destination)__: warps the hero to another map, or another location on the same map. The location is formatted: `MAP_ID@COL,ROW`
- __questState (quest, state)__: Sets the provided quest to the provided state. This is quite a simple trigger. Probably triggers quest updates
- __setVariable(var, value)__: Sets the provided variable in the global registry to the provided value.
- __changeEntity (tile)__: Changes the entity that is on the same tile as this trigger to another sprite, denoted by its tile-id.
- __removeEntity ()__: Removes the entity that is on the same tile as this trigger.
- __drop(contents...)__: Drops the supplied list of contents (separated by a comma, with each entry detailing the drop type and drop amount separated with a colon). 