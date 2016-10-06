local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_foregrip";
ITEM.Name =				"Foregrip";
ITEM.Description =		"A modular foregrip made for weapons with rails.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.1;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Handguard";
ITEM.AttachmentEnt =    "md_foregrip";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
