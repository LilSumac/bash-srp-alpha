if CLIENT then
    SWEP.PrintName = "Crowbar";
    SWEP.ViewModelFlip = false;
elseif SERVER then
    AddCSLuaFile("shared.lua");
end

SWEP.Base = "bash_wep_base_melee";
SWEP.Category = "BASH Weapons";
SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.Primary.Damage = 20;
SWEP.MissSound = Sound("Weapon_Crowbar.Single");
SWEP.WallSound = Sound("Weapon_Crowbar.Melee_HitWorld");

SWEP.WorldModel = "models/weapons/w_crowbar.mdl";
SWEP.ViewModel = "models/weapons/c_crowbar.mdl";
SWEP.HoldType = "melee2";
SWEP.HolsterType = "normal";
SWEP.RunSightPos = Vector(0, 0, -8);
SWEP.RunSightAng = Angle(0, 0, 0);
SWEP.WallSightPos = Vector(0, 0, -5);
SWEP.WallSightAng = Angle(0, 0, 0);
SWEP.SafeSightPos = Vector(0, 0, -10);
SWEP.SafeSightAng = Angle(0, 0, 0);
