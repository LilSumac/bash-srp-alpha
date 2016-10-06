local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_svd";
ITEM.Name =             "Dragunov SVD";
ITEM.Description =      "A semi-automatic DMR developed in the Soviet Union. Chambers a 7.62x54mmR round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/drag/w_snip_dragn.mdl");
ITEM.Tier =             4;
ITEM.Weight =           4.5;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     58000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_svd";
ITEM.AmmoType =         "762x54";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_kobra", "md_aimpoint", "md_acog", "md_pso1", "md_fas2_leupold"}},
    [2] = {header = "Barrel", atts = {"md_saker"}},
    [3] = {header = "Handguard", atts = {"md_foregrip", "md_hk416_bipod"}},
    [4] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
