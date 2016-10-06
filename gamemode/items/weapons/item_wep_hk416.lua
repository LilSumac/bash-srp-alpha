local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_hk416";
ITEM.Name =             "HK416";
ITEM.Description =      "An extremely modern German carbine, chambered with a 5.56 NATO round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_cwkk_hk416.mdl");
ITEM.Tier =             4;
ITEM.Weight =           3;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     45000;
ITEM.Durability =       5000;
ITEM.MetalYield =       5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_hk416";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    {header = "Sight", atts = {"bg_hk416_foldsight", "md_reflex", "md_eotech", "md_aimpoint", "md_acog"}},
    {header = "Barrel ext", atts = {"bg_hk416_longbarrel"}},
    {header = "Barrel", atts = {"md_saker"}},
    {header = "Side Rail", atts = {"bg_hk416_railcover"}},
    {header = "Handguard", atts = {"md_foregrip", "md_hk416_bipod", "md_m203"}},
    {header = "Magazine", atts = {"bg_hk416_34rndmag", "bg_hk416_cmag"}},
    {header = "Stock", atts = {"bg_hk416_heavystock", "bg_hk416_nostock"}}
};
BASH:ProcessItem(ITEM);
