#region //Room values
#macro ROOM_TITLE room_titleScreen
#macro ROOM_CHARACTER_CREATION room_characterCreation
#macro ROOM_INTRO_SCREEN room_inn
#endregion

#region //grid things
#macro GRID_CELL_WIDTH 16
#macro GRID_CELL_HEIGHT 16
#endregion


//player constants
#region
#macro PLAYER_STARTING_HP 40
#macro PLAYER_STARTING_PP 4
#macro PLAYER_FLICKER (game_get_speed(gamespeed_fps) * 3)
#endregion

#region	//static object pointers
#macro BLOCK obj_block //Wall objects.
#macro DOLL obj_doll //Base character object.
#macro MELEE obj_meleeSwing //melee swing object
#macro GUARD obj_meleeGuard //melee guard object
#endregion

#region //Weapon structs.
#macro ITEM_WOODENSWORD  ItemMelee("Wooden Sword", noone, spr_weaponWoodenSwordIcon, 1, "A toy wooden sword.", -1, aiType.melee, spr_weaponWoodenSword, spr_weaponWoodenSwordGuard, 1, 1, 9, 180, 4)
#macro ITEM_SWORD  ItemMelee("Sword", noone, spr_weaponSwordIcon, 1, "A double-edged longsword.", -1, aiType.melee, spr_weaponSword, spr_weaponSwordGuard, 2, 1, 9, 180, 4)
#macro ITEM_MAGICSWORD  ItemMelee("Magic Sword", noone, spr_weaponMagicSwordIcon, 1, "Enchanted sword.", -1, aiType.melee, spr_weaponMagicSword,  spr_weaponMagicSwordGuard, 3, 1, 9, 180, 4)
#macro ITEM_HAMMER  ItemMelee("Hammer", noone, spr_weaponHammerIcon, 1, "A heavy hammer for combat.", -1, aiType.melee, spr_weaponHammer,  spr_weaponHammerGuard, 5, 6, 9, 360, 5)
#macro ITEM_AXE  ItemMelee("Axe", noone, spr_weaponAxeIcon, 1, "An axe that can cut down trees or people.", -1, aiType.melee, spr_weaponAxe,spr_weaponAxeGuard, 3, 4, 9, 135, 5)
#macro ITEM_KNIFE  ItemMelee("Knife", noone, spr_weaponKnifeIcon, 1, "A pointy knife for stabbing.", -1, aiType.melee, spr_weaponKnife, spr_weaponKnifeGuard, 1, 1, 15, 135, 4)
#macro ITEM_BOOMERANG	ItemInstancer("Boomerang", noone, spr_boomerangIcon, 1, "A boomerang that comes back when thrown.", -1, aiType.ranged, obj_boomerang, 5);
#macro ITEM_FIRECRYSTAL ItemInstancer("Fire Crystal", noone, spr_fireCrystalIcon, 1, "Throw a fireball at enemies.", -1, aiType.ranged, obj_fireball, 4)
#endregion

#region //Doll physics things.
#macro DOLL_FRICT 0.01
#macro DOLL_LUNGE 4
#macro DOLL_ACCEL 0.2
#macro DOLL_MAX_SPEED 2.5
#endregion

#region //NPC timters
#macro PASSIVE_TIME (game_get_speed(gamespeed_fps) * 3)
#macro MELEE_ATTACK_TIME (game_get_speed(gamespeed_fps) * 3)
#endregion

#region	//numeric game values.
#macro FLICKER (game_get_speed(gamespeed_fps) / 3)
#macro RANGE_MELEE 16
#macro RANGE_CLOSE 50
#macro RANGE_MID 150
#macro RANGE_LONG 200
#macro TEXT_SPEED 10
#macro TEXT_BALLOON_SPEED 5
#macro TEXT_BALLOON_MAXW 100
#macro SECOND game_get_speed(gamespeed_fps)
#endregion

#region	//Controls.
#macro ANY_BUTTON (keyboard_check(vk_anykey))
#macro RIGHT_BUTTON (keyboard_check(vk_right) || keyboard_check(ord("D")) || gamepad_button_check(0, gp_padr))
#macro DOWN_BUTTON (keyboard_check(vk_down) || keyboard_check(ord("S")) || gamepad_button_check(0, gp_padd))
#macro LEFT_BUTTON (keyboard_check(vk_left) || keyboard_check(ord("A")) || gamepad_button_check(0, gp_padl))
#macro UP_BUTTON (keyboard_check(vk_up) || keyboard_check(ord("W")) || gamepad_button_check(0, gp_padu))
#macro A_BUTTON (keyboard_check(vk_space) || gamepad_button_check(0, gp_face1))
#macro B_BUTTON (keyboard_check(ord("Q")) || gamepad_button_check(0, gp_face2))
#macro X_BUTTON (keyboard_check(ord("E")) || gamepad_button_check(0, gp_face3))
#macro Y_BUTTON (keyboard_check(ord("R")) || gamepad_button_check(0, gp_face4))
#macro FACE_BUTTON (A_BUTTON || B_BUTTON || X_BUTTON || Y_BUTTON) 
#macro START_BUTTON ((gamepad_button_check(0, gp_start)) || (keyboard_check(vk_enter)))
#macro SELECT_BUTTON ((gamepad_button_check(0, gp_select)) || (keyboard_check(vk_tab)))
#macro MOUSE_LEFT_BUTTON mouse_check_button(mb_left)
#macro MOUSE_RIGHT_BUTTON mouse_check_button(mb_right)
#macro MOUSE_LEFT_BUTTON_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_LEFT_BUTTON)
#macro MOUSE_RIGHT_BUTTON_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_RIGHT_BUTTON)
#macro MOUSE_WHEEL_UP (mouse_wheel_up() || keyboard_check_pressed(vk_pageup))
#macro MOUSE_WHEEL_DOWN (mouse_wheel_down() || keyboard_check_pressed(vk_pagedown))

#macro ANY_BUTTON_PRESSED (keyboard_check_pressed(vk_anykey))
#macro RIGHT_BUTTON_PRESSED (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(0, gp_padr))
#macro DOWN_BUTTON_PRESSED (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(0, gp_padd))
#macro LEFT_BUTTON_PRESSED (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(0, gp_padl))
#macro UP_BUTTON_PRESSED (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(0, gp_padu))
#macro A_BUTTON_PRESSED (keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1))
#macro B_BUTTON_PRESSED (keyboard_check_pressed(ord("Q")) || gamepad_button_check_pressed(0, gp_face2))
#macro X_BUTTON_PRESSED (keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(0, gp_face3))
#macro Y_BUTTON_PRESSED (keyboard_check_pressed(ord("R")) || gamepad_button_check_pressed(0, gp_face4))
#macro MOUSE_LEFT_BUTTON_PRESSED mouse_check_button_pressed(mb_left)
#macro MOUSE_RIGHT_BUTTON_PRESSED mouse_check_button_pressed(mb_right)
#macro MOUSE_LEFT_BUTTON_PRESSED_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_LEFT_BUTTON_PRESSED)
#macro MOUSE_RIGHT_BUTTON_PRESSED_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_RIGHT_BUTTON_PRESSED)

#macro ANY_BUTTON_RELEASED (keyboard_check_released(vk_anykey))
#macro START_BUTTON_RELEASED ((gamepad_button_check_released(0, gp_start)) || (keyboard_check_released(vk_enter)))
#macro SELECT_BUTTON_RELEASED ((gamepad_button_check_released(0, gp_select)) || (gamepad_button_check_released(vk_tab)))
#macro RIGHT_BUTTON_RELEASED (keyboard_check_released(vk_right) || keyboard_check_released(ord("D")) || gamepad_button_check_released(0, gp_padr))
#macro DOWN_BUTTON_RELEASED (keyboard_check_released(vk_down) || keyboard_check_released(ord("S")) || gamepad_button_check_released(0, gp_padd) || mouse_wheel_down())
#macro LEFT_BUTTON_RELEASED (keyboard_check_released(vk_left) || keyboard_check_released(ord("A")) || gamepad_button_check_released(0, gp_padl))
#macro UP_BUTTON_RELEASED (keyboard_check_released(vk_up) || keyboard_check_released(ord("W")) || gamepad_button_check_released(0, gp_padu) || mouse_wheel_up())
#macro A_BUTTON_RELEASED (keyboard_check_released(vk_space) || gamepad_button_check_released(0, gp_face1))
#macro B_BUTTON_RELEASED (keyboard_check_released(ord("Q")) || gamepad_button_check_released(0, gp_face2))
#macro X_BUTTON_RELEASED (keyboard_check_released(ord("E")) || gamepad_button_check_released(0, gp_face3))
#macro Y_BUTTON_RELEASED (keyboard_check_released(ord("R")) || gamepad_button_check_released(0, gp_face4))
#macro FACE_BUTTON_RELEASED (A_BUTTON_RELEASED || B_BUTTON_RELEASED || X_BUTTON_RELEASED || Y_BUTTON_RELEASED) 
#macro MOUSE_LEFT_BUTTON_RELEASED mouse_check_button_pressed(mb_left)
#macro MOUSE_RIGHT_BUTTON_RELEASED mouse_check_button_pressed(mb_right)
#macro MOUSE_LEFT_BUTTON_RELEASED_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_LEFT_BUTTON_RELEASED)
#macro MOUSE_RIGHT_BUTTON_RELEASED_NOT_GUI (!position_meeting(mouse_x, mouse_y, abs_gui) && MOUSE_RIGHT_BUTTON_RELEASED)
#endregion

//extra colors
#region//Human skin colors
#macro c_black1 make_color_rgb(120, 65, 35)
#macro c_black2 make_color_rgb(160, 65, 35)
#macro c_black3 make_color_rgb(160, 85, 60)
#macro c_white1 make_color_rgb(255, 195, 140)
#macro c_white2 make_color_rgb(255, 215, 130)
#macro c_white3 make_color_rgb(255, 195, 140)
#macro c_hispanic1 make_color_rgb(175, 105, 75)
#macro c_hispanic2 make_color_rgb(255, 205, 165)
#macro c_hispanic3 make_color_rgb(255, 170, 140)
#macro c_asian1 make_color_rgb(210, 135, 100)
#macro c_asian2 make_color_rgb(255, 205, 105)
#macro c_asian3 make_color_rgb(255, 180, 90)

//Human hair colors.
#macro c_blonde make_color_rgb(235, 255, 0)
#macro c_darkBrunette make_color_rgb(100, 70, 0)
#macro c_brunette make_color_rgb(150, 70, 0)
#macro c_lightBrunette make_color_rgb(200, 125, 0)
#macro c_ginger make_color_rgb(220, 110,0)


//colors colors
#macro c_violet make_color_rgb(210, 64, 115)
#endregion

#region //enums
enum factions
{
	player, neutral, enemy	
}

enum compare 
{
	greaterThan, 
	lessThan, 
	greaterThanOrEqual, 
	lessThanOrEqual, 
	equals	
}

enum cursor
{
	normal,
	follow,
	attack,
	move,
	select
}

enum aiType
{
	na, 
	melee, 
	ranged, 
	consumable, 
	special
}

#endregion