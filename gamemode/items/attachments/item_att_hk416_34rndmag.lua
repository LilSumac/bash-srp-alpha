local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_hk416_34rndmag";
ITEM.Name =				"HK416 34 rnd. Magazine";
ITEM.Description =		"A 34-round magazine for the HK416.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "bg_hk416_34rndmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
