local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_saker";
ITEM.Name =				"Saker Silencer";
ITEM.Description =		"A long silencer guarenteed to hide muzzle flashes and lower firing volume.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "md_saker";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
