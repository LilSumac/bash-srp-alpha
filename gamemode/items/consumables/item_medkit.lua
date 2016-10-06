local BASH = BASH;
local ITEM = {};
ITEM.ID =				"medkit";
ITEM.Name =				"Medkit";
ITEM.Description =		"A basic medical kit containing supplies for the simplest of wounds.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/medical/medkit1.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		5;
ITEM.DefaultStock =     50;
ITEM.DefaultPrice =     250;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Treat";
ITEM.ConsumeVariable =  "Health";
ITEM.ConsumeEffect =    25;
ITEM.ConsumeMessage =   "You've used a medkit on yourself.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
