local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_m203";
ITEM.Name =				"M203 Launcher";
ITEM.Description =		"A detachable grenade launcher compatible with some NATO rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/cw2/attachments/m203.mdl");
ITEM.Weight =			1;
ITEM.Hidden =           true;
ITEM.LootHidden =       true;
//  Not yet implemented.
//ITEM.DefaultStock = 	0;
//ITEM.DefaultPrice = 	8000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Handguard";
ITEM.AttachmentEnt =    "md_m203";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
