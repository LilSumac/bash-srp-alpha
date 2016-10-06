local BASH = BASH;
local ITEM = {};
ITEM.ID =				"skat_9m_recruit";
ITEM.Name =				"SKAT-9M (Recruit)";
ITEM.Description =		"A military protective suit with outstanding ballistics and anomaly protection, second only to the exo-suit. Includes heavy, military-grade kevlar protection, an anomalous protection suit, and a respirator.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/skat_mili.mdl");
ITEM.Tier =             4;
ITEM.Weight =			12;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	74000;
ITEM.Durability =		35;
ITEM.FabricYield =		10;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/cakez/rxstalker/stalker_hero/stalker_hero_military_respi.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		40;
ITEM.BurnResist = 		25;
ITEM.AcidResist = 		25;
ITEM.ElectroResist = 	25;
ITEM.ColdResist = 		25;
ITEM.Inventory =		"inv_skat";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);