/// @description Inherits, initializes NPC variables.
event_inherited();

var _command = new NPCCommandIdle();

npc_initialize(npc_name_random(), "The swift brown fox quickly jumped over the lazy dog", 100, _command);
