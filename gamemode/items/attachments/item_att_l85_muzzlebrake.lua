local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_l85_muzzlebrake";
ITEM.Name =				"SA80-A2 Muzzle Brake";
ITEM.Description =		"A muzzle brake for the SA80-A2's barrel.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "md_muzzlebrake";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
