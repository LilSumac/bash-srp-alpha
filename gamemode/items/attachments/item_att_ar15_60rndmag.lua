local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ar15_60rndmag";
ITEM.Name =				"AR-15 60 rnd. Magazine";
ITEM.Description =		"A 60-round magazine for the AR-15.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	10000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "bg_ar1560rndmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
