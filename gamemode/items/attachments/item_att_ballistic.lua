local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ballistic";
ITEM.Name =				"Ballistic Scope";
ITEM.Description =		"A long-range sight compatible with most modular snipers.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	12000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_ballistic";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
