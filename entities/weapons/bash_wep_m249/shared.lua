AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M249"
	SWEP.CSMuzzleFlashes = true

	SWEP.IronsightPos = Vector(-2.05, -1.887, 0.964)
	SWEP.IronsightAng = Vector(0.21, 0.028, 0)

	SWEP.ELCANPos = Vector(-2.047, -2.493, 0.046)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.058, -0.879, 0.052)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.004, -2.438, -0.113)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.037, -1.821, 0.149)
	SWEP.AimpointAng = Vector(0, 0, 0)


	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.ELCANDZAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGV5AxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = false
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 3
	SWEP.ForeGripOffsetCycle_Reload_Empty = 3

	SWEP.BackupSights = {["md_acogv5"] = {[1] = Vector(-1.964, -2.945, 0.611), [2] = Vector(1.182, 0.256, 0)},
	["md_dz_elcanv2"] = {[1] = Vector(-2.047, -2.518, -0.723), [2] = Vector(0.218, -0.08, 0)}}

	SWEP.BoltBone = "BoltHandle"
	SWEP.BoltShootOffset = Vector(0, 3.8, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.AttachmentModelsVM = {

		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "LidCont", pos = Vector(0.108, -14.532, -10.19), adjustment = {min = 9, max = 11.609, axis = "x", inverse = true, inverseDisplay = true}, angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},

        ["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "LidCont", rel = "", pos = Vector(-0.42, -8, -4.5), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_hk416_bipod"] = { type = "Model", model = "models/c_bipod.mdl", bone = "Weapon", rel = "", pos = Vector(0, 7.072, 0.726), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "LidCont", rel = "", pos = Vector(-0.202, -0.949, 0.072), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Weapon", rel = "", pos = Vector(0.019, 3.68, 1.526), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "LidCont", rel = "", pos = Vector(-0.208, -2.924, 1.325), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Weapon", pos = Vector(-0.345, -6.684, -1.144), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699)},

		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "LidCont", rel = "", pos = Vector(-0.54, -8, -5.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }


	}

	SWEP.ShortDotPos = Vector(-2.428, -4.107, -0.721)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ForeGripHoldPos = {
		["L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45.555, 0) },
	["L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 58.888, 0) },
	["L Finger42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 41.111, 0) },
	["L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(2.63, -1.724, 0), angle = Angle(1.11, -4.298, 1.455) },
	["L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 38.888, 0) },
	["L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 3.332, 0) },
	["L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0.185), angle = Angle(18.888, 81.111, 0) },
	["L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 21.111, 0) },
	["L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -7.778) },
	["L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, -3.333, 83.333) },
	["L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-3.333, -12.223, 0) },
	["L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 27.777, 0) },
	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(12.222, 34.444, 36.666) },
	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, 5.556, 0) },
	["L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 41.111, 0) }
}




end

SWEP.LuaViewmodelRecoil = false

--SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -50},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
--	[2] = {header = "Barrel", offset = {-175, -100}, atts = {"md_pbs1"}},
--	[3] = {header = "Handguard", offset = {-100, 200}, atts = {"md_foregrip"}}}

SWEP.BarrelBGs = {main = 2, rpk = 1, short = 4, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, heavy = 1, foldable = 2}
SWEP.ReceiverBGs = {main = 3, rpk = 1, regular = 0}
SWEP.MagBGs = {main = 4, regular = 0, rpk = 1}

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_eotech", "md_acog", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-300, 0}, atts = {"md_foregrip", "md_hk416_bipod"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw2"}

SWEP.Sounds = {	draw = {{time = 0, sound = "CW_DZ_M249_CLOTH"}},

	reload = {[1] = {time = 0.5, sound = "CW_DZ_M249_COVEROPEN"},
	[2] = {time = 1.4, sound = "CW_DZ_M249_MAGOUT"},
	[3] = {time = 3.65, sound = "CW_DZ_M249_MAGIN"},
	[4] = {time = 4.35, sound = "CW_DZ_M249_BELTIN"},
	[5] = {time = 5.4, sound = "CW_DZ_M249_COVERCLOSE"}}}


SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "dz"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_lemg_m249dzem.mdl"
SWEP.WorldModel		= "models/weapons/w_lemg_m249dzem.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45_belt"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_DZ_M249_FIRE"
SWEP.FireSoundSuppressed = "CW_DZ_M249_FIRE_SUPPRESSED"
SWEP.Recoil = 0.8

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 25
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 6.5
SWEP.ReloadTime_Empty = 7
SWEP.ReloadHalt = 6.5
SWEP.ReloadHalt_Empty = 7
SWEP.SnapToIdlePostReload = true
