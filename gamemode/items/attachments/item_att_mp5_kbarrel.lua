local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_mp5_kbarrel";
ITEM.Name =				"MP5K Kit";
ITEM.Description =		"A kit that provides the neccessary parts to convert an MP5 into an MP5K.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Handguard";
ITEM.AttachmentEnt =    "bg_mp5_kbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
