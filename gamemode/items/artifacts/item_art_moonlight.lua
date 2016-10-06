local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_moonlight";
ITEM.Name =				"Moonlight";
ITEM.Description =		"Degenerate case of the activity of the Electro anomaly. It seems that such a wonderful round form is created when the anomaly is subjected to thermal influences. Expensive artifact.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/predatorcz/stalker/artifacts/electra_blue.mdl");
ITEM.Tier =             2;
ITEM.Weight =			2;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    20;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
