AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mossberg 500"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_moss", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/moss")

	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.9

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_m500.mdl"
	SWEP.WMPos = Vector(-1, 1.5, -1)
	SWEP.WMAng = Vector(-8, 0, 180)

	SWEP.ShellPosOffset = {x = -4, y = 0, z = -6}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1

	SWEP.ReticleInactivityPostFire = 1.0

	SWEP.SightWithRail = true

	SWEP.IronsightPos = Vector(-2.681, 2.06, 0.465)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.FrontRearPos = Vector(-4.841, -6.052, 1.159)
    SWEP.FrontRearAng = Vector(0, 0.101, 0)

	SWEP.MicroT1Pos = Vector(-4.801, -5.904, 1.24)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-4.83, -4.501, 1.559)
    SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.CSGO556Pos = Vector(-4.856, -6.165, 1.319)
    SWEP.CSGO556Ang = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-4.815, -4.068, 1.437)
    SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-4.85, -7.239, 1.041)
    SWEP.AimpointAng = Vector(0.515, 0, 0)

	SWEP.ACOGPos = Vector(-4.864, -7.505, 0.839)
    SWEP.ACOGAng = Vector(0, 0, 0)


	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-4.861, -7.505, -0.584), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 50.5}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}

	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = { ["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "weapon", rel = "", pos = Vector(5.256, -0.313, -1.716), angle = Angle(-0.995, 90.441, 0.402), size = Vector(0.592, 0.592, 0.592), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }

}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	SWEP.LaserPosAdjust = Vector(0.8, 0, 0.3)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = true

SWEP.Attachments = { [1] = {header = "Barrel", offset = {100, -500}, atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_slugrounds", "am_flechetterounds"}},
}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {insert = {{time = 0.1, sound = "CW_M500_INSERT"}},

	after_reload = {{time = 0.2, sound = "CW_M500_PUMP2"}},
	shoot1 = {{time = 0.6, sound = "CW_M500_PUMP"}},
    shoot2= {{time = 0.6, sound = "CW_M500_PUMP"}},}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Shot"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/shotgun/v_m500.mdl"
SWEP.WorldModel		= "models/weapons/w_m500.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 8
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70"

SWEP.FireDelay = 1.3
SWEP.FireSound = "CW_M500_FIRE"
SWEP.FireSoundSuppressed = "CW_M500_FIRESIL"
SWEP.Recoil = 6

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.013
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 18
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.7
SWEP.ReloadFinishWait = 1.3
SWEP.ShotgunReload = true

SWEP.Chamberable = false
