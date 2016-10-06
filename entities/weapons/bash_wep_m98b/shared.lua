if CustomizableWeaponry then

SWEP.magType = "srMag"

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Barett M98 Bravo"
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
	SWEP.ShellDelay = 1.2
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.SightWithRail = false
	SWEP.AimBreathingEnabled = true

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

--	SWEP.CustomizePos = Vector(-10.5, -5.8, 0.4)
--	SWEP.CustomizeAng = Vector(27, -50, -30)

	SWEP.IronsightPos = Vector(-2.201, -3.5, 0.6)
	SWEP.IronsightAng = Vector(0, -0.065, 0)

	SWEP.EoTechPos = Vector(-2.181, -4.75, 0.54)
	SWEP.EoTechAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(-3.197, -3.608, -0.101)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.ReflexPos = Vector(-3.197, -3.608, 0.244)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.BallisticPos = Vector(-2.201, -3.35, 0.56)
	SWEP.BallisticAng = Vector(0, 0, 0)

	SWEP.CmorePos = Vector(-3.215, -3.608, 0.2)
	SWEP.CmoreAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(-3.2, -3.6, 0.16)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.201, -3.034, 0.512)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CSGOACOGPos = Vector(-3.21, -2.6, 0.044)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)

	SWEP.CSGO556Pos = Vector(-3.2, -3.6, 0.2)
	SWEP.CSGO556Ang = Vector(0, 0, 0)

	SWEP.CSGOSSGPos = Vector(-2.225, -0.951, 0.639)
	SWEP.CSGOSSGAng = Vector(0, 0, 0)

	SWEP.ELCANPos = Vector(-2.201, -3.034, 0.474)
	SWEP.ELCANAng = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(-2.201, -3.034, 0.8)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.LeupoldPos = Vector(-2.241, -3.501, 0.72)
	SWEP.LeupoldAng = Vector(0, 0, 0)

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BackupSights = {	["md_acog_fixed"] = {[1] = Vector(-2.201, -3.034, -0.38), [2] = Vector(0, 0, 0)},
							["md_elcan"] = {[1] = Vector(-2.211, -3.034, -0.311), [2] = Vector(0.2, 0, 0)}
	}

	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.LeupoldAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_uecw_watch"] = { type = "Model", model = "models/gmod4phun/watch_prop.mdl", bone = "Bip01 L ForeTwist", rel = "", pos = Vector(6.764, -0.24, 0.159), angle = Angle(0, 0, 130), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -7.25, 0.2), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_leupold"] = { type = "Model", model = "models/v_fas2_leupold.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -12.025, 2.049), angle = Angle(0, -90, 0), size = Vector(1.75, 1.75, 1.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_fas2_leupold_mount"] = { type = "Model", model = "models/v_fas2_leupold_mounts.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -12.025, 2.049), angle = Angle(0, -90, 0), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_sight_front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "M98_Body", rel = "", pos = Vector(-2.75, -11.25, 2.424), angle = Angle(0, -90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_sight_rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "M98_Body", rel = "", pos = Vector(-2.826, -20.75, 2.424), angle = Angle(0, -90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "M98_Body", rel = "", pos = Vector(0.168, -4.244, -3.869), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "M98_Body", rel = "", pos = Vector(0.4, 3.18, 1.981), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "M98_Body", rel = "", pos = Vector(0.4, 1.649, 1.713), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_acog_fixed"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.322, -16.25, -3.82), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "M98_Body", rel = "", pos = Vector(-0.322, -16.25, -3.82), angle = Angle(0, 0, 0), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -1.5, -1.351), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "M98_Body", rel = "", pos = Vector(-1.55, -19.75, 1.625), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "M98_Body", rel = "", pos = Vector(0.275, -21.851, -10.301), angle = Angle(3.5, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "M98_Body", rel = "", pos = Vector(0.419, 0.8, 1.94), angle = Angle(0, 180, 0), size = Vector(0.349, 0.349, 0.349), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "M98_Body", rel = "", pos = Vector(0.3, 9.8, 1.759), angle = Angle(0, 90, 0), size = Vector(0.4, 0.4, 0.4), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "M98_Body", rel = "", pos = Vector(0.4, 5.719, -2), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255)},
--		["md_csgo_acog"] = { type = "Model", model = "models/kali/weapons/csgo/eq_optic_acog.mdl", bone = "M98_Body", rel = "", pos = Vector(0.439, -3.8, -1.351), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
--		["md_csgo_556"] = { type = "Model", model = "models/kali/weapons/csgo/eq_optic_sig.mdl", bone = "M98_Body", rel = "", pos = Vector(0.449, 1.6, 1.6), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_uecw_csgo_scope_ssg"] = { type = "Model", model = "models/gmod4phun/csgo/eq_optic_scope_bender.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -10.75, 0.819), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_csgo_silencer_rifle"] = { type = "Model", model = "models/kali/weapons/csgo/eq_suppressor_rifle.mdl", bone = "M98_Body", rel = "", pos = Vector(0, 17.549, -0.801), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["md_csgo_silencer_ballistic"] = { type = "Model", model = "models/kali/weapons/csgo/eq_dsr50_suppressor.mdl", bone = "M98_Body", rel = "", pos = Vector(0, -1.5, 0), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
}

	SWEP.LaserPosAdjust = Vector(1, 0, 0)--{x = 1, y = 0, z = 0}
	SWEP.LaserAngAdjust = Angle(0, 180, 0) --{p = 2, y = 180, r = 0}

function SWEP:RenderTargetFunc()

if self.AttachmentModelsVM.md_rail then
	self.AttachmentModelsVM.md_rail.active = true
end

if self.AttachmentModelsVM.md_uecw_watch then
	self.AttachmentModelsVM.md_uecw_watch.active = true
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
SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim = true
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 2.5
SWEP.BipodFireAnim = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -500},  atts = {"md_eotech", "md_elcan", "md_ballistic"}},
	[2] = {header = "Barrel extension", offset = {100, -500}, atts = {}},
	[3] = {header = "Handguard", offset = {-500, -500}, atts = {"md_bipod"}},
--	[4] = {header = "Misc", offset = {-500, 800}, atts = {"md_anpeq15"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_magnum", "am_matchgrade"}}}

if CustomizableWeaponry_KK_HK416 then
	//table.insert( SWEP.Attachments[1].atts, 1, "md_fas2_aimpoint" )
	table.insert( SWEP.Attachments[1].atts, 7, "md_fas2_leupold" )
end

--SWEP.AttachmentDependencies = {} -- this is on a PER ATTACHMENT basis, NOTE: the exclusions and dependencies in the Attachments table is PER CATEGORY

SWEP.Animations = {fire = "m98_fire",
	fireDry = "m98_fire",
	reload = "m98_reload",
	reload_empty = "m98_reload_empty",
	idle = "m98_idle",
	draw = "m98_draw"}

SWEP.Sounds = {m98_reload = {[1] = {time = 0.6, sound = "CW_M98_MAGTAP"},
	[2] = {time = 1.2, sound = "CW_M98_MAGOUT"},
	[3] = {time = 2.0, sound = "CW_M98_MAGCLOTH"},
	[4] = {time = 2.2, sound = "CW_M98_MAGIN"},
	[5] = {time = 2.4, sound = "CW_M98_MAGLOCK"}},
	m98_reload_empty = {[1] = {time = 0.6, sound = "CW_M98_MAGTAP"},
	[2] = {time = 1.2, sound = "CW_M98_MAGOUT"},
	[3] = {time = 2.0, sound = "CW_M98_MAGCLOTH"},
	[4] = {time = 2.2, sound = "CW_M98_MAGIN"},
	[5] = {time = 2.4, sound = "CW_M98_MAGLOCK"},
	[6] = {time = 3+0.4, sound = "CW_M98_BOLTFORWARD"},
	[7] = {time = 3+0.55, sound = "CW_M98_BOLTBACK"},
	[8] = {time = 3.1+0.85, sound = "CW_M98_BOLTPUSH"},
	[9] = {time = 3.1+1.1, sound = "CW_M98_BOLTLOCK"}},
	m98_draw = {[1] = {time = 0.01, sound = "CW_M98_DRAW"}},
	m98_fire = {[1] = {time = 0.85, sound = "CW_M98_BOLTFORWARD"},
	[2] = {time = 1.05, sound = "CW_M98_BOLTBACK"},
	[3] = {time = 1.3, sound = "CW_M98_BOLTPUSH"},
	[4] = {time = 1.5, sound = "CW_M98_BOLTLOCK"}
	}}

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
SWEP.ViewModel		= "models/weapons/v_g4p_cw20_snip_m98b.mdl"
SWEP.WorldModel		= "models/weapons/w_m82.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "338lapua"

SWEP.FireDelay = 2.5
SWEP.FireSound = "CW_M98_FIRE"
SWEP.FireSoundSuppressed = "CW_M98_FIRE_SUPPRESSED"
SWEP.Recoil = 3.2

SWEP.HipSpread = 0.12
SWEP.AimSpread = 0
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 72
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 5
SWEP.ReloadHalt = 3.3
SWEP.ReloadHalt_Empty = 5.3
SWEP.SnapToIdlePostReload = true

end
