local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_longris";
ITEM.Name =				"Long Rail Interface System";
ITEM.Description =		"A kit that supplies the necessary parts to add a long rail system to a weapon's receiver.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	1500;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Receiver";
ITEM.AttachmentEnt =    "bg_longris";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
