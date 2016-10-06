AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "CZ Scorpion Evo 3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.IronsightPos = Vector(-2.922, -3.185, 0.814)
	SWEP.IronsightAng = Vector(0, 0, 0)


	SWEP.MicroT1Pos = Vector(-2.947, -5.146, 0.307)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-2.938, -5.356, -0.021)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.918, -4.861, 0.386)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.937, -5.098, 0.134)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(2.933, -0.24, -1.466)
	SWEP.SprintAng = Vector(0, 40.582, 0)

	SWEP.CustomizePos = Vector(7.96, 0, -0.072)
	SWEP.CustomizeAng = Vector(8.442, 49.245, 0)

	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.922, -4.89, -0.706), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(2.509, -4.013, 0.004), angle = Angle(90, -90, 0), size = Vector(0.36, 0.36, 0.36)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(-7.781, 6.907, -0.26), angle = Angle(0, 0, -90), size = Vector(1.003, 1.003, 1.003)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(7.472, 0.146, -0.185), angle = Angle(90, 0, -90), size = Vector(0.703, 0.703, 0.703)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(-1.476, 0.639, 0.287), angle = Angle(-90, 0, -90), size = Vector(0.773, 0.773, 0.773)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "body", pos = Vector(8.529, -2.204, 0.518), angle = Angle(-1.900, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "body", pos = Vector(15.055, -1.724, -0.95), angle = Angle(21.422, -92.033, 1.99), size = Vector(1.075, 1.075, 1.075)}
	}

	SWEP.ForegripOverridePos = {
		["bg_mp5_sdbarrel"] = {
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(-4.029, 14.069, 0) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(0, -8.988, 0) }
		},

		["bg_mp5_kbarrel"] = {
			["Bip01 R Hand"] = {pos = Vector(0, 0, 0), angle = Angle(0.263, 23.951, -31.754) },
			["Bip01 R Finger2"] = {pos = Vector(0, 0, 0), angle = Angle(-0.894, 32.728, 3.026) },
			["Bip01 R Finger21"] = {pos = Vector(0, 0, 0), angle = Angle(0, 12.1, 0) },
			["Bip01 R Finger01"] = {pos = Vector(0, 0, 0), angle = Angle(0, 25.451, 0) },
			["Bip01 R Clavicle"] = {pos = Vector(-6.856, 2.325, 2.252), angle = Angle(48.464, 28.256, 12.512) },
			["Bip01 R Finger4"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 14.687) },
			["Bip01 R Finger1"] = {pos = Vector(0, 0, 0), angle = Angle(-1.813, 71.625, 0) },
			["Bip01 R Finger41"] = {pos = Vector(0, 0, 0), angle = Angle(0, -26.932, 0) },
			["Bip01 R Finger31"] = {pos = Vector(0, 0, 0), angle = Angle(0, -16.4, 0) },
			["Bip01 R Finger02"] = {pos = Vector(0, 0, 0), angle = Angle(0, 89.527, 0) },
			["Bip01 R Finger3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 18.952, 11.305) },
			["Bip01 R Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(-15.782, -6.495, 33.964) },
			["Bip01 R Finger32"] = {pos = Vector(0, 0, 0), angle = Angle(0, 54.675, -4.284) },
			["Bip01 R Finger42"] = {pos = Vector(0, 0, 0), angle = Angle(0, 67.799, 0) }
		}
	}

	SWEP.AttachmentPosDependency = {["md_tundra9mm"] = {["bg_mp5_kbarrel"] = Vector(-0.038, -10.749, 0.324)}}

	SWEP.LaserPosAdjust = {x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = 2, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, retractable = 1, none = 2}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.MagBGs = {main = 4, round15 = 0, round30 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}, exclusions = {bg_mp5_sdbarrel = true}},
[3] = {header = "Rail", offset = {250, 400}, atts = {"md_anpeq15"}}}




SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload1",
	reload_empty = "reload1",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload1 = {[1] = {time = 0.4, sound = "CW_CZ_MAGOUT"},
	[2] = {time = 0.8, sound = "CW_CZ_MAGIN"}},

	reload1 = {[1] = {time = 0.4, sound = "CW_CZ_MAGOUT"},
	[2] = {time = 1.2, sound = "CW_CZ_MAGIN"},
	[3] = {time = 1.75, sound = "CW_CZ_BOLTBACK"}}}


SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_smg_bf4_cz3a1.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_bf4_cz3a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_MP5_FIRE"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.66
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 1.66
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true
