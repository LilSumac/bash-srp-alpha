local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_firefly";
ITEM.Name =				"Firefly";
ITEM.Description =		"Firefly interacts with fields unknown to science, considerably speeding up regeneration of tissue and organs in living beings, as well as normalizing metabolic processes. This artifact can literally get a badly wounded stalker back on his feet in seconds. Unfortunately, Firefly is extremely rare. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/predatorcz/stalker/artifacts/glass.mdl");
ITEM.Tier =             5;
ITEM.Weight =			2;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	55000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       20;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
