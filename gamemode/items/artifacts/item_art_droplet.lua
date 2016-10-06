local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_droplet";
ITEM.Name =				"Droplet";
ITEM.Description =		"Formed in the Burner anomaly at high temperatures. From the exterior looks like a tear-like shade compound with a glossy surface, covered in cracks. Users often report heightened emotions.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_droplet.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	2000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       -5;
BASH:ProcessItem(ITEM);
