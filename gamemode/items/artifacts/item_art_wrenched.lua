local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_wrenched";
ITEM.Name =				"Wrenched";
ITEM.Description =		"This bizarrely-shaped artifact appears in places with increased gravitational activity. Acts as a kind of sponge that absorbs radioactive elements. In so doing, the artifact provides protection from outside radiation as well as from radioactive particles that have already made their way into the body.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/wrenched.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	5000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       -5;
BASH:ProcessItem(ITEM);
