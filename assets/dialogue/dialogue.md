# Dialogue
Dialogue is one of the most complex matters of this RPG. This document will explain the various rules used in creating the dialogue
files that we use in this engine. 

1. All the dialogue for a single npc is stored in a `.txt` file with the npc id as a filename.
2. The full name of the npc is provided in a line that starts with an `@`
3. A line that starts with `#` denotes the start of a topic, or entry. `greeting` is the default starting point of a dialogue.
4. A line that starts with `-` shows the start of a response to the normal line above it.
5. A `>` symbol shows where this response will lead to. Usually `exit` is used as a fake non-existent destination. As soon as the dialogue tries to locate a nonexistent entry, the dialogue exits.
6. Conditions for certain entries to trigger are written between `{` and `}` brackets. In these brackets you can test several variables using standard comparison operators.
7. Commands that are executed for certain entries are prefaced by a `:`. Commands are generally written in all caps. 

## Basic Structure.
So, to recapitulate, every dialogue file contains multiple topics. Each of these topics can have multiple entries, but __must__ at least contain one `{DEFAULT}` condition. These conditions decide when certain entries are picked in dialogue. 

Every entry can have various commands and responses attached to it. The former are explained in more depth in the next subsection, whereas the latter can lead to other topics, or to exit.

## Commands
At the time of writing there are the following commands that are supported in the current version of the dialogue parser:
```
SET(var, value) -- sets a global register variable to the specified value
HEAL(amt) -- heals the hero for the specified amount of hitpoints
DAMAGE(amt) -- damages the hero for the specified amount of hitpoints
WEAPON(type) -- sets the weapon type that the hero uses
ARMOR(type) -- sets the armor type that the hero uses
QUEST(name, state) -- sets the state of the specified quest
HEALTH(amt) -- sets the amount of maximum health of the hero
MANA(amt) -- sets the amount of maximum mana of the hero
```

## Conditions
Anything between the conditional markers (`{}`) is parsed to a variable, operator and value. One exception is when checking for the existence of a global flag. In that case you could only provide the variable name, omitting the operand or value.

The most obfuscated part is the way variable names get resolved. In order, to resolve, we check:
1. If it's a special reserved name such as `health`
2. The hero's effects.
3. The quest state database
4. The global variable database

Ideally we should be able to add multiple conditions in one line, which is a feature on the roadmap.