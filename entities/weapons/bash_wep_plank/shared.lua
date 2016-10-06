if CLIENT then
    SWEP.PrintName = "Wooden Plank";
    SWEP.ViewModelFlip = false;
elseif SERVER then
    AddCSLuaFile("shared.lua");
end

SWEP.Base = "bash_wep_base_melee";
SWEP.Category = "BASH Weapons";
SWEP.Spawnable = true;
SWEP.AdminSpawnable = true;

SWEP.Primary.Damage = 20;
SWEP.MissSound = Sound("weapons/knife/knife_slash1.wav");
SWEP.WallSound = Sound("weapons/melee/crowbar/crowbar_hit-1.wav");

SWEP.WorldModel = "models/weapons/w_plank.mdl";
SWEP.ViewModel = "models/weapons/v_plank.mdl";
SWEP.HoldType = "melee";
SWEP.HolsterType = "normal";
SWEP.RunSightPos = Vector(0, 0, -8);
SWEP.RunSightAng = Angle(0, 0, 0);
SWEP.WallSightPos = Vector(0, 0, -5);
SWEP.WallSightAng = Angle(0, 0, 0);
SWEP.SafeSightPos = Vector(0, 0, -10);
SWEP.SafeSightAng = Angle(0, 0, 0);
