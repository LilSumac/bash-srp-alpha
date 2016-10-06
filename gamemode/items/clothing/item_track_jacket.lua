local BASH = BASH;
local ITEM = {};
ITEM.ID =				"track_jacket";
ITEM.Name =				"Track Jacket";
ITEM.Description =		"A light and swishy track jacket to match with your track pants. You /are/ wearing track pants, right...?";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Weight =           3;
ITEM.DefaultStock = 	500;
ITEM.DefaultPrice = 	100;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
