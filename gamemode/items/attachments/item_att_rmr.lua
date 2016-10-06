local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_rmr";
ITEM.Name =				"RMR Sight";
ITEM.Description =		"A miniature red-dot sight designed specifically for sidearms.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_rmr";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
