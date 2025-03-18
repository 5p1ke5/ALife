/// @description Insherits, lets player pick clothing options.
event_inherited();

//Sets optionSelected with the color sliders.



var _increment = RIGHT_BUTTON_RELEASED - LEFT_BUTTON_RELEASED;
			
//Set colors.
var _red = sliderRed.val;
var _green = sliderGreen.val;
var _blue = sliderBlue.val;
			

switch (optionSelected)
{
	case 0: //Face
		faceIndex += _increment;
			
		if (faceIndex < 0)
		{
			faceIndex = sprite_get_number(spr_dollFaces) - 1;	
		}
		
		if (faceIndex >= sprite_get_number(spr_dollFaces))
		{
			faceIndex = 0;
		}
		
		faceIndex = faceIndex;

		if (MOUSE_LEFT_BUTTON)
		{
			image_blend = make_color_rgb(_red, _green, _blue);
		}
		
		options[optionSelected] =  "FACE: " + string(faceIndex);
		break;
		
		
	case 1: //Hair
		hairIndex += _increment;
		
		if (hairIndex < 0)
		{
			hairIndex =  sprite_get_number(spr_dollHairs) - 1;	
		}
		
		if (hairIndex >= sprite_get_number(spr_dollHairs))
		{
			hairIndex = 0;
		}

		if (MOUSE_LEFT_BUTTON)
		{
			hairColor = make_color_rgb(_red, _green, _blue);
		}
	
		
		options[optionSelected] = "HAIR: " + string(hairIndex);
	break;
	
	
	case 2: //Shirt
		shirtIndex += _increment;
		
		if (shirtIndex < 0)
		{
			shirtIndex = sprite_get_number(spr_dollShirts) - 1;	
		}
		
		if (shirtIndex >= sprite_get_number(spr_dollShirts))
		{
			shirtIndex = 0;
		}
	
	
		if (MOUSE_LEFT_BUTTON)
		{
			shirtColor = make_color_rgb(_red, _green, _blue);
		}
		
		options[optionSelected] = 	"SHIRT: " + string(shirtIndex);
	break;
	
	case 3: //Pants.
	/* We only have one pair of pants right now. This can be uncommented when we get more.
		global.playerPantsIndex += _increment;
		
		if (global.playerPantsIndex < 0)
		{
			global.playerPantsIndex = global.pants - 1;	
		}
		
		if (global.playerPantsIndex >= array_length(global.pants))
		{
			global.playerPantsIndex = 0;
		}
		
		
		pants = global.pants[global.playerPantsIndex];
		options[optionSelected] = "PANTS: " + string(global.playerPantsIndex);
		*/
		if (MOUSE_LEFT_BUTTON)
		{
			pantsColor = make_color_rgb(_red, _green, _blue);
		}
	break;
	
	case 4: //Exit
		if (FACE_BUTTON_RELEASED)
		{
			
			//Creates a doll with the values from the character creation and then really quick serializes it.
			var _doll = instance_create_depth(x, y, depth, obj_doll);
			var _inventory = inventory_initialize();
			
			inventory_add(_inventory, new ITEM_AXE);
			
			with (_doll)
			{
				doll_initialize(PLAYER_STARTING_HP, PLAYER_STARTING_HP, PLAYER_STARTING_PP, PLAYER_STARTING_PP, factions.player, 
				other.faceIndex, other.hairIndex, other.shirtIndex, other.pantsIndex, other.image_blend, other.hairColor, other.shirtColor, other.pantsColor, _inventory);	
			}
			
			var _struct = serialize_instance_extended(_doll)
			
			ds_list_add(global.partySerialized, _struct);
			room_goto(ROOM_INTRO_SCREEN);
		}
	break;
}


//Debug Feature: Writes current Doll data to clipboard.
if (START_BUTTON)
{
	var _string =
	"var _faceIndex = " + string(faceIndex) + ";\n" + 
	"var _hairIndex = " + string(hairIndex) + ";\n" + 
	"var _shirtIndex = " + string(shirtIndex) + ";\n" + 
	"var _pantsIndex = " + string(pantsIndex) + ";\n" + 

	"var _skinColor = " + string(image_blend) + ";\n" + 
	"var _hairColor = " + string(hairColor) + ";\n" + 
	"var _shirtColor = " + string(shirtColor) + ";\n" + 
	"var _pantsColor = " + string(pantsColor) +  ";\n\n" + 
	"doll_initialize(5, 5, 3, 3, _faction, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor);";
	clipboard_set_text(_string);
}