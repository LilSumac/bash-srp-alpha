local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_urchin";
ITEM.Name =				"Urchin";
ITEM.Description =		"The Burnt Fuzz anomaly very rarely gives rise to this artifact. Blood pressure rises, the body gets rid of a large amount of red blood cells. But along with them the stored radiation leaves the body as well. In his fundamental work titled \'Ionization and Polarization of the Components of Rare Artifacts\', Sakharov noted that the content of this formation has a critical stability, and it's not realistic to create such an artifact in lab conditions in the next ten years.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_urchen.mdl");
ITEM.Tier =             3;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	30000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       -10;
ITEM.RadsPerMin =       -30;
BASH:ProcessItem(ITEM);
