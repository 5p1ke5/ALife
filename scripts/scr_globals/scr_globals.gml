/// @function globals_initialize()
/// @description Initializes the game's global variabls.
function globals_initialize()
{
	global.player = 1; //The instance the player is currently controlling.
	
	global.playerMaxHP = 400;
	global.playerHP = 400;
	
	//hhhhh dunno if I'll use these
	global.playerMaxPP = 3;
	global.playerPP = 3;
	
	//Player appearance variables.
	global.playerFaceIndex = 0;
	global.playerHairIndex = 0;
	global.playerShirtIndex = 0;
	global.playerPantsIndex = 0;
	
	global.playerSkinColor = c_hispanic1;
	global.playerHairColor = c_brunette;
	global.playerShirtColor = c_red;
	global.playerPantsColor = c_blue;
	
	//Cursor things.
	global.cursors[0] = spr_cursor;
	global.cursors[1] = spr_cursorFollow;
	global.cursors[2] = spr_cursorAttack;
	global.cursors[3] = spr_cursorMove;
	global.cursors[4] = spr_cursorSelect;
	
	global.cursorState = cursor.normal;
	
	//Faction things
	//Currently recruited allies.
	global.partyMembers = ds_list_create();
	
	
	//Currently selected allies.
	global.selected = ds_list_create();
	
	//Story flags.
	global.storyTalkedToDad = false;
	
	#region
	global.names = ["Paula", "Nicole", "Martha", "Edna", "Kylie", "Brittany", "Marissa", "Alyssa", "Jeanie", "Carla", "Bethany", "Demi", "Tiffany", "Sophia", "Martina", "Tiana", "Tina", "Leslie", "Taina", "Louise", "Lulu", "Ava", "Beverly", "Joan", "Natalya", "Elise", "Iris", "Amanda", "Natty", "Catty", "Moira", "RoseCorey", "Chris", "Alex", "Norman", "Maxwell", "Steve", "Stephen", "Carlos", "Logan", "Joshua", "Josh", "Miguel", "Mcduff", "Oliver", "Morgan", "Nick", "Jimmy", "Bimmy", "Juan", "Carlito", "Tyrell", "Dmitri", "Daivon", "Riley", "Marcus", "Razwell", "Blorkus", "Dongus", "Darius", "McVile", "Razor", "Monster", "Collin"];
	#endregion
}