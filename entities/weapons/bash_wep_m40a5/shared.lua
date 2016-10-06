AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M40A5"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.9

	SWEP.IconLetter = "i"
	killicon.AddFont("", "", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzle_center_M82"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.AimBreathingEnabled = true
	SWEP.FullAimViewModelRecoil = false

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_snip_m40a5.mdl"
	SWEP.WMPos = Vector(0.7, -0.4, 1.5)
	SWEP.WMAng = Vector(-7, 0, 180)

	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

    SWEP.IronsightPos = Vector(-2.77, -2.406, 0.128)
    SWEP.IronsightAng = Vector(0.76, 0, 0)

	SWEP.EoTechPos = Vector(-2.721, -1.658, 0.019)
    SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.76, -2.056, -0.201)
    SWEP.AimpointAng = Vector(0.98, -0.003, 0)

	SWEP.MicroT1Pos = Vector(-2.8, -2.527, 0.101)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.78, -2.306, -0.341)
    SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.721, -3.335, -0.08)
    SWEP.CSGOSSGAng = Vector(4.01, 0, 0)

    SWEP.TatScpPos = Vector(-2.718, -2.931, 0.303)
    SWEP.TatScpAng = Vector(0, 0, 0)

	SWEP.IsightsPos = Vector(-2.8, -3.399, 0.039)
    SWEP.IsightsAng = Vector(-0.341, 0, 0)

SWEP.SprintPos = Vector(2.065, -3.011, -1.346)
SWEP.SprintAng = Vector(-14.537, 45.528, -20.805)

	SWEP.M40SAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.78, -2.227,-1.374), [2] = Vector(0, 0, 0)}}

	SWEP.ACOGAxisAlign = {right = 1, up = 0, forward = 1}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}

	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM ={
	["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "gun-main", rel = "", pos = Vector(-3.425, 2.569, 0.09), angle = Angle(-90.441, 101.625, 12.444), size = Vector(0.968, 0.968, 0.968), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "gun-main", rel = "", pos = Vector(-5.619, 6.118, -0.249), angle = Angle(-1.32, 4.26, -89.874), size = Vector(0.779, 0.779, 0.779), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "gun-main", rel = "", pos = Vector(1.712, -2.957, -0.16), angle = Angle(90.177, -1.218, -87.724), size = Vector(0.365, 0.365, 0.365), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_m40s"] = { type = "Model", model = "models/cw2/attachments/m40scope.mdl", bone = "gun-main", rel = "", pos = Vector(0.481, -2.083, -0.164), angle = Angle(0.566, 1.868, -90.544), size = Vector(0.892, 0.892, 0.892), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "gun-main", rel = "", pos = Vector(-2.162, 2.576, 0.256), angle = Angle(-90.614, 90.356, -1.032), size = Vector(0.927, 0.927, 0.927), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "gun-main", rel = "", pos = Vector(13.906, 0.162, -0.16), angle = Angle(-89.583, 94.457, 2.279), size = Vector(0.754, 0.754, 0.754), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "gun-main", rel = "", pos = Vector(9.93, -1.374, 0.384), angle = Angle(-0.777, -180, -0.508), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_couldbewhat"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "gun-main", rel = "", pos = Vector(5.44, -3.691, 2.799), angle = Angle(0.727, 3.736, -90.712), size = Vector(1.389, 1.389, 1.389), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_csgo_scope_ssg"] = { type = "Model", model = "models/kali/weapons/csgo/eq_optic_scope_ssg08.mdl", bone = "gun-main", rel = "", pos = Vector(2.032, -2.533, -0.231), angle = Angle(0, 1, -90.921), size = Vector(0.711, 0.711, 0.711), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_attironsights"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "gun-main", rel = "", pos = Vector(-6.394, -3.995, 2.312), angle = Angle(0, 0, -90.461), size = Vector(1.085, 1.085, 1.085), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "gun-main", rel = "", pos = Vector(10.175, -2.286, -2.595), angle = Angle(0, 90.525, -0.183), size = Vector(0.801, 0.801, 0.801), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	SWEP.LaserPosAdjust = Vector(0, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(2, 180, 0) --{p = 2, y = 180, r = 0}

end


SWEP.LuaViewmodelRecoil = false
SWEP.Chamberable = true
SWEP.ReticleInactivityPostFire = 1.8

SWEP.SightBGs = {main = 1, none = 1}


SWEP.Attachments = {[1] = {header = "Sight", offset = {900, -300},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {350, -300},  atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-200, -500}, atts = {"md_bipod"}},
	[4] = {header = "Rail", offset = {-150, 300}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {400, 500}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"l96_fire"},
	reload = "l96_reload_full",
	reload_empty = "l96_reload_empty",
	idle = "l96_idle",
	draw = "l96_draw"}

SWEP.Sounds = {l96_reload_empty = {[1] = {time = 0.7, sound = "m40a5.pull"},
	[2] = {time = 1.2, sound = "m40a5.magout"},
	[3] = {time = 2.0, sound = "m40a5.magin"},
	[4] = {time = 2.8, sound = "m40a5.release"},
    [5] = {time = 3.0, sound = "m40a5.down"}},

	  l96_fire = {[1] = {time = 0.5, sound = "m40a5.pull"},
	[2] = {time = 0.8, sound = "m40a5.release"},
	[3] = {time = 1.0, sound = "m40a5.down"}},

		  l96_reload_full = {[1] = {time = 1.0, sound = "m40a5.magout"},
	[2] = {time = 1.8, sound = "m40a5.magin"}}

	}
SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Rage"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_snip_m40a5.mdl"
SWEP.WorldModel		= "models/weapons/w_snip_m40a5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = false

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762x51"
SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true

SWEP.FireDelay = 1.4
SWEP.FireSound = "CW_M40A5_FIRE"
SWEP.FireSoundSuppressed = "CW_M40A5_FIRE_SUPPRESSED"
SWEP.Recoil = 1.3

SWEP.HipSpread = 0.2
SWEP.AimSpread = 0.0002
SWEP.VelocitySensitivity = 2
SWEP.MaxSpreadInc = 3
SWEP.SpreadPerShot = 0.1
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 100
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.5
SWEP.ReloadTime_Empty = 3.3
SWEP.ReloadHalt = 3.05
SWEP.ReloadHalt_Empty = 4.85
