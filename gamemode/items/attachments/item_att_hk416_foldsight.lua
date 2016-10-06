local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_hk416_foldsight";
ITEM.Name =				"HK416 Folding Sight";
ITEM.Description =		"A simple folding sight for the HK416 rifle.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "bg_hk416_foldsight";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
