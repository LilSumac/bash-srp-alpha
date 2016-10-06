AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "KRISS Vector"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "x"
	killicon.AddFont("cw_mp5", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.5
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}


	SWEP.IronsightPos = Vector(-1.635, -3.554, 0.68)
	SWEP.IronsightAng = Vector(0, 0.039, 0)

	SWEP.FoldSightPos = Vector(-2.208, -4.3, 0.143)
	SWEP.FoldSightAng = Vector(0.605, 0, -0.217)

	SWEP.EoTechPos = Vector(-1.621, -4.794, 0.079)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-1.65, -5.706, 0.194)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.644, -5.513, 0.314)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

SWEP.AttachmentModelsVM = {
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Main", rel = "", pos = Vector(-0.009, 3.423, 1.893), angle = Angle(0.902, 0, 0), size = Vector(0.36, 0.36, 0.36)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Main", rel = "", pos = Vector(0.256, -8.928, -7.92), angle = Angle(0, -90, 0), size = Vector(0.904, 0.904, 0.904)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Main", pos = Vector(-0.223, -1.736, -3.027), angle = Angle(0, 0, 0), size = Vector(0.846, 0.846, 0.846)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Main", pos = Vector(0, 0.361, -1.548), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Main", pos = Vector(-0.182, 7.491, 0.640), angle = Angle(0, 90, 90), size = Vector(0.556, 0.556, 0.556)}
	}



	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 50)
end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {500, -500}, atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {0, -500}, atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {-400, 0}, atts = {"md_anpeq15"}}}


SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.35, sound = "CW_KRISS_CLIPOUT"},
	[2] = {time = 1.5, sound = "CW_KRISS_CLIPIN"},
	[3] = {time = 2.0, sound = "CW_KRISS_SLIDEBACK"}}}

SWEP.SpeedDec = 20

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "3burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Haru"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/imhard/kriss/v_kri_ss5.mdl"
SWEP.WorldModel		= "models/weapons/w_acp_crb.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 25
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "45acp"

SWEP.FireDelay = 0.05
SWEP.FireSound = "CW_KRISS_FIRE"
SWEP.FireSoundSuppressed = "CW_KRISS_FIRE_SUPPRESSED"
SWEP.Recoil = 0.5

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 28
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.7
SWEP.ReloadTime_Empty = 2
SWEP.ReloadHalt = 1.0
SWEP.ReloadHalt_Empty = 1.0
SWEP.SnapToIdlePostReload = false
