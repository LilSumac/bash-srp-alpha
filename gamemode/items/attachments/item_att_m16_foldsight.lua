local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_m16_foldsight";
ITEM.Name =				"M16 Folding Sight";
ITEM.Description =		"A simple folding sight for the M16A4 and M4A1 rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_uecw_foldsight";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
