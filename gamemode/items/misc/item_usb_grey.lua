local BASH = BASH;
local ITEM = {};
ITEM.ID =				"usb_grey";
ITEM.Name =				"Grey USB Drive";
ITEM.Description =		"A simple USB thumbdrive. Who knows what could be stored within?";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/usb_b.mdl");
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     8000;
ITEM.LootHidden =       true;
ITEM.NoProperties =     true;
BASH:ProcessItem(ITEM);
