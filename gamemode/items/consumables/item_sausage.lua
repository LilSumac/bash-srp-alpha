local BASH = BASH;
local ITEM = {};
ITEM.ID =				"sausage";
ITEM.Name =				"Sausage";
ITEM.Description =		"An uncut Italian sausage.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/food/sausage.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	80;
ITEM.DefaultPrice = 	80;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Eat";
ITEM.ConsumeVariable =  "IsHungry";
ITEM.ConsumeEffect =    -1;
ITEM.ConsumeMessage =   "You've enjoyed a tasty sausage.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
