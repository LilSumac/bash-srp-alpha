local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_mac11_extbarrel";
ITEM.Name =				"MAC-11 Extended Barrel";
ITEM.Description =		"A kit that supplies the necessary parts to extend a MAC-11's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel ext";
ITEM.AttachmentEnt =    "bg_mac11_extended_barrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
