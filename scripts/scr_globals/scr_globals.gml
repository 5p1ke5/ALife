/// @function globals_initialize()
/// @description Initializes the game's global variabls.
function globals_initialize()
{
	global.player = -1; //The instance the player is currently controlling. Will be set on room load.
	
	//Coordinates teh party will be spawned at on room transition. -1, -1 is considered 'blank' and will result in the party being spawned at the spawn point's coordinates.
	global.spawnX = -1;
	global.spawnY = -1;
	
	//Cursor things.
	global.cursors[0] = spr_cursor;
	global.cursors[1] = spr_cursorFollow;
	global.cursors[2] = spr_cursorAttack;
	global.cursors[3] = spr_cursorMove;
	global.cursors[4] = spr_cursorSelect;
	
	global.cursorState = cursor.normal;
	
	//Faction things
	global.party = party_initialize();
	global.partySerialized = party_serialized_intialize();  //Party members serialized between levels. Element 0 will be designated the player upon deserialization.
	
	
	//Currently selected allies.
	global.selected = ds_list_create();
	global.selectedUnit = noone;
	
	//The movement planning grid.
	global.mpGrid = noone;
	
	global.names = ["Paula", "Nicole", "Martha", "Edna", "Kylie", "Brittany", "Marissa", "Alyssa", "Jeanie", "Carla", "Bethany", "Demi", "Tiffany", "Sophia", "Martina", "Tiana", "Tina", "Leslie", "Taina", "Louise", "Lulu", "Ava", "Beverly", "Joan", "Natalya", "Elise", "Iris", "Amanda", "Natty", "Catty", "Moira", "RoseCorey", "Chris", "Alex", "Norman", "Maxwell", "Steve", "Stephen", "Carlos", "Logan", "Joshua", "Josh", "Miguel", "Mcduff", "Oliver", "Morgan", "Nick", "Jimmy", "Bimmy", "Juan", "Carlito", "Tyrell", "Dmitri", "Daivon", "Riley", "Marcus", "Razwell", "Blorkus", "Dongus", "Darius", "McVile", "Razor", "Monster", "Collin"];
	
	
	#region //Story flags.
	global.storyTalkedToAtticus = false;
	#endregion
}