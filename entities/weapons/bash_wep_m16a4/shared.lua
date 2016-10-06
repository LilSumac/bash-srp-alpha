if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M16A4"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
--	SWEP.MuzzleAtachment = 1
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.IronsightPos = Vector(-2.171, -4.5, 0.3)
	SWEP.IronsightAng = Vector(0.07, 0.01, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-2.17, -2.437, 0.25)
	SWEP.EoTechAng = Vector(0.067, 0, 0)

	SWEP.AimpointPos = Vector(-2.141, -2.415, 0.458)
	SWEP.AimpointAng = Vector(-0.257, 0.14, 0)

	SWEP.MicroT1Pos = Vector(-2.19, -4.712, 0.68)
	SWEP.MicroT1Ang = Vector(-1.938, 0, -0.217)

	SWEP.CmorePos = Vector(-2.162, -2.27, 0.601)
	SWEP.CmoreAng = Vector(-0.714, 0.075, 0)

	SWEP.ReflexPos = Vector(-2.161, -1.951, 0.519)
	SWEP.ReflexAng = Vector(-0.494, 0.068, 0)

	SWEP.TrijiconPos = Vector(-2.161, -1.951, 0.519)
	SWEP.TrijiconAng = Vector(-0.494, 0.068, 0)

	SWEP.ACOGPos = Vector(-2.168, -3.563, 0.379)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-2.168, -3.563, 0.2)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.168, -3, 0.35)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.UECWFoldSightPos = Vector(-2.161, -4.5, 0.319)
	SWEP.UECWFoldSightAng = Vector(0.15, 0.1, 0)

	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-2.168, -3, -0.53), [2] = Vector(1, 0, 0)},
	["md_acog_fixed"] = {[1] = Vector(-2.168, -3.563, -0.53), [2] = Vector(0.5, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0.04, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_uecw_watch"] = { type = "Model", model = "models/gmod4phun/watch_prop.mdl", bone = "Bip01 L ForeTwist", rel = "", pos = Vector(6.764, -0.24, 0.159), angle = Angle(0, 0, 130), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_foldsight_rear"] = { type = "Model", model = "models/gmod4phun/foldsight_rear.mdl", bone = "smdimport001", rel = "", pos = Vector(0.079, 0.795, 4.15), angle = Angle(0, 0, 0), size = Vector(2, 2, 2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_usgimag"] = { type = "Model", model = "models/gmod4phun/usgimag.mdl", bone = "Magazine001", rel = "", pos = Vector(0, 0.294, -0.255), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_emag"] = { type = "Model", model = "models/gmod4phun/emag.mdl", bone = "Magazine001", rel = "", pos = Vector(0, 0.294, -2.185), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_60rnd"] = { type = "Model", model = "models/gmod4phun/60rndmag.mdl", bone = "Magazine001", rel = "", pos = Vector(0, 1.84, -0.533), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "smdimport001", rel = "", pos = Vector(-1.361, -7.801, 3.45), angle = Angle(0, -90, 0), size = Vector(1.059, 1.059, 1.059), color = Color(255, 255, 255, 255)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "smdimport001", pos = Vector(0, 4.82, 0), angle = Angle(0, 0, 2), size = Vector(0.75, 0.75, 0.75)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "smdimport001", rel = "", pos = Vector(0.019, 2.2, 3.56), angle = Angle(0, -180, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "smdimport001", rel = "", pos = Vector(-0.452, -2.556, -1.428), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "smdimport001", pos = Vector(-0.225, 9.715, 3.15), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699)},
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "smdimport001", pos = Vector(2.299, -6.611, 4.138), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), animated = true},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "smdimport001", rel = "", pos = Vector(0.075, 11.234, 0.647), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "smdimport001", rel = "", pos = Vector(-0.281, -3.027, -0.969), angle = Angle(0, 0, 3), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "smdimport001", rel = "", pos = Vector(-0.281, -3.027, -0.969), angle = Angle(0, 0, 3), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "smdimport001", rel = "", pos = Vector(-0.24, -4.388, -2.20), angle = Angle(0, 0, 1), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_betacmag"] = { type = "Model", model = "models/wystan/cmag.mdl", bone = "Magazine001", rel = "", pos = Vector(-0.08, -3.612, -1.366), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "smdimport001", rel = "", pos = Vector(0, 4.408, 3.594), angle = Angle(0, 0, 2), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "smdimport001", rel = "", pos = Vector(0.273, -8.513, -7.808), angle = Angle(3, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "smdimport001", rel = "", pos = Vector(0, 4.2, 0.72), angle = Angle(0, 0, 2), size = Vector(2.2, 2.2, 2.2)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "smdimport001", rel = "", pos = Vector(0.06, -5.4, -0.58), angle = Angle(-2, -90, 0), size = Vector(0.95, 0.95, 0.95)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "smdimport001", rel = "", pos = Vector(0, 21.399, 0.699), angle = Angle(-3, -90, 0), size = Vector(1, 1, 1)},
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "smdimport001", rel = "", pos = Vector(0.1, 11, 0.4), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "smdimport001", rel = "", pos = Vector(0, 2.345, 3.38), angle = Angle(0, 0, 2), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
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

	SWEP.CMagHoldPos = {
	["Bip01 L Finger3"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger4"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger41"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger2"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger0"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger31"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Clavicle"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Forearm"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger21"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger11"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L Finger01"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Bip01 L UpperArm"] = { vector = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}

	SWEP.BoltBone = "Bolt001"
	SWEP.BoltShootOffset = Vector(-1.75, 0, 0)

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(2, 180, 0) --{p = 2, y = 180, r = 0}

function SWEP:RenderTargetFunc()

if self.AttachmentModelsVM.md_uecw_watch then
	self.AttachmentModelsVM.md_uecw_watch.active = true
end

end

	SWEP.MagBoneName = "Magazine001"

end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {100, -600},  atts = {"md_uecw_foldsight", "md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel", offset = {-500, -600}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-500, -100}, atts = {"md_foregrip", "md_bipod", "md_m203"}},
	[4] = {header = "Magazine", offset = {-500, 400}, atts = {"md_uecw_60rnd"}},
	[5] = {header = "Rail", offset = {400, 400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, -100}, atts = {"am_magnum", "am_matchgrade"}}}

--SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.55, sound = "CW_M16A4_MAGOUT"},
	[2] = {time = 1.35, sound = "CW_M16A4_MAGIN"},
	[3] = {time = 2.0, sound = "CW_M16A4_BOLTBACK"},
	[4] = {time = 2.35, sound = "CW_M16A4_BOLTFORWARD"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_m16a4.mdl"
SWEP.WorldModel		= "models/weapons/w_m16.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_M16A4_FIRE"
SWEP.FireSoundSuppressed = "CW_M16A4_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 30
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.65
SWEP.ReloadTime_Empty = 1.65
SWEP.ReloadHalt = 1.9
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = true

end
