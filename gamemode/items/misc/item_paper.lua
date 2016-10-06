local BASH = BASH;
local ITEM = {};
ITEM.ID =				"paper";
ITEM.Name =				"Paper";
ITEM.Description =		"A simple piece of paper, ready to be written on.";
ITEM.FlavorText =		"The pen is mightier than the sword.";
ITEM.WorldModel =		Model("models/props_c17/paper01.mdl");
ITEM.Weight =			0;
ITEM.DefaultStock = 	1000;
ITEM.DefaultPrice = 	5;

ITEM.IsWritable =       true;
BASH:ProcessItem(ITEM);
