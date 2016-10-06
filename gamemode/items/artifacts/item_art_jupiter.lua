local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_jupiter";
ITEM.Name =				"The Eye of Jupiter";
ITEM.Description =		"An artifact that has never been touched by the hands of men, until now.";
ITEM.FlavorText =		"I committed the first crime by creating men as mortals. After that, what more could you do, you the murderers?";
ITEM.WorldModel =		Model("models/srp/items/art_zoonlight.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	120000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       80;
BASH:ProcessItem(ITEM);
