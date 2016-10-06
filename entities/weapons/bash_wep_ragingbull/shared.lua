AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Taurus Raging Bull"
	SWEP.CSMuzzleFlashes = true

	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true

	SWEP.IronsightPos = Vector(1.393, -3.803, 0.034)
	SWEP.IronsightAng = Vector(0, 0, -0.977)

	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)

	SWEP.ACOGPos = Vector(1.434, -6.636, -0.82)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.RMRPos = Vector(1.43, -3.31, -0.278)
	SWEP.RMRAng = Vector(0.266, 0.206, 0)

	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(1.429, -6.568, -1.629), [2] = Vector(0, 0, 0)}}

	SWEP.AttachmentModelsVM = {
	["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "gun", pos = Vector(3.486, -8.898, -5.777), angle = Angle(0, 180, 0), size = Vector(0.732, 0.732, 0.732)},
	["md_rmr"] = {model = "models/wystan/attachments/2octorrds.mdl", bone = "gun", pos = Vector(3.437, -11.679, -1.716), angle = Angle(0, 180, 0), size = Vector(1.042, 1.042, 1.042)}
}
	SWEP.ViewModelMovementScale = 0.8
	SWEP.FullAimViewmodelRecoil = true
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = true
SWEP.CanRestOnObjects = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {300, -300},  atts = {"md_rmr", "md_acog"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "bronco44_reload",
	idle = "bronco44_idle",
	draw = "bronco44_draw"}

SWEP.Sounds = {bronco44_reload = {[1] = {time = 0.5, sound = "CW_MR96_CYLINDEROPEN"},
	[2] = {time = 0.3, sound = "CW_MR96_ROUNDSOUT"},
	[3] = {time = 1.4, sound = "CW_MR96_ROUNDSIN"}},
	bronco44_draw = {[1] = {time = 0.6, sound = "CW_MR96_CYLINDERCLOSE"}}}

SWEP.SpeedDec = 10

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"double"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/v_daxb_bronco.mdl"
SWEP.WorldModel		= "models/weapons/w_daxb_bronco.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 6
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "44mag"

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_MR96_FIRE_LONG"
SWEP.Recoil = 2.6

SWEP.HipSpread = 0.030
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.2
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 52
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 1.6
SWEP.ReloadHalt = 2.7

SWEP.ReloadTime_Empty = 1.6
SWEP.ReloadHalt_Empty = 2.7
