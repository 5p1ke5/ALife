#region //NPC functions.
/// @function npc_initialize(_name, _Text)
/// @description initializes NPC variables.
/// @param _name the name of the NPC. Will also be put in the text box.
/// @param _texts[] an array containing the text that will go in the NPC speech balloon.
/// @param _level How quickly the NPC reacts. Lower is stronger, with 0 being strongest. 100 is easy.
/// @param _npcState npcState struct. Should be initialzed with the NPCState constructor and the correct npcStates. Can also be an array of NPCStates.
function npc_initialize(_name, _texts, _level, _npcState)
{
	name = _name;
	texts = _texts;
	textIndex = 0; //Current indext in the text array.
	level = _level;

	//This will contain a reference to any dialogue balloon the NPC creates.
	//If it equals noone the NPC has no created dialogue balloons.
	myBalloon = noone;
	
	//What the NPC is trying to do. Think of it as what they have instead of controller input.
	//If its a struct makes it an array with just that struct. 
	if (is_struct(_npcState))
	{
		npcStates = array_create(1, _npcState)	
	}
	else //Otherwise assumes its an array and makes that array the npcStates array.
	{
		npcStates = _npcState;
	}
	
	//List of other npcs being sensed.
	senseList = ds_list_create();
	
	//List of enemies that have been sensed. If not empty is engaging enemies in combat.
	senseListEnemies =  ds_list_create();
	
	//When attack timer <0 the NPC can attack again.
	attackTimer = -1;
}

/// @function npc_behavior()
/// @description Changes NPC state based on the character being targetted. Returns the final state.
function npc_behavior()
{
	//Updates lists of sensed npcs.
	npc_sense_actors();
	
	//increment timers
	if (attackTimer > -1)
	{
		attackTimer--;
	}

	//If the NPC senses enemies they will be in a fighting state.
	//This can itself be overriden if the unit is in certain states.
	if (ds_list_size(senseListEnemies) > 0) 
	&&  (instanceof(npcStates[0]) != "NPCStateMove")
	{
		npc_fight(ds_list_find_value(senseListEnemies, 0));
	}
	else //Otherwise performs state action as ordered.
	{
		show_debug_message("States: {0}, current state: {1}", npcStates, instanceof(npcStates[0]));
		npcStates[0].Perform(id)	
	}
	
	//If right clicked opens dropdown for that NPC.
	if (position_meeting(mouse_x, mouse_y, id) && MOUSE_RIGHT_BUTTON_RELEASED_NOT_GUI)
	{
		npc_create_dropdown();
	}
}

///@function npc_create_dropdown()
///@description Destroys all other dropdowns, then creates a dropdown at the mouse position. Returns the created dropdown.
function npc_create_dropdown()
{
	//Destroys all currently existing dropdowns.
	instance_destroy(obj_dropdown);
	
	var _buttons = array_create(0);
	array_push(_buttons, obj_buttonTalk);
	
	//If the npc is not in the player's party but is in the player's faction, they can be recruited.
	if (ds_list_find_index(global.party, id) == -1)
	{
		if (faction == factions.player)
		{
			array_push(_buttons, obj_buttonRecruit);
		}
	}
	//If they are in the player's faction they can be dismissed.
	else
	{
		if (instanceof(npcStates[0]) == "NPCStateFollow")
		{
			array_push(_buttons, obj_buttonMove);
			array_push(_buttons, obj_buttonAttack);
		}
		else
		{
			array_push(_buttons, obj_buttonFollow);	
		}
		
		array_push(_buttons, obj_buttonDismiss);
	}
	
	var _dropdown = gui_dropdown_create(mouse_x, mouse_y, depth - 5, _buttons, self);
	return _dropdown;
}

/// @function npc_sense_actors()
/// @description Gets a list of all objects within range of the NPC, adds them to senseList and senseListEnemies.
function npc_sense_actors()
{
	//Resets lists
	senseList = ds_list_create();
	senseListEnemies =  ds_list_create();
	
	//Adds sensed NPCs to the list
	var _npcsFound = collision_circle_list(x, y, CLOSE_RANGE, abs_doll, false, true, senseList, true);
	
	//Add sensed enemies to the list of sensed enemies.
	for (var _i = 0; _i < _npcsFound; _i++)
	{
		var _npc = ds_list_find_value(senseList, _i);
		
		//enemyFaction vs playerFaction and neutral faction.
		if (faction != factions.enemy) //If the calling npc is an enemy.
		{
			if (_npc.faction == factions.enemy)
			{
				ds_list_add(senseListEnemies, _npc);
			}
		}
		else //If the calling npc is a player or neutral.
		{
			if (_npc.faction == factions.player) || (_npc.faction == factions.neutral)
			{
				ds_list_add(senseListEnemies, _npc);
			}
		}
	}
}



/// @function npc_speak()
/// @description Checks if a speechballoon can be generated and if so generates a speech ballon. Returns the current textIndex
function npc_speak()
{	
	if (instance_exists(myBalloon))
	{
		return textIndex;
	}
	
	var _text = texts[textIndex];
	
	//Increments textIndex and wraps around if necessary.
	textIndex++;
	if (textIndex > array_length(texts) - 1)
	{
		textIndex = 0;	
	}
	
	//Creates speech balloon object.
	var _name = name;
	
	draw_set_font(fnt_speech);
	var _balloonHeight = string_height_ext(_text, string_height(_text), TEXT_BALLOON_MAXW);
	draw_set_font(fnt_default);
	
	var _balloon = instance_create_depth(x, y - 32 - _balloonHeight, depth, obj_speechBalloon);
	with (_balloon)
	{
		speechBalloon_initialize(_text, string_length(_text) * TEXT_BALLOON_SPEED, other, _name);
	}
	
	myBalloon = _balloon;
	
	return textIndex;
}


/// @function npc_speak_ext(_texts, _textIndex)
/// @description Checks if a speechballoon can be generated and if so generates a speech ballon. This one you can pass an array of texts and an index. Returns the current textIndex.
/// @param _texts An array of strings to be read into the players speach.
/// @param _textIndex the index in the text array to display.
function npc_speak_ext(_texts, _textIndex)
{
	if (instance_exists(myBalloon))
	{
		return _textIndex;
	}
	
	var _text = _texts[_textIndex];
	
	//Increments textIndex and wraps around if necessary.
	_textIndex++;
	if (_textIndex > array_length(_texts) - 1)
	{
		_textIndex = 0;	
	}
	
	//Creates speech balloon object.
	var _name = name;
	
	draw_set_font(fnt_speech);
	var _balloonHeight = string_height_ext(_text, string_height(_text), TEXT_BALLOON_MAXW);
	draw_set_font(fnt_default);
	
	var _balloon = instance_create_depth(x, y - 32 - _balloonHeight, depth, obj_speechBalloon);
	with (_balloon)
	{
		speechBalloon_initialize(_text, string_length(_text) * TEXT_BALLOON_SPEED, other, _name);
	}
	
	myBalloon = _balloon;
	
	return _textIndex;
}


/// @function npc_move_to(_target)
/// @description makes the npc move towards a target (Can be an instance or a Point2)
/// @param _target Instance or Point2 or anything with a .x and .y value to move towards.
function npc_move_to(_target)
{
	var _hDir = 0;
	var _vDir = 0;
			
			
	//Todo: Make this so NPCs actually figure out the angle to their target instead of like 8 possible directions
	if (distance_to_point(_target.x, _target.y) > CLOSE_RANGE/2)
	{
		//_hDir = sign(_target.x - x);
		//_vDir = sign(_target.y - y);
		var _angle = point_direction(x, y, _target.x, _target.y);
		
		_hDir = lengthdir_x(1, _angle)
		_vDir = lengthdir_y(1, _angle)
		
		//show_debug_message("{0} - hDir {1} - vDir {2} - angle {3}", name, _hDir, _vDir, _angle);
	}
			
	doll_movement(_hDir, _vDir);
}


/// @function npc_fight(_target)
/// @description NPC behavior when they're targetting an enemy. Causes them to pursue and cast spells at the target.
/// @param _target The target the npc is attacking.
function npc_fight(_target)
{
		//If has items in inventory sends the selected item to the state machine to decide behavior from there.
		if (ds_list_size(inventory) > 0)
		{
			var _item = inventory[|inventoryIndex];
			npc_fight_itemUse(_item, _target)
		}
		
		//If unarmed runs away.
		else
		{
			doll_movement( sign(_target.x - x), -sign(_target.y - y));
		}
}

/// @function npc_fight_itemUse(_item, _target)
/// @description Decides how to behave in a fight based on passed item.
/// @param _item Item currently selected at intentoryIndex.
/// @param _target Instance being attacked.
function npc_fight_itemUse(_item, _target)
{
	var _ai = _item.GetAI();
	var _dist = point_distance(x, y, _target.x, _target.y);
	
	//Does different things depending on item type.
	switch (_ai) 
	{
	    case aiType.melee: 
			//Approaches
			var _range = (sprite_get_bbox_right(_item.sprite) - sprite_get_bbox_left(_item.sprite)) * 2;
			
			if (_dist > _range) 
			{
				doll_movement(sign(_target.x - x), sign(_target.y - y));
			}
			//Attacks if in range.
			else if (!instance_exists(myHeld)) 
			{
				if (attackTimer < 0)
				{
					angle = point_direction(x, y, _target.x, _target.y);
					
					_item.Use(id);
					
					attackTimer = (_item.arc / _item.spd) + irandom_range( round(sqrt(level)), level);
				}
			}
	        break;
			
		case aiType.ranged:
		
			break;
			
	    default: //Tries to run away.
				doll_movement(-sign(_target.x - x), -sign(_target.y - y));
	        break;
	}
}



///@function npc_exit_state()
///@description Attempts to exit the npc's current state. Can only exit state if npcStates array has more than 1 item.
///@returns The next state in the array or noone if there is only 1 item in the array.
function npc_exit_state()
{
	//State can only be exited if the number of items in npcState is greater than 1.
	if (array_length(npcStates) > 1)
	{
		array_shift(npcStates); //If so, deletes the current state from the npcStates arra
		show_debug_message("Exit State, states: {0}.", npcStates);
		return npcStates[0];
	}
	
	return noone;
}

/// @function npc_name_random()
/// @description returns a randomly generated name.
function npc_name_random()
{
	return global.names[irandom(array_length(global.names) - 1)];
}

#endregion



#region //NPCState structs.

///@function NPCState() constructor
///@description struct that describes the current state of the NPC associated with it. Children define specific states below.
function NPCState() constructor
{
	
	//Performs whatever action the state is associated with. Should usually be overwritten.
	static Perform = function(_user)
	{
		print("Called!");
	}
}

///@function NPCStateFollow(_target): NPCState() constructor
///@description state for when NPC is following an object (usually another doll.) No exit condition.
///@param _target reference ot an object to follow.
function NPCStateFollow(_target): NPCState() constructor
{
	target = _target;
	static Perform = function(_user)
	{
		//Creates a temporary variable holding the target from this struct so it can be used by the user.
		var _target = target;
		with (_user)
		{
			npc_move_to(_target);
		}
	}
}

///@function NPCStateIdle(): NPCState() constructor
///@description state for when NPC is idle. Just makes them sort of mill about. No exit condition.
function NPCStateIdle(): NPCState() constructor
{
	//How long the NPC waits between switching between standing still and moving around.
	passiveTimer = -1;
	
	//Directions the state is telling the NPC to move to. If both are 0 just doesn't move.
	stateHDir = 0;
	stateVDir = 0;
	
	static Perform = function(_user)
	{
		//Increments timer, makes doll move in chosen direction.
		if (passiveTimer > -1)
		{
			passiveTimer--;
			
			var _hDir = stateHDir;
			var _vDir = stateVDir;
			with (_user)
			{
				doll_movement(_hDir, _vDir);
			}
		}
		else
		{
			//Reset timer.
			passiveTimer = PASSIVE_TIME;
			
			//Either picks a new direction to move in or stays still till timer goes off next.
			var _move = choose(true, false);
			if (_move)
			{
				stateHDir = irandom_range(-1, 1);
				stateVDir = irandom_range(-1, 1);
			}
			else
			{
				stateHDir = 0;
				stateVDir = 0;
			}
		}
	}
}

///@function NPCStateMove(_target): NPCState() constructor
///@description state for when NPC is moving towards a given point. Once the NPC gets there they just wait so this can also be used to make an NPC wait at a given point. If the NPC has more than one item in npcStates exits upon reaching the point.
///@param _target Point2 for the target to move towards.
///@param _duration Time for the NPC to wait at the given point.
function NPCStateMove(_target, _duration = -1): NPCState() constructor
{
	target = _target;
	duration = _duration;
	maxDuration = duration;
	static Perform = function(_user)
	{
		var _target = target;
		var _duration = duration;
		var _maxDuration = maxDuration;
		with (_user)
		{
			//Moves towards target point until right at it.
			npc_move_to(_target);
			
			//If NPC gets to their location waits for duration (if any) and then attempt to exit state.
			if (distance_to_point(_target.x, _target.y) < CLOSE_RANGE)
			{
				if (_duration > -1)
				{
					_duration--;	
				}
				else
				{
					npc_exit_state();
				}
			}
		}
		
		duration = _duration;
	}
}

///@function NPCStateTalkTo(_target, _dialogue = noone): NPCState() constructor
///@description Goes to a location or towards a target while talking.
///@param _target a Point2 or an Instance to go towards while talking.
///@param [_dialogue] the things the NPC will say. If left blank will just use the NPC's own dialogue.
function NPCStateTalkTo(_target, _dialogue = noone): NPCState() constructor
{
	target = _target;
	dialogue = _dialogue;
	textIndex = 0;
	static Perform = function(_user)
	{
		//Get variables from state for use in the NPC.
		var _dialogue = dialogue;
		var _textIndex = textIndex;
		
		
		//Moves towards target point until right at it.
		var _target = target;
		with (_user)
		{
			npc_move_to(_target);
			
			//If an array was passed reads through that
			if (_dialogue != noone)
			{
				_textIndex = npc_speak_ext(_dialogue, _textIndex);
			}
			else //Otherwise uses the npc's current dialogue.
			{
				npc_speak();
			}
			
			
			//If textIndex == 0 that means the NPC is done with their dialogue.
			if (_dialogue == noone && textIndex == 0) || (_dialogue != noone && _textIndex == 0)
			{
				npc_exit_state();	
			}
		}
		
		//Sets the NPCStateTalkTo's textIndex to equal the updated value. If the value wasn't updated it just stays the same.
		textIndex = _textIndex;
	}
}



/// @function NPCStateSetDialogue(_dialogue) : NPCStateIdle() constructor
/// @description Sets the NPC's current texts array and resets the textIndex. Attempts to exit state. Should usually have another state right after.
function NPCStateSetDialogue(_dialogue) : NPCStateIdle() constructor
{
	dialogue = _dialogue;
	
	static Perform = function(_user)
	{
		var _dialogue = dialogue;
		
		with (_user)
		{
			//Sets dialogue to the passed value, resets text index.
			texts = _dialogue;
			textIndex = 0;
			
			//Attemps to exit state.
			npc_exit_state();
		}
	}
}


///@function NPCStateLoop(_states): NPCState() constructor
///@description replaces the executing NPC's npcStates array with the passed _states array, then appends a copy of this state to the end. This causes the NPC to loop the passed _states array.
///@param _states the new states array that will be looped through.
function NPCStateLoop(_states): NPCState() constructor
{
	
	//serializes the passed array into a serializedStates array. 
	states = [];
	for (var _i = 0; _i < array_length(_states); _i++)
	{
		array_push(states, variable_clone(_states[_i]))
	}
	
	//Replaces the _user's states array with the NPCStateLoop's own, appends a copy of this struct to the end.
	static Perform = function(_user)
	{
		var _states = states;
		
		array_push(_states, new NPCStateLoop(_states)); //Appends of a copy of this data structure to the end, causing it to loop.
		
		
		with (_user)
		{
			npcStates = [];
			npcStates = _states;
		
		}
	}
}


/// @function NPCStateAwaitTarget(_target) : NPCState() constructor
/// @description Has the NPC stand still until a target gets close enough, then attempts to exit state.
/// @param _target An instance or point2 or something with x and y. 
/// @param _range How close the NPC has to be to _target to go to the next state.
function NPCStateAwaitTarget(_target, _range = CLOSE_RANGE) : NPCState() constructor
{
	target = _target;
	range = _range;
	
	static Perform = function(_user)
	{
		var _target = target;
		var _range = range;
		
		with (_user)
		{
			//If the target gets close enough attempts to go to next state.
			if (distance_to_point(_target.x, _target.y) < _range)
			{
				npc_exit_state();
			}
		}
	}
}

#endregion



/// @function speechBalloon_initialize(_text, _time, _owner, _name) 
/// @description Creates a specch balloon object.
/// @param _text The text that will be displayed.
/// @param _time The amount of time for which the balloon will exist.
/// @param _owner The instance that created this object.
/// @param _name The name of the npc that created this balloon.
function speechBalloon_initialize(_text, _maxTime, _owner, _name) 
{
	text = _text;
	maxTime = _maxTime;
	time = maxTime;
	owner = _owner;
	name = _name;
}

