local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_p220";
ITEM.Name =             "P220";
ITEM.Description =      "A common German sidearm that has spawned countless varients. Chambered with a 9mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_o226.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1;
ITEM.DefaultStock =     12;
ITEM.DefaultPrice =     5000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_p220";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Barrel", atts = {"md_tundra9mm"}}
};
BASH:ProcessItem(ITEM);
