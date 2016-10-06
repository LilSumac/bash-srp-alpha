AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PPSh-41"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "f"
	killicon.Add("cw_ppsh-41", "vgui/kills/cw_ppsh-41", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_ppsh-41")

	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.MuzzlePosMod = {x = 4.5, y = 20, z = -2}
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.8
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.87

	SWEP.KobraPos = Vector(6.28, -10.252, 1.6)
	SWEP.KobraAng = Vector(2.813, 0, 0)

	SWEP.IronsightPos = Vector(6.28, -11, 2.519)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(6.36, -8.643, 1.84)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(6.199, -8.443, 1.919)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(6.32, -9.046, 1.96)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(6.32, -10.252, 1.639)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)

	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.HoloPos = Vector(6.32, -1, 1.879)
	SWEP.HoloAng = Vector(0, 0, 0)

	SWEP.BoltBone = "Bolt_and_bloc"
	SWEP.BoltShootOffset = Vector(-3, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(6.32, -10.051, 0.602), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 2, hor = 3, roll = 2, forward = 2, pitch = 1}
	SWEP.ACOGAxisAlign = {right = 0, up = -180, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_fas2_holo_aim"] = { type = "Model", model = "models/v_holo_sight_orig_hx.mdl", bone = "PPhS_41", rel = "", pos = Vector(-3, 0, -1.8), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_holo"] = { type = "Model", model = "models/v_holo_sight_kkrc.mdl", bone = "PPhS_41", rel = "", pos = Vector(-3, 0, -1.8), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "PPhS_41", rel = "", pos = Vector(11.947, 0, 0.569), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_kobra"] = { type = "Model", model = "models/cw2/attachments/kobra.mdl", bone = "PPhS_41", rel = "", pos = Vector(3, -0.51, -1.201), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "PPhS_41", rel = "", pos = Vector(0.518, 0, -1), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "PPhS_41", rel = "", pos = Vector(1.557, -0.75, 1.557), angle = Angle(0, -180, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "PPhS_41", rel = "", pos = Vector(9, 0, 0.189), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "PPhS_41", rel = "", pos = Vector(1, 0, 2.596), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "PPhS_41", rel = "", pos = Vector(-9.87, -0.401, -8.4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "PPhS_41", rel = "", pos = Vector(-4.676, 0.209, -2.58), angle = Angle(0, 90, 0), size = Vector(0.898, 0.898, 0.898), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "PPhS_41", rel = "", pos = Vector(-2.597, 0.3, -2.597), angle = Angle(0, 90, 0), size = Vector(0.898, 0.898, 0.898), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.CustomizationMenuScale = 0.1

	SWEP.LaserPosAdjust = {x = 0, y = 0, z = 0}
	SWEP.LaserAngAdjust = {p = -1, y = 180, r = 0}
	SWEP.SightWithRail = true
	SWEP.CustomizationMenuScale = 0.012
end

	SWEP.ForeGripHoldPos = {
	["Bone23"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-11.929, -57.471, 0) },
	["Bone22"] = { scale = Vector(1, 1, 1), pos = Vector(-0.556, 0, 0), angle = Angle(22.77, 14.095, -1.084) },
	["Right_L_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(5, -1.668, -5), angle = Angle(0, 0, 0) }
}



SWEP.BarrelBGs = {main = 2, sd = 1, k = 2, regular = 0}
SWEP.StockBGs = {main = 1, regular = 0, retractable = 1, none = 2}
SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.MagBGs = {main = 4, round15 = 0, round30 = 1}
SWEP.LuaViewmodelRecoil = true

//Thanks to Knife Kitty
	SWEP.Attachments = {[1] = {header = "Sight", offset = {700, -400}, atts = {"md_microt1", "md_eotech", "md_kobra", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {200, -400}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-400, 0}, atts = {"md_foregrip", "md_bipod"}},
	[4] = {header = "Rail", offset = {-450, -450}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {700, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {[1] = {time = 0.4, sound = "CW_PPS_BOLTPULL"},
	[2] = {time = 1.5, sound = "CW_PPS_MAGOUT"},
	[3] = {time = 2.2, sound = "CW_PPS_MAGIN"},
	[4] = {time = 3, sound = "CW_PPS_BOLTFORWARD"}}}

SWEP.SpeedDec = 15

SWEP.Slot = 2
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

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/pps/v_smg_pps.mdl"
SWEP.WorldModel		= "models/weapons/pps/w_smg_pps.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/pps/w_smg_pps.mdl"
SWEP.WMPos = Vector(-1.5, 2, 5)
SWEP.WMAng = Vector(-3,1,180)
SWEP.ADSFireAnim = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 71
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "762x25"
SWEP.Chamberable = false
SWEP.AimViewModelFOV = 50

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_PPS_FIRE"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.75

SWEP.HipSpread = 0.040
SWEP.AimSpread = 0.011
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 25
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.3
SWEP.ReloadTime = 2
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.6
SWEP.ReloadHalt_Empty = 3.5
