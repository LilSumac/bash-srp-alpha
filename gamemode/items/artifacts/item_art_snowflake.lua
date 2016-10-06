local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_snowflake";
ITEM.Name =				"Snowflake";
ITEM.Description =		"At first glance, this artifact resembles Kolobok. Some claim that it actually is Kolobok, its properties reinforced by exposure to a powerful electric field. The artifact has excellent electrostimulative properties, increasing the bearer's vitality considerably. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/snowflake.mdl");
ITEM.Tier =             3;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
