AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AK-12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}

	SWEP.IronsightPos = Vector(-2.083, -2, 0.6)
	SWEP.IronsightAng = Vector(0, 0.6, 0)

	SWEP.CoyotePos = Vector(-2.07, -2, 0.33)
    SWEP.CoyoteAng = Vector(0, 0.6, 0)

	SWEP.EoTechPos = Vector(-2.07, -2, 0.29)
	SWEP.EoTechAng = Vector(0, 0.6, 0)

	SWEP.AimpointPos = Vector(-2.03, -2, 0.379)
	SWEP.AimpointAng = Vector(0, 0.699, 0)

	SWEP.MicroT1Pos = Vector(-2.02, -2, 0.259)
	SWEP.MicroT1Ang = Vector(0, 0.8, 0)

	SWEP.BFReflexPos = Vector(-2.06, -2, 0.4)
    SWEP.BFReflexAng = Vector(0, 0.699, 0)

	SWEP.RscopePos = Vector(-2.151, -4, 0.4)
    SWEP.RscopeAng = Vector(-0.5, -0.101, 0)

	SWEP.CSGOACOGPos = Vector(-2.08, -4, 0.28)
	SWEP.CSGOACOGAng = Vector(0.6, 1, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.PSO1AxisAlign = {right = 0, up = 90, forward = 180}
	SWEP.BFRIFLEAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl",bone = "ak12", rel = "", pos = Vector(-0.368, 11, 0.8), angle = Angle(0, 88, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "ak12", rel = "", pos = Vector(-0.201, 17.299, -1.06), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_cyotesight"] = {model = "models/rageattachments/cyotesight.mdl", bone = "ak12", rel = "", pos = Vector(-0.01, 0, 1), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_bfreflex"] = {model = "models/rageattachments/usareddot.mdl", bone = "ak12", rel = "", pos = Vector(-0.051, -0.5, 0.8), angle = Angle(0, -90, 0), size = Vector(0.54, 0.54, 0.54)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "ak12", rel = "", pos = Vector(-0.13, -3.5, -1.9), angle = Angle(0, 0, 0), size = Vector(0.54, 0.54, 0.54)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "ak12", rel = "", pos = Vector(0.119, -6, -4.58), angle = Angle(0, -90, 0), size = Vector(0.54, 0.54, 0.54)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "ak12", pos = Vector(-0.201, 6, -1.701), angle = Angle(0, 0.2, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl",  bone = "ak12", rel = "", pos = Vector(0, 0, 1.299), angle = Angle(0, 180, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_csgo_acog"] = {model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "ak12", rel = "", pos = Vector(0, -3.636, -1.101), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_bfriflescope"] = {model = "models/rageattachments/sniperscopesv.mdl", bone = "ak12", rel = "", pos = Vector(-0.04, 0, 1.1), angle = Angle(0, -180, 0), size = Vector(0.529, 0.529, 0.529)},
	}
	SWEP.LaserPosAdjust = Vector(1, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end

SWEP.SightBGs = {main = 4, carryhandle = 0, foldsight = 1, none = 2}
SWEP.BarrelBGs = {main = 3, longris = 4, long = 3, magpul = 2, ris = 1, regular = 0}
SWEP.StockBGs = {main = 2, regular = 0, heavy = 1, sturdy = 2}
SWEP.MagBGs = {main = 5, regular = 0, round60 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_saker", "md_pbs1"}},
	[3] = {header = "Rail", offset = {200, -100}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"ak47_shoot1", "ak47_shoot2", "ak47_shoot3"},
	reload = "ak47_reload",
	reload_empty = "ak47_reload2",
	idle = "ak47_idle",
	draw = "ak47_draw"}

SWEP.Sounds = {ak47_draw = {{time = 0.25, sound = "AK12.BOLTB"},
{time = 0.5, sound = "AK12.BOLTF"}},

	ak47_reload = {[1] = {time = 1, sound = "AK12.MAGOUT"},
	[2] = {time = 1.5, sound = "AK12.MAGIN"}},

	ak47_reload2 = {[1] = {time = 0.2, sound = "AK12.MAGOUT"},
	[2] = {time = 1.8, sound = "AK12.MAGIN"},
	[3] = {time = 2.8, sound = "AK12.BOLTB"},
	[4] = {time = 3.1, sound = "AK12.BOLTF"}},
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Rysingson"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_gun_ak12.mdl"
SWEP.WorldModel		= "models/weapons/w_ak107.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "545x39"

SWEP.FireDelay = 0.0923
SWEP.FireSound = "AK12.FIRE"
SWEP.FireSoundSuppressed = "AK12.FIRESIL"
SWEP.Recoil = 0.75

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 35
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1.15
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 1.9
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = false
