local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cigarettes";
ITEM.Name =				"Pack of Cigarettes";
ITEM.Description =		"A box in which are a few loose cigarettes. Eases stress and hunger, but results in lack of stamina.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_wasteland/kitchen_fridge001a.mdl");
ITEM.ModelColor =       Color(200, 0, 0);
ITEM.ModelScale =       0.05;
ITEM.IsStackable =		true;
ITEM.DefaultStacks =    20;
ITEM.MaxStacks =		20;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	100;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Smoke";
ITEM.ConsumeVariable =  {
    [1] = "Stamina",
    [2] = "IsHungry"
};
ITEM.ConsumeEffect =    {
    [1] = -25,
    [2] = -1
};
ITEM.ConsumeMessage =   "You smoke a cigarette.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
