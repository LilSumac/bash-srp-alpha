local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_meat_chunk";
ITEM.Name =				"Meat Chunk";
ITEM.Description =		"This organic artifact consists of fossilized, mutated animal tissues. Exudes a mucous fluid which partially neutralizes the effects of harmful chemicals on human skin. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/meat chunk.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       10;
ITEM.RadsPerMin =       15;
BASH:ProcessItem(ITEM);
