local BASH = BASH;
local ITEM = {};
ITEM.ID =				"beer";
ITEM.Name =				"Beer Bottle";
ITEM.Description =		"A glass bottle of some popular beer from a brewery in Germany. Cures a dry mouth and a sad soul.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/GlassBottle01a.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	300;
ITEM.DefaultPrice = 	50;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  {
    [1] = "DrunkMul",
    [2] = "IsThirsty"
};
ITEM.ConsumeEffect =    {
    [1] = 20,
    [2] = -1
};
ITEM.ConsumeMessage =   "You've enjoyed a nice drink of beer.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
