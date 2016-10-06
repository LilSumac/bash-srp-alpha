AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Striker 12"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "q"
	killicon.AddFont("cw_strike", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/hud/strike")

	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.3

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_striker_12g.mdl"
	SWEP.WMPos = Vector(-1, 0, -1)
	SWEP.WMAng = Vector(-5, 2, 180)

	SWEP.ShellPosOffset = {x = 6, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 1

	SWEP.ReticleInactivityPostFire = 1.0

	SWEP.SightWithRail = true

	SWEP.IronsightPos = Vector(-1.941, 0, 0.959)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.FrontRearPos = Vector(-4.841, -6.052, 1.159)
    SWEP.FrontRearAng = Vector(0, 0.101, 0)

	SWEP.MicroT1Pos = Vector(-4.801, -5.904, 1.24)
    SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.EoTechPos = Vector(-2.586, -2.679, 0.079)
    SWEP.EoTechAng = Vector(0.328, -0.216, -0.704)

	SWEP.CSGO556Pos = Vector(-4.856, -6.165, 1.319)
    SWEP.CSGO556Ang = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-2.641, -5.11, 0.6)
    SWEP.ReflexAng = Vector(-0.029, 0, 0)

	SWEP.AimpointPos = Vector(-4.85, -7.239, 1.041)
    SWEP.AimpointAng = Vector(0.515, 0, 0)

	SWEP.ACOGPos = Vector(-4.864, -7.505, 0.839)
    SWEP.ACOGAng = Vector(0, 0, 0)


	SWEP.CustomizePos = Vector(7.711, -0.482, -2)
	SWEP.CustomizeAng = Vector(16.364, 40.741, 15.277)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-4.861, -7.505, -0.584), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 50.5}
	SWEP.CSGO556AxisAlign = {right = 0, up = 0, forward = 50.5}

	SWEP.AlternativePos = Vector(-0.64, 0.294, -0.978)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.AttachmentModelsVM = {
	["md_saker"] ={  model = "models/cw2/attachments/556suppressor.mdl", bone = "Dao12", rel = "", pos = Vector(-4.703, -0.698, -2.418), angle = Angle(0, 90.067, 0), size = Vector(0.702, 0.702, 0.702)}


}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, -180.000, -180.000)
end

SWEP.LuaViewmodelRecoil = false
SWEP.SightBGs = {main = 2, none = 1}
SWEP.ADSFireAnim = false

SWEP.Attachments = {[1] = {header = "Barrel", offset = {300, -500},  atts = {"md_saker"}},
            ["+reload"] = {header = "Ammo", offset = {800, 300}, atts = {"am_slugrounds", "am_flechetterounds"}},

					}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {insert = {{time = 0.1, sound = "CW_STRIKER12_INSERT"}},

	after_reload = {{time = 0.2, sound = "CW_STRIKER12_BOLTPULL"}},

	draw = {{time = 0, sound = "CW_STRIKER12_DRAW"}},}

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
SWEP.ViewModel		= "models/weapons/shotgun/v_shot_strike.mdl"
SWEP.WorldModel		= "models/weapons/w_striker_12g.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 12
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70"

SWEP.FireDelay = 0.15
SWEP.FireSound = "CW_STRIKER12_FIRE"
SWEP.FireSoundSuppressed = "Weapon_Saiga12.Silenced2"
SWEP.Recoil = 4

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.9
SWEP.MaxSpreadInc = 0.06
SWEP.ClumpSpread = 0.025
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.8
SWEP.Shots = 12
SWEP.Damage = 8
SWEP.DeployTime = 1

SWEP.ReloadStartTime = 0.5
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = 1.3
SWEP.ShotgunReload = true

SWEP.Chamberable = false
