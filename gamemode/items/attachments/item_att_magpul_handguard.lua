local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_magpul_handguard";
ITEM.Name =				"Magpul Handguard";
ITEM.Description =		"A handguard system made specifically for AR-type rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Receiver";
ITEM.AttachmentEnt =    "bg_magpulhandguard";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
