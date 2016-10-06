local BASH = BASH;
local ITEM = {};
ITEM.ID =				"antirad";
ITEM.Name =				"Anti-rad Medication";
ITEM.Description =		"A pack of pills that counters the effects of radiation sickness.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/item/medical/antirad.mdl");
ITEM.IsStackable =		true;
ITEM.MaxStacks =		4;

ITEM.IsConsumable =     true;
ITEM.ConsumeString =    "Treat";
ITEM.ConsumeVariable =  "Radiation";
ITEM.ConsumeEffect =    -25;
ITEM.ConsumeMessage =   "You've consumed the anti-rad pills.";
ITEM.ConsumeIcon =      "icon16/pill.png";
BASH:ProcessItem(ITEM);
