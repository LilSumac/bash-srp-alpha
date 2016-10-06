local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_deagle_comp";
ITEM.Name =				"Desert Eagle Compensator";
ITEM.Description =		"A kit that supplies the necessary parts to attach a compensator to a Desert Eagle.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	10000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Barrel";
ITEM.AttachmentEnt =    "bg_deagle_compensator";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
