local BASH = BASH;
local ITEM = {};
ITEM.ID =				"coffee";
ITEM.Name =				"Cup of Coffee";
ITEM.Description =		"A mug of warm coffee. Not very mobile, unfortunately.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_junk/garbage_coffeemug001a.mdl");
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	25;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Drink";
ITEM.ConsumeVariable =  {
    [1] = "Stamina",
    [2] = "IsThirsty"
};
ITEM.ConsumeEffect =    {
    [1] = 25,
    [2] = -1
};
ITEM.ConsumeMessage =   "You sip down the hot mug of coffee.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
