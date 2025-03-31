/// @function party_initialize()
/// @description Sets the global party array as an empty ds_list.
/// @returns returns an empty ds_list.
function party_initialize()
{
	return ds_list_create();	
}

/// @function party_serialized_intialize()
/// @description Sets the global serialized party array as an empty ds_list.
/// @returns returns an empty ds_list.
function party_serialized_intialize()
{
	return ds_list_create();
}


///@function party_serialize()
///@description Serializes all party members into a ds_list. Returns that list of serialized party members.
function party_serialize()
{
	var _partySerialized = ds_list_create();
	
	
	for (var _i = 0; _i < ds_list_size(global.party); _i++) 
	{
		var _serializedDoll = serialize_instance_extended(ds_list_find_value(global.party, _i));
		
		ds_list_add(_partySerialized, _serializedDoll);
	}
	
	return _partySerialized;
}


/// @function party_add()
/// @description adds an instance reference to the party member list.
/// @param _instance The instance to be added to the list.
function party_add(_instance)
{
	//Only adds to the party if the instance isn't already in the list.
	if (ds_list_find_index(global.party, _instance) == -1)
	{
		ds_list_add(global.party, _instance);
	}
}

/// @function party_remove(_instance)
/// @description Attempts to find an Instance refernce on the list and if its there deletes it from the list.
/// @param _instance The instance to search from the list.
function party_remove(_instance)
{
	ds_list_delete(global.party, ds_list_find_index(global.party, _instance));	
}


