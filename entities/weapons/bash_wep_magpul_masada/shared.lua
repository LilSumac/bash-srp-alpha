if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Magpul Masada"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 16, y = 12, z = -1}
	SWEP.InvertShellEjectAngle = true

	SWEP.ForeGripOffsetCycle_Draw = 0.43
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.CustomizePos = Vector(-13.507, -6.981, 1.175)
	SWEP.CustomizeAng = Vector(27.256, -50.713, -29.239)

	SWEP.IronsightPos = Vector(2.012, -3.28, 0.773)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.CmorePos = Vector(2.02, -2.4, 0.82)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(2.02, -2.8, 0.4)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(2.012, -3.28, 0.62)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(2.012, -3.28, 0.72)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(2.042, -3.28, 0.9)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(2.012, -3.28, 0.5)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(2.02, -2.8, 0.99)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.BallisticPos = Vector(2.02, -2.8, 0.760)
	SWEP.BallisticAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.TrijiconPos = Vector(2.0, -2.8, 0.77)
	SWEP.TrijiconAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(2, -4.6, 0.759)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(2.039, -4.02, 0.639)
	SWEP.FAS2AimpointAng = Vector(-0.4, 0.075, 0)

	SWEP.SprintPos = Vector(-3.401, -2.201, 1.399)
	SWEP.SprintAng = Vector(-15.801, -34.401, 0)

	SWEP.AlternativePos = Vector(-1.241, 0, 1.08)
	SWEP.AlternativeAng = Vector(0, 0, 0)


	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(2.02, -3.28, -0.56), [2] = Vector(0, 0, 0)},
	["md_acog_fixed"] = {[1] = Vector(2.005, -4.28, -0.65), [2] = Vector(0, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Right_U_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "smdimport", rel = "", pos = Vector(1.315, -5, -3.08), angle = Angle(0, -90, -180), size = Vector(1.039, 1.039, 1.039), color = Color(255, 255, 255, 255)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "smdimport", rel = "", pos = Vector(0.006, 6.98, -2.757), angle = Angle(180, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "smdimport", rel = "", pos = Vector(0, 3, -2.52), angle = Angle(0, 180, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "smdimport", rel = "", pos = Vector(0.26, -3.6, 3.1), angle = Angle(180, 0, 0), size = Vector(1, 1, 1)},
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "smdimport", rel = "", pos = Vector(0.36, -2.2, 3.18), angle = Angle(0, 180, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "smdimport", rel = "", pos = Vector(-0.26, -8.8, 8.1), angle = Angle(180, 90, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "smdimport", rel = "", pos = Vector(-0.419, 20.406, 1.975), angle = Angle(0, 0, 180), size = Vector(0.699, 0.699, 0.699)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "smdimport", pos = Vector(0, 1, -4.1), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "smdimport", pos = Vector(0, 2, -2.7), angle = Angle(180, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_acog_fixed"] = {model = "models/wystan/attachments/2cog.mdl", bone = "smdimport", pos = Vector(0.34, -2.9, 3.2), angle = Angle(180, 0, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "smdimport", pos = Vector(0.2, 10.9, -2.5), angle = Angle(180, -90, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_bipod"] = {model = "models/wystan/attachments/bipod.mdl", bone = "smdimport", rel = "", pos = Vector(0.1, 13.369, 0.74), angle = Angle(0, 180, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "smdimport", rel = "", pos = Vector(0, 22.2, -2), angle = Angle(0, -90, 0), size = Vector(1, 1, 1)},
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "smdimport", rel = "", pos = Vector(-0.02, 5.199, 0), angle = Angle(180, 0, 0), size = Vector(2.2, 2.2, 2.2)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "smdimport", rel = "", pos = Vector(-0.08, -3.6, 1.039), angle = Angle(180, 90, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "smdimport", rel = "", pos = Vector(0, 6.4, -2), angle = Angle(180, 90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {[4] = 1} },
		["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "smdimport", rel = "", pos = Vector(-1.64, -1, -2), angle = Angle(180, 90, 0), size = Vector(0.699, 0.699, 0.699), animated = true},
	}

	SWEP.M203HoldPos = {
		["Right_U_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-2, -2, -1), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
	['Bone06'] = {pos = Vector(0, 0, 0), angle = Angle(88.449996948242, 0, 0)},
	['Bone10'] = {pos = Vector(0, 0, 0), angle = Angle(62.006000518799, 0, 0)},
	['Bone12'] = {pos = Vector(0, 0, 0), angle = Angle(37.987998962402, 0, 0)},
	['Bone24'] = {pos = Vector(0, 0, 0), angle = Angle(0, -84.275001525879, 0)},
	['Bone22'] = {pos = Vector(0, 0, 0), angle = Angle(11.244000434875, -1.7690000534058, 13.89999961853)},
	['Bone23'] = {pos = Vector(0, 0, 0), angle = Angle(0.64999997615814, -37.838001251221, 0)},
	['Bone16'] = {pos = Vector(0, 0, 0), angle = Angle(63.831001281738, 0, 0)},
	['Right_L_Arm'] = {pos = Vector(-1, -0.9, 0.3), angle = Angle(-15.463000297546, 0, -87.300003051758)},
	['Right_Hand'] = {pos = Vector(0, 0, 0), angle = Angle(0, 19.386999130249, 0)},
	['Bone18'] = {pos = Vector(0, 0, 0), angle = Angle(28.062999725342, -13.137999534607, 0)},
	['Bone08'] = {pos = Vector(0, 0, 0), angle = Angle(18.218999862671, 0, 0)},
	['Bone14'] = {pos = Vector(0, 0, 0), angle = Angle(53.325000762939, 0, 0)},
	['Bone20'] = {pos = Vector(0, 0, 0), angle = Angle(48.137001037598, 0, 0)}
	}

--	SWEP.BoltBone = "bolt" -- okay then, dont move the charging handle :D
--	SWEP.BoltShootOffset = Vector(0, -3.2, 0)

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

function SWEP:RenderTargetFunc()

	if !self.SkinSilencerInstalled then -- if we dont have skin silencer, hide it
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("silencer"), Vector(0.009, 0.009, 0.009))
	else
	self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone("silencer"), Vector(1, 1, 1))
	end

end

end

SWEP.SightBGs = {main = 1, carryhandle = 0, none = 1}
SWEP.BarrelBGs = {regular = 0}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {200, -500},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel", offset = {-400, -500}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-400, 0}, atts = {"md_foregrip", "md_bipod"}},
	[4] = {header = "Rail", offset = {250, 400}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

if CustomizableWeaponry_KK_HK416 then
	//table.insert( SWEP.Attachments[1].atts, 7, "md_fas2_aimpoint" )
end

--SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.9, sound = "CW_MAGPUL_MASADA_MAGOUT"},
	[2] = {time = 1.8, sound = "CW_MAGPUL_MASADA_MAGIN"},
	[3] = {time = 2.4, sound = "CW_MAGPUL_MASADA_BOLT"}},
	draw = {{time = 0.01, sound = "CW_XM8_CLOTH"},
	{time = 0.5, sound = "CW_MAGPUL_MASADA_DRAW"}}}


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
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_rif_masada.mdl"
SWEP.WorldModel		= "models/weapons/w_masada.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.075
SWEP.FireSound = "CW_MAGPUL_MASADA_FIRE"
SWEP.FireSoundSuppressed = "CW_MAGPUL_MASADA_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 22
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.1
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 2.4
SWEP.ReloadHalt_Empty = 3.6
SWEP.SnapToIdlePostReload = true

end
