if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M4A1"
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

	SWEP.IronsightPos = Vector(-2.895, -3.319, 0.547)
	SWEP.IronsightAng = Vector(0.079, 0, -0.327)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-2.89, -1.311, 0.6)
	SWEP.EoTechAng = Vector(-0.814, 0, 0)

	SWEP.AimpointPos = Vector(-2.846, -2.488, 0.568)
	SWEP.AimpointAng = Vector(0, 0.2, 0)

	SWEP.MicroT1Pos = Vector(-2.911, -2.8, 0.879)
	SWEP.MicroT1Ang = Vector(-1, 0, 0)

	SWEP.CmorePos = Vector(-2.892, -2.787, 0.712)
	SWEP.CmoreAng = Vector(-0.583, 0, 0)

	SWEP.ReflexPos = Vector(-2.902, -1.469, 1.039)
	SWEP.ReflexAng = Vector(-1.724, 0, 0)

	SWEP.TrijiconPos = Vector(-2.901, -3.6, 0.62)
	SWEP.TrijiconAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.952, -0.5, 0.268)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-2.881, -2.8, 0.54)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.952, -0.5, 0.25)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.721, -2.8, 0.28)
	SWEP.FAS2AimpointAng = Vector(0.1, 0.55, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.CustomizePos = Vector(10.173, -4.106, -1.895)
	SWEP.CustomizeAng = Vector(30.736, 40.667, 30.569)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.UECWFoldSightPos = Vector(-2.881, -3.3, 0.4)
	SWEP.UECWFoldSightAng = Vector(0.839, 0.07, 0)


	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-2.952, -0.5, -0.76), [2] = Vector(0, 0, 0)},
	["md_acog_fixed"] = {[1] = Vector(-2.952, -0.5, -0.85), [2] = Vector(0, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0.04, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_uecw_foldsight_rear"] = { type = "Model", model = "models/gmod4phun/foldsight_rear.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.601, -7.2, 0.93), angle = Angle(0, 0, 180), size = Vector(2.15, 2.15, 2.15), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_usgimag"] = { type = "Model", model = "models/gmod4phun/usgimag.mdl", bone = "|*M4| - Magazine", rel = "", pos = Vector(-1.65, -10.051, 4.55), angle = Angle(0, 0, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_emag"] = { type = "Model", model = "models/gmod4phun/emag.mdl", bone = "|*M4| - Magazine", rel = "", pos = Vector(-1.65, -10.051, 5.65), angle = Angle(0, 0, 180), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_60rnd"] = { type = "Model", model = "models/gmod4phun/60rndmag.mdl", bone = "|*M4| - Magazine", rel = "", pos = Vector(-1.65, -11.851, 4.949), angle = Angle(0, 0, 180), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.58, -12.061, 2.279), angle = Angle(0, 90, 180), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {[3] = 1, [4] = 1} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.425, 2.062, 13.225), angle = Angle(-4.444, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-2.106, -3.056, 7.407), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-2.106, -3.056, 7.407), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.683, -9.344, 1.769), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.907, -2.337, 7.381), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-12.275, -15.818, 5.263), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.731, -17.768, 4.125), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.706, -11.113, 1.462), angle = Angle(180, -180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.68, -9.261, 0.34), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.675, -9.2, 1.539), angle = Angle(180, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.701, -11.261, 4.28), angle = Angle(180, 180, 0), size = Vector(2.2, 2.2, 2.2)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.621, -2, 5.519), angle = Angle(180, -90, 0), size = Vector(0.85, 0.85, 0.85)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.701, -26.48, 1.879), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
	}

	SWEP.ForeGripHoldPos = {
		['Left_L_Arm'] = {pos = Vector(1.2, -0.2, 1.6), angle = Angle(0, 0, 90)},
		['Left4'] = {pos = Vector(0, -0.15000000596046, 0), angle = Angle(60.14400100708, -13.27499961853, 0)},
		['Left5'] = {vector = Vector(0, 0, 0), angle = Angle(19.218999862671, -3.8310000896454, 0)},
		['Left7'] = {vector = Vector(0, 0, 0), angle = Angle(42.444000244141, -8.8680000305176, 0)},
		['Left9'] = {vector = Vector(0, 0, 0), angle = Angle(13.449999809265, 0, 0)},
		['Left10'] = {vector = Vector(0, 0, 0), angle = Angle(31.812000274658, -1.3999999761581, 0)},
		['Left12'] = {vector = Vector(0, 0, 0), angle = Angle(24.488000869751, 0, 0)},
		['Left13'] = {vector = Vector(0, 0, 0), angle = Angle(19.91900062561, 0, 0)},
		['Left1'] = {vector = Vector(0, 0, 0), angle = Angle(27.77499961853, 0.98199999332428, 0)},
		['Left2'] = {vector = Vector(0, 0, 0), angle = Angle(0, 23.14999961853, 0)},
		['Left3'] = {vector = Vector(0, 0, 0), angle = Angle(0, 44.89400100708, 0)}
	}

	SWEP.BoltBone = "|*M4| - Shell Ejection Port"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(2, 180, 0) --{p = 2, y = 180, r = 0}

	SWEP.MagBoneName = "|*M4| - Magazine"

function SWEP:RenderTargetFunc()

	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, make the carryhandle invisible
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("|*M4| - Carry Handle"), Vector(0, 0, 0))
	else
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("|*M4| - Carry Handle"), Vector(1, 1, 1))
	end

	if !self.SkinSilencerInstalled then -- if we dont have skin silencer, hide it
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("|*M4| - Silencer"), Vector(0.009, 0.009, 0.009))
	else
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("|*M4| - Silencer"), Vector(1, 1, 1))
	end

end

end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {100, -600},  atts = {"md_uecw_foldsight", "md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel", offset = {-500, -600}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-500, -100}, atts = {"md_foregrip", "md_bipod"}},
	[4] = {header = "Magazine", offset = {-500, 400}, atts = {"md_uecw_60rnd"}},
	["+reload"] = {header = "Ammo", offset = {500, 400}, atts = {"am_magnum", "am_matchgrade"}}}

if CustomizableWeaponry_KK_HK416 then
	//table.insert( SWEP.Attachments[1].atts, 7, "md_fas2_aimpoint" )
end

--SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.4, sound = "CW_M4A1_MAGOUT"},
	[2] = {time = 1.2, sound = "CW_M4A1_MAGIN"},
	[3] = {time = 2.0, sound = "CW_M4A1_BOLTBACK"},
	[4] = {time = 2.35, sound = "CW_M4A1_BOLTFORWARD"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"},
	{time = 0.2, sound = "CW_M4A1_BOLTBACK"},
	{time = 0.45, sound = "CW_M4A1_BOLTFORWARD"}}}

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
SWEP.ViewModel		= "models/weapons/v_rif_m4cu.mdl"
SWEP.WorldModel		= "models/weapons/w_rif_m4a1.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.066666666666667
SWEP.FireSound = "CW_M4A1_FIRE"
SWEP.FireSoundSuppressed = "CW_M4A1_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.042
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadTime_Empty = 3.2
SWEP.ReloadHalt = 2.1
SWEP.ReloadHalt_Empty = 3.2
SWEP.SnapToIdlePostReload = true

end
