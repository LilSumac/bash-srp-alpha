AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPD"
	SWEP.CSMuzzleFlashes = true

	SWEP.IronsightPos = Vector(-4.1, 0, 3.05)
	SWEP.IronsightAng = Vector(-0.5, 0, 0)

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

	SWEP.Sounds = {	draw = {{time = 0, sound = "CW_DZ_M249_CLOTH"}},

		reload = {[1] = {time = 0.5, sound = "CW_DZ_M249_COVEROPEN"},
		[2] = {time = 1.2, sound = "CW_DZ_M249_MAGOUT"},
		[3] = {time = 1.6, sound = "CW_DZ_M249_MAGIN"},
		[4] = {time = 2.5, sound = "CW_DZ_M249_BELTIN"},
		[5] = {time = 3.4, sound = "CW_DZ_M249_COVERCLOSE"},
		[6] = {time = 4.5, sound = "CW_AK74_BOLTPULL"}}
	}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "LilSumac"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rpd.mdl"
SWEP.WorldModel		= "models/weapons/w_rpd.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "762x39_belt"

SWEP.FireDelay = 0.092307692307692
SWEP.FireSound = "CW_PKM_FIRE"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 48
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.8
SWEP.ReloadTime_Empty = 4.8
SWEP.ReloadHalt = 4.8
SWEP.ReloadHalt_Empty = 4.8
SWEP.SnapToIdlePostReload = true
