local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_glacier";
ITEM.Name =				"Glacier";
ITEM.Description =		"An artifact much like its lesser sibling the Icicle, the Glacier is a beautiful formation of anomalous ice. Its rarity shows in what little is understood of it, folklore telling tales of STALKERs able to brave the toughest of blizzards because of them. This artifact is an asset in the cold enviroment of its origin.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/spezzy/art_trystal.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	8000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    10;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
