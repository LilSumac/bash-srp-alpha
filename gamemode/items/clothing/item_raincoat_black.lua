local BASH = BASH;
local ITEM = {};
ITEM.ID =				"raincoat_black";
ITEM.Name =				"Black Raincoat";
ITEM.Description =		"A black raincoat looking to be in quite good condition. Definately capable of keeping out the rain.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           3;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	250;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
