local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_pbs1";
ITEM.Name =				"PBS-1 Suppressor";
ITEM.Description =		"A thick suppressor made for specific Warsaw weapons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	4000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "md_pbs1";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
