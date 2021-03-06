local BASH = BASH;
local ITEM = {};
ITEM.ID =				"psz9d_mono";
ITEM.Name =				"Monolith PSZ-9d";
ITEM.Description =		"A cheap, run-of-the-mill protective suit often used as the flagship uniform for the footsoldiers of a faction. Comes with some basic ballistics protection and a respiratory system. This particular suit has been made for the Monolith group, with an arctic color scheme. Quite hard for the common STALKER to get their hands on.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/psz9d_monolith.mdl");
ITEM.Tier =             2;
ITEM.Weight =			6;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;
ITEM.Durability =		15;
ITEM.FabricYield =		5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/stalkertnb/psz9d_mono.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		15;
ITEM.BurnResist = 		10;
ITEM.AcidResist = 		10;
ITEM.ElectroResist = 	10;
ITEM.ColdResist = 		10;
ITEM.Inventory =		"inv_psz9d";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);
