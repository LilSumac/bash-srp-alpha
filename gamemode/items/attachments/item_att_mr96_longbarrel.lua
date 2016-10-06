local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_regbarrel";
ITEM.Name =				"MR96 Long Barrel Kit";
ITEM.Description =		"A kit that provides the neccessary parts to extend an MR96's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "bg_longbarrelmr96";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
