local BASH = BASH;
local ITEM = {};
ITEM.ID =				"trenchcoat_green";
ITEM.Name =				"Green Trenchcoat";
ITEM.Description =		"Garb usually worn by the bandits of the Zone. Offers little to no protection against any of the Zone's deadly flora or fauna.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/outfit/bandit3a.mdl");
ITEM.Weight =			3;
ITEM.LootHidden =       false;
ITEM.DefaultStock = 	100;
ITEM.DefaultPrice = 	750;
ITEM.Durability =		3;
ITEM.FabricYield =		5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/cakez/rxstalker/stalker_bandit/stalker_bandit4b.mdl");
ITEM.BodyArmor = 		3;
ITEM.BurnResist = 		3;
ITEM.AcidResist = 		3;
ITEM.ElectroResist = 	3;
ITEM.ColdResist = 		3;
ITEM.Inventory =		"inv_trenchcoat";
ITEM.StorageSize =      STORAGE_MED;
ITEM.Upgradeable =      true;
ITEM.Upgrades = {
    {"trenchcoat_green_reinf", 2500, {["fabric"] = 8}, {"ballistic_vest"}}
};
BASH:ProcessItem(ITEM);
