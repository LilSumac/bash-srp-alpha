local BASH = BASH;
local ITEM = {};
ITEM.ID =				"medkit_military";
ITEM.Name =				"Military Medkit";
ITEM.Description =		"A medical kit distributed to medics containing supplies for advanced trauma care.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/medical/medkit2.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		5;
ITEM.DefaultStock =     20;
ITEM.DefaultPrice =     500;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Treat";
ITEM.ConsumeVariable =  "Health";
ITEM.ConsumeEffect =    50;
ITEM.ConsumeMessage =   "You've used a medkit on yourself.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
