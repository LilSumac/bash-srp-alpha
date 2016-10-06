local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_wheel";
ITEM.Name =				"Altered Wheel";
ITEM.Description =		"A former wheel that controlled some part of a dredge station, now some sort of half-artifact that emits quite a bit of radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/predatorcz/stalker/artifacts/control.mdl");
ITEM.Tier =             3;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	18000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       50;
BASH:ProcessItem(ITEM);
