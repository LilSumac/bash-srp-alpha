local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_regbarrel";
ITEM.Name =				"Regular Pistol Barrel Kit";
ITEM.Description =		"A kit that provides the neccessary parts to extend or shorten a sidearm's barrel to its standard length.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "bg_regularbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
