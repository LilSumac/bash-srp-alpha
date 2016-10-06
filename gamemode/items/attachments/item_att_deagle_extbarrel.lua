local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_deagle_extbarrel";
ITEM.Name =				"Desert Eagle Extended Barrel";
ITEM.Description =		"A kit that supplies the necessary parts to extend a Desert Eagle's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	12000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "bg_deagle_extendedbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
