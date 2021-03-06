local BASH = BASH;
local ITEM = {};
ITEM.ID =				"cs3_drab";
ITEM.Name =				"Drab CS-3";
ITEM.Description =		"An interesting compilation of gear made for Clear Sky soldiers. Unlike its brethren, the CS-2, this suit focuses more on utilty than protection. Instead of a ballistic/load-bearing vest combination, this suit features a simple chest rigging and lacks a helmet.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/outfit/cs_heavy.mdl");
ITEM.Tier =             3;
ITEM.Weight =			8;
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	18000;
ITEM.Durability =		15;
ITEM.FabricYield =		6;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/stalkertnb/cs3_ltdead.mdl");
ITEM.BodyArmor = 		20;
ITEM.BurnResist = 		10;
ITEM.AcidResist = 		10;
ITEM.ElectroResist = 	10;
ITEM.ColdResist = 		10;
ITEM.Inventory =		"inv_cs3";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);
