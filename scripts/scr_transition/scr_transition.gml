///@function transition_initialize(_spawnX, _spawnY)
///@description sets variables for a transition object. Should usually be in an instance's create event.
///@param _roomTo The room to be sent to.
///@param _spawnX x coordinate the party will spawn at.
///@param _spawnY y coordinate the party will spawn at.
function transition_initialize(_roomTo, _spawnX, _spawnY)
{
	roomTo = _roomTo;
	spawnX = _spawnX;
	spawnY = _spawnY;
}


///@function transition_goto()
///@description Transitions to the specified room and sets the spawn coordinates.
function transition_goto()
{
	global.spawnX = spawnX;
	global.spawnY = spawnY;
	room_goto(roomTo);
}