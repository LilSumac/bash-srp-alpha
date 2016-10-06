local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_longbarrel";
ITEM.Name =				"Long Barrel";
ITEM.Description =		"A kit that supplies the necessary parts to extend a rifle's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Receiver";
ITEM.AttachmentEnt =    "bg_longbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
