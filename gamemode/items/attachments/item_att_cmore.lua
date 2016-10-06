local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_cmore";
ITEM.Name =				"C-More Sight";
ITEM.Description =		"A red-dot reflex sight compatible with most modular weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_cmore";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
