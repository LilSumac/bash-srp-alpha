local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_anpeq15";
ITEM.Name =				"AN/PEQ-15 Target Pointer";
ITEM.Description =		"A military-grade aiming system that works on most RIS-equipped weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	4000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Rail";
ITEM.AttachmentEnt =    "md_anpeq15";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
