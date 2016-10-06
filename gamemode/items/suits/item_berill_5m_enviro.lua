local BASH = BASH;
local ITEM = {};
ITEM.ID =				"berill_5m_enviro";
ITEM.Name =				"Berill-5M (Environmental)";
ITEM.Description =		"A special protective suit made for the Ukrainian Military for use in the Zone. The most common varient for boots on the ground, with a balance between utility and protection. Comes integrated with the closed-circuit respiratory system seen most commonly on SEVA suits.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/berill_mili.mdl");
ITEM.Tier =             3;
ITEM.Weight =			6;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	36000;
ITEM.Durability =		25;
ITEM.FabricYield =		6;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/stalkertnb/beri_seva.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		30;
ITEM.BurnResist = 		20;
ITEM.AcidResist = 		20;
ITEM.ElectroResist = 	20;
ITEM.ColdResist = 		20;
ITEM.Inventory =		"inv_berill";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);