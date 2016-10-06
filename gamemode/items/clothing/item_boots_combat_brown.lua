local BASH = BASH;
local ITEM = {};
ITEM.ID =				"boots_combat_brown";
ITEM.Name =				"Brown Combat Boots";
ITEM.Description =		"A pair of brown combat boots. Perfect for traversing the treacherous Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(209, 139, 89);
ITEM.ModelScale =       0.75;
ITEM.Weight =           1.5;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	125;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Feet";
BASH:ProcessItem(ITEM);
