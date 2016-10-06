AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

CustomizableWeaponry:registerAmmo("9x18MM", "9x18MM Rounds", 9, 18)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "P220"

	SWEP.IconLetter = "a"
	killicon.AddFont("cw_deagle", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false

	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 1
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 1}

	SWEP.IronsightPos = Vector(-2.097, 0.386, 0.61)
	SWEP.IronsightAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(2.526, -9.506, -8.24)
	SWEP.SprintAng = Vector(70, 0, 0)

	SWEP.MoveType = 1
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = false
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(0, -1.2, 0)
	SWEP.BoltBonePositionRecoverySpeed = 25
	SWEP.OffsetBoltDuringNonEmptyReload = true
	SWEP.BoltReloadOffset = Vector(0, 1.25, 0)
	SWEP.ReloadBoltBonePositionRecoverySpeed = 20
	SWEP.ReloadBoltBonePositionMoveSpeed = 100
	SWEP.StopReloadBoneOffset = 0.8
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = true
	SWEP.DisableSprintViewSimulation = true
	SWEP.FOVPerShot = 0.3

	SWEP.AttachmentModelsVM = {
		["md_tundra9mm"] = {model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "wpn_body", pos = Vector(-0.203, -10.4, 2.151), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)}
	}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.25, hor = 0.5, roll = 2, forward = 0, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.BoltBonePositionRecoverySpeed = 17 -- how fast does the bolt bone move back into it's initial position after the weapon has fired

	SWEP.SlideBGs = {main = 1, pm = 0, pb = 1}
	SWEP.SuppressorBGs = {main = 2, pm = 1, pb = 2, none = 0}
	SWEP.MagBGs = {main = 3, regular = 0, extended = 1}
end

SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.CanRestOnObjects = false

SWEP.AttachmentDependencies = {["bg_makarov_pb_suppressor"] = {"bg_makarov_pb6p9"}}
SWEP.AttachmentExclusions = {["bg_makarov_pm_suppressor"] = {"bg_makarov_pb6p9"}}

SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_tundra9mm"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {reload = "reload",
	fire = {"fire1", "fire2", "fire3"},
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {{time = 0.61, sound = "CW_P220_MAGOUT"},
	{time = 1.23, sound = "CW_P220_MAGIN"},
	{time = 1.99, sound = "CW_P220_SLIDEBACK"},
	{time = 2.12, sound = "CW_P220_SLIDEFORWARD"}}
}

SWEP.SpeedDec = 5

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "pistol"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/cw2/pistols/p220.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_o226.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 9
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19"

SWEP.FireDelay = 0.135
SWEP.FireSound = "CW_P220_FIRE"
SWEP.FireSoundSuppressed = "CW_P220_FIRE_SUPPRESSED"
SWEP.Recoil = 0.77

SWEP.HipSpread = 0.034
SWEP.AimSpread = 0.012
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.22
SWEP.Shots = 1
SWEP.Damage = 19
SWEP.DeployTime = 0.4
--SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.59
SWEP.ReloadHalt = 1.8

SWEP.ReloadTime_Empty = 2.78
SWEP.ReloadHalt_Empty = 3

SWEP.SnapToIdlePostReload = true
