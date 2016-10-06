local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_tundra";
ITEM.Name =				"TUNDRA Suppressor";
ITEM.Description =		"A small, lightweight guarenteed to hide muzzle flashes and lower firing volume.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "md_tundra9mm";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
