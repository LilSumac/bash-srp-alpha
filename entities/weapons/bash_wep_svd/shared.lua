AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
// SCK Name: svd
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Dragunov SVD"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.Add("cw_dragnov", "vgui/kills/cw_dragnov", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_dragnov")

	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.IronsightPos = Vector(-3.15, -2.01, 1.56)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(-3, 0, 0.879)
	SWEP.CoD4ReflexAng = Vector(0, 0.3, 2)

	SWEP.EoTechPos = Vector(-3, 0, 0.839)
	SWEP.EoTechAng = Vector(-1.5, 0, 2)

	SWEP.EoTech552Pos = Vector(-3.01, 0, 0.84)
	SWEP.EoTech552Ang = Vector(-1.5, 0, 2)

	SWEP.EoTech553Pos = Vector(-3.07, 0, 0.479)
	SWEP.EoTech553Ang = Vector(0, 0, 1.5)

	SWEP.AimpointPos = Vector(-3, 0, 0.6)
	SWEP.AimpointAng = Vector(0, 0.25, 2)

	SWEP.CoD4TascoPos = Vector(-3.08, 0, 1.15)
	SWEP.CoD4TascoAng = Vector(0, 0.2, 2)

	SWEP.FAS2AimpointPos = Vector(-3.11, 0, 1.19)
	SWEP.FAS2AimpointAng = Vector(-1.5, 0.045, 2)

	SWEP.MicroT1Pos = Vector(-3.161, 0, 1.32)
	SWEP.MicroT1Ang = Vector(-1.5, 0, 2)

	SWEP.ACOGPos = Vector(-3.08, 0, 0.75)
	SWEP.ACOGAng = Vector(-1.5, 0, 2)
	SWEP.CoD4ACOGPos = Vector(-3.08, 0, 0.8)
	SWEP.CoD4ACOGAng = Vector(-1.5, 0, 2)

	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)

	SWEP.LeupoldPos = Vector(-3.1, 0, 0.5)
	SWEP.LeupoldAng = Vector(2, 0, 2)
	SWEP.LeupoldAxisAlign = {right = -4, up = -0.09, forward = -1.55}

	SWEP.HoloPos = Vector(-3.141, 0, 0.899)
	SWEP.HoloAng = Vector(-1.701, -0.2, 2)

	SWEP.PSOPos = Vector(-3, 0, 0.8)
	SWEP.PSOAng = Vector(0, 0, 2)

	SWEP.KobraPos = Vector(-3.161, 0, 0.879)
	SWEP.KobraAng = Vector(0 ,0 , 2)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-3.181, 0, -0.32), [2] = Vector(-1, -1, 2)}}

	SWEP.PSO1AxisAlign = {right = -2, up = 3, forward = 90}

	SWEP.ACOGAxisAlign = {right = -0.5, up = 3, forward = 0}
	SWEP.CoD4ACOGAxisAlign = {right = 0.5, up = 179, forward = -1.55}

	SWEP.RPSOPos = Vector(-2.981, 0, 1.059)
	SWEP.RPSOAng = Vector(0 ,0 , 2)
	SWEP.RPSOAxisAlign = {right = -2, up = 2.9, forward = -1.55}

	SWEP.RscopePos  = Vector(-3.01, -2.01, 1.1)
	SWEP.RscopeAng = Vector(0 ,0 , 2)
	SWEP.BFRIFLEAxisAlign = {right = 0, up = 0, forward = -1.55}

	SWEP.MW3SPos  = Vector(-3.12, 0, 0.54)
	SWEP.MW3SAng = Vector(0 ,0 , 2)
	SWEP.MW3SAxisAlign = {right = -2, up = 2.9, forward = -1.55}

	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.SightWithRail = true

	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(0, 5, 0)
	SWEP.HoldBoltWhileEmpty = false
	SWEP.DontHoldWhenReloading = true

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Base", rel = "", pos = Vector(-0.01, 2.2, 0.5), angle = Angle(0, -90, 0), size = Vector(1.149, 1.149, 1.149)},
		["md_fas2_eotech_stencil"] = { type = "Model", model = "models/c_fas2_eotech_stencil.mdl", bone = "Base", rel = "", pos = Vector(-0.01, 2.2, 0.5), angle = Angle(0, -90, 0), size = Vector(1.149, 1.149, 1.149)},
		["md_mw3scope"] = { type = "Model", model = "models/rageattachments/v_msrscope.mdl", bone = "Base", rel = "", pos = Vector(0.19, -1, 0), angle = Angle(0, -86, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_bfriflescope"] = { type = "Model", model = "models/rageattachments/sniperscopesv.mdl", bone = "Base", rel = "", pos = Vector(-0.051, -2, 0.75), angle = Angle(0, -178, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_pso1scope"] = { type = "Model", model = "models/rageattachments/ragepso.mdl", bone = "Base", rel = "", pos = Vector(0.2, -2.597, 2), angle = Angle(0, -85.325, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -5.715, -2.1), angle = Angle(0, 93, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -1.558, 0), angle = Angle(0, 3, 1), size = Vector(1, 1, 0.5)},
		["md_kobra"] = { type = "Model", model = "models/cw2/attachments/kobra.mdl", bone = "Base", rel = "", pos = Vector(0.419, 0, -2.401), angle = Angle(0, -178, 0), size = Vector(0.55, 0.55, 0.55)},
		["md_pso1"] = { type = "Model", model = "models/cw2/attachments/pso.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -5, -1.601), angle = Angle(0, -178, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_cod4_acog_v2"] = { type = "Model", model = "models/v_cod4_acog.mdl", bone = "Base", rel = "", pos = Vector(-0.201, -4.676, -1.8), angle = Angle(0, 94, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.561, -7.792, -4), angle = Angle(0, 3, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint_rigged.mdl", bone = "Base", rel = "", pos = Vector(0.115, 1.557, 0.1), angle = Angle(0, -87, 0), size = Vector(1.149, 1.149, 1.149)},
		["md_cod4_eotech_v2"] = { type = "Model", model = "models/v_cod4_eotech.mdl", bone = "Base", rel = "", pos = Vector(-0.25, -5.715, -2), angle = Angle(0, 94, 0), size = Vector(0.898, 0.898, 0.898)},
		["md_hk416_bipod"] = { type = "Model", model = "models/c_bipod.mdl", bone = "Base", rel = "", pos = Vector(0.6, 10.909, -1.5), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_cod4_reflex"] = { type = "Model", model = "models/v_cod4_reflex.mdl", bone = "Base", rel = "", pos = Vector(-0.301, -5.801, -1.9), angle = Angle(0, 94, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_fas2_holo"] = { type = "Model", model = "models/v_holo_sight_kkrc.mdl", bone = "Base", rel = "", pos = Vector(-0.24, -4.901, -3.550), angle = Angle(0, -86.7, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_holo_aim"] = { type = "Model", model = "models/v_holo_sight_orig_hx.mdl", bone = "Base", rel = "", pos = Vector(-0.24, -4.901, -3.550), angle = Angle(0, -86.7, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_leupold"] = { type = "Model", model = "models/v_fas2_leupold.mdl", bone = "Base", rel = "", pos = Vector(-0.15, -3, 2.2), angle = Angle(0, -87, 0), size = Vector(1.799, 1.799, 1.799)},
		["md_fas2_leupold_mount"] = { type = "Model", model = "models/v_fas2_leupold_mounts.mdl", bone = "Base", rel = "", pos = Vector(-0.15, -3.6, 2.2), angle = Angle(0, -85, 0), size = Vector(1.799, 1.799, 1.799)},
		["bg_hk416_silencer"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Base", rel = "", pos = Vector(1.399, 27.5, -2.1), angle = Angle(0, -177, -2), size = Vector(0.949, 0.949, 0.949)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(0.5, 10, -2.401), angle = Angle(0, 3, 3), size = Vector(0.75, 0.75, 0.75)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(0.649, 3.5, 0), angle = Angle(0, 95, 90), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.65, -12.988, -9.7), angle = Angle(0, -85, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.051, -1.558, 1), angle = Angle(0, -177, 0), size = Vector(0.349, 0.349, 0.349)},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(0.3, -4, -3.3), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(-0.671, -6.7, -4.2), angle = Angle(0, 4, 0), size = Vector(0.898, 0.898, 0.898)}
	}

	SWEP.CompM4SBoneMod = {}


	SWEP.ForeGripHoldPos = {
		["l-pinky-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(180, 0, 0) },
		["l-ring-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(72.222, 0, 0) },
		["l-middle-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(90, 0, 0) },
		["l-index-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, 0, 0) },
		["l-forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-2, 1.296, -0.556), angle = Angle(-12.223, -21.112, 81.111)}
	}


	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(2.25, 182.5, 0)
end

SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 2}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
SWEP.LuaViewmodelRecoil = true

	SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_microt1", "md_eotech", "md_kobra", "md_aimpoint", "md_acog", "md_pso1", "md_fas2_leupold"}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
		[3] = {header = "Handguard", offset = {-250, 150}, atts = {"md_foregrip", "md_hk416_bipod"}},
		[4] = {header = "Rail", offset = {-250, 600}, atts = {"md_anpeq15"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}
	}

SWEP.Animations = {fire = {"shoot", "shoot2"},
	reload = "reload",
	idle = "draw",
	draw = "draw"}

SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_SVD_DRAW"}},

	reload = {
	[1] = {time = 0.6, sound = "CW_SVD_MAGOUT"},
	[2] = {time = 1.8, sound = "CW_SVD_TAP"},
	[3] = {time = 1.85, sound = "CW_SVD_MAGIN"},
	[4] = {time = 2.35, sound = "CW_SVD_BOLTBACK"}}}

SWEP.SpeedDec = 38

SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"
SWEP.AimViewModelFOV = 50

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/drag/v_snip_dragn.mdl"
SWEP.WorldModel		= "models/weapons/drag/w_snip_dragn.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.ADSFireAnim = false
SWEP.WM = "models/weapons/drag/w_snip_dragn.mdl"
SWEP.WMPos = Vector(-1, -1, -0.2)
SWEP.WMAng = Vector(-3,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762x54"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_SVD_FIRE"
SWEP.FireSoundSuppressed = "CW_AK74_FIRE_SUPPRESSED"
SWEP.Recoil = 1

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.0035
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 64
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.10
SWEP.ReloadTime = 2.35
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 0.1
SWEP.ReloadHalt_Empty = 0.1
SWEP.SnapToIdlePostReload = true
