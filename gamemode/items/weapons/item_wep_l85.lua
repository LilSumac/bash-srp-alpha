local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_l85";
ITEM.Name =             "SA80-A2";
ITEM.Description =      "The civilian variant of the standard issue service rifle of the British Armed Forces. Chambers a 5.56x45mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_rif_dzl85.mdl");
ITEM.Tier =             3;
ITEM.Weight =           4;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     26000;
ITEM.Durability =       4000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_l85";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_attghostring"}},
	[2] = {header = "Barrel", atts = {"md_saker", "md_flashhider1", "md_muzzlebrake"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
