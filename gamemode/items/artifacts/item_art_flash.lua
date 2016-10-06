local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_flash";
ITEM.Name =				"Flash";
ITEM.Description =		"Thanks to its heavily crystallized molecules, this electrostatic artifact is a powerful absorbent of electric charges, able to protect its bearer from electric shocks of up to 5,000 volts. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/predatorcz/stalker/artifacts/electra_flash.mdl");
ITEM.Tier =             2;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	10000;

ITEM.IsArtifact =       true;
ITEM.ElectroResist =    10;
ITEM.RadsPerMin =       15;
BASH:ProcessItem(ITEM);
