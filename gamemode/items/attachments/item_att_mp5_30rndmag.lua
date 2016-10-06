local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_mp5_30rndmag";
ITEM.Name =				"MP5 30 rnd. Magazine";
ITEM.Description =		"A 30-round magazine for the MP5.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "bg_mp530rndmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
