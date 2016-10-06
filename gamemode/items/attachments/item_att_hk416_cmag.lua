local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_hk416_cmag";
ITEM.Name =				"HK416 Beta C-Mag";
ITEM.Description =		"A 100-round magazine for the HK416.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	25000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "bg_hk416_cmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
