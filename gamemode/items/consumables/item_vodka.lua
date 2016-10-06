local BASH = BASH;
local ITEM = {};
ITEM.ID =				"vodka";
ITEM.Name =				"Vodka";
ITEM.Description =		"A tall bottle of Ukraine's finest cheap vodka. Cures a dry mouth and a sad soul.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/food/vokda.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	200;
ITEM.DefaultPrice = 	70;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  {
    [1] = "DrunkMul",
    [2] = "IsThirsty"
};
ITEM.ConsumeEffect =    {
    [1] = 50,
    [2] = -1
};
ITEM.ConsumeMessage =   "You've enjoyed a nice drink of vodka.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
