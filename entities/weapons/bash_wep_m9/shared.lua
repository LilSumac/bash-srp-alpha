AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Beretta M9"
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

	SWEP.IronsightPos = Vector(2.43, -3.106, 0.879)
	SWEP.IronsightAng = Vector(0.621, -1.849, 0)

	SWEP.RMRPos = Vector(2.322, -2.606, 0.656)
	SWEP.RMRAng = Vector(-0.141, -2.48, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)

	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)

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
	SWEP.BoltBone = "slidey"
	SWEP.BoltShootOffset = Vector(-1.7, -0.05, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 20 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "mnine", rel = "", pos = Vector(-1.578, -13.749, -2.835), angle = Angle(5.045, -90, -90), size = Vector(0.199, 0.199, 0.199)},
		["md_rmr"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "slidey", pos = Vector(-1.229, -9.346, -1.247), angle = Angle(-1.096, -180, 0), size = Vector(0.816, 0.816, 0.816)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "mnine", pos = Vector(-1.438, -17.298, -2.837), angle = Angle(0, 0, -4.368), size = Vector(0.626, 0.626, 0.626)}
	}
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[3] = {header = "Rail", offset = {50, 200}, atts = {"md_anpeq15"}},
[1] = {header = "Sight", offset = {300, -400}, atts = {"md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_tundra9mm"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload_unsil",
	reload_empty = "reload_unsil",
	idle = "idle_unsil",
	draw = "draw_unsil"}



	SWEP.Sounds = {reload_unsil = {[1] = {time = 0.42, sound = "CW_TOKAREV_MAGOUT"},
	[2] = {time = 1, sound = "CW_TOKAREV_MAGIN"},
	[3] = {time = 1.6, sound = "CW_GLOCK_CLOTH"}}}



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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_pist_m92.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_cz75.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_GLOCKFIRE_FIRE"
SWEP.FireSoundSuppressed = "CW_DEAGLE_FIRE_SUPPRESSED"
SWEP.Recoil =0.8

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 18
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.98
SWEP.ReloadHalt = 2

SWEP.ReloadTime_Empty = 1.98
SWEP.ReloadHalt_Empty = 2
