local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_leupold";
ITEM.Name =				"Leupold Scope";
ITEM.Description =		"A long-range sight compatible with most modular snipers.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	8000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_fas2_leupold";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
