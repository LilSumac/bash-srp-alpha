local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_eakmag";
ITEM.Name =				"Extended AK Magazine";
ITEM.Description =		"A 40-round magazine for certain AK-family rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	3500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Magazine";
ITEM.AttachmentEnt =    "md_uecw_akmag";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
