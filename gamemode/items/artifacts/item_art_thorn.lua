local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_thorn";
ITEM.Name =				"Thorn";
ITEM.Description =		"The result of the interaction between the anomaly Burnt Fuzz and the body of a careless stalker. The Thorn artifact pokes the body of its owner, no matter what. But it also helps clean the body of radionucliodes. Quite widespread and cheap.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_thorn.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	5000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       -10;
BASH:ProcessItem(ITEM);
