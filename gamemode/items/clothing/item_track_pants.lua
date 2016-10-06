local BASH = BASH;
local ITEM = {};
ITEM.ID =				"track_pants";
ITEM.Name =				"Track Pants";
ITEM.Description =		"The absolute cornerstone of Russian fashion: the track pants. Comfortable, utilitarian, and swishy.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_c17/SuitCase001a.mdl");
ITEM.ModelScale =       0.75;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           2;
ITEM.DefaultStock = 	500;
ITEM.DefaultPrice = 	100;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Legs";
BASH:ProcessItem(ITEM);
