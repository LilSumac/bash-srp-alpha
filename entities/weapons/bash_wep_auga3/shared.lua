AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AUG A3"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/gsm/w_gsm_aug.mdl"
	SWEP.WMPos = Vector(0, -6, 0)
	SWEP.WMAng = Vector(0, 0, 180)

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_auggsm", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

    SWEP.SelectIcon = surface.GetTextureID("weaponicons/gsmaug")
	killicon.Add("cw_auggsm", "weaponicons/gsmaug", Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.SightWithRail = false

    SWEP.IronsightPos = Vector(-2.171, -2.01, 0.079)
    SWEP.IronsightAng = Vector(0.4, -0.151, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

    SWEP.EoTechPos = Vector(-2.12, -2.412, -0.48)
    SWEP.EoTechAng = Vector(0, 0, 0)

    SWEP.AimpointPos = Vector(-2.161, -2.814, 0.079)
    SWEP.AimpointAng = Vector(0, 0, 0)

    SWEP.MicroT1Pos = Vector(-2.161, -3.016, 0.159)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

    SWEP.ACOGPos = Vector(-2.161, -2.211, -0.201)
    SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.151, -1.81, -1.16), [2] = Vector(0.699, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = -0.5, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BoltBone = "a3_charger"
	SWEP.BoltShootOffset = Vector(-2.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
        ["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "A3_Body", pos = Vector(-2.401, -9.87, 1), angle = Angle(180, 0, 0), size = Vector(0.37, 0.37, 0.37)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "A3_Body", pos = Vector(-2.05, 3.635, 13.899), angle = Angle(180, -90, 0), size = Vector(1.2, 1.2, 1.2)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "A3_Body", pos = Vector(-2.6, -10.5, 0.8), angle = Angle(5.843, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "A3_Body", pos = Vector(-2.597, -4.676, 5.599), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "A3_Body", pos = Vector(-2.701, -4.676, 5.63), angle = Angle(-180, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "A3_Body", pos = Vector(-1.65, -17.143, 2.596), angle = Angle(0, -90, -90), size = Vector(0.5, 0.5, 0.5)}
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

	SWEP.LaserPosAdjust = Vector(0, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_saker"}},



	[3] = {header = "Rail", offset = {250, 400}, atts = {"md_anpeq15"}}}

SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.8, sound = "CW_GSM_AUG_MAGOUT"},
	[2] = {time = 1.9, sound = "CW_GSM_AUG_MAGIN"},
	[3] = {time = 2.6, sound = "CW_GSM_AUG_BOLT"}},

	draw = {[1] = {time = 0.6, sound = "CW_GSM_AUG_DRAW"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
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
SWEP.ViewModel		= "models/cw2/gsm/v_gsm_auga3.mdl"
SWEP.WorldModel		= "models/cw2/gsm/w_gsm_aug.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_GSM_AUG_FIRE"
SWEP.FireSoundSuppressed = "CW_GSM_AUG_FIRE_SUPPRESSED"
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
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3
SWEP.SnapToIdlePostReload = true
