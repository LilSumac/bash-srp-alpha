local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_mica";
ITEM.Name =				"Mica";
ITEM.Description =		"The Fruit Punch anomaly is able to create such an artifact at the rarest, most extreme collection of physical conditions. The result is a semi-transparent and dense object. A rare and expensive artifact.";
ITEM.FlavorText =		"Diamonds of the Zone.";
ITEM.WorldModel =		Model("models/srp/items/art_mica.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	12000;

ITEM.IsArtifact =       true;
ITEM.AcidResist =       -10;
ITEM.BurnResist =       -10;
ITEM.ArmorBoost =       10;
BASH:ProcessItem(ITEM);
