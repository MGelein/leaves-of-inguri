# Quests
This document briefly details how a quest is structured. Every quest is stored separately in its own `.txt` file, named by its id value.

1. A line that starts with `@` is the name of the quest that is shown in the UI
2. A line that starts with `#` describes a state of the quest
3. A line that starts with `>` contains a short summary for the quest overlay

The first state of a quest __must__ be named `start` and the last state of a quest __must__ be named `end`. The rest of the states
can be any valid string.

## List of Quests
- __tutorial__: (Town - Southern Road) To make your way into town you are subjected to the tutorial. __Wooden Shield__
- (Town - Inn) Help the inn-keeper with his stereotypical rat problem. __Health +5__
- (Town - Public Square) Explore the town and find out what is troubling its inhabitants. __Leather Armor__
- (Fields - Farmland) Wolves are roaming the farmland to the north of the city, please clear and see if everyone's okay. __Story__
- (Fields - Forest) One of the herders knows where the wolves are coming from and points you to the small local forest. __Trident__
- (Fields - Abbey Road) Recover the stolen jewelery from a travelling merchant __Health +5__
- (Abbey - Graveyard) Put a ring of a long deceased ancestor on their grave to appease their spirit. __Story__
- (Abbey - Courtyard) Discover the nature of Inguri and learn the heal spell __Heal__
- (Abbey - Interior) Defeat the first of the three cultists and claim their jewel __Mana +5__
- (Outskirts - Inguri Forest) Help the old forester by finding the rogue tree __Talk With Plants__
- (Outskirts - Gatehouse) Bring the city crest from the Gatehouse back to the archeologist __Story__
- (Outskirts - Housing District) Find and bring back a total of _n_ rings to town __Health +5__
- (Palace - Servant Quarters) Kill the, now undead, servants to bring peace to their haunted existence __Health +5__
- (Palace - Armory) Find the three parts of the chain armor, maybe some ore __Chain Armor__
- (Palace - Throne Room) Find more information about why the Lost City fell, uncover its faith __Story__
- (Gardens - Greenhouse) Gather the various components for a brew that will fortify your body __Mana +5__
- (Gardens - Patio) Help the old tree on the patio by defeating the rogue trees  __Story__
- (Gardens - Tree Garden) Defeat the second of the three cultists and gain their jewel __Axe__
- (Outer Sanctum - Arcane Library) Explore the arcane library and bring back an exotic tome __Blink__
- (Outer Sanctum - Guest Chambers) Clear the remains of the undead guests from their former chambers __Iron Shield__
- (Outer Sanctum - Courtyard) Reactivate the waterflow in the courtyard to enter the temple __Mana +5__
- (Temple - Tree Forge) Collect the leaves of Inguri to prepare for the creation of the best armor __Plate Armor__
- (Temple - Altar of Inguri) Defeat the final of the three cultists and get the final jewel __Health +5__
- (Temple - Private Chambers) Learn about the full details of the sacrilegious event in the highpriest's diary __Story__
- (Inguri - The Vault) Gain entry to the mighty vault of the temple by finding the three scattered keys in the temple. __Sword__
- (Inguri - The Walk) Survive the long and dangerous journey that the cultists almost destroyed through their sacrilege __Health +5__
- (Inguri - The Heart) Bring Inguri back to live by placing the three jewel parts back into her heart __Story__