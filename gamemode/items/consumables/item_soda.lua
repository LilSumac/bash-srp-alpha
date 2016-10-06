local BASH = BASH;
local ITEM = {};
ITEM.ID =				"soda";
ITEM.Name =				"Can of Soda";
ITEM.Description =		"A can of European soda, unopened. Pop and fizzle.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/PopCan01a.mdl");
ITEM.DefaultStock = 	500;
ITEM.DefaultPrice = 	25;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  {
    [1] = "Stamina",
    [2] = "IsThirsty"
};
ITEM.ConsumeEffect =    {
    [1] = 10,
    [2] = -1
};
ITEM.ConsumeMessage =   "You drink down the fizzy canned beverage.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
