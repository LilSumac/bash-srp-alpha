local BASH = BASH;
local ITEM = {};
ITEM.ID =				"energy_drink";
ITEM.Name =				"Energy Drink";
ITEM.Description =		"A canned beverage filled with sugar, caffine, and the likes. Helps get rid of thirst and boost stamina.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/food/drink.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		2;
ITEM.DefaultStock = 	40;
ITEM.DefaultPrice = 	150;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  {
    [1] = "Stamina",
    [2] = "IsThirsty"
};
ITEM.ConsumeEffect =    {
    [1] = 50,
    [2] = -1
};
ITEM.ConsumeMessage =   "You've downed an entire energy drink.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
