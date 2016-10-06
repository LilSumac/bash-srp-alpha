local BASH = BASH;
local ITEM = {};
ITEM.ID =				"slacks_black";
ITEM.Name =				"Black Slacks";
ITEM.Description =		"A very nice pair of black slacks! Not really appropriate for the Zone, but the way of fashion isn\'t an easy one.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelScale =       0.75;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	2;
ITEM.DefaultPrice = 	575;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Legs";
BASH:ProcessItem(ITEM);
