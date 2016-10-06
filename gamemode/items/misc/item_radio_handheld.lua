local BASH = BASH;
local ITEM = {};
ITEM.ID =				"radio_handheld";
ITEM.Name =				"Handheld Radio";
ITEM.Description =		"A small handheld radio with a frequency tuner.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/radio.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	20;
ITEM.DefaultPrice = 	50;

ITEM.NoProperties =     true;
BASH:ProcessItem(ITEM);
