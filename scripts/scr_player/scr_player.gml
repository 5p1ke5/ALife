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
	
	
	///Code for commanding party units.
	//Allows you to perform commands using hotkeys.
	if (keyboard_check(ord("1")))
	{
		global.cursorState = cursor.normal;
		cursor_sprite = global.cursors[global.cursorState];
	}

	if (keyboard_check(ord("2")))
	{
		global.cursorState = cursor.select;
		cursor_sprite = global.cursors[global.cursorState];
	}

	if (keyboard_check(ord("3")))
	{
		global.cursorState = cursor.follow;
		cursor_sprite = global.cursors[global.cursorState];
	}

	if (keyboard_check(ord("4")))
	{
		global.cursorState = cursor.attack;
		cursor_sprite = global.cursors[global.cursorState];
	}

	if (keyboard_check(ord("5")))
	{
		global.cursorState = cursor.move;
		cursor_sprite = global.cursors[global.cursorState];
	}
	
	
	if (MOUSE_LEFT_BUTTON_RELEASED_NOT_GUI)
	{
		var _list = ds_list_create();
		collision_point_list(mouse_x, mouse_y, DOLL, false, true, _list, true);

		switch (global.cursorState)
		{
			case cursor.normal:
	
			break;
	
			case cursor.select:
				for (var _i = 0; _i < ds_list_size(_list); _i++)
				{
					var _npc = ds_list_find_value(_list, _i);
			
					//If it's a member of the party can select and deselect.
					var _indexA = ds_list_find_index(global.party, _npc)
			
					if (_indexA != -1)
					{
						//If not part of selection selects; if not deselects.
						var _indexB = ds_list_find_index(global.selected, _npc);
						if (_indexB == -1)
						{
							//Adds to list
							ds_list_add(global.selected, _npc);
							break;
						}
				
						//removes from list. Either way breaks.
						ds_list_delete(global.selected, _indexB);
						break;
					}
				}
			break;
	
			case cursor.follow:
				//Check if mouse is an NPC and if so adds them to the party list and makes them follow the player..
				for (var _i = 0; _i < ds_list_size(_list); _i++)
				{
					var _npc = ds_list_find_value(_list, _i);
			
					if (_npc.faction == factions.player)
					{
						var _playerID = id;
						with (_npc)
						{
							_newState = new NPCStateFollow(_playerID);
				
							state = _newState;
						}
				
						if (ds_list_find_index(global.party, _npc) == -1)
						{
							ds_list_add(global.party, _npc)
						}
				
						if (ds_list_find_index(global.selected, _npc) == -1)
						{
							ds_list_add(global.selected, _npc)
						} 
						break;
					}
				}
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
				//Order all selected NPCs to move.
				var _point = new Point2(mouse_x, mouse_y);
				var _newState = new NPCStateMove(_point);
		
				print(string(_point));
				for (var _i = 0; _i < ds_list_size(global.selected); _i++)
				{
					var _npc = ds_list_find_value(global.selected, _i);
			
					with (_npc)
					{
						state = _newState;
						print(string(state));
					}
			
				}
		
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
