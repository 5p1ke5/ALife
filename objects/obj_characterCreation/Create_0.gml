/// @description Initializes default doll.

	
//Player appearance variables.
//faceIndex = 0;
//hairIndex = 0;
//shirtIndex = 0;
//pantsIndex = 0;
	
//image_blend = c_hispanic1;
//hairColor = c_brunette;
//shirtColor = c_red;
//pantsColor = c_blue;

doll_initialize(4, 4, 5, 5, factions.player, 0, 0, 0, 0, c_hispanic1, c_brunette, c_red, c_blue);
	
	
var _array;
_array[0] = "FACE: " + string(faceIndex);
_array[1] = "HAIR: " + string(hairIndex);
_array[2] = "SHIRT: " + string(shirtIndex);
_array[3] = "PANTS: " + string(pantsIndex);
_array[4] = "START GAME";
	
menu_create(_array);


//Sliders.
sliderRed = instance_find(obj_colorSliderRed, 0);
sliderGreen = instance_find(obj_colorSliderGreen, 0);
sliderBlue = instance_find(obj_colorSliderBlue, 0);