local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_slug";
ITEM.Name =				"Slug";
ITEM.Description =		"Formed by the Fruit Punch anomaly. The negative effects of this artifact are countered by the fact that it heightens the coagulation quality of blood, making the user bleed more slowly. It's also known to cause a sensitivity to light for unknown reasons.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/art_slug.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	10000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       10;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
