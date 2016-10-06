if CustomizableWeaponry then

SWEP.magType = "pistolMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "MP412 REX"
	SWEP.CSMuzzleFlashes = true

	SWEP.IconLetter = "f"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_pistol_rbull"
	SWEP.PosBasedMuz = true

	SWEP.DryFire = true

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}

	SWEP.MicroT1Pos = Vector(-2.115, -2.8, 0.04)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.328, -3.053, -0.567)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.DocterPos = Vector(-2.346, -3, 0.142)
	SWEP.DocterAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.326, -2.126, 0.507)
	SWEP.IronsightAng = Vector(0.49, 0.14, 0)

	SWEP.ACOGPos = Vector(-2.32, -3.053, -0.518)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.634, -8.28, -8.311)
	SWEP.SprintAng = Vector(70, 0, 0)

	SWEP.AlternativePos = Vector(-0.88, 1.325, -0.561)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.MoveType = 1

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-2.32, -3.053, -1.366), [2] = Vector(0.345, 0, 0)},
	["md_acog_fixed"] = {[1] = Vector(-2.32, -3.053, -1.395), [2] = Vector(0, 0, 0)}
	}

	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true

	SWEP.AttachmentModelsVM = {
--		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "MP412_Barrel", rel = "", pos = Vector(0, 2.24, 0.8), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255)},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "MP412_Barrel", rel = "", pos = Vector(-0.28, -5, -1.963), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_docter"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "MP412_Barrel", rel = "", pos = Vector(-0.239, -1.44, 2.483), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "MP412_Barrel", rel = "", pos = Vector(0, -6.2, 0.1), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "MP412_Barrel", rel = "", pos = Vector(-0.28, -5, -1.963), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.LaserPosAdjust = Vector(0, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(1, 180, 0) --{p = 2, y = 180, r = 0}

end

SWEP.BarrelBGs = {main = 1, regular = 0, compensator = 1, extended = 2}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {-550, -400}, atts = {"md_elcan", "md_docter"}},
	["+reload"] = {header = "Ammo", offset = {-550, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"rex_fire1", "rex_fire2"},
	fireDry = "rex_fire_empty",
	reload = "rex_reload",
	reload_empty = "rex_reload",
	idle = "rex_idle",
	draw = "rex_deploy"}

SWEP.Sounds = {rex_reload = {[1] = {time = 0.45, sound = "CW_MP412_CYLINDEROPEN"},
	[2] = {time = 1.05, sound = "CW_MP412_ROUNDSOUT"},
	[3] = {time = 2.55, sound = "CW_MP412_ROUNDSIN"},
	[4] = {time = 3.35, sound = "CW_MP412_CYLINDERCLOSE"}},
	rex_deploy = {{time = 0.01, sound = "CW_XM8_CLOTH"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pist_mp412.mdl"
SWEP.WorldModel		= "models/weapons/w_daxb_bronco.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "357mag"

SWEP.FireDelay = 0.235
SWEP.FireSound = "CW_MP412_FIRE"
SWEP.FireSoundSuppressed = "CW_MP412_FIRE_SUPPRESSED"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.039
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.02
SWEP.SpreadCooldown = 0.25
SWEP.Shots = 1
SWEP.Damage = 46
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4
SWEP.ReloadHalt = 4

SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt_Empty = 4

end
