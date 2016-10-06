if CustomizableWeaponry then

SWEP.magType = "srMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AWM"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_SR25"
	SWEP.NoSilMuz = true
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = 3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.SightWithRail = false
	SWEP.AimBreathingEnabled = true
	SWEP.FullAimViewModelRecoil = false

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

--	SWEP.CustomizePos = Vector(-10.5, -5.8, 0.4)
--	SWEP.CustomizeAng = Vector(27, -50, -30)

	SWEP.IronsightPos = Vector(-2.722, -1.882, 0.43)
	SWEP.IronsightAng = Vector(0.33, 0.15, 0)

	SWEP.EoTechPos = Vector(-2.74, -2.8, 0.1)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-2.74, -2, 0.52)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-2.76, -2.8, 0.66)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.BallisticPos = Vector(-2.76, -4.6, 0.36)
	SWEP.BallisticAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-2.75, -2.8, 0.36)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.76, -2.8, 0.62)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.715, -2.8, 0.28)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-2.76, -2.8, 0.38)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGO556Pos = Vector(-2.77, -2.8, 0.52)
	SWEP.CSGO556Ang = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.76, -2.8, 0.4)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.72, -2.8, 0.28)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.78, -2.8, 0.326)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.LeupoldPos = Vector(-2.76, -2.8, 0.3)
	SWEP.LeupoldAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.LeupoldAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Base", rel = "", pos = Vector(0.237, 0.158, -1.209), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_leupold"] = { type = "Model", model = "models/v_fas2_leupold.mdl", bone = "Base", rel = "", pos = Vector(0, -2.34, 1.679), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {[3] = 2} },
		["md_fas2_leupold_mount"] = { type = "Model", model = "models/v_fas2_leupold_mounts.mdl", bone = "Base", rel = "", pos = Vector(0, -2.34, 1.679), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "Base", rel = "", pos = Vector(0, 1.799, 0.18), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroups = {[4] = 1, [2] = 1, [3] = 1} },
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Base", rel = "", pos = Vector(0.237, 0.159, -1.209), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_sight_front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "Base", rel = "", pos = Vector(-2.245, 11.534, 1.524), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, },
        ["md_sight_rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "Base", rel = "", pos = Vector(-2.224, -9.171, 1.763), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.181, -6.19, -3.939), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Base", rel = "", pos = Vector(-0.01, 0, 0.8), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Base", rel = "", pos = Vector(-0, -0.981, 0.564), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(-0.251, -5.538, -3.681), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Base", rel = "", pos = Vector(-0.251, -5.538, -3.681), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(-0.362, -5.115, -4.128), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "Base", rel = "", pos = Vector(0.105, 9.359, -2.06), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), bodygroup = {1,1}},
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "Base", rel = "", pos = Vector(-1.28, -7.544, 1.124), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(0.284, -10.891, -10.914), angle = Angle(5, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(0, 2.2, -2.901), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(0.019, -1.8, 0.699), angle = Angle(0, 180, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(0.059, 14, -0.12), angle = Angle(-180, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "Base", rel = "", pos = Vector(0.05, -7.801, -2.75), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_556"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_sig.mdl", bone = "Base", rel = "", pos = Vector(0.039, -1.201, 0.439), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_scope_ssg"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_scope_bender.mdl", bone = "Base", rel = "", pos = Vector(0.05, -0.801, 0.46), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_ballistic"] = { type = "Model", model = "models/kali/weapons/csgo/eq_dsr50_suppressor.mdl", bone = "Base", rel = "", pos = Vector(0.019, 4, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "Base", rel = "", pos = Vector(-0.02, 23, -0.801), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
}

	SWEP.LaserPosAdjust = Vector(0.4, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

	SWEP.CustomizationMenuScale = 0.014

function SWEP:RenderTargetFunc()

if self.AttachmentModelsVM.md_rail then
	self.AttachmentModelsVM.md_rail.active = true
end

	if self.AimPos != self.IronsightPos then -- if we have a sight/scope equiped, hide the front and rar sights
	self.AttachmentModelsVM.md_sight_front.active = false
	self.AttachmentModelsVM.md_sight_rear.active = false
	else
	self.AttachmentModelsVM.md_sight_front.active = true
	self.AttachmentModelsVM.md_sight_rear.active = true
	end

end

end

SWEP.SightBGs = {sightup = "", sightdown = ""}
SWEP.BarrelBGs = {regular = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = true
SWEP.BipodFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.AimBreathingIntensity = 1
SWEP.GlobalDelayOnShoot = 1.6

SWEP.Attachments = {
	{header = "Sight", offset = {600, -500},  atts = {"md_microt1", "md_cmore", "md_reflex", "md_elcan", "md_eotech", "md_aimpoint", "md_acog", "md_ballistic"}},
	{header = "Barrel", offset = {100, -500}, atts = {"md_saker"}},
	{header = "Handguard", offset = {-500, -500}, atts = {"md_bipod"}},
	{header = "Rail", offset = {-500, 0}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {-500, 600}, atts = {"am_magnum", "am_matchgrade"}}
}

if CustomizableWeaponry_KK_HK416 then
	//table.insert( SWEP.Attachments[1].atts, 7, "md_fas2_aimpoint" )
	table.insert( SWEP.Attachments[1].atts, 11, "md_fas2_leupold" )
end

--SWEP.AttachmentDependencies = {} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = "fire",
	fireDry = "fire",
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {{time = 0.5, sound = "CW_AWM_CLIPTAP"},
	{time = 0.8, sound = "CW_AWM_CLIPOUT"},
	{time = 1.6, sound = "CW_AWM_CLIPIN"},
	{time = 2.1, sound = "CW_AWM_CLIPTAP"},
	{time = 2.6, sound = "CW_AWM_BOLTBACK"},
	{time = 3.05, sound = "CW_AWM_BOLTPUSH"},
	{time = 3.4, sound = "CW_AWM_BOLTLOCK"}},
	fire = {{time = 0.15, sound = "CW_AWM_BOLTBACK"},
	{time = 0.65, sound = "CW_AWM_BOLTPUSH"},
	{time = 1, sound = "CW_AWM_BOLTLOCK"}},
	draw = {{time = 0.01, sound = "CW_AWM_DRAW"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_awm.mdl"
SWEP.WorldModel		= "models/weapons/w_awm.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "338lapua"

SWEP.FireDelay = 1.6
SWEP.FireSound = "CW_AWP_FIRE"
SWEP.FireSoundSuppressed = "CW_AWP_FIRE_SUPPRESSED"
SWEP.Recoil = 3.4

SWEP.HipSpread = 0.16
SWEP.AimSpread = 0
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 62
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.4
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 2.2
SWEP.ReloadHalt_Empty = 4
SWEP.SnapToIdlePostReload = true

end
