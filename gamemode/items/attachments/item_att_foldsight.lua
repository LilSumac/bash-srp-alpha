local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_foldsight";
ITEM.Name =				"Folding Sight";
ITEM.Description =		"A simple folding sight for modern assault rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "bg_foldsight";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
