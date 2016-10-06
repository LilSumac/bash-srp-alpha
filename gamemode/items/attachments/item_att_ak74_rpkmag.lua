local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ak74_rpkmag";
ITEM.Name =				"AK-74 RPK Magazine";
ITEM.Description =		"An RPK-sized magazine for an AK-74.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	3000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "bg_ak74rpkmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
