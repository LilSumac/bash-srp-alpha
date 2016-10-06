AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Vityaz-SN"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 0.7
	SWEP.DrawTraditionalWorldModel = false
		SWEP.WM = "models/weapons/w_smg_ppv.mdl"
	SWEP.WMPos = Vector( -0.5, -3, -0.5)
	SWEP.WMAng = Vector(-7, 0, 180)

	SWEP.IronsightPos = Vector(-3.116, -4.801, 1.1)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-3.139, -4.487, 0.57)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-3.12, -4.433, 0.5)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-3.131, -5.968, 0.5)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.KobraPos = Vector(-3.1, -5.915, 0.56)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.PSOPos = Vector(-3.076, -0.76, 0.25)
	SWEP.PSOAng = Vector(0, 0, 0)

   SWEP.SprintPos = Vector(1.917, -6.279, -1.765)
   SWEP.SprintAng = Vector(-12.353, 50.144, -25.1)

	SWEP.AlternativePos = Vector(-0.24, 0, -0.48)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-3.125, -4.548, -0.581), [2] = Vector(0, 0, 0)}}

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(-2.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.ShellPosOffset = {x = 4, y = 0, z = 2}

	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "wpn_body", pos = Vector(0.273, -7.624, -6.139), angle = Angle(1.649, -90, 0.523), size = Vector(0.8, 0.8, 0.8)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "wpn_body", pos = Vector(-0.22, -4.244, -1.892), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "wpn_body", pos = Vector(-0.018, 13.46, 0.237), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "wpn_body", pos = Vector(0, 1.023, 2.809), angle = Angle(0, 180, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "wpn_body", pos = Vector(0.389, 1.72, -0.281), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "wpn_body", pos = Vector(-0.101, -3.175, -0.401), angle = Angle(0, 180, 0), size = Vector(0.8, 0.8, 0.8)}
		}

	SWEP.PSO1AxisAlign = {right = 90, up = 0, forward = 0}
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_pso1", "md_microt1"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {300, 200}, atts = {"am_magnum", "am_matchgrade"}}
	}

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload_full",
	reload_empty = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.4, sound = "Weapon_pp19vit.Cloth"},
	[2] = {time = 1.0, sound = "Weapon_pp19vit.Cliprelease"},
	[3] = {time = 1.3, sound = "Weapon_pp19vit.Clipout"},
    [4] = {time = 1.7, sound = "Weapon_pp19vit.Clipin"},
	[5] = {time = 2.6, sound = "Weapon_pp19vit.Slideback"}},

	reload_full = {[1] = {time = 0.4, sound = "Weapon_pp19vit.Cloth"},
	[2] = {time = 1.0, sound = "Weapon_pp19vit.Cliprelease"},
	[3] = {time = 1.3, sound = "Weapon_pp19vit.Clipout"},
    [4] = {time = 1.7, sound = "Weapon_pp19vit.Clipin"}}

	}
SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Hitman, Zozzie & Kyler"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_smg_ppv.mdl"
SWEP.WorldModel		= "models/weapons/w_smg_ppv.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19"

SWEP.FireDelay = 0.08
SWEP.FireSound = "Weapon_pp19vit.1"
SWEP.FireSoundSuppressed = "CW_MP5_FIRE_SUPPRESSED"
SWEP.Recoil = 0.6

SWEP.HipSpread = 0.07
SWEP.AimSpread = 0.009
SWEP.VelocitySensitivity = 1.5
SWEP.MaxSpreadInc = 0.15
SWEP.SpreadPerShot = 0.005
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 27
SWEP.DeployTime = 0.8

SWEP.ReloadSpeed = 1.0
SWEP.ReloadTime = 2.9
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 1.8
SWEP.ReloadHalt_Empty = 3.5
SWEP.SnapToIdlePostReload = false
