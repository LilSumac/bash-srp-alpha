AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Saiga 12K"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_saiga", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/saiga")

	SWEP.MuzzleEffect = "muzzleflash_shotgun"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.Shell = "shotshell"
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 1, y = -2, z = -5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.FireMoveMod = 5
	SWEP.SightWithRail = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cw20_saiga2.mdl"
	SWEP.WMPos = Vector(0, -1.5, -1.3)
	SWEP.WMAng = Vector(-12, 0, 180)

	SWEP.CustomizePos = Vector(3.819, 0, -1.407)
	SWEP.CustomizeAng = Vector(10.553, 30.25, 7.034)

	SWEP.IronsightPos = Vector(-2.04, -1, 0.439)
	SWEP.IronsightAng = Vector(0.1, 0, 0)

	SWEP.EoTechPos = Vector(-2.099, -2.359, -0.84)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(2.27, -2.914, 0.574)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.006, -3.566, -0.44)
	SWEP.FAS2AimpointAng = Vector(0, 0.703, 0)

	SWEP.KobraPos = Vector(-2.02, -3.669, -0.16)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.12, -4.047, -0.64)
    SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2, -3.418, -0.08)
	SWEP.ACOGAng = Vector(-0.2, -0.05, 0)

	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-15.478, 16.884, -9.849)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {
	["md_acog_fixed"] = {[1] = Vector(-2, -3.428, -0.681), [2] = Vector(0, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SpecterAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}
	SWEP.CSGOACOGAxisAlign = {right = 0, up = 0, forward = -40}
	SWEP.CSGOSSGAxisAlign = {right = 0, up = 0, forward = 145}

	SWEP.M203CameraRotation = {p = 0, y = 0, r = 0}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Saiga12k", rel = "", pos = Vector(0.159, -10.905, -9.061), angle = Angle(2.696, -90.38, 0), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Saiga12k", rel = "", pos = Vector(-0.434, -5.384, -2.962), angle = Angle(0, 0, 0), size = Vector(0.897, 0.897, 0.897)},
		["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint.mdl", bone = "Saiga12k", rel = "", pos = Vector(-0.183, 2.947, 1.419), angle = Angle(0, -90.595, 0), size = Vector(1.001, 1.001, 1.001)},
		["md_kobra"] = { model = "models/cw2/attachments/kobra.mdl", bone = "Saiga12k", rel = "", pos = Vector(0.344, -0.475, -1.706), angle = Angle(0, 180, 0), size = Vector(0.569, 0.569, 0.569)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Saiga12k", rel = "", pos = Vector(-0.424, 0.177, 0.638), angle = Angle(0, 0, 0), size = Vector(1.044, 1.039, 0.809)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/attachment/eq_suppressor_rifle.mdl", bone = "Saiga12k", rel = "", pos = Vector(-0, 17, -0.601), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Saiga12k", rel = "", pos = Vector(-0, 8, 1.74), angle = Angle(0, 90, 180), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Saiga12k", rel = "", pos = Vector(0, 1.7, -2), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.BoltBone = "Saiga_bolt"
	SWEP.BoltShootOffset = Vector(-2.5, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = True

	SWEP.LaserPosAdjust = Vector(-0.8, -10, 0.1)--{x = 1, y = 1, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}
end

--SWEP.SightBGs = {main = 2, none = 1}
SWEP.HoldBoltWhileEmpty = true
SWEP.LuaViewmodelRecoil = true
SWEP.LuaVMRecoilAxisMod = {vert = 0.4, hor = 0.4, roll = 0.3, forward = 0.4, pitch = 0.5}
SWEP.CustomizationMenuScale = 0.012

SWEP.Attachments = {[1] = {header = "Sight", offset = {1000, 000},  atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {-400, -150}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {200, -500}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {700, 550}, atts = {"am_slugrounds", "am_flechetterounds"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.4, sound = "saiga.magout"},
	[2] = {time = 0.8, sound = "saiga.magdraw"},
	[3] = {time = 1.1, sound = "saiga.handle"},
	[4] = {time = 1.7, sound = "saiga.magin"},
	[5] = {time = 2.4, sound = "saiga.magdraw"}},

	reload_empty = {[1] = {time = 0.4, sound = "saiga.magout"},
	[2] = {time = 0.8, sound = "saiga.magdraw"},
	[3] = {time = 1.1, sound = "saiga.handle"},
	[4] = {time = 1.7, sound = "saiga.magin"},
	[5] = {time = 2.6, sound = "saiga.boltback"},
	[6] = {time = 2.85, sound = "saiga.boltforward"}},

	draw = {{time = 0.6, sound = "saiga.click"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "2burst","semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Hex"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/shotgun/v_saiga12k.mdl"
SWEP.WorldModel		= "models/weapons/w_cw20_saiga2.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "12x70"

SWEP.FireDelay = 0.12
SWEP.FireSound = "Weapon_Saiga12.Single"
SWEP.FireSoundSuppressed = "Weapon_Saiga12.Silenced2"
SWEP.Recoil = 2.5

SWEP.HipSpread = 0.060
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.04
SWEP.ClumpSpread = 0.045
SWEP.SpreadPerShot = 0.05
SWEP.SpreadCooldown = 0.6
SWEP.Shots = 12
SWEP.Damage = 4
SWEP.DeployTime = 1
SWEP.ADSFireAnim = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 3
SWEP.ReloadHalt_Empty = 3.8
SWEP.SnapToIdlePostReload = true
