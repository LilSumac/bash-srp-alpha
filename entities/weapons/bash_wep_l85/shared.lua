AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SA80-A2"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.8

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_rif_dzl85.mdl"
	SWEP.WMPos = Vector(-1, -6, -1.5)
	SWEP.WMAng = Vector(0, 0, 180)

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.IronsightPos = Vector(-2.228, -1.43, -0.058)
	SWEP.IronsightAng = Vector(0, 0.035, 0)

	SWEP.GsightsPos = Vector(-2.228, -1.43, -0.058)
	SWEP.GsightsAng = Vector(0, 0.035, 0)


	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-2.21, -4.686, 0.239)
	SWEP.EoTechAng = Vector(0, 0, -0.217)

	SWEP.AimpointPos = Vector(-2.194, -4.686, 0.338)
	SWEP.AimpointAng = Vector(-1.951, 0, -0.217)

	SWEP.MicroT1Pos = Vector(-2.208, -4.712, 0.633)
	SWEP.MicroT1Ang = Vector(-1.938, 0, -0.217)

	SWEP.ACOGPos = Vector(-2.211, -4, 0.146)
	SWEP.ACOGAng = Vector(-1.4, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.211, -4, -0.95), [2] = Vector(-2, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = -0.5, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-1.9, 0, 0)
	SWEP.HoldBoltWhileEmpty = false
	SWEP.DontHoldWhenReloading = true

	SWEP.AttachmentModelsVM = {

		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "body", rel = "", pos = Vector(-1.492, -2.498, -2.464), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_flashhider1"] = { type = "Model", model = "models/dzembi/bf4/flashhider.mdl", bone = "body", rel = "", pos = Vector(12.097, -2.55, -0.156), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["md_muzzlebrake"] = { type = "Model", model = "models/dzembi/bf4/rifle_muzzlebreak.mdl", bone = "body", rel = "", pos = Vector(13.557, -2.526, -0.076), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

         ["md_ghostring"] = { type = "Model", model = "models/dzembi/bf4/ghostsights_front.mdl", bone = "body", rel = "", pos = Vector(7.155, -5.104, -0.005), angle = Angle(0, 0, -90), size = Vector(0.308, 0.308, 0.308), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_attghostring"] = { type = "Model", model = "models/dzembi/bf4/ghostsights_back.mdl", bone = "body", rel = "", pos = Vector(-3.125, -5.079, 0), angle = Angle(0, 0, -90), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },


		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "body", rel = "", pos = Vector(5.487, -3.487, 0.13), angle = Angle(180, 0, -90), size = Vector(0.532, 0.532, 0.532), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "smdimport001", pos = Vector(2.299, -6.611, 4.138), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), animated = true}
	}

	SWEP.M203HoldPos = {
		["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-2.76, 2.651, 1.386), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
		["Bip01 L Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 42.713, 0) },
		["Bip01 L Clavicle"] = {pos = Vector(-3.299, 1.235, -1.79), angle = Angle(-55.446, 11.843, 0) },
		["Bip01 L Forearm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 42.41) },
		["Bip01 L Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 71.308, 0) },
		["Bip01 L Finger11"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.795, 0) },
		["Bip01 L Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 26.148, 0) },
		["Bip01 L Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(6.522, 83.597, 0) },
		["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(23.2, 16.545, 0) },
		["Bip01 L Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 31.427, 0) },
		["Bip01 L Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 29.565, 0) },
		["Bip01 L Hand"] = {pos = Vector(0, 0, 0), angle = Angle(9.491, 14.793, -15.926) },
		["Bip01 L Finger12"] = {pos = Vector(0, 0, 0), angle = Angle(0, -9.195, 0) },
		["Bip01 L Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 10.164, 0) },
		["Bip01 L Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.395, 0) },
		["Bip01 L Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(2.411, 57.007, 0) }
	}

	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.LaserPosAdjust = Vector(-0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end

SWEP.SightBGs = {main = 4, carryhandle = 0, foldsight = 1, none = 2}
SWEP.BarrelBGs = {main = 3, longris = 4, long = 3, magpul = 2, ris = 1, regular = 0}
SWEP.StockBGs = {main = 2, regular = 0, heavy = 1, sturdy = 2}
SWEP.MagBGs = {main = 5, regular = 0, round60 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = { [1] = {header = "Sight", offset = {600, -500},  atts = {"md_attghostring"}},
	[2] = {header = "Barrel", offset = {-300, -400}, atts = {"md_saker", "md_flashhider1", "md_muzzlebrake"}},


	[3] = {header = "Rail", offset = {250, 400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_DZ_L85_MAGOUT"}},

	reload = {[1] = {time = 0.35, sound = "CW_DZ_L85_MAGOUT"},
	[2] = {time = 1.5, sound = "CW_DZ_L85_MAGIN"},
	[3] = {time = 1.6, sound = "CW_DZ_L85_COLTH"},
	[4] = {time = 2.3, sound = "CW_DZ_L85_BOLT"},
	[5] = {time = 2.7, sound = "CW_DZ_L85_CLOTH"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rif_dzl85.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_dzl85.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.0857
SWEP.FireSound = "CW_DZ_L85_FIRE"
SWEP.FireSoundSuppressed = "CW_DZ_L85_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.15
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 2.35
SWEP.ReloadHalt_Empty = 3.2
SWEP.SnapToIdlePostReload = true
