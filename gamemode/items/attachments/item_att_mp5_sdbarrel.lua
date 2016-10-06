local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_mp5_sdbarrel";
ITEM.Name =				"MP5SD Kit";
ITEM.Description =		"A kit that provides the neccessary parts to convert an MP5 into an MP5SD.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2250;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Handguard";
ITEM.AttachmentEnt =    "bg_mp5_sdbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
