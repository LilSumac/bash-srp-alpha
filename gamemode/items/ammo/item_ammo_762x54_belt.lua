local BASH = BASH;
local ITEM = {};
ITEM.ID =				"ammo_762x54_belt";
ITEM.Name =				"7.62x54mmR Belt";
ITEM.Description =		"A box of belted, rimmed Soviet rifle cartridges that have the longest service life of all military-issued cartridges in the world.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/ammo/pkm.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.01;
ITEM.DefaultStock = 	4000;
ITEM.DefaultPrice = 	7500;
ITEM.IsStackable =		true;
ITEM.DefaultStacks =    250;
ITEM.MaxStacks =        1000;
BASH:ProcessItem(ITEM);