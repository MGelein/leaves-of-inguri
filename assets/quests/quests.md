# Quests
This document briefly details how a quest is structured. Every quest is stored separately in its own `.txt` file, named by its id value.

1. A line that starts with `@` is the name of the quest that is shown in the UI
2. A line that starts with `#` describes a state of the quest
3. A line that starts with `>` contains a short summary for the quest overlay

The first state of a quest __must__ be named `start` and the last state of a quest __must__ be named `end`. The rest of the states
can be any valid string.