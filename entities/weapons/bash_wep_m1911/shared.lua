AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
CustomizableWeaponry:registerAmmo(".45 ACP", ".45 Rounds", 11.43, 23)
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1911"
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

	SWEP.IronsightPos = Vector(-2.161, -2.148, 0.368)
	SWEP.IronsightAng = Vector(0.772, 0.071, 0)

	SWEP.ACOGPos = Vector(-2.247, -6.5, -0.602)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(-2.112, -1.977, 0.218)
	SWEP.RMRAng = Vector(0.21, 0.287, 0)

	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)

	SWEP.LaserPosAdjust = Vector(-0.3, -10, 0)
	SWEP.LaserAngAdjust = Angle(5.32, 180, 0)

	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.241, -4.728, -1.568), [2] = Vector(0, 0, 0)}}

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "slide"
	SWEP.BoltShootOffset = Vector(-1, 0, 0)
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 20 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "body", rel = "", pos = Vector(0.024, -0.38, 3.364), angle = Angle(-95, 0, 0), size = Vector(0.236, 0.236, 0.236)},
		["md_rmr"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "slide", pos = Vector(0.186, -0.513, 1.45), angle = Angle(180, 0, -90), size = Vector(0.896, 0.896, 0.896)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(0.032, 0.479, -2.616), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5)}
	}
end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[3] = {header = "Rail", offset = {50, 200}, atts = {"md_anpeq15"}},
[1] = {header = "Sight", offset = {500, -250}, atts = {"md_rmr"}},
[2] = {header = "Barrel", offset = {-600, -350}, atts = {"md_saker"}}}

SWEP.Animations = {fire = {"shoot1_unsil", "shoot2_unsil"},
	reload = "reload",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}


	SWEP.Sounds = {reload = {[1] = {time = 0.5, sound = "CW_M1911_MAGOUT"},
	[2] = {time = 1, sound = "CW_M1911_MAGIN"},
	[3] = {time = 1.2, sound = "CW_M1911_SLIDE"}},

	draw = {[1] = {time = 0, sound = "CW_M1911_DRAW"}}
	}




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
SWEP.ViewModel		= "models/weapons/v_pist_m1911a.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_hpbr.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "45acp"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_M911_FIRE"
SWEP.FireSoundSuppressed = "CW_M1911_SUPP"
SWEP.Recoil =1

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.020
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 32
SWEP.DeployTime = 1
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.98
SWEP.ReloadHalt = 2

SWEP.ReloadTime_Empty = 1.98
SWEP.ReloadHalt_Empty = 2
