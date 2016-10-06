if CustomizableWeaponry then

SWEP.magType = "brMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN FAL"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.NoSilMuz = true
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 0, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

--	SWEP.CustomizePos = Vector(-10.5, -5.8, 0.4)
--	SWEP.CustomizeAng = Vector(27, -50, -30)

	SWEP.IronsightPos = Vector(-2.718, -4, 0.8)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.FoldSightPos = Vector(-2.02, -3.4, 0.12)
	SWEP.FoldSightAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.7, -2.8, 0.04)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.72, -2, 0.32)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-2.715, -2.8, 0.46)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.BallisticPos = Vector(-2.7, -2.8, 0.12)
	SWEP.BallisticAng = Vector(0, 0, 0)

	SWEP.TrijiconPos = Vector(-2.721, -3.201, 0.319)
	SWEP.TrijiconAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-2.75, -2.8, 0.285)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.721, -3.201, 0.4)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.721, -3.201, -0.04)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.725, -3.201, -0.071)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-2.721, -2.8, 0.119)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGO556Pos = Vector(-2.721, -2.8, 0.4)
	SWEP.CSGO556Ang = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.711, -3.6, 0.209)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-2.724, -3.8, -0.89), [2] = Vector(0.2, -0.06, 0)},
	["md_acog_fixed"] = {[1] = Vector(-2.727, -3.8, -0.971), [2] = Vector(0.2, -0.06, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "weapon", rel = "", pos = Vector(0.18, 4.8, -3.451), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "weapon", rel = "", pos = Vector(-0, 0.28, 1.08), angle = Angle(0, 180, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "weapon", rel = "", pos = Vector(-0.02, -1.201, 1.299), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "weapon", rel = "", pos = Vector(1.299, 7.199, 1.659), angle = Angle(0, 90, 0), size = Vector(1.049, 1.049, 1.049), color = Color(255, 255, 255, 255)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "weapon", rel = "", pos = Vector(-0.301, 10.5, -9.601), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "weapon", rel = "", pos = Vector(0, 0.2, -3.201), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "weapon", rel = "", pos = Vector(-0.04, 1.259, 1.24), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "weapon", rel = "", pos = Vector(0.25, 4.675, -3.451), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "weapon", rel = "", pos = Vector(0, -7.6, 1.049), angle = Angle(0, -90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_ballistic"] = { type = "Model", model = "models/kali/weapons/csgo/eq_dsr50_suppressor.mdl", bone = "weapon", rel = "", pos = Vector(-0.08, -1.601, -0.201), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "weapon", rel = "", pos = Vector(-0.08, 6.48, -2.481), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_uecw_csgo_556"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_sig.mdl", bone = "weapon", rel = "", pos = Vector(-0.076, 0.56, 0.939), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "weapon", rel = "", pos = Vector(0.28, 5.199, -3.721), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "weapon", rel = "", pos = Vector(0.28, 5.199, -3.721), angle = Angle(0, 180, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "weapon", rel = "", pos = Vector(1.5, 8.199, 1.75), angle = Angle(0, 90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_uecw_csgo_scope_ssg"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_scope_bender.mdl", bone = "weapon", rel = "", pos = Vector(-0.08, -1.201, 0.949), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "weapon", rel = "", pos = Vector(-0.026, -0.45, -1.121), angle = Angle(0, 180, 0), size = Vector(1.899, 1.899, 1.899), color = Color(255, 255, 255, 255)},
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

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
end

SWEP.SightBGs = {sightup = "", sightdown = ""}
SWEP.BarrelBGs = {regular = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {00, -500},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan", "md_ballistic"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel", offset = {-500, -500}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {-500, 400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.3, sound = "CW_FAL_MAGOUT"},
	[2] = {time = 1.9, sound = "CW_FAL_MAGIN"},
	[3] = {time = 2.5, sound = "CW_FAL_BOLT"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"}}}

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
SWEP.ViewModel		= "models/weapons/v_fal_rifle.mdl"
SWEP.WorldModel		= "models/weapons/w_fnfal.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "762x51"

SWEP.FireDelay = 0.092307
SWEP.FireSound = "CW_FAL_FIRE"
SWEP.FireSoundSuppressed = "CW_FAL_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 36
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 2.7
SWEP.ReloadHalt_Empty = 3.4
SWEP.SnapToIdlePostReload = true

end
