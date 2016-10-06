local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_schmidt_shortdot";
ITEM.Name =				"Schmidt ShortDot";
ITEM.Description =		"A combination of a red-dot sight and a scope manufactured by Schmidt and Bender.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	8000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_schmidt_shortdot";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
