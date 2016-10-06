local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_icicle";
ITEM.Name =				"Glacier";
ITEM.Description =		"A frozen, anomalous formation that is cold to the touch. This artifact is spawned by the frost anomalies spotted within the permanantly frozen areas of the Zone. Its effects are mostly unknown save for that it seems to protect the holder against the very conditions that formed it.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/spezzy/art_ftoneflower.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	4000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    5;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
