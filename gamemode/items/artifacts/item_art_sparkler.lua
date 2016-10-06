local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_sparkler";
ITEM.Name =				"Sparkler";
ITEM.Description =		"A bright representative of the electrostatic family of artifacts, this artifact can smooth fluctuations in electric field density. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/sparkler.mdl");
ITEM.Tier =             1;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	6000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    10;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
