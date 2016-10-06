AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TAR-21"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_rif_tar21.mdl"
	SWEP.WMPos = Vector(-3.25, 0.456, 0)
	SWEP.WMAng = Vector(0, 0.282, -180)

	SWEP.IronsightPos = Vector(-1.826, -1.311, 0.171)
	SWEP.IronsightAng = Vector(0.82, 0.041, 0)

	SWEP.CustomizePos = Vector(7.275, -2.02, -0.668)
	SWEP.CustomizeAng = Vector(33.123, 48.542, 17.056)

	SWEP.EoTechPos = Vector(-1.843, -0.692, -0.055)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-1.831, -1.515, 0.187)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.792, -1.382, 0.185)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-1.849, -2.28, -0.112)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.BackupSights = {["md_acog_fixed"] = {[1] = Vector(-1.849, -2.28, -1.107), [2] = Vector(0.486, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.M203OffsetCycle_Reload = 0.81
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "L_Arm_Controller"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.M203HoldPos = {
		["L_Arm_Controller"] = {pos = Vector(10.197, -2.123, -1.015), angle = Angle(0, 0, 0)}
	}

	SWEP.AttachmentModelsVM = {
	    ["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "Receiver", pos = Vector(0.204, -0.788, 0.646), angle = Angle(-90, 0, -90), size = Vector(0.986, 0.986, 0.986)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Receiver", pos = Vector(0.216, 2.278, 6.331), angle = Angle(-180, 0, -90), size = Vector(0.865, 0.865, 0.865)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Receiver", pos = Vector(-0.274, 9.447, 12.737), angle = Angle(-90, 0, -90), size = Vector(1.113, 1.113, 1.113)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Receiver", pos = Vector(0.495, -1.277, -3.062), angle = Angle(90, -180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Receiver", pos = Vector(-0.392, -3.997, -1.839), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Receiver", pos = Vector(-0.06, -2.796,  1.305), angle = Angle(-180, 180, 90), size = Vector(0.389, 0.389, 0.389)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Receiver", pos = Vector(0.043, -4.163, 10.09), angle = Angle(0, 0, 90), size = Vector(0.848, 0.848, 0.848)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "Receiver", pos = Vector(2.316, -9.063, 3.388), angle = Angle(1.07, -90, 0), size = Vector(1, 1, 1), animated = true},
		["md_acog_fixed"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Receiver", pos = Vector(0.347, 2.486, 6.039), angle = Angle(-180, 0, -90), size = Vector(0.885, 0.885, 0.885)}
	}

	SWEP.ForeGripHoldPos = {
		["Left12"] = {pos = Vector(0, 0, 0), angle = Angle(11.357, -2.181, 0) },
		["Left1"] = {pos = Vector(0, 0.74, 0), angle = Angle(0, -9.094, 0) },
		["Left3"] = {pos = Vector(0, 0, 0), angle = Angle(0, 70.535, 0) },
		["Left8"] = {pos = Vector(0, 0, 0), angle = Angle(25.916, -11.879, 0) },
		["Left5"] = {pos = Vector(0, 0, 0), angle = Angle(46.38, -15.816, -10.117) },
		["Left11"] = {pos = Vector(0, 0, 0), angle = Angle(24.169, -5.834, 0) },
		["Left9"] = {pos = Vector(0, 0, 0), angle = Angle(20.329, 0, 0) },
		["Left_L_Arm"] = {pos = Vector(0, 0, 0), angle = Angle(0, 0, 88.917) },
		["Left14"] = {pos = Vector(0, 0, 0), angle = Angle(19.552, -13.228, 0) },
		["Left2"] = {pos = Vector(0, 0.74, 0), angle = Angle(0.127, 45.395, 0) },
		["Left_Hand"] = {pos = Vector(0, 0, 0), angle = Angle(-19.973, 0, 25.535) },
		["Left_U_Arm"] = {pos = Vector(1.812, 0.024, -1.239), angle = Angle(0, 0, 0) }
	}

	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.SightBGs = {main = 1,  none = 1}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	SWEP.BoltBone = "Ejection port"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)

	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end


SWEP.SightBGs = {main = 1, carryhandle = 0, none = 1}
SWEP.BarrelBGs = {regular = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {-300, -200},  atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {200, -300},  atts = {"md_anpeq15"}},

	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0.2, sound = "CW_TAR_BOLTPULL"},
{time = 0.4, sound = "CW_TAR_BOLTRELEASE"}},

	reload = {{time = 0.4, sound = "CW_TAR_MAGOUT"},
	{time = 1.3, sound = "CW_TAR_MAGIN"},
	{time = 2.3, sound = "CW_TAR_BOLTPULL"},
	{time = 2.5, sound = "CW_TAR_BOLTRELEASE"}}}


SWEP.SpeedDec = 40

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

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_tar21.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_tar21.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.0667
SWEP.FireSound = "CW_TAR-21_FIRE3", "CW_TAR-21_FIRE2", "CW_TAR-21_FIRE1"
SWEP.FireSoundSuppressed = "CW_TAR-21_SUPP2"
SWEP.Recoil = 1

SWEP.HipSpread = 0.048
SWEP.AimSpread = 0.0025
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 28
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.2
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 3.5
SWEP.SnapToIdlePostReload = true
