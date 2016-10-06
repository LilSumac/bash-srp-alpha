local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_fireball";
ITEM.Name =				"Fireball";
ITEM.Description =		"Crystallizes in the anomaly Burner. Fights well with radioactivity, though the heightened rate of energy exchange wears out the muscles of the moving apparatus. Artifact emits heat.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/fireball.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	6000;

ITEM.IsArtifact =       true;
ITEM.BurnResist =       10;
ITEM.RadsPerMin =       -10;
BASH:ProcessItem(ITEM);
