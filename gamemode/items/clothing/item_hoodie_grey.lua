local BASH = BASH;
local ITEM = {};
ITEM.ID =				"hoodie_grey";
ITEM.Name =				"Grey Hoodie";
ITEM.Description =		"A grey pullover hoodie, complete with front pouch. Looks nice and comfy!";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(150, 150, 150);
ITEM.Weight =           3;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	175;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
