local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_nostock";
ITEM.Name =				"Buttplate Kit";
ITEM.Description =		"A kit that supplies the necessary parts to remove a stock from a weapon.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.1;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Stock";
ITEM.AttachmentEnt =    "bg_nostock";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
