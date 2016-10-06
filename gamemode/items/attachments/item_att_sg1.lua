local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_sg1";
ITEM.Name =				"SG1 Sight";
ITEM.Description =		"A long-range sight made specifically for the G3 rifle.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	8000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "bg_sg1scope";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
