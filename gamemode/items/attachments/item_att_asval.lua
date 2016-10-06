local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_asval";
ITEM.Name =				"AS VAL Modification";
ITEM.Description =		"A kit that supplies the necessary parts to modify a VSS into an AS VAL.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			1;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Receiver";
ITEM.AttachmentEnt =    "bg_asval";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
