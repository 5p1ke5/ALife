///@function gui_dropdown_initialize()
///@description initializes variables for a dropdown box and creates all the buttons.
///@param _objects[] an array with button objects.
///@param _creator A reference to the instance that created this element.
function gui_dropdown_initialize(_objects, _creator=noone)
{
	//reference to this object.
	var _self = id;
	
	//Creates the array that will hold the button elements.
	buttons = array_create(array_length(_objects));
	
	//Creates each button object and positions it and assigns the dropdown as its owner.
	for (var _i = 0; _i < array_length(_objects); _i++) 
	{
		buttons[_i] = instance_create_depth(x, y + (_i * 8), depth, _objects[_i]);
		with (buttons[_i])
		{
			owner = _self;	
		}
	}
	
	
	//Creates a reference to the instance that created this dropdown. Noone means it doesn't have one specifically defined.
	creator = _creator;
}


///@function gui_dropdown_create(_x, _y, _depth, _objects, _fillColor, _outlineColor, _creator=noone)
///@description creates a dropdown box and initializes variables for it. Returns a reference to the dropdown box instance.
///@param _x X coordinate of the dropdown.
///@param _y Y coordinate of the dropdown.
///@param _depth Depth to create dropdown at.
///@param _objects[] an array with button objects.
///@param _creator A reference to the instance that created this element.
function gui_dropdown_create(_x, _y, _depth, _objects, _creator=noone)
{
	var _id = id;
	var _dropdown = instance_create_depth(_x, _y, _depth, obj_dropdown);
	
	with (_dropdown)
	{
		gui_dropdown_initialize(_objects, _id)	
	}
	
	return _dropdown;
}

///@function gui_button_initialize(_text, _fillColor, _lineColor, _textColor, _owner=noone)
///@description Initializes variables for a gui button object.
///@param _text The text string for the button.
///@param _fillColor the background color for the button
///@param _lineColor the outline color for the button. If noone just doesn't draw one.
///@param _textColor the color of the text.
///@param _owner the owner of the button object. if noone there just isn't one.
function gui_button_initialize(_text, _fillColor, _lineColor, _textColor, _owner=noone)
{
	text = _text;
	image_blend = _fillColor;
	lineColor = _lineColor;
	textColor = _textColor;
	owner = _owner;
}






















