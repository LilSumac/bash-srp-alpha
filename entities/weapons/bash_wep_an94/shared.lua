if CustomizableWeaponry then

SWEP.magType = "arMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "AN-94"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "w"
	killicon.AddFont("cw_ar15", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.6
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.SightWithRail = true

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.IronsightPos = Vector(-1.8, -1.497, 0.8)
	SWEP.IronsightAng = Vector(-0.828, 0.14, 0)

	SWEP.EoTechPos = Vector(-1.78, -3.859, -0.76)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-1.8, -2.757, -0.52)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.TrijiconPos = Vector(-1.78, -3.6, -0.607)
	SWEP.TrijiconAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-1.8, -4.2, -0.361)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-1.82, -4.016, -0.62)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-1.841, -4.2, -0.44)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-1.785, -2.78, -0.76)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-1.785, -2.78, -0.78)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-1.795, -3.8, -0.64)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {
	["md_elcan"] = {[1] = Vector(-1.795,-4.5,-1.52), [2] = Vector(0, -0.101, 0)},
	["md_acog_fixed"] = {[1] = Vector(-1.787,-4.5,-1.601), [2] = Vector(0, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = 0, y = 0, r = 0}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(0, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_uecw_akmag"] = { type = "Model", model = "models/gmod4phun/akmag_bg_skin.mdl", bone = "mag_mesh", rel = "", pos = Vector(-0.25, 0, 1.649), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "bolt_mesh", rel = "", pos = Vector(-1.92, 0.66, -2.181), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "body_mesh", rel = "", pos = Vector(-1.558, -0.051, 2.14), angle = Angle(0, 90, 0), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255)},
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "body_mesh", rel = "", pos = Vector(3.296, -0.32, -2.208), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "body_mesh", rel = "", pos = Vector(3.296, -0.32, -2.208), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "body_mesh", rel = "", pos = Vector(3.588, -0.24, -2.158), angle = Angle(0, -90, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body_mesh", rel = "", pos = Vector(-3.8, -0.101, 2.25), angle = Angle(0, -90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "body_mesh", rel = "", pos = Vector(6.657, 0.18, -7.105), angle = Angle(5, 180, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body_mesh", rel = "", pos = Vector(-2.011, -0.075, 2.035), angle = Angle(0, -90, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "body", rel = "", pos = Vector(-0.551, -2.34, -2.639), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_trijicon"] = { type = "Model", model = "models/att_trijicon.mdl", bone = "body_mesh", rel = "", pos = Vector(-3.661, -0.04, -0.22), angle = Angle(0, -90, 0), size = Vector(1.95, 1.95, 1.95), color = Color(255, 255, 255, 255)},
		["md_uecw_csgo_acog"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_acog.mdl", bone = "body_mesh", rel = "", pos = Vector(3.72, -0.02, -1.081), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255)},
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "bolt_mesh", rel = "", pos = Vector(-20.16, 0.66, -0.7), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
		["md_rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "body_mesh", rel = "", pos = Vector(-1.6, -0.299, 0.68), angle = Angle(0, -90, 0), size = Vector(1, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}

	SWEP.ForeGripHoldPos = {
		["l_ring_low"] = {vector = Vector(0, 0, 0), angle = Angle(19.048, 0, 0)},
		["l_middle_low"] = {vector = Vector(0, 0, 0), angle = Angle(47.618, 0, 0)},
		["l_ring_mid"] = {vector = Vector(0, 0, 0), angle = Angle(-13.334, 0, 0)},
		["l_middle_tip"] = {vector = Vector(0, 0, 0), angle = Angle(41.904, 0, 0)},
		["l_thumb_low"] = {vector = Vector(0, 0, 0), angle = Angle(20.951, 0, -28.571)},
		["l_wrist"] = {vector = Vector(0, 0, 0), angle = Angle(19.048, -2.534, 7.66)},
		["l_thumb_tip"] = {vector = Vector(0, 0, 0), angle = Angle(0, 95.237, 0)},
		["l_ring_tip"] = {vector = Vector(0, 0, 0), angle = Angle(60.951, 0, 0)},
		["l_pinky_tip"] = {vector = Vector(0, 0, 0), angle = Angle(85.713, 0, 0)},
		["l_thumb_mid"] = {vector = Vector(0, 0, 0), angle = Angle(0, 13.333, 0)},
		["l_pinky_low"] = {vector = Vector(0, 0, 0), angle = Angle(0, 0, -15.238)},
		["l_index_tip"] = {vector = Vector(0, 0, 0), angle = Angle(13.333, 0, 0)},
		["l_middle_mid"] = {vector = Vector(0, 0, 0), angle = Angle(-15.238, 0, 0)},
		["l_index_mid"] = {vector = Vector(0, 0, 0), angle = Angle(3.438, 0, 0)},
		["l_pinky_mid"] = {vector = Vector(0, 0, 0), angle = Angle(-28.571, 0, 0)},
		["l_forearm"] = {pos = Vector(2, -1.274, 1.055), angle = Angle(-1.905, 13.333, 87.619)},
		["l_index_low"] = {vector = Vector(0, 0, 0), angle = Angle(74.286, 0, -9.469)}
	}

	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-3.2, 0, 0)

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(2, 180, 0) --{p = 2, y = 180, r = 0}

	SWEP.MagBoneName = "mag_mesh"
	SWEP.UECWAKMagSkin = 1

end

SWEP.SightBGs = {main = 2, none = 1}
SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -500},  atts = {"md_microt1","md_cmore", "md_reflex", "md_elcan", "md_eotech", "md_aimpoint"}, exclusions = {bg_ris = true, bg_longbarrel = true}},
	[2] = {header = "Barrel", offset = {100, -500}, atts = {"md_saker"}},
	[3] = {header = "Handguard", offset = {-400,-500}, atts = {"md_foregrip"}},
	[4] = {header = "Magazine", offset = {-200, 0}, atts = {"md_uecw_akmag"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

SWEP.AttachmentDependencies = {["md_m203"] = {"bg_longris"}} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = {"fire1", "fire2", "fire3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {reload = {[1] = {time = 0.65, sound = "CW_AN94_MAGOUT"},
	[2] = {time = 1.95, sound = "CW_AN94_MAGIN"},
	[3] = {time = 3, sound = "CW_AN94_BOLT"}},
	draw = {{time = 0.01, sound = "CW_FOLEY_MEDIUM"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "2burst", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_cstm_an94.mdl"
SWEP.WorldModel		= "models/weapons/w_ak107.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "545x39"

SWEP.FireDelay = 0.1
SWEP.FireSound = "CW_AN94_FIRE"
SWEP.FireSoundSuppressed = "CW_AN94_FIRE_SUPPRESSED"
SWEP.Recoil = 1.05

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 31
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.3
SWEP.ReloadTime_Empty = 4
SWEP.ReloadHalt = 2.8
SWEP.ReloadHalt_Empty = 4.5
SWEP.SnapToIdlePostReload = true

function SWEP:CycleFiremodes()
	t = self.FireModes

	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end

	if self.dt.State == CW_AIMING or self:isBipodDeployed() then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end

	if self.FireMode != self.FireModes[t.last] and self.FireModes[t.last] then
		CT = CurTime()
		self:SelectFiremode(self.FireModes[t.last])
		self:SetNextPrimaryFire(CT + 0.25)
		self:SetNextSecondaryFire(CT + 0.25)
		self.ReloadWait = CT + 0.25
	end

	if self.FireMode == "2burst" then
		self.FireDelay = 0.033
	else self.FireDelay = 0.1 end

end

end
