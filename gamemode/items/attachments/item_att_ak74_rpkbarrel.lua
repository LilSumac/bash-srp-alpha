local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_ak74_rpkbarrel";
ITEM.Name =				"AK-74 RPK Barrel";
ITEM.Description =		"A kit that supplies the necessary parts to mirror an RPK on an AK-74's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	3500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Receiver";
ITEM.AttachmentEnt =    "bg_ak74_rpkbarrel";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
