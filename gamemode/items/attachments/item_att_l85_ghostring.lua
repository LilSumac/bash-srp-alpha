local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_l85_ghostring";
ITEM.Name =				"SA80-A2 Ghost Ring Ironsights";
ITEM.Description =		"A tactical version of the SA80-A2's ironsights.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Sight";
ITEM.AttachmentEnt =    "md_attghostring";
ITEM.RequiresTech =     false;
BASH:ProcessItem(ITEM);
