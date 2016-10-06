AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
CustomizableWeaponry:registerAmmo("7.62×25mm", "7.62x25 Rounds", 7.62, 25)
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TT-30"
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

	SWEP.IronsightPos = Vector(-2.283, -4.652, 0.233)
	SWEP.IronsightAng = Vector(0.953, 0, 0)

	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(-2.234, -3.034, -0.245)
	SWEP.RMRAng = Vector(1.725, 0.27, 0)

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
		["md_rmr"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "slide", pos = Vector(0.195, 1.491, 0.405), angle = Angle(0, 180, 0), size = Vector(0.921, 0.921, 0.921)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(-0.007, -4.713, -0.747), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)}
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


	SWEP.Sounds = {reload = {[1] = {time = 0.42, sound = "CW_TOKAREV_MAGOUT"},
	[2] = {time = 1.2, sound = "CW_TOKAREV_MAGIN"},
	[3] = {time = 1.9, sound = "CW_TOKAREV_SLIDE"}},

	draw = {[1] = {time = -0.03, sound = "CW_TOKAREV_DEPLOY"}}}



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
SWEP.ViewModel		= "models/weapons/v_pist_tokevpist.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_tokevpist.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762×25"

SWEP.FireDelay = 0.04
SWEP.FireSound = "CW_TOKAREV_FIRE"
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
