/// @description If hurt also sets target and plays sound effect.

//Checks HP at start. If it's different we know that damage was taken.
var _startHP = hp;

/// @description If the othe object is blockable will check if the doll is holding a guard object.
if (object_is_ancestor(other.object_index, abs_blockable)) && instance_exists(myHeld)
{
	if (myHeld.object_index == obj_meleeGuard)
	{
		
		//Angle of the attack relative to the parrying object.
		var _attackAngle = point_direction(myHeld.x, myHeld.y, other.x, other.y);
		
		//If the angle for blocking is correct parries the attack, applies knockback to attacker.
		if (abs(angle_difference(angle, _attackAngle)) < 90)
		{
			with(other)
			{
				if (damage != 0)
				{
					damage = 0;
		
					audio_play_sound(snd_seParry, 1, false);
					
					//Knockback
					with(owner)
					{
						hsp = -hsp * 0.75;
						vsp = -vsp * 0.75;
					}
				}
			}
			
		}
		else
		{
			event_inherited();
		}
	}
	else
	{
		event_inherited();
	}
}
else
{
	event_inherited();
}

//If damage was taken and there isn't a target already sets target as whoever delt that damage.
if (hp < _startHP)// && (!instance_exists(target))
{
	
	audio_play_sound(snd_seNPCHit, 1, false);
}
