local BASH = BASH;
local ITEM = {};
ITEM.ID =				"bread";
ITEM.Name =				"Bread Chunk";
ITEM.Description =		"A small chunk of fresh bread. Goes well with sausage!";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/food/bread.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	200;
ITEM.DefaultPrice = 	40;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Eat";
ITEM.ConsumeVariable =  "IsHungry";
ITEM.ConsumeEffect =    -1;
ITEM.ConsumeMessage =   "You've enjoyed a fresh piece of bread.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
