AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PP-19 Bizon"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/gsm/w_gsm_bizon.mdl"
	SWEP.WMPos = Vector(0, -4, 0)
	SWEP.WMAng = Vector(0, 0, 180)

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_bizongsm", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

    SWEP.SelectIcon = surface.GetTextureID("weaponicons/bizongsm")
	killicon.Add("cw_bizongsm", "weaponicons/bizongsm", Color(255, 80, 0, 150))

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

	SWEP.BoltBone = "BIZON_Bolt"
	SWEP.BoltShootOffset = Vector(-3.6, 0, 0)

    SWEP.IronsightPos = Vector(-2.013, -1.5, 0.28)
    SWEP.IronsightAng = Vector(0.75, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.025, -2.951, -0.281)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-2.03, -2.412, -0.601)
    SWEP.EoTechAng = Vector(0, 0, 0)

    SWEP.AimpointPos = Vector(-2.04, -3.82, -0.281)
    SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.04, -2.814, -0.44)
    SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CustomizePos = Vector(2.009, 0.019, -1.206)
    SWEP.CustomizeAng = Vector(12.663, 23.215, 7.034)

	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.KobraPos = Vector(-1.981, -2.613, -0.401)
    SWEP.KobraAng = Vector(2, 0.15, 0)

	SWEP.SprintPos = Vector(2.009, 0.019, -1.206)
    SWEP.SprintAng = Vector(-18.996, 46.431, -35.176)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.05, -1.81, -1.081), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AttachmentModelsVM = {
	    ["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "BIZON_Body", pos = Vector(-0.175, -7.5, 0.1), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "BIZON_Body", pos = Vector(0, -7, 1.6), angle = Angle(0, 180, 0), size = Vector(0.3, 0.3, 0.3)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "BIZON_Body", pos = Vector(0.25, -17.5, -8.2), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "BIZON_Body", pos = Vector(-0.151, -10.9, -1.9), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "BIZON_Body", pos = Vector(-0.25, -10.75, -1.951), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "BIZON_Body", pos = Vector(-0.5, 0.5, 0.1), angle = Angle(0, 90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "BIZON_Body", pos = Vector(0.4, -6.753, -1.711), angle = Angle(0, -180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "BIZON_Body", pos = Vector(0, 10, -1.4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)}
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

	SWEP.LaserPosAdjust = Vector(0, 1.5, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, retractable = 1, none = 2}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.MagBGs = {main = 4, round15 = 0, round30 = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_kobra"}},
[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_tundra9mm"}, exclusions = {bg_mp5_sdbarrel = true}},
[3] = {header = "Rail", offset = {-400, -400}, atts = {"md_anpeq15"}}}



SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.6, sound = "GSM_BIZON_MAGOUT"},
	[2] = {time = 2.2, sound = "GSM_BIZON_MAGIN"}},

	reload_empty = {[1] = {time = 0.6, sound = "GSM_BIZON_MAGOUT"},
	[2] = {time = 2.2, sound = "GSM_BIZON_MAGIN"},
	[3] = {time = 2.9, sound = "GSM_BIZON_BOLTPULL"}}}


SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "2burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/gsm/v_gsm_bizon.mdl"
SWEP.WorldModel		= "models/cw2/gsm/w_gsm_bizon.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 55
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18"

SWEP.FireDelay = 0.08
SWEP.FireSound = "GSM_BIZON_FIRE"
SWEP.FireSoundSuppressed = "GSM_BIZON_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.035
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5
