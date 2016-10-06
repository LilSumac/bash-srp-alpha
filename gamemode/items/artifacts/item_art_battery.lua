local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_battery";
ITEM.Name =				"Battery";
ITEM.Description =		"The origin of this item remains a scientific enigma. It is only known that its composition includes dielectric elements, but scientists have yet to identify the exact physical conditions required for its formation. The artifact is popular in the Zone and valued by its residents and visitors for its restorative abilities. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/battery.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	55000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    30;
ITEM.RadsPerMin =       25;
BASH:ProcessItem(ITEM);
