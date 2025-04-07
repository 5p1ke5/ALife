/// @function player_control()
/// @description uses keyboard input to control a doll designated as the player character.
function player_control()
{ //TODO: Consider moving input macros like RIGHT_BUTTON into params (eg player_control(MOUSE_RIGHT_BUTTON)) but might be too big and arbitrary of a list so maybe keep it no params.
	
	
	///Code for using items with mouse button and movement via arrow keys.
	
	//Mouse button stuff (using inventory items basically)
	
	//If the player is not holding an item, allows them to use one.
	if (!instance_exists(myHeld)) && (global.cursorState == cursor.normal)
	{
		//Resets angle. If it needs to be used its reset every step.
		angle = -1;

		//Use item. Call's the item's Use method.
		if (MOUSE_LEFT_BUTTON_PRESSED_NOT_GUI)
		{
			angle = point_direction(x, y, mouse_x, mouse_y);
	
			if (ds_list_size(inventory) > 0)
			{
				var _item = inventory[|inventoryIndex];
				_item.Use(id);
			}
		}
	
		//Alt use of item. Call's item's AltUse method.
		else if (MOUSE_RIGHT_BUTTON_NOT_GUI)
		{
			angle = point_direction(x, y, mouse_x, mouse_y);
		
			if (ds_list_size(inventory) > 0)
			{
				var _item = inventory[|inventoryIndex];
				_item.AltUse(id);
			}
		}
	}

	//Lets player use inventory items
	inventoryIndex += (MOUSE_WHEEL_UP - MOUSE_WHEEL_DOWN)

	//Changing inventory dispels held item.
	if (MOUSE_WHEEL_UP - MOUSE_WHEEL_DOWN != 0)
	{
		instance_destroy(myHeld);
		myHeld = noone;
	}

	//Sets index.
	if (inventoryIndex >= ds_list_size(inventory))
	{
		inventoryIndex = 0;
	}
	if (inventoryIndex < 0)
	{
		inventoryIndex = ds_list_size(inventory) - 1;
	}
	
	
	///Movement via keyboard.
	
	//Can't move if the instance is holding a melee attack object (might change to an abstract object that locks movement or maybe adding a variable to object that can be held.
	if !(instance_exists(myHeld) && myHeld.object_index == obj_meleeSwing)
	{
		doll_movement( RIGHT_BUTTON - LEFT_BUTTON, DOWN_BUTTON - UP_BUTTON);
	}
	
	

	//Cancels out of cursor, untargets.	
	if (MOUSE_RIGHT_BUTTON)
	{
		global.selectedUnit = noone;
		cursor_state_set(cursor.normal);
	}

	if (keyboard_check(ord("4")))
	{
		global.cursorState = cursor.attack;
		cursor_sprite = global.cursors[global.cursorState];
	}
	
	
	///TODO: Maybe move this to a function?
	if (MOUSE_LEFT_BUTTON_RELEASED_NOT_GUI)
	{
		var _list = ds_list_create();
		collision_point_list(mouse_x, mouse_y, DOLL, false, true, _list, true);

		switch (global.cursorState)
		{
			case cursor.normal:
	
			break;
	
			case cursor.attack:
				//Order all selected npcs to attack
				//for testing purposes i'm making it so it swaps control to first npc in list.
				if (ds_list_size(_list) != 0)
				{
					global.player = ds_list_find_value(_list, 0);
				}
			break;
	
			case cursor.move:
				//Order currently selected NPCs to move.
				var _point = new Point2(mouse_x, mouse_y);
				var _newState = new NPCStateMove(_point);
			
				with (global.selectedUnit)
				{
					array_insert(npcStates, 0, _newState);
				}
				
				global.selectedUnit = noone;
				cursor_state_set(cursor.normal);
			break;
		}
	}
}

function player_draw_gui()
{
	draw_set_halign(fa_left);

	draw_text(5, 5, "HP: " + string(hp) + "/" + string(maxHP));
	draw_text(5, 20, "PP: " + string(pp)+ "/" + string(maxPP));

	if (ds_list_size(inventory) > 0)
	{
		var _item = inventory[|inventoryIndex];
		draw_text(5, 35, "Item: " + _item.itemName);	
	}

	for (var _i = 0; _i < ds_list_size(global.party); _i++)
	{
		var _partyMember = ds_list_find_value(global.party, _i)
	
		//If one of the selected party members draws the text in yellow. Otherwise black.
		if (ds_list_find_index(global.selected, _partyMember) != -1)
		{
			var _color = c_yellow;
		}
		else
		{
			var _color = c_black;
		}
	
		if (instance_exists(_partyMember))
		{
			draw_text_color(0, window_get_height() - ((1 + _i) * 20) - 20, _partyMember.name, _color, _color, _color, _color, 1);	
		}
	}
}
