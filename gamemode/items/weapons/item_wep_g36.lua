local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_g36";
ITEM.Name =             "G36C";
ITEM.Description =      "A German assault rifle made to replace the G3. Chambers a 5.56x45mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/cw20_g36c.mdl");
ITEM.Tier =             4;
ITEM.Weight =           3;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     48000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_g36";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip"}},
	[4] = {header = "Rail", atts = {"md_anpeq15"}, dependencies = {md_microt1 = true, md_eotech = true, md_schmidt_shortdot = true, md_acog = true}}
};
BASH:ProcessItem(ITEM);
