if ( !CustomizableWeaponry ) then return end
AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN SCAR-L"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -5, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_rf_scarl.mdl"
	SWEP.WMPos = Vector(0, -0.5, 0.5)
	SWEP.WMAng = Vector(0, 0, 180)

	SWEP.IronsightPos = Vector(-2.513, -2.31, 0.626)
	SWEP.IronsightAng = Vector(0.903, 0, 0)

	-- SWEP.EoTechPos = Vector(-2.033, -4.864, 0.157)
	-- SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.515, -5.98, 0.691)
	SWEP.AimpointAng = Vector(1.049, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.513, -2.31, 0.626)
	SWEP.MicroT1Ang = Vector(0.903, 0, 0)

	-- SWEP.ACOGPos = Vector(-2.52, -5.428, 0.4)
	-- SWEP.ACOGAng = Vector(1.049, 0, 0)

	SWEP.SG1Pos = Vector(-1.614, -0.861, -0.51)
	SWEP.SG1Ang = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.021, -4.864, -1.122), [2] = Vector(0, 0, 0)}}

	-- SWEP.SightWithRail = true
	-- SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AlternativePos = Vector(1.2, 1, -1)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	-- SWEP.M203OffsetCycle_Reload = 0.81
	-- SWEP.M203OffsetCycle_Reload_Empty = 0.73
	-- SWEP.M203OffsetCycle_Draw = 0

	-- SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "l-upperarm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	-- SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	-- SWEP.M203Ang = Vector(0, 0, 0)

	-- SWEP.M203HoldPos = {
		-- ["l-upperarm"] = {pos = Vector(2.197, -2.123, -1.015), angle = Angle(0, 0, 0)}
	-- }

	SWEP.AttachmentModelsVM = {
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "Gun", pos = Vector(-0.102, -2.948, -2), angle = Angle(0, 0, 0), size = Vector(0.894, 0.894, 0.894)},
		-- ["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "Gun", pos = Vector(0.273, -9.521, -8.363), angle = Angle(3.332, -90, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "Gun", pos = Vector(0.041, 7.989, 2.921), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Gun", pos = Vector(-0.227, -3.259, -0.978), angle = Angle(0, 0, 0), size = Vector(0.7, 0.7, 0.7)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "Gun", pos = Vector(0.152, 2.596, 3.186), angle = Angle(0, 180, 0), size = Vector(0.432, 0.432, 0.432)},
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Gun", pos = Vector(0.153, 2.993, 0.09), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5)},
		-- ["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "Gun", pos = Vector(2.316, -9.063, 3.388), angle = Angle(1.07, -90, 0), size = Vector(1, 1, 1), animated = true},
		-- ["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "Gun", pos = Vector(-0.186, -3.031, -1.718), angle = Angle(0, 0, 0), size = Vector(0.848, 0.848, 0.848)}
	}

	SWEP.ForeGripHoldPos = {
		["l-ring-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, 0, 0) },
		["l-thumb-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, -7.778, 0) },
		["l-thumb-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, 0, 0) },
		["l-middle-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, 0, 0) },
		["l-pinky-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(32.222, 1.11, -12.223) },
		["l-ring-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10, 0, 0) },
		["l-middle-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.111, 0, 0) },
		["l-forearm"] = { scale = Vector(1, 1, 1), pos = Vector(-1.297, 0.185, 1.296), angle = Angle(-1.111, -5.557, 63.333) },
		["lwrist"] = { scale = Vector(1, 1, 1), pos = Vector(-0.898, -0.03, -0.09), angle = Angle(14.444, -5.557, 16.666) },
		["l-upperarm"] = { scale = Vector(1, 1, 1), pos = Vector(2.036, -1.297, -0.556), angle = Angle(0, 0, 0) },
		["l-middle-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.555, 0, 0) },
		["l-pinky-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(56.666, 0, 0) },
		["l-thumb-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(105.555, 0, 0) },
		["l-ring-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(85.555, 0, 0) },
		["l-index-mid"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(34.444, 0, 0) },
		["l-index-low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(36.666, -3.333, 0) },
		["l-index-tip"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(30, 0, -16.667) }
	}

	SWEP.AttachmentPosDependency = {["md_anpeq15"] = {["bg_longris"] = Vector(-0.225, 13, 3.15)},
	["md_saker"] = {["bg_longbarrel"] = Vector(-0.042, 9, -0.1), ["bg_longris"] = Vector(-0.042, 9, -0.1)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	SWEP.BoltBone = "boltslide"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)

	SWEP.LaserPosAdjust = Vector(0.5, 0, 0)
	SWEP.LaserAngAdjust = Angle(0, 180, 0)
end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = false

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -300},  atts = {"md_microt1", "md_aimpoint"}},
	[2] = {header = "Barrel", offset = {-600, -300},  atts = {"md_saker"}},
	[3] = {header = "Rail", offset = {100, -600},  atts = {"md_anpeq15"}},
	[4] = {header = "Handguard", offset = {-400, 150}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.Animations = {fire = {"fire_01", "fire_02", "fire_03"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_MEDIUM"}},

	reload = {{time = 0.5, sound = "CW_SCARL_MAGOUT"},
	{time = 0.6, sound = "CW_FOLEY_LIGHT"},
	{time = 1.1, sound = "CW_SCARL_MAGIN"},
	{time = 1.3, sound = "CW_FOLEY_LIGHT"},
	{time = 1.6, sound = "CW_SCARL_MAGSLAP"},
	{time = 2.0, sound = "CW_SCARL_BOLT"},
	{time = 2.2, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "David Bowie"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_rf_scarl.mdl"
SWEP.WorldModel		= "models/weapons/w_rf_scarl.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "556x45"

SWEP.FireDelay = 0.096
SWEP.FireSound = "CW_SCARL_FIRE"
SWEP.FireSoundSuppressed = "CW_SCARL_FIRE_SUPPRESSED"
SWEP.Recoil = 0.9

SWEP.HipSpread = 0.04
SWEP.AimSpread = 0.0010
SWEP.VelocitySensitivity = 1
SWEP.MaxSpreadInc = 0.03
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.15
SWEP.Shots = 1
SWEP.Damage = 12
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 0.9
SWEP.ReloadTime = 1.8
SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt = 1.8
SWEP.ReloadHalt_Empty = 2.6

SWEP.SnapToIdlePostReload = true
