AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Browning Hi-Power"
	SWEP.CSMuzzleFlashes = true

	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.6
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 1, z = 1}
	SWEP.MuzzlePosOffset = {x = -10, y = 0, z = 0}


	SWEP.MicroT1Pos = Vector(-2.28, -4.661, -0.292)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.25, -6.198, -0.32)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-1.792, -2.319, 0.232)
	SWEP.IronsightAng = Vector(0.435, 0.061, 0)

	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(-1.767, -3.702, -0.04)
	SWEP.RMRAng = Vector(0.28, 0.123, 0)

	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)

	SWEP.LaserPosAdjust = Vector(0.2, -5, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)

	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1.6, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 20 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "gun_main", rel = "", pos = Vector(0.103, 3.003, 0.065), angle = Angle(0, 90, -90), size = Vector(0.312, 0.312, 0.312)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(-2.918, -1.555, -1.525), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_rmr"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "slide", pos = Vector(-2.784, -0.108, -0.244), angle = Angle(90, -90, 0), size = Vector(0.952, 0.952, 0.952)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "gun_main", pos = Vector(-0.024, 6.382, 0.071), angle = Angle(0, 180, 0), size = Vector(0.615, 0.615, 0.615)}
	}
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {
[1] = {header = "Sight", offset = {100, -400}, atts = {"md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_saker"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}



	SWEP.Sounds = {reload = {[1] = {time = 0.42, sound = "CW_HP_MAGOUT"},
	[2] = {time = 1, sound = "CW_HP_MAGIN"},
	[3] = {time = 1.6, sound = "CW_HP_SLIDE"}}}



SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_hpbr.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_hpbr.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 13
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_HPFIRE_FIRE"
SWEP.FireSoundSuppressed = "CW_DEAGLE_FIRE_SUPPRESSED"
SWEP.Recoil =0.8

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 21
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.98
SWEP.ReloadHalt = 2

SWEP.ReloadTime_Empty = 1.98
SWEP.ReloadHalt_Empty = 2
