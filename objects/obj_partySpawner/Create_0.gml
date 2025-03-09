/// @description Goes through the list of serialized party members and spawns them in. Item 0 in the list is designated player.
for (var _i = 0; _i < ds_list_size(global.partySerialized); _i++)
{
	var _doll = instance_create_depth(x, y, depth, obj_doll);
	show_debug_message(ds_list_find_value(global.partySerialized, _i));
	var _struct = ds_list_find_value(global.partySerialized, _i);
	
	show_debug_message(ds_list_read(global.partySerialized));
	
	show_debug_message(_struct);
	print(_doll.faceIndex);
	
	if (_i == 0)
	{
		global.player = _doll;	
	}
	
	with (_doll)
	{
		maxHP = _struct.maxHP;
		hp = _struct.pp;
		maxPP = _struct.maxPP;
		pp = _struct.pp;
		faction = _struct.faction;
		faceIndex = _struct.faceIndex;
		hairIndex = _struct.hairIndex;
		shirtIndex = _struct.shirtIndex;
		pantsIndex = _struct.pantsIndex;
		hairColor = _struct.hairColor;
		shirtColor = _struct.shirtColor;
		pantsColor = _struct.pantsColor;
		image_blend = _struct.skinColor;
		inventory = _struct.inventory;
		inventoryIndex = _struct.inventoryIndex;
		ppRegen = _struct.ppRegen;
		name = _struct.name;
		text = _struct.text;
		level = _struct.level;
	}
}