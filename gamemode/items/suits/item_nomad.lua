local BASH = BASH;
local ITEM = {};
ITEM.ID =				"nomad";
ITEM.Name =				"Nomad Suit";
ITEM.Description =		"An extension of the simple anorak jacket, this suit features a tactical vest, convenient utility belt, and a simple respirator. Ideal for a STALKER on the move.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/io7a_merc3.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =			4;
ITEM.DefaultStock = 	25;
ITEM.DefaultPrice = 	3500;
ITEM.Durability =		5;
ITEM.FabricYield =		5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/stalkertnb/bandit_male7.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		10;
ITEM.BurnResist = 		5;
ITEM.AcidResist = 		5;
ITEM.ElectroResist = 	5;
ITEM.ColdResist = 		5;
ITEM.Inventory =		"inv_nomad";
ITEM.StorageSize =      STORAGE_MED;
ITEM.Upgradeable =      true;
ITEM.Upgrades = {
    {"cossack", 3500, {["fabric"] = 12}, {"kneepads_black", "belt_utility"}}
};
BASH:ProcessItem(ITEM);
