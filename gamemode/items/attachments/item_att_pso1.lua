local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_pso1";
ITEM.Name =				"PSO-1 Scope";
ITEM.Description =		"A long-range sight compatible with most modular Warsaw snipers.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	6000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_pso1";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
