local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_vss";
ITEM.Name =             "VSS Vintorez";
ITEM.Description =      "A suppressed Russian sniper rifle issued primarily to Spetsnaz units. Chambers a 9x39mm subsonic round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/cw2/rifles/w_vss.mdl");
ITEM.Tier =             5;
ITEM.Weight =           3;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     64000;
ITEM.Durability =       20000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_vss";
ITEM.AmmoType =         "9x39";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_pso1"}},
	[2] = {header = "Magazine", atts = {"bg_asval_20rnd"}},
	[3] = {header = "Receiver", atts = {"bg_asval"}}
};
BASH:ProcessItem(ITEM);
