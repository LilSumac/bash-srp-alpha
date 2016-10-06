local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_kobra";
ITEM.Name =				"Kobra Sight";
ITEM.Description =		"A CQB red-dot sight compatible with most modular Warsaw weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	750;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_kobra";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
