local BASH = BASH;
local ITEM = {};
ITEM.ID =				"water";
ITEM.Name =				"Water Bottle";
ITEM.Description =		"A bottle of pure water, an invaluable resource in the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Water_bottle.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	200;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  "IsThirsty"
ITEM.ConsumeEffect =    -1
ITEM.ConsumeMessage =   "You've enjoyed a nice drink of water.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
