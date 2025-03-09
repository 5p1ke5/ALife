///@function serialize_instance(_instance)
///@description Gets all variables from an instance, then saves them to a SerializedInstance() struct.
///@param _instance the instance to be serialized.
///@return A new serialized instance, or -1 if no valid instance was found.
function serialize_instance(_instance)
{
	if !(instance_exists(_instance))
	{
		return -1;	
	}
	
	var _variableNameArray = variable_instance_get_names(_instance);
	var _serializedInstance = {};
	
	//Gets all non built-in variables from the instance and puts them in a struct.
	for (var _i = 0; _i < array_length(_variableNameArray); _i++)
	{
		var _var = variable_instance_get(_instance, _variableNameArray[_i]);
		variable_struct_set(_serializedInstance,  _variableNameArray[_i], _var)
	}
	
	//Adding built-in variables as they become necessary.	
	with(_serializedInstance)
	{
		image_blend = _instance.image_blend;	
	}
	
	return _serializedInstance;
	
}

///@function instance_deserialize_doll(_x, _y, _depth, _struct)
///@description Creates a doll at the given location and initializes it's values using the given struct (serialized instance of a doll object)
///@param _x X coordinate to place the doll at.
///@param _y Y coordinate to place the doll at.
///@param _depth Depth to place the doll at.
///@param _struct The struct containing a serialized instance of a doll. Select variables will be taken from this and used to initialize the doll.
///@return Returns a reference to the created doll.
function instance_deserialize_doll(_x, _y, _depth, _struct)
{
	var _doll = instance_create_depth(_x, _y, _depth, obj_doll);
	
	with (_doll)
	{
		doll_initialize(_struct.maxHP, _struct.maxHP, _struct.maxPP, _struct.maxPP, _struct.faction, 
		_struct.faceIndex, _struct.hairIndex, _struct.shirtIndex, _struct.pantsIndex, _struct.image_blend, _struct.hairColor, _struct.shirtColor, _struct.pantsColor, _struct.inventory);
	}
	
	return _doll;
}