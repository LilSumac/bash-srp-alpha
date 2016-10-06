local BASH = BASH;
local ITEM = {};
ITEM.ID =				"railboy";
ITEM.Name =				"\'The Railboy\'";
ITEM.Description =		"A marvel of modern protection, almost looks straight out of a post-apocalyptic video game. Features a heavy ballistics vest, a heavy helmet, and military-grade BDUs.";
ITEM.FlavorText =		"Lord, what a splendid world we ruined...";
ITEM.WorldModel =		Model("models/stalkertnb/outfits/skat_merc.mdl");
ITEM.Tier =             4;
ITEM.Weight =			26;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;
ITEM.Durability =		35;
ITEM.FabricYield =		10;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsSuit =			true;
ITEM.PlayerModel =		Model("models/cakez/rxstalker/stalker_neutral/now_neutral_razgr_1.mdl");
ITEM.Respiration =      true;
ITEM.BodyArmor = 		45;
ITEM.HelmetArmor =      15
ITEM.BurnResist = 		5;
ITEM.AcidResist = 		5;
ITEM.ElectroResist = 	5;
ITEM.ColdResist = 		5;
ITEM.Inventory =		"inv_blastsuit";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);
