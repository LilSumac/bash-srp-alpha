//	Alert types.
ALERT_NONE = 0;
ALERT_HELPER = 1;
ALERT_PDAS = 2;

//	Ammo class names to actual names.
AMMO_STRINGS = {
	["12x70"] = "12x70mm Buckshot",
	["357mag"] = ".357 Magnum",
	["45acp"] = ".45 ACP",
	["50ae"] = ".50 AE",
	["50bmg"] = ".50 BMG",
	["545x39"] = "5.45x39mm",
	["556x45"] = "5.56x45mm",
	["762x39"] = "7.62x39mm",
	["762x51_belt"] = "7.62x51mm Belt",
	["762x51"] = "7.62x51mm",
	["762x54_belt"] = "7.62x54mm Belt",
	["762x54"] = "7.62x54mm",
	["9x18"] = "9x18mm",
	["9x19"] = "9x19mm",
	["9x39"] = "9x39mm",
	["rpg"] = "PG-7V Warhead"
};

//	Body parts enum.
BODY_PARTS = {
	"Head", "Ears",
	"Eyes", "Neck",
	"Torso", "Back",
	"Waist", "Legs",
	"Knees", "Feet"
};

//	BASH colors.
color_con = Color(192, 192, 192, 255);
color_red = Color(200, 0, 0, 255);
color_green = Color(0, 200, 0, 255);
color_blue = Color(0, 0, 200, 255);
color_purple = Color(200, 0, 200, 255);

//	All characters.
CHARACTERS = {
	'q', 'w', 'e', 'r',
	't', 'y', 'u', 'i',
	'o', 'p', 'a', 's',
	'd', 'f', 'g', 'h',
	'j', 'k', 'l', 'z',
	'x', 'c', 'v', 'b',
	'n', 'm', 'Q', 'W',
	'E', 'R', 'T', 'Y',
	'U', 'I', 'O', 'P',
	'A', 'S', 'D', 'F',
	'G', 'H', 'J', 'K',
	'L', 'Z', 'X', 'C',
	'V', 'B', 'N', 'M',
	'0', '1', '2', '3',
	'4', '5', '6', '7',
	'8', '9'
};

//	Equipment name to index.
EQUIP_PARTS = {
	["Primary"] = 1,
	["Secondary"] = 2,
	["Melee"] = 3
};

//	Flag types.
FLAG_PLY = 1;
FLAG_CHAR = 2;

//	Gender types.
//	(TRIGGERED)
GENDER_MALE = 1;
GENDER_FEMALE = 2;

//	Inventory types.
INV_MAIN = 1;
INV_SEC = 2;
INV_ACC = 3;
INV_STORE = 4;
INV_CLOTHING = 5;
INV_EQUIP = 6;

//	Logging types.
LOG_ALL = 1;
LOG_IC = 2;

//	Valid file prefixes.
PREFIXES_CLIENT = {"cl_", "vgui_"};
PREFIXES_SHARED = {"sh_", "item_", "inv_", string.sub(game.GetMap(), 1, string.find(game.GetMap(), '_', 1))};
PREFIXES_SERVER = {"sv_"};

//	Item size types.
SIZE_LARGE = 3;
SIZE_MED = 2;
SIZE_SMALL = 1;
SIZE_MIN = 0;

//	Item storage types.
STORAGE_INF = 4;
STORAGE_LARGE = 3;
STORAGE_MED = 2;
STORAGE_SMALL = 1;

if CLIENT then
	//	Positioning constants.
	SCRW = ScrW();
	SCRH = ScrH();
	CENTER_X = SCRW / 2;
	CENTER_Y = SCRH / 2;
	//	Notification positioning types.
	NOTIF_TOP_LEFT = 0;
	NOTIF_TOP_CENT = 1;
	NOTIF_TOP_RIGHT = 2;
	NOTIF_BOT_LEFT = 3;
	NOTIF_BOT_CENT = 4;
	NOTIF_BOT_RIGHT = 5;

	//	Color mod tables.
	COLOR_MODIFY = {
		DEFAULT = {
			["$pp_colour_addr"] = 		0,
			["$pp_colour_addg"] = 		0,
			["$pp_colour_addb"] = 		0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 	1,
			["$pp_colour_colour"] = 	1,
			["$pp_colour_mulr"] =		0,
			["$pp_colour_mulg"] = 		0,
			["$pp_colour_mulb"] = 		0
		},
		DEPRESSING = {
			["$pp_colour_addr"] = 		0,
			["$pp_colour_addg"] = 		0,
			["$pp_colour_addb"] = 		0,
			["$pp_colour_brightness"] = 0,
			["$pp_colour_contrast"] = 	1.25,
			["$pp_colour_colour"] = 	0.5,
			["$pp_colour_mulr"] =		0,
			["$pp_colour_mulg"] = 		0,
			["$pp_colour_mulb"] = 		0
		}
	};

	//	Disabled HUD elements.
	DISABLED_HUD = {
		"CHudHealth",
		"CHudSuitPower",
		"CHudBattery",
		"CHudCrosshair",
		"CHudAmmo",
		"CHudChat",
		"CHudDamageIndicator",
		"CHudHintDisplay",
		"CHudVoiceStatus",
		"CHudVoiceSelfStatus",
		"CHudWeaponSelection",
		"CHudZoom",
		"CHudPoisonDamageIndicator"
	};
	//	Weapons with crosshairs enabled.
	ENABLED_CROSSHAIRS = {
		"gmod_tool",
		"weapon_physgun"
	};
end
