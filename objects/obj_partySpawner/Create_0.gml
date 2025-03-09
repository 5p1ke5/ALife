/// @description Goes through the list of serialized party members and spawns them in. Item 0 in the list is designated player. 
//As they are spawned in the variables are read in from the struct.
for (var _i = 0; _i < ds_list_size(global.partySerialized); _i++)
{
	var _struct = ds_list_find_value(global.partySerialized, _i);
	
	var _doll = instance_deserialize_doll(x, y, depth, _struct); //Using this breaks the camera. Why?
	//var _doll = instance_create_depth(x, y, depth, obj_doll);
	
	//with (_doll)
	//{
	//	doll_initialize(_struct.maxHP, _struct.maxHP, _struct.maxPP, _struct.maxPP, _struct.faction, 
	//	_struct.faceIndex, _struct.hairIndex, _struct.shirtIndex, _struct.pantsIndex, _struct.image_blend, _struct.hairColor, _struct.shirtColor, _struct.pantsColor, _struct.inventory);
	//}
	
	if (_i == 0)
	{
		global.player = _doll;	
	}
	
}