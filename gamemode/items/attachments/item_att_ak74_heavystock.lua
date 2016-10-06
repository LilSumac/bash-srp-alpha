local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ak74_heavystock";
ITEM.Name =				"AK-74 Heavy Stock";
ITEM.Description =		"A kit that supplies the necessary parts to attach a heavy stock to an AK-74.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			1;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Stock";
ITEM.AttachmentEnt =    "bg_ak74heavystock";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
