local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_nebula";
ITEM.Name =				"Nebula";
ITEM.Description =		"The Nebula artifact, named for its shifting inner patterns, is one of the frigid artifacts spawned from the biting cold of the Zone's winter regions. Like the others of its 'family', its effects are mostly unrecorded aside from the cold resistance all of these artifacts seem to offer.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/srp/items/spezzy/art_poonlight.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	16000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    15;
ITEM.RadsPerMin =       15;
BASH:ProcessItem(ITEM);
