local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_hk416_extbarrel";
ITEM.Name =				"HK416 Extended Barrel";
ITEM.Description =		"A kit that supplies the necessary parts to extend an HK416's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	15000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel ext";
ITEM.AttachmentEnt =    "bg_hk416_longbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
