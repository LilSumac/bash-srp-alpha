local BASH = BASH;
local ITEM = {};
ITEM.ID =				"hoodie_red";
ITEM.Name =				"Red Hoodie";
ITEM.Description =		"A red pullover hoodie, complete with front pouch. Looks nice and comfy!";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(200, 25, 25);
ITEM.Weight =           3;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	175;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
