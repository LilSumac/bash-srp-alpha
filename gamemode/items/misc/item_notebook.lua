local BASH = BASH;
local ITEM = {};
ITEM.ID =				"notebook";
ITEM.Name =				"Notebook";
ITEM.Description =		"A simple spiral notebook, ready to be written in.";
ITEM.FlavorText =		"The pen is mightier than the sword.";
ITEM.WorldModel =		Model("models/props_c17/paper01.mdl");
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	50;

ITEM.IsWritable =       true;
BASH:ProcessItem(ITEM);
