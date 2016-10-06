local BASH = BASH;
local ITEM = {};
ITEM.ID =				"tourists_delight";
ITEM.Name =				"Tourist\'s Delight";
ITEM.Description =		"A can of military rations taken from an abandoned military depot. It is capable of removing hunger and restoring some health. The contents could be anything.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/food/tuna.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	50;
ITEM.DefaultPrice = 	200;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Eat";
ITEM.ConsumeVariable =  {
    [1] = "Health",
    [2] = "IsHungry"
};
ITEM.ConsumeEffect =    {
    [1] = 20,
    [2] = -1
};
ITEM.ConsumeMessage =   "You've opened and devoured a can of mystery meat.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
