AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x39MM", "9x39MM", 9, 39)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "VSS Vintorez"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

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

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/cw2/rifles/w_vss.mdl"
	SWEP.WMPos = Vector(1, -9, 1.2)
	SWEP.WMAng = Vector(0, 180, 180)

	SWEP.PSOPos = Vector(-2.304, 1.417, 0.402)
	SWEP.PSOAng = Vector(0, 0, 0)

	SWEP.IronsightPos = Vector(-2.491, -2.954, 1.759)
	SWEP.IronsightAng = Vector(0.052, 0, 0)

	SWEP.KobraPos = Vector(-2.587, -3.539, 0.509)
	SWEP.KobraAng = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.527, -3.054, -0.385)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.541, -3.504, -0.233)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ShortDotPos = Vector(-2.517, -3.504, -0.166)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.CustomizePos = Vector(12.121, -4.907, -0.461)
	SWEP.CustomizeAng = Vector(17.232, 58.485, 19.311)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.PSO1AxisAlign = {right = 0, up = 0, forward = 90}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(0.2, 0, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Object01", pos = Vector(-0.234, -6.67, -2.567), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Object01", pos = Vector(0.282, -11.613, -8.844), angle = Angle(3.332, -90, 0), size = Vector(1, 1, 1)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "Object01", pos = Vector(-0.232, -0.908, 0.637), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_pso1"] = {model = "models/cw2/attachments/pso.mdl", bone = "Object01", pos = Vector(0.09, -6.288, -1.887), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "Object01", pos = Vector(-0.32, -6.019, -2.675), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "Object01", pos = Vector(0.4, -0.965, -1.775), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	SWEP.BoltBone = "ak46_bolt"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
end

SWEP.MagBGs = {main = 3, round20 = 1, regular = 0}
SWEP.StockBGs = {main = 2, asval = 1, vss = 0}

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_pso1"}},
	[2] = {header = "Magazine", offset = {100, 100},  atts = {"bg_asval_20rnd"}},
	[3] = {header = "Receiver", offset = {100, -300},  atts = {"bg_asval"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"ak47_fire1", "ak47_fire2", "ak47_fire3"},
	reload = "ak47_reload",
	reload_empty = "ak47_reloadempty",
	idle = "ak47_idle",
	draw = "ak47_draw"}

SWEP.Sounds = {ak47_draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"},
	{time = 0.41, sound = "CW_VSS_BOLTBACK"},
	{time = 0.79, sound = "CW_VSS_BOLTFORWARD"}},

	ak47_reload = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
	{time = 0.7, sound = "CW_G3A3_HANDLE"},
	{time = 0.98, sound = "CW_VSS_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2.1, sound = "CW_VSS_MAGIN"}},

	ak47_reloadempty = {{time = 0.4, sound = "CW_FOLEY_LIGHT"},
	{time = 0.7, sound = "CW_G3A3_HANDLE"},
	{time = 0.98, sound = "CW_VSS_MAGOUT"},
	{time = 1.4, sound = "CW_FOLEY_LIGHT"},
	{time = 2.1, sound = "CW_VSS_MAGIN"},
	{time = 2.5, sound = "CW_FOLEY_MEDIUM"},
	{time = 3.53, sound = "CW_VSS_BOLTBACK"},
	{time = 3.77, sound = "CW_VSS_BOLTFORWARD"},
	{time = 4, sound = "CW_FOLEY_LIGHT"}},
}

SWEP.SpeedDec = 25

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
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/rifles/vss.mdl"
SWEP.WorldModel		= "models/cw2/rifles/w_vss.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_VSS_FIRE"
SWEP.FireSoundSuppressed = "CW_VSS_FIRE"
SWEP.Recoil = 1.1

SWEP.SuppressedOnEquip = true

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.045
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 31
SWEP.DeployTime = 1.2

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 2.63
SWEP.ReloadTime_Empty = 3.92
SWEP.ReloadHalt = 3.6
SWEP.ReloadHalt_Empty = 4.7
