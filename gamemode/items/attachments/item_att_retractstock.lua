local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_retractstock";
ITEM.Name =				"Retractable Stock";
ITEM.Description =		"A kit that supplies the necessary parts to add a retractable stock to a weapon.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	750;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Stock";
ITEM.AttachmentEnt =    "bg_retractablestock";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
