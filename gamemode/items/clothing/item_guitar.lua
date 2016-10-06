local BASH = BASH;
local ITEM = {};
ITEM.ID =				"guitar";
ITEM.Name =				"6-String Guitar";
ITEM.Description =		"A worn but working acoustic guitar complete with case! Play a tune for your friends, or sling it on your back.";
ITEM.FlavorText =		"He was a good STALKER.";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	500;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Back";
BASH:ProcessItem(ITEM);
