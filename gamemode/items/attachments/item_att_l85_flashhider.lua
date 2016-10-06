local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_l85_flashhider";
ITEM.Name =				"SA80-A2 Flash Hider";
ITEM.Description =		"A flash hider for the SA80-A2's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "md_flashhider1";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
