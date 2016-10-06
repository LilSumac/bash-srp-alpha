local BASH = BASH;
local ITEM = {};
ITEM.ID =				"medkit_scientific";
ITEM.Name =				"Scientific Medkit";
ITEM.Description =		"A medical kit distributed to Ecologists containing supplies for the worst of wounds.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/medical/medkit3.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		5;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     750;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Treat";
ITEM.ConsumeVariable =  "Health";
ITEM.ConsumeEffect =    75;
ITEM.ConsumeMessage =   "You've used a medkit on yourself.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
