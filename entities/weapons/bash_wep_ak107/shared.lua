AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-107"
	SWEP.CSMuzzleFlashes = true

	SWEP.IronsightPos = Vector(4.65, 0, 1)
	SWEP.IronsightAng = Vector(1, -0.5, 0)

	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -2}
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {}

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {	draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.2, sound = "CW_AK74_MAGOUT"},
	[2] = {time = 0.7, sound = "CW_AK74_MAGIN"},
	[3] = {time = 1.4, sound = "CW_AK74_BOLTPULL"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "LilSumac"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_ak107.mdl"
SWEP.WorldModel		= "models/weapons/w_ak107.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "545x39"

SWEP.FireDelay = 0.092307692307692
SWEP.FireSound = "CW_AK74_FIRE"
SWEP.Recoil = 1.2

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 2
SWEP.SnapToIdlePostReload = true
