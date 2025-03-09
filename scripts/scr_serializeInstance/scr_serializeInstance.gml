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
	
	//Adding built-in variables.	
	with(_serializedInstance)
	{
		image_blend = _instance.image_blend;	
	}
	
	return _serializedInstance;
	
}