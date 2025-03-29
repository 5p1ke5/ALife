///@function gui_dropdown_initialize()
///@description initializes variables for a dropdown box.
///@param _elements[] an array with structs for button elements.
///@param _fillColor a color to fill the dropdown with
///@param _outlineColor a color to outline the dropdown with.
///@param _creator A reference to the instance that created this element.
function gui_dropdown_initialize(_elements, _fillColor, _outlineColor, _creator=noone)
{
	
	//Creates the array that will hold the button elements.
	elements = array_create(array_length(_elements));
	
	//Turns each struct in _elements into a button that will go into the elements array.
	for (var _i = 0; _i < array_length(_elements) - 1; _i++) 
	{
		
	    //elements[_i] = gui_button_create(x, y, depth, _elements[_i].text, _elements[_i].clickMethod, _elements[_i].arguments, self);
	}
	
	fillColor = _fillColor;
	outlineColor = _outlineColor;
	
	width = 100;
	height = 100;
	
	//Creates a reference to the instance that created this dropdown. Noone means it doesn't have one specifically defined.
	creator = _creator;
}

///@function gui_dropdown_create(_x, _y, _depth, _elements, _fillColor, _outlineColor, _creator=noone)
///@description Creates a dropdown element and initializes variables for it. Returns the created dropdown object.
///@param _x X coordinate to create the dropdown at.
///@param _y Y coordinate to create the dropdown at.
///@param _depth depth to create the dropdown at.
///@param _elements[] an array with structs for button elements.
///@param _fillColor a color to fill the dropdown with
///@param _outlineColor a color to outline the dropdown with.
///@param _creator A reference to the instance that created this element.
function gui_dropdown_create(_x, _y, _depth, _elements, _fillColor, _outlineColor, _creator=noone)
{
	var _dropdown = instance_create_depth(_x, _y, _depth, obj_dropdown);
	
	with (_dropdown)
	{
		gui_dropdown_initialize(_elements, _fillColor, _outlineColor, _creator)
	}
	
	return _dropdown;
}

///@function gui_button_initialize(_clickMethod )
///@description initializes variables for a gui button.
///@param _text The text the button will disaply.
///@param _clickMethod A method to be executed when the button is click.
///@param [_arguments[]] an array of arguments to be fed into the clickMethod method.
function gui_button_initialize(_text, _clickMethod, _arguments = [], _owner = noone)
{
	text = _text;
	clickMethod = _clickMethod;
	arguments = _arguments;
	
	owner = _owner;
}

///@function gui_button_create(_x, _y, _depth, (_text, _clickMethod, _arguments = [], _owner = noone)
///@description Creates a gui button at the specified point and initializes its variables.
///@param _x X coordinate to create the button at.
///@param _y Y coordinate to create the button at.
///@param _depth depth to create the button at.
///@param _text The text the button will disaply.
///@param _clickMethod A method to be executed when the button is click.
///@param [_arguments[]] an array of arguments to be fed into the clickMethod method.
function gui_button_create(_x, _y, _depth, _text, _clickMethod, _arguments = [], _owner = noone)
{
	var _button = instance_create_depth(_x, _y, _depth, obj_button);
	
	with (_button)
	{
		gui_button_initialize(_text, _clickMethod, _arguments, _owner);	
	}
	
	return _button;
}


///TODO: Just put these in object events?

///@function gui_button_step()
///@description code to be performed during step event.
function gui_button_step()
{
	if (position_meeting(mouse_x, mouse_y, id) && MOUSE_LEFT_BUTTON_PRESSED)
	{
		//event_user(0)
		gui_button_method();
	}
}

///@function gui_button_method()
///@description Executes the gui button's method. Usually should be called on click somehpw. 
function gui_button_method()
{
	method_call(clickMethod, arguments);
}