local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_hk416_railcover";
ITEM.Name =				"HK416 Rail Covers";
ITEM.Description =		"A set of covers for the side rails of an HK416.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "bg_hk416_railcover";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
