local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_m16_foldsight";
ITEM.Name =				"Surefire 60 rnd. Magazine";
ITEM.Description =		"A 60-round magazine for the M16A4 and M4A1.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	10000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "md_uecw_60rnd";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
