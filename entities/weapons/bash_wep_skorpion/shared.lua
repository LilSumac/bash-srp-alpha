AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")


if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Skorpion vz. 65"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	--SWEP.SelectIcon = "vgui/hud/cw_vz61_icon"
	local icol = Color( 255, 255, 255, 255 )
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/cw_vz61_kry")
	killicon.Add(  "cw_vz61_kry",		"vgui/hud/kryceks_vz61", icol  )
	SWEP.MuzzleEffect = "muzzleflash_pistol"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.Shell = "smallshell"
	SWEP.ShellScale = 0.3
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = 0}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 1
	SWEP.ForeGripOffsetCycle_Reload_Empty = 1

	SWEP.IronsightPos = Vector(-2.321, -2.418, 0.56)
	SWEP.IronsightAng = Vector(0, 0, 0)


	SWEP.SprintPos = Vector(0, 0, 0)
	SWEP.SprintAng = Vector(-12.664, 18.995, -18.996)

	SWEP.CustomizePos = Vector(8.442, -4.02, -1.81)
	SWEP.CustomizeAng = Vector(43.618, 21.106, 42.915)

	SWEP.AlternativePos = Vector(0, 1.325, -0.801)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	--SWEP.BackupSights = {["md_acog"] = {[1] = Vector(2.028, -5.613, -1.124), [2] = Vector(0, 0, 0)}}

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "VZ's Controller", rel = "", pos = Vector(0.1, 5.5, 0.699), angle = Angle(180, 90, 0), size = Vector(0.449, 0.449, 0.449) },
		["md_tundra9mm"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "VZ's Controller", rel = "", pos = Vector(0, 9.6, 0.649), angle = Angle(0, 180, -3), size = Vector(0.5, 0.5, 0.5) },
		["kry_vz61_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "VZ's Controller", rel = "", pos = Vector(0, -2.1, -0.801), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5) }

	}
	SWEP.ForegripOverridePos = {
		["md_foregrip"] = {
			["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -3.375, 12.375) },
			["arm_controller_01"] = { scale = Vector(1, 1, 1), pos = Vector(2.062, -0.564, -0.939), angle = Angle(0, 0, 0) },
			["l_thumb_low"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(21.375, 21.375, 48.375) }
		},

			["kry_vz61_likeaboss"] =  {
	["l_wrist"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(49.389, -14.268, 25.243) },
	["arm_controller_01"] = { scale = Vector(1, 1, 1), pos = Vector(-7.378, 2.271, 2), angle = Angle(-90, -55, 0) },
	["l_forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(29.634, -23.049, 12.072) }
	}
}




	--SWEP.AttachmentDependencies = {["md_microt1"]={"kry_g3_claw_rail"}, ["md_aimpoint"]={"kry_g3_claw_rail"}, ["kry_docter_sight"]={"kry_g3_claw_rail"}}
	SWEP.AttachmentExclusions = {["kry_vz61_likeaboss"] = {"kry_vz61_foregrip"}}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(3.5, 0, 0)

	SWEP.SightWithRail = false
	SWEP.CustomizationMenuScale = 0.012
end


SWEP.StocksBGs = {stock = 1, folded = 0, unfolded = 1 }

--SWEP.LuaViewmodelRecoil = false
--SWEP.FullAimViewmodelRecoil = true

SWEP.Attachments = {
[1] = {header = "Rail", offset = {-650, 70}, atts = {"md_anpeq15", "kry_vz61_foregrip"}},
[2] = {header = "Barrel", offset = {-470, -400}, atts = { "md_tundra9mm"}},
[3] = {header = "Stock", offset = {470, 150}, atts = {"kry_vz61_stock_open"}},
["+reload"] = {header = "Ammo", offset = {110, 560}, atts = {"am_magnum", "am_matchgrade"}}
}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	reload_empty = "reload1",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {draw = {[1] = {time = 0, sound = "CW_HOLSTER"}},	reload = { [1] = {time = 0.45, sound = "KRY_VZ61_MAGOUT"}, 	[2] = {time = 1.72, sound = "KRY_VZ61_MAGIN"}	},
	reload1 = {[1] = {time = 0.42, sound = "KRY_VZ61_MAGOUT"},
	[2] = {time = 1.85, sound = "KRY_VZ61_MAGIN"},
	[3] = {time = 2.4, sound = "KRY_VZ61_BOLTUSAGE"}

	}
	}

SWEP.SpeedDec = 15

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "active"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "Krycek"
SWEP.Contact		= "thekrych@gmail.com"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/krycek/v_vz61_cw20.mdl"
SWEP.WorldModel		= "models/weapons/krycek/w_vz61_m9k.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x18"

SWEP.FireDelay = 0.063
SWEP.FireSound = "KRY_VZ61_FIRE"
SWEP.FireSoundSuppressed = "KRY_VZ61_FIRE_SUPPRESSED"
SWEP.Recoil = 0.64

SWEP.HipSpread = 0.068
SWEP.AimSpread = 0.029
SWEP.VelocitySensitivity = 1.1
SWEP.MaxSpreadInc = 0.18
SWEP.SpreadPerShot = 0.006
SWEP.SpreadCooldown = 0.06
SWEP.Shots = 1
SWEP.Damage = 13
SWEP.DeployTime = 0.92

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.0
SWEP.ReloadTime_Empty = 3.17
SWEP.ReloadHalt = 2.0
SWEP.ReloadHalt_Empty = 3.05

if CustomizableWeaponry.magSystem then

CustomizableWeaponry.magSystem:registerMagType("vzMag", " Vz.61 Mag", 0)
--CustomizableWeaponry.magSystem:assignMagToWeaponClass("cw_vz61_kry", "vzMag")

SWEP.magType = "vzMag"
end
