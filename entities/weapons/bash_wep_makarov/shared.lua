AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Makarov"
	SWEP.CSMuzzleFlashes = true

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true

	SWEP.IronsightPos = Vector(-3.7, 2.5957, 2.5)
	SWEP.IronsightAng = Vector(0.25, 0.25, 0)

	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {};

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.2, sound = "CW_MR96_CYLINDEROPEN"},
	[2] = {time = 0.5, sound = "CW_MR96_CYLINDERCLOSE"},
	[3] = {time = 0.9, sound = "CW_COMPACT45_SLIDE"}}
}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_makaro.mdl"
SWEP.WorldModel		= "models/weapons/w_makaro.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x18"

SWEP.FireDelay = 0.09
SWEP.FireSound = "BASH_MAKAROV_FIRE"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.04
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 15
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.4
SWEP.ReloadHalt = 1.4

SWEP.ReloadTime_Empty = 1.4
SWEP.ReloadHalt_Empty = 1.4
