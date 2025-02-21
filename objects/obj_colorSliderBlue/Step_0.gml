/// @description Makes color change when you change option.

// Inherit the parent event
event_inherited();

if (UP_BUTTON_RELEASED) || (DOWN_BUTTON_RELEASED)
{
	optionSelected = owner.optionSelected;
	switch (optionSelected)
	{
		case 0: //Skin
			val = color_get_blue(global.playerSkinColor);
		break;
		case 1: //Hair
			val = color_get_blue(global.playerHairColor);
		break;
		case 2: //Shirt
			val = color_get_blue(global.playerShirtColor);
		break;
		case 3: //Pants
			val = color_get_blue(global.playerPantsColor);
		break;
		default: 
		break;
		
	}
}
