local BASH = BASH;
local ITEM = {};
ITEM.ID =				"bandages";
ITEM.Name =				"Bandages";
ITEM.Description =		"A roll of clean white bandages.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/medical/bandage.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		20;
ITEM.DefaultStock =     100;
ITEM.DefaultPrice =     100;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Treat";
ITEM.ConsumeVariable =  "Health";
ITEM.ConsumeEffect =    10;
ITEM.ConsumeMessage =   "You've applied a bandage to yourself.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
