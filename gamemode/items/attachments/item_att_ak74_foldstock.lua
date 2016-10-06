local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ak74_foldstock";
ITEM.Name =				"AK-74 Folding Stock";
ITEM.Description =		"A kit that supplies the necessary parts to attach a folding stock to an AK-74.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	750;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Stock";
ITEM.AttachmentEnt =    "bg_ak74foldablestock";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
