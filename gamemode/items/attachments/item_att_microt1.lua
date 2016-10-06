local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_microt1";
ITEM.Name =				"Micro T-1 Sight";
ITEM.Description =		"A tactical red-dot sight compatible with most modular NATO weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_microt1";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
