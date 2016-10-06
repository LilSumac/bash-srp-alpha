local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cloak_black";
ITEM.Name =				"Black Cloak";
ITEM.Description =		"A long black cloak that reaches down to the backs of the wearers knees. What are you hiding?";
ITEM.FlavorText =		"The STALKER the Zone deserves, but does not need.";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelScale =       0.7;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	100;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Back";
BASH:ProcessItem(ITEM);
