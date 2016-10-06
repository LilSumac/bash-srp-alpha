local BASH = BASH;
local ITEM = {};
ITEM.ID =				"att_bipod";
ITEM.Name =				"Rifle Bipod";
ITEM.Description =		"A collapsable bipod that can attach to and stabilize most modular rifles.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/cardboard_box004a.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	5000;

ITEM.IsAttachment =     true;
ITEM.AttachmentSlot =   "Handguard";
ITEM.AttachmentEnt =    "bg_bipod";
ITEM.RequiresTech =     true;
BASH:ProcessItem(ITEM);
