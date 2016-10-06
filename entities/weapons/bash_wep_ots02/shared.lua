AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
CustomizableWeaponry:registerAmmo("9×18mm", "9×18mm Makarov", 9, 18)
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "OTs-02 Kiparis"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_smg"
	SWEP.PosBasedMuz = false
	SWEP.SightWithRail = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "smallshell"
	SWEP.ShellPosOffset = {x = -1.5, y = -2, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1

	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-2.6, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true

	SWEP.IronsightPos = Vector(-2.48, -0.463, 0.811)
	SWEP.IronsightAng = Vector(-0.003, 0.196, 0)

	SWEP.MicroT1Pos = Vector(-2.529, -1.351, -0.241)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.522, -2.554, -0.266)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.KobraPos = Vector(-2.534, -2.3, -0.158)
	SWEP.KobraAng = Vector(-0.23, 0, 0)

	SWEP.AimpointPos = Vector(-2.541, 0.056, -0.129)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.518, -2.79, -0.501)
	SWEP.ACOGAng = Vector(0, 1.490, 0)

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.518, -2.79, -1.180), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.012

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "body", pos = Vector(-2.859, 0.296, -0.426), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(7.563, 0.372, -4.857), angle = Angle(0, 180, 0), size = Vector(0.669, 0.669, 0.669)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "body", pos = Vector(0.351, 0.202, 2.512), angle = Angle(0, 90, 0), size = Vector(0.284, 0.284, 0.284)},
		["md_rail"] = {model = "models/wystan/attachments/akrailmount.mdl", bone = "body", pos = Vector(0.37, 0.037, 1.202), angle = Angle(0, -90, 0), size = Vector(0.66, 0.66, 0.66)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "UMP_Body", pos = Vector(-0.801, 5.666, -0.534), angle = Angle(0, 90, -90), size = Vector(0.5, 0.5, 0.5)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "body", pos = Vector(2.433, 0.219, -0.35), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_kobra"] = {model = "models/cw2/attachments/kobra.mdl", bone = "body", pos = Vector(0.266, 0.566, -0.802), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "body", pos = Vector(3.819, -0.055, -1.39), angle = Angle(0, -90, 0), size = Vector(0.662, 0.662, 0.662)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", offset = {-400, -300},  atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {-400, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload1",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_KIPARIS_DEPLOY"}},

	reload1 = {{time = 0.4, sound = "CW_KIPARIS_MAGOUT"},
	{time = 1.45, sound = "CW_KIPARIS_MAGIN"},
	{time = 2, sound = "CW_KIPARIS_BOLTBACK"}}
	}



SWEP.SpeedDec = 15

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
SWEP.ViewModel		= "models/weapons/v_smg_kip.mdl"
SWEP.WorldModel		= "models/weapons/krycek/w_vz61_m9k.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18"

SWEP.FireDelay = 0.0706
SWEP.FireSound = "CW_KIPARIS1_FIRE", "CW_KIPARIS2_FIRE", "CW_KIPARIS3_FIRE", "CW_KIPARIS4_FIRE", "CW_KIPARIS5_FIRE", "CW_KIPARIS6_FIRE"
SWEP.FireSoundSuppressed = "CW_UMP45_FIRE_SUPPRESSED"
SWEP.Recoil = 0.7

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.01
SWEP.VelocitySensitivity = 1.7
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 20
SWEP.DeployTime = 1


SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.8
SWEP.ReloadTime_Empty = 3.5
SWEP.ReloadHalt = 2
SWEP.ReloadHalt_Empty = 3.5
