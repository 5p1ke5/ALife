/// @description Goes through the list of serialized party members and spawns them in. Item 0 in the list is designated player. 
//As they are spawned in the variables are read in from the struct.

//Reinitializes party, clearing the list.
global.party = party_initialize();

//Attempts to spawn party at the spawn point defined in globals. -1,-1 is considered 'blank' and in that case just spawns the party at the instance's coordinates.
if (global.spawnX == -1 && global.spawnY == -1)
{
	var _spawnX = x;
	var _spawnY = y;
}
else
{
	var _spawnX = global.spawnX;
	var _spawnY = global.spawnY;
}

//resets global spawn variables.
global.spawnX = -1;
global.spawnY = -1;


for (var _i = 0; _i < ds_list_size(global.partySerialized); _i++)
{
	var _struct = ds_list_find_value(global.partySerialized, _i);
	
	var _doll = instance_deserialize_doll(_spawnX, _spawnY, depth, _struct);

	
	if (_i == 0)
	{
		global.player = _doll;
	}	
	else
	{
		with (_doll)
		{
			//Resets npcStates so it only contains a commands to follow the player.
			var _state = new NPCStateFollow(global.player);
			npcStates = array_create(1, _state);
		}
	}
		

	//Adds them to the party.	
	party_add(_doll);
}