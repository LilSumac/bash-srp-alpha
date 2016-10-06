local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_compass";
ITEM.Name =				"Compass";
ITEM.Description =		"A rare artifact – it's been several years since one was found. The artifact can locate gaps in anomaly fields, effectively acting as a compass. It is believed that it can help one traverse the most complex anomaly fields completely unharmed. However, very few know how to handle it properly.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/compass.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	80000;

ITEM.IsArtifact =       true;
ITEM.BurnResist =       10;
ITEM.AcidResist =       10;
ITEM.ElectroResist =    10;
ITEM.RadsPerMin =       40;
BASH:ProcessItem(ITEM);
