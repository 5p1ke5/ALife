#region //NPC functions.

/// @function npc_initialize(_name, _texts, _level, _npcCommands)
/// @description initializes NPC variables.
/// @param _name the name of the NPC. Will also be put in the text box.
/// @param _texts[] an array containing the text that will go in the NPC speech balloon.
/// @param _level How quickly the NPC reacts. Lower is stronger, with 0 being strongest. 100 is easy.
/// @param _npcCommands npcState struct. Should be initialzed with the NPCCommand constructor and the correct npcCommands. Can also be an array of NPCCommands.
function npc_initialize(_name, _texts, _level, _npcCommands)
{
	name = _name;
	texts = _texts;
	textIndex = 0; //Current indext in the text array.
	level = _level;

	//This will contain a reference to any dialogue balloon the NPC creates. If it equals noone the NPC has no created dialogue balloons.
	myBalloon = noone;
	
	//What the NPC is trying to do. Think of it as what they have instead of controller input. 
	if (is_struct(_npcCommands)) //If its a struct makes it an array with just that struct. 
	{
		npcCommands = array_create(1, _npcCommands)	
	}
	else //Otherwise assumes its an array and makes that array the npcCommands array.
	{
		npcCommands = _npcCommands;
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

	//If the NPC senses enemies they will be in a fighting state. This can itself be overriden if the unit is in certain states.
	if (ds_list_size(senseListEnemies) > 0) && (instanceof(array_first(npcCommands)) != "NPCCommandMove")
	{
		npc_fight(ds_list_find_value(senseListEnemies, 0));
	}
	else //Otherwise performs state action as ordered.
	{
		npcCommands[0].Perform(id)	
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
		if (instanceof(npcCommands[0]) == "NPCCommandFollow")
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
/// @param _range How close the npc has to move to the target. Defaults to CLOSE_RANGE/2 (25 px)
function npc_move_to(_target, _range = CLOSE_RANGE/2)
{
	var _hDir = 0;
	var _vDir = 0;
			
	if (distance_to_point(_target.x, _target.y) > _range)
	{
		var _angle = point_direction(x, y, _target.x, _target.y);
		
		_hDir = lengthdir_x(2, _angle)
		_vDir = lengthdir_y(2, _angle)
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



///@function npc_exit_command()
///@description Attempts to exit the npc's current command. Can only exit command if npcCommands array has more than 1 item. Needs to be called from within an NPC instance.
///@returns The next command in the array or noone if there is only 1 item in the array.
function npc_exit_command()
{
	//State can only be exited if the number of items in npcState is greater than 1.
	if (array_length(npcCommands) > 1)
	{
		array_shift(npcCommands); //If so, deletes the current state from the npcCommands array
		return npcCommands[0];
	}
	
	return noone;
}

/// @function npc_name_random()
/// @description returns a randomly generated name.
function npc_name_random()
{
	return global.names[irandom(array_length(global.names) - 1)];
}

/// @function npc_check_target(_target)
/// @description check if the target exists as either a struct or instance. Returns true or false.
/// @param the target to be checked.
function npc_check_target(_target)
{
	return (instance_exists(_target) || instanceof(_target) != undefined)
}
#endregion



#region //NPCCommand structs.

///@function NPCCommand() constructor
///@description struct that describes the current state of the NPC associated with it. Children define specific states below.
function NPCCommand() constructor
{
	
	//Performs whatever action the state is associated with. Should usually be overwritten.
	static Perform = function(_user)
	{
		print("Called!");
	}
}

///@function NPCCommandFollow(_target): NPCCommand() constructor
///@description state for when NPC is following an object (usually another doll.) No exit condition.
///@param _target reference ot an object to follow.
function NPCCommandFollow(_target): NPCCommand() constructor
{
	target = _target;
	static Perform = function(_user)
	{

		//If target no longer exists attempts to exit state.
		if !(npc_check_target(target))
		{
			with (_user)
			{
				npc_exit_command();
				return;
			}
		}
		
		//Creates a temporary variable holding the target from this struct so it can be used by the user.
		var _target = target;
		with (_user)
		{
			npc_move_to(_target);
		}
	}
}

///@function NPCCommandIdle(): NPCCommand() constructor
///@description state for when NPC is idle. Just makes them sort of mill about. No exit condition.
function NPCCommandIdle(): NPCCommand() constructor
{
	//How long the NPC waits between switching between standing still and moving around.
	passiveTimer = -1;
	
	//Directions the state is telling the NPC to move to. If both are 0 just doesn't move.
	commandHDir = 0;
	commandVDir = 0;
	
	static Perform = function(_user)
	{
		//Increments timer, makes doll move in chosen direction.
		if (passiveTimer > -1)
		{
			passiveTimer--;
			
			var _hDir = commandHDir;
			var _vDir = commandVDir;
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
				commandHDir = irandom_range(-1, 1);
				commandVDir = irandom_range(-1, 1);
			}
			else
			{
				commandHDir = 0;
				commandVDir = 0;
			}
		}
	}
}


///@function NPCCommandMove(_target, _duration)
///@description state for when NPC is moving towards a given point. Once the NPC gets there they just wait so this can also be used to make an NPC wait at a given point. If the NPC has more than one item in npcCommands exits upon reaching the point.
///@param _target Point2 for the target to move towards.
///@param _duration Time for the NPC to wait at the given point.
function NPCCommandMove(_target, _duration = -1): NPCCommand() constructor
{
	target = _target;
	duration = _duration;
	
	static Perform = function(_user)
	{
		//If target no longer exists attempts to exit state.
		if !(npc_check_target(target))
		{
			with (_user)
			{
				npc_exit_command();
				return;
			}
		}
		
		var _target = target;
		var _duration = duration;
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
					npc_exit_command();
				}
			}
		}
		
		duration = _duration;
	}
}



///@function NPCCommandMovePath(_target, _duration = -1): NPCCommand() constructor
///@description state for when NPC is moving towards a given point. This version uses motion planning and paths.
///@param _target Point2 for the target to move towards.
///@param _duration Time for the NPC to wait at the given point.
function NPCCommandMovePath(_target, _duration = -1): NPCCommand() constructor
{
	target = _target;
	duration = _duration;
	
	//These will be defined the first time Perform runs.
	mpPath = path_add();
	motionPathed = false;
	path = array_create(0);
	
	//show_debug_message(string("{0}, {1}", other.x, other.y))
	static Perform = function(_user)
	{
		//If target no longer exists attempts to exit state.
		if !(npc_check_target(target))
		{
			with (_user)
			{
				npc_exit_command();
				return;
			}
		}
		
		var _target = target;
		var _duration = duration;
		
		//Initializes motionPath if necessary. 
		if (path_get_number(mpPath) == 0)
		{
			motionPathed = mp_grid_path(global.mpGrid, mpPath, _user.x, _user.y, _target.x, _target.y, true);
			
			//Pushes mpPath coordinates to array 'path' as Point2s
			for (var _i = 0; _i < path_get_number(mpPath) ; _i++) 
			{
				array_push(path, new Point2(path_get_point_x(mpPath, _i), path_get_point_y(mpPath, _i)));	
			}
		}
		
		//Is this passed by reference? Double check I might not need this
		var _path = path;
		
		with (_user)
		{
			
			//If the array has elements the unit is still navigating the given path.
			if (array_length(_path) > 0)
			{
				//Moves towards each point until right at it, then removes it from the array.
				var _point = array_first(_path);
				npc_move_to(_point, 0);
			
				if (distance_to_point(_point.x, _point.y) <= 2)
				{
					array_shift(_path);
				}
			
			}
			else //Otherwise the instance is at the goal and attempts to exit state. Waits there until it can.
			{
				npc_move_to(_target, 0);
				if (_duration > -1)
				{
					_duration--;	
				}
				else
				{
					npc_exit_command();
				}
			}
		}
		
		duration = _duration;
	}
}

/// @function NPCCommandCheckGlobalVar(_globalVarName, _npcCommand1, _npcCommand2, _checkVal = true, _comparison = compare.equals)
/// @description Takes _globalVarName as the string of a variable name and checks it. If true, inserts NPCCommand1 next in npcCommands (Position 1), if false inserts NPCCommand2. Then exits state.
/// @param _globalVarName the string version of a variable.
/// @param _NPCCommand1 the NPCCommand that gets inserted at index 1 if the comparison returns true.
/// @param _NPCCommand2 the NPCCommand that gets inserted at index 1 if the comparison returns false.
/// @param _checkVal The value to be checked against. Defaults to 'true' so if not filled in it just treates _globalVarName as a boolean.
/// @oaram _comparison The comparison sign (<, >, =) to use. Wants an enum. Defaults to equals.
function NPCCommandCheckGlobalVar(_globalVarName, _npcCommand1, _npcCommand2, _checkVal = true, _comparison = compare.equals): NPCCommand() constructor
{
	globalVarName = _globalVarName;
	npcCommand1 = _npcCommand1;
	npcCommand2 = _npcCommand2;
	checkVal = _checkVal;
	comparison = _comparison;
	
	static Perform = function(_user)
	{
		//Gets the value using the string name.
		var _value = variable_global_get(globalVarName);
		
		//Checks the compare value, defaults to ==
		switch (comparison) 
		{
			case compare.greaterThan:
			    var _check = (_value > checkVal);
		        break;
		    case compare.lessThan:
		        var _check = (_value < checkVal);
		        break;
		    case compare.greaterThanOrEqual:
		        var _check = (_value >= checkVal);
		        break;
		    case compare.lessThanOrEqual:
		        var _check = (_value <= checkVal);
		        break;
		    default: // ==
		        var _check = (_value == checkVal);
		        break;
		}
		
		var _command = _check ? npcCommand1 : npcCommand2;
		
		with (_user)
		{
			array_insert(npcCommands, 1, _command);	
			npc_exit_command();
		}
	}
}



/// @function NPCCommandSetGlobalVar(_globalVarName, _value)
/// @description Sets the given global variable and then attempts to exit.
/// @param _globalVarName A string containing the name of the global variable to be set.
/// @param _value The value to set the global variable to.
function NPCCommandSetGlobalVar(_globalVarName, _value): NPCCommand() constructor
{
	globalVarName = _globalVarName;
	value = _value;
	
	executed = false; //This will be set to true after the variable has been set so it doesn't get reset if the command can't be exited.
	
	static Perform = function(_user)
	{
		//Sets the variable as directed, then attempts to exit state.
		if !(executed)
		{
			variable_global_set(globalVarName, value);
			executed = true;
		}
		
		with (_user)
		{
			npc_exit_command();
		}
	}
}



/// @function NPCCommandCheckInstanceVar(_instance, _instanceVarName, _value = true, _compare = compare.equals)
/// @description Checks the value of an instance's instance variable, 
/// @param _instance The instance containing the variable to check. If no variable is passed just treats it as a boolean. If the instance can't be found defaults to _NPCCommand2. Checks like "_instanceVarName <_comparison> _checkVal"
/// @param _instanceVarName A string containing the name of the instance variable to check.
/// @param _NPCCommand1 the NPCCommand that gets inserted at index 1 if the comparison returns true.
/// @param _NPCCommand2 the NPCCommand that gets inserted at index 1 if the comparison returns false.
/// @param _checkVal The value to check the instance variable against.
/// @oaram _comparison The comparison sign (<, >, =) to use. Wants an enum. Defaults to equals.
function NPCCommandCheckInstanceVar(_instance, _instanceVarName, _npcCommand1, _npcCommand2, _checkVal = true, _comparison = compare.equals): NPCCommand() constructor
{
	instance = _instance;
	instanceVarName = _instanceVarName;	
	npcCommand1 = _npcCommand1;
	npcCommand2 = _npcCommand2;
	checkVal = _checkVal;
	comparison = _comparison
	
	static Perform = function (_user)
	{	
		if (instance_exists(instance))
		{
			//Gets the value using the string name.
			var _value = variable_instance_get(instance, instanceVarName);
			
			//Checks the compare value, defaults to equal.
			switch (comparison) 
			{
			    case compare.greaterThan:
			        var _check = (_value > checkVal);
			        break;
			    case compare.lessThan:
			        var _check = (_value < checkVal);
			        break;
			    case compare.greaterThanOrEqual:
			        var _check = (_value >= checkVal);
			        break;
			    case compare.lessThanOrEqual:
			        var _check = (_value <= checkVal);
			        break;
			    default: // ==
			        var _check = (_value == checkVal);
			        break;
			}
			var _command = _check ? npcCommand1 : npcCommand2;
		}
		
		
		//Inserts the new commands in the array.
		with (_user)
		{
			array_insert(npcCommands, 1, _command);	
			npc_exit_command();
		}
	}
}



///@function NPCCommandSetInstanceVar(_instance, _instanceVarName, _value)
///@description Attempts to set a variable on an instance to the given value.
/// @param _instance The instance containing the variable to be set.
/// @param _instanceVarName A string containing the name of the instance variable to be set.
/// @param _value The value to set the instance variable to.
function NPCCommandSetInstanceVar(_instance, _instanceVarName, _value): NPCCommand() constructor
{
	instance = _instance;
	instanceVarName = _instanceVarName;
	value = _value;
	
	//We only want to execute perform once so once Perform is used this is set to true and then it won't try to set the variable again.
	executed = false;
	
	static Perform = function(_user)
	{
		if !(executed)
		{
			//Checks if the instance exists. If so changes the variable
			if (instance_exists(instance))
			{
				variable_instance_set(instance, instanceVarName, value);	
			} //If not, does nothing and tries to exit state.
			
			executed = true;
		}
		
		with (_user)
		{
			npc_exit_command();	
		}
	}
}



/// @function NPCCommandFight(_target)
/// @description makes thes calling NPC fight the target. Attempts to exit when the target is dead.
/// @param _target The target that is currently being fought.
function NPCCommandFight(_target): NPCCommand() constructor
{
	target = _target;
	
	static Perform = function(_user)
	{
		var _target = target;
		
		with (_user)
		{
			if (instance_exists(_target))
			{
				npc_fight(_target);	
			}
			else
			{
				npc_exit_command();
			}
		}
	}
}

///@function NPCCommandTalkTo(_target, _dialogue = noone): NPCCommand() constructor
///@description Goes to a location or towards a target while talking.
///@param _target a Point2 or an Instance to go towards while talking.
///@param [_dialogue] the things the NPC will say. If left blank will just use the NPC's own dialogue.
function NPCCommandTalkTo(_target, _dialogue = noone): NPCCommand() constructor
{
	target = _target;
	dialogue = _dialogue;
	textIndex = 0;
	static Perform = function(_user)
	{
		//If target no longer exists attempts to exit state.
		if !(npc_check_target(target))
		{
			with (_user)
			{
				npc_exit_command();
				return;
			}
		}
		
		//Get variables from state for use in the NPC.
		var _target = target;
		var _dialogue = dialogue;
		var _textIndex = textIndex;
		
		with (_user)
		{
			//Moves towards target point until right at it.
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
			
			
			//If textIndex == 0 that means the NPC is done with their dialogue. Checks for in either case if a dialogue array was passed or using the NPC's own dialogue.
			if (_dialogue == noone && textIndex == 0) || (_dialogue != noone && _textIndex == 0)
			{
				npc_exit_command();	
			}
		}
		
		//Sets the NPCCommandTalkTo's textIndex to equal the updated value. If the value wasn't updated it just stays the same.
		textIndex = _textIndex;
	}
}



/// @function NPCCommandSetDialogue(_dialogue)
/// @description Sets the NPC's current texts array and resets the textIndex. Attempts to exit state. Should usually have another state right after.
/// @param _dialogue an array or string. This will be set as the npc's texts array. If its just a string is first converted to a 1-element array.
function NPCCommandSetDialogue(_dialogue) : NPCCommand() constructor
{
	dialogue = _dialogue;
	
	executed = false;
	static Perform = function(_user)
	{
		var _dialogue = dialogue;
		var _executed = executed;
		
		with (_user)
		{
			if (!_executed)
			{
				//Sets dialogue to the passed value, resets text index. 
				if (is_array(_dialogue))
				{
					texts = _dialogue;
				}
				else //If it's not an array turns the passed value into a 1-element array.
				{
					texts = array_create(1, _dialogue);	
				}
				//Resets textIndex and sets _executed to true.
				textIndex = 0;
				_executed = true;
			}
			
			//Attemps to exit state.
			npc_exit_command();
			
		}
		executed = _executed;
	}
}


/// @function NPCCommandSetCommands(_commands)
/// @description Sets the NPC's command list to the passed commands.
/// @param _commands An array of commands that will replace the NPC's current list.
function NPCCommandSetCommands(_commands) : NPCCommand() constructor
{
	commands = _commands;
	
	//Doesn't need an exit condition: Replaces itself with the passed commands.
	static Perform = function(_user)
	{
		var _commands = commands;
		
		with (_user)
		{
			npcCommands = _commands;
		}
	}
}


/// @function NPCCommandInsertCommands(_commands, _index)
/// @description Inserts the passed _commands array into the calling NPC's commands array. By default inserts at 0 but will insert at a passed index.
/// @param _commands An array of commands that will be inserted into the NPC's current list.
/// @param _index The index to begin inserting at.
function NPCCommandInsertCommands(_commands, _index = 0) : NPCCommand() constructor
{
	commands = _commands;
	index = _index;
	
	static Perform = function(_user)
	{
		with (_user)
		{
			
		}
	}
}


///@function NPCCommandLoop(_states): NPCCommand() constructor
///@description replaces the executing NPC's npcCommands array with the passed _states array, then appends a copy of this state to the end. This causes the NPC to loop the passed _states array.
///@param _states the new states array that will be looped through.
function NPCCommandLoop(_commands): NPCCommand() constructor
{
	
	//Clones the passed array 
	commands = array_create(0);
	for (var _i = 0; _i < array_length(_commands); _i++)
	{
		array_push(commands, variable_clone(_commands[_i]))
	}
	
	//Replaces the _user's states array with the NPCCommandLoop's own, appends a copy of this struct to the end.
	static Perform = function(_user)
	{
		var _commands = commands;
		
		array_push(_commands, new NPCCommandLoop(_commands)); //Appends of a copy of this data structure to the end, causing it to loop.
		
		
		with (_user)
		{
			npcCommands = array_create(0);
			npcCommands = _commands;
		
		}
	}
}


/// @function NPCCommandAwaitTarget(_target) : NPCCommand() constructor
/// @description Has the NPC stand still until a target gets close enough, then attempts to exit state.
/// @param _target An instance or point2 or something with x and y. 
/// @param _range How close the NPC has to be to _target to go to the next state.
function NPCCommandAwaitTarget(_target, _range = CLOSE_RANGE) : NPCCommand() constructor
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
				npc_exit_command();
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

