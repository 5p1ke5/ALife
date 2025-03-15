/// @description Goes through the list of serialized party members and spawns them in. Item 0 in the list is designated player. 
//As they are spawned in the variables are read in from the struct.

//Reinitializes party, clearing the list.
global.party = party_initialize();

for (var _i = 0; _i < ds_list_size(global.partySerialized); _i++)
{
	var _struct = ds_list_find_value(global.partySerialized, _i);
	
	var _doll = instance_deserialize_doll(x, y, depth, _struct);

	
	if (_i == 0)
	{
		global.player = _doll;	
	}

	//Adds them to the party.	
	party_add(_doll);
}