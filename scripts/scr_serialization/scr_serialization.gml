///@function serialize_instance(_instance)
///@description Gets all instance from an instance, then saves them to a struct. This lets you easily read all the variables from the struct into an object with the deserialize_instance function (id is used to find which instance is which).
///@param _instance the instance to be serialized.
///@return A struct with all instance variables.
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
	
	print(_serializedInstance);
	return _serializedInstance;
	
}



///@function serialize_instance_extended(_instance)
///@description Gets all writable variables + id from an instance, then saves them to a SerializedInstance() struct. This lets you easily read all the variables from the struct into an object with the deserialize_instance function (id is used to find which instance is which).
///@param _instance the instance to be serialized.
///@return A new serialized instance, or -1 if no valid instance was found.
function serialize_instance_extended(_instance)
{
	//Get instance variables first.
	var _serializedInstance = serialize_instance(_instance);
	
	//Reads in all the built-in variables that are writable.
	with(_serializedInstance)
	{
		id = _instance.id;
		visible = _instance.visible;
		solid = _instance.solid;
		persistent = _instance.persistent;
		depth = _instance.depth;
		layer = _instance.layer;
		alarm = _instance.alarm;
		
		direction = _instance.direction;
		friction = _instance.friction;
		gravity = _instance.gravity;
		gravity_direction = _instance.gravity_direction;
		hspeed = _instance.hspeed;
		vspeed = _instance.vspeed;
		speed = _instance.speed;
		x = _instance.x;
		y = _instance.y;
		
		sprite_index = _instance.sprite_index;
		image_alpha = _instance.image_alpha;
		image_angle = _instance.image_angle;
		image_blend = _instance.image_blend;
		image_speed = _instance.image_speed;
		image_xscale = _instance.image_xscale;
		image_yscale = _instance.image_yscale;
		
		mask_index = _instance.mask_index;
		
	}
	
	return _serializedInstance;
	
}

///@function serialize_instance_all(_instance)
///@description Gets all variables from an instance, then saves them to a SerializedInstance() struct.
///@param _instance the instance to be serialized.
///@return A new serialized instance, or -1 if no valid instance was found.
function serialize_instance_all(_instance)
{
	//First gets all the variables that are not read-only + id.
	var _serializedInstance = serialize_instance(_instance);
	
	//Now we add in all the read-only variables.
	with(_serializedInstance)
	{
		xstart = _instance.xstart;
		ystart = _instance.ystart;
		xprevious = _instance.xprevious;
		yprevious = _instance.yprevious;
		
		object_index = _instance.object_index;
	
		sprite_width = _instance.sprite_width;
		sprite_height = _instance.sprite_height;
		image_number = _instance.image_number;
		
		bbox_bottom = _instance.bbox_bottom;
		bbox_left = _instance.bbox_left;
		bbox_right = _instance.bbox_right;
		bbox_top = _instance.bbox_top;
		
	}
	
	
	print(_serializedInstance);
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