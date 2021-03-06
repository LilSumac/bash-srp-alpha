local BASH = BASH;
local ITEM = {};
ITEM.ID =				"berill_2k_assault";
ITEM.Name =				"Berill-2K (Assault)";
ITEM.Description =		"A special protective suit made for the Ukrainian Military for use in the Zone. This particular lighter varient of the original 5M series provides more maneuverability at the expense of protection, along with a lighter green color scheme. Comes with a Sphere-08 tactical helmet.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/berill_mili.mdl");
ITEM.Tier =             3;
ITEM.Weight =			6;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	25000;
ITEM.Durability =		20;
ITEM.FabricYield =		6;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/cakez/rxstalker/stalker_hero/stalker_hero_svoboda_light_tacti.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		25;
ITEM.HelmetArmor =      15;
ITEM.BurnResist = 		10;
ITEM.AcidResist = 		10;
ITEM.ElectroResist = 	10;
ITEM.ColdResist = 		10;
ITEM.Inventory =		"inv_berill";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);
