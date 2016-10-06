local BASH = BASH;
local ITEM = {};
ITEM.ID =				"scrap_fabric";
ITEM.Name =				"Scrap Fabric";
ITEM.Description =		"Just some pieces of scrapped fabric. Perhaps someone could make use of these?";
ITEM.FlavorText =		"You got a Kik, STALKER?";
ITEM.WorldModel =		{
	Model("models/gibs/metal_gib1.mdl"),
	Model("models/gibs/metal_gib2.mdl"),
	Model("models/gibs/metal_gib3.mdl"),
	Model("models/gibs/metal_gib4.mdl"),
	Model("models/gibs/metal_gib5.mdl")
};
ITEM.ModelColor =       Color(209, 139, 89);
ITEM.Weight =			0.25;
ITEM.DefaultPrice =		100;
ITEM.DefaultStock =		1000;
ITEM.IsStackable =		true;
ITEM.MaxStacks =		10;

ITEM.IsScrap =			true;
BASH:ProcessItem(ITEM);
