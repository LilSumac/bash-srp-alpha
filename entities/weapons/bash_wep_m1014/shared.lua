AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M1014"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_m1014", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/m1014")

	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.1

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_m1014.mdl"
	SWEP.WMPos = Vector(-1, 6, -1)
	SWEP.WMAng = Vector(-12, 0, 180)

	SWEP.BoltBone = "Bolt"
	SWEP.BoltShootOffset = Vector(0, 2.1, 0)
	SWEP.OffsetBoltOnBipodShoot = True

	SWEP.ShellPosOffset = {x = -3, y = 0, z = -5}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1

	SWEP.ReticleInactivityPostFire = 1.0

	SWEP.SightWithRail = true

	SWEP.IronsightPos = Vector(-2.645, -2.921, 1.259)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.FrontRearPos = Vector(-4.841, -6.052, 1.159)
    SWEP.FrontRearAng = Vector(0, 0.101, 0)

	SWEP.MicroT1Pos = Vector(-4.801, -5.904, 1.24)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.62, -2.921, 0.119)
    SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.CoD4TascoPos = Vector(-2.62, -3.521, 0.56)
    SWEP.CoD4TascoAng = Vector(0, 0, 0)

	SWEP.CoD4ReflexPos = Vector(-2.62, -0.88, 0.319)
    SWEP.CoD4ReflexAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.62, -2.921, 0.079)
    SWEP.AimpointAng = Vector(0.515, 0, 0)

	SWEP.ACOGPos = Vector(-2.6, -3.415, 0.081)
    SWEP.ACOGAng = Vector(0.564, 0, 0)


	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.6, -3.521, -0.84), [2] = Vector(0.768, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}

	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
	["md_cod4_reflex"] = { model = "models/v_cod4_reflex.mdl", bone = "Base", rel = "", pos = Vector(-0.158, -5.303, -2.076), angle = Angle(0, 90.63, 0), size = Vector(0.884, 0.884, 0.884)},
	["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.32, -6.453, -4.422), angle = Angle(0, 0, 0), size = Vector(0.935, 0.935, 0.935), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(-0.398, -6.362, -4.187), angle = Angle(0, 0, 0), size = Vector(0.873, 0.873, 0.873), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.255, -11.803, -10.778), angle = Angle(3.513, -87.823, -0.313), size = Vector(1.024, 1.024, 1.024), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.082, -5.513, -2.096), angle = Angle(0, 90.235, 0), size = Vector(0.902, 0.902, 0.902), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
    ["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(0.588, 10.513, 0.187), angle = Angle(-180, -90, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, -180.000, -180.000)
end

SWEP.LuaViewmodelRecoil = false

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -500},  atts = {"md_eotech", "md_aimpoint", "md_acog"}},
            ["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_slugrounds", "am_flechetterounds"}},
			        [2] = {header = "Rail", offset = {-200, 00},  atts = {"md_anpeq15"}},
					}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {insert = {{time = 0.2, sound = "CW_XM1014_INSERT"}},

	after_reload = {{time = 0.2, sound = "CW_XM1014_BOLTPULL"}},

	draw = {{time = 0, sound = "CW_XM1014_DRAW"}},}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Shot"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/shotgun/v_shot_mm1014.mdl"
SWEP.WorldModel		= "models/weapons/w_m1014.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 7
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_XM1014_FIRE"
SWEP.FireSoundSuppressed = "CW_M500_FIRESIL"
SWEP.Recoil = 4.5

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.035
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 16
SWEP.Damage = 10
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1.3
SWEP.ShotgunReload = true

SWEP.Chamberable = false
