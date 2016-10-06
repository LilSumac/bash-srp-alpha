local BASH = BASH;
local ITEM = {};
ITEM.ID =				"baseballcap_dea";
ITEM.Name =				"DEA Cap";
ITEM.Description =		"A black cap with \'DEA\' printed on the front. To be worn forwards, backwards, or any which way.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props/cs_office/Snowman_hat.mdl");
ITEM.ModelColor =       Color(0, 0, 0);
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	50;
ITEM.FabricYield =		2;
ITEM.LootHidden =       true;

ITEM.IsClothing =		true;
ITEM.BodyPos =          "Head";
BASH:ProcessItem(ITEM);
