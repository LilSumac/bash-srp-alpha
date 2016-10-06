local BASH = BASH;
local ITEM = {};
ITEM.ID =				"hoodie_drugrug";
ITEM.Name =				"Drug Rug";
ITEM.Description =		"A knitted hoodie with a front pouch and a tribal pattern and color scheme.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_bag001a.mdl");
ITEM.ModelColor =       Color(25, 25, 25);
ITEM.Weight =           3;
ITEM.DefaultStock = 	20;
ITEM.DefaultPrice = 	225;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Torso";
BASH:ProcessItem(ITEM);
