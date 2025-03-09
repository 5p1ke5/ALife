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
			global.playerFaceIndex += _increment;
			
			if (global.playerFaceIndex < 0)
			{
				global.playerFaceIndex = sprite_get_number(spr_dollFaces) - 1;	
			}
			
			if (global.playerFaceIndex >= sprite_get_number(spr_dollFaces))
			{
				global.playerFaceIndex = 0;
			}
			
			faceIndex = global.playerFaceIndex;

			if (MOUSE_LEFT_BUTTON)
			{
				image_blend = make_color_rgb(_red, _green, _blue);
				global.playerSkinColor = image_blend;
			}
			
			options[optionSelected] =  "FACE: " + string(global.playerFaceIndex);
		break;
		
		case 1: //Hair
			global.playerHairIndex += _increment;
			
			if (global.playerHairIndex < 0)
			{
				global.playerHairIndex =  sprite_get_number(spr_dollHairs) - 1;	
			}
			
			if (global.playerHairIndex >= sprite_get_number(spr_dollHairs))
			{
				global.playerHairIndex = 0;
			}

			if (MOUSE_LEFT_BUTTON)
			{
				hairColor = make_color_rgb(_red, _green, _blue);
				global.playerHairColor = hairColor;
			}
			
			hairIndex = global.playerHairIndex;
			
			options[optionSelected] = "HAIR: " + string(global.playerHairIndex);
		break;
		
		case 2: //Shirt
			global.playerShirtIndex += _increment;
			
			if (global.playerShirtIndex < 0)
			{
				global.playerShirtIndex = sprite_get_number(spr_dollShirts) - 1;	
			}
			
			if (global.playerShirtIndex >= sprite_get_number(spr_dollShirts))
			{
				global.playerShirtIndex = 0;
			}
			
			shirtIndex = global.playerShirtIndex;

			if (MOUSE_LEFT_BUTTON)
			{
				shirtColor = make_color_rgb(_red, _green, _blue);
				global.playerShirtColor = shirtColor;
			}
			
			options[optionSelected] = 	"SHIRT: " + string(global.playerShirtIndex);
		break;
		
		case 3: //Pants.
		/*
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
				global.playerPantsColor = pantsColor;
			}
		break;
		
		case 4: //Exit
			if (FACE_BUTTON_RELEASED)
			{
				////Serialize the variables for the array.
				//var _struct = {
				//	maxHP : PLAYER_STARTING_HP,
				//	hp : maxHP,
				//	maxPP : PLAYER_STARTING_PP,
				//	pp : maxPP,
				//	faction : other.faction,
				//	faceIndex : other.faceIndex,
				//	hairIndex : other.hairIndex,
				//	shirtIndex : other.shirtIndex,
				//	pantsIndex : other.pantsIndex,
				//	hairColor : other.hairColor,
				//	shirtColor : other.shirtColor,
				//	pantsColor : other.pantsColor,
				//	skinColor : other.image_blend,
				//	inventory : ds_list_create(),
				//	inventoryIndex : other.inventoryIndex,
				//	ppRegen : other.ppRegen,
				//	name : "Player",
				//	text : "Hi, I'm the main character!",
				//	level : 100
				//	}
				
				var _doll = instance_create_depth(x, y, depth, obj_doll);
				with (_doll)
				{
					doll_initialize(PLAYER_STARTING_HP, PLAYER_STARTING_HP, PLAYER_STARTING_PP, PLAYER_STARTING_PP, factions.player, 
					other.faceIndex, other.hairIndex, other.shirtIndex, other.pantsIndex, other.image_blend, other.hairColor, other.shirtColor, other.pantsColor);	
				}
				
				var _struct = serialize_instance(_doll)
				
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