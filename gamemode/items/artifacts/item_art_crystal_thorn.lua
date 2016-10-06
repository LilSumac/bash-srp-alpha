local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_crystal_thorn";
ITEM.Name =				"Crystal Thorn";
ITEM.Description =		"Crystallizes in the anomaly Burnt Fuzz. Naturally takes out the radiation from the organism. That is, through the ears along with some amount of blood. Blood loss is possible also through other openings. Widespread and quite effective, which is the cause for the stable price in the artifact market. ";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_crystalthorn.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	12000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       -15;
BASH:ProcessItem(ITEM);
