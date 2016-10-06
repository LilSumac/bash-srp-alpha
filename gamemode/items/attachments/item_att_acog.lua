local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_acog";
ITEM.Name =				"ACOG Sight";
ITEM.Description =		"A compact rifle scope compatible with most modular weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_acog";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
