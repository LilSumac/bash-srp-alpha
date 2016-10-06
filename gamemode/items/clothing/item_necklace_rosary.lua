local BASH = BASH;
local ITEM = {};
ITEM.ID =				"necklace_rosary";
ITEM.Name =				"Rosary";
ITEM.Description =		"A necklace of metal beads used for Catholic prayer.";
ITEM.FlavorText =		"Life everlasting.";
ITEM.WorldModel =		Model("models/Items/CrossbowRounds.mdl");
ITEM.ModelScale =       0.5;
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Tier =             2;
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	200;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Neck";
BASH:ProcessItem(ITEM);
