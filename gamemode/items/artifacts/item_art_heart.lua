local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_heart";
ITEM.Name =				"Heart of the Oasis";
ITEM.Description =		"A strange object that hails from the equally-mysterious location known as 'The Oasis'. The subject of many legends within the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/predatorcz/stalker/artifacts/crystal_plant.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	80000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       15;
ITEM.ElectroResist =    15;
ITEM.BurnResist =       15;
ITEM.RadsPerMin =       25;
BASH:ProcessItem(ITEM);
