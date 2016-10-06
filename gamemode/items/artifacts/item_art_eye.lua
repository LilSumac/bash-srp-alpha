local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_eye";
ITEM.Name =				"Eye";
ITEM.Description =		"This artifact, which resembles the human eye, considerably increases the body's metabolism, helping wounds heal quicker. Experienced stalkers say that the Eye also brings luck. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/eye.mdl");
ITEM.Tier =             4;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;

ITEM.IsArtifact =       true;
ITEM.ArmorBoost =       10;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
