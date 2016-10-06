
if CustomizableWeaponry then

	AddCSLuaFile()
	AddCSLuaFile("sh_sounds.lua")
	include("sh_sounds.lua")

	util.PrecacheModel("models/weapons/v_cwkk_hk416.mdl")
	util.PrecacheModel("models/weapons/w_cwkk_hk416.mdl")

	local Vec0 = Vector(0,0,0)
	local Vec1 = Vector(1,1,1)
	local Ang0 = Angle(0,0,0)

	local USE_OLD_WELEMENTS = true		//requires map restart

	SWEP.magType = "arMag"

	if CLIENT then
		SWEP.PrintName = "HK416"
		SWEP.CSMuzzleFlashes = true
		SWEP.ViewModelMovementScale = 1.15

		SWEP.IconLetter = "w"
		killicon.Add( "cw_kk_hk416", "qq_icons/kills/cw_kk_hk416", Color(255, 80, 0, 150))
		SWEP.SelectIcon = surface.GetTextureID("qq_icons/select/cw_kk_hk416")

		SWEP.MuzzleEffect = "muzzleflash_6"

		SWEP.SnapToGrip = true
		SWEP.ShellScale = 0.35

		SWEP.ForeGripOffsetCycle_Reload = 0.775
		SWEP.ForeGripOffsetCycle_Reload_Empty = 0.825
		SWEP.ForeGripOffsetCycle_Draw = 0.6

		SWEP.M203OffsetCycle_Reload = 0.775
		SWEP.M203OffsetCycle_Reload_Empty = 0.73
		SWEP.M203OffsetCycle_Draw = 0.5

		SWEP.BaseArm = "Bip01 L Clavicle"
		SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

		SWEP.HoldBoltWhileEmpty = true
		SWEP.DontHoldWhenReloading = false

		SWEP.BoltBone = "g"
		SWEP.BoltShootOffset = Vector(0, 2.46, 0)
		SWEP.OffsetBoltOnBipodShoot = true

		SWEP.AttachmentModelsVM = {
			/*top*/		["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "bod", rel = "", pos = Vector(-0.019, -11, 4.448), angle = Angle(0, -90, 0), size = Vector(0.55, 0.55, 0.55)},
			-- /*side back*/["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "bod", rel = "", pos = Vector(-0.912, -7.884, 3.447), angle = Angle(0, -90, 90), size = Vector(0.55, 0.55, 0.55)},
			-- /*side front*/	["md_anpeq15"] = {model = "models/cw2/attachments/anpeq15.mdl", bone = "bod", rel = "", pos = Vector(-0.912, -11.664, 3.447), angle = Angle(0, -90, 90), size = Vector(0.55, 0.55, 0.55)},

			["md_reflex"] = {model = "models/attachments/kascope.mdl", bone = "bod", rel = "", pos = Vector(-0.134, 1.621, 1.68), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
			-- ["md_cod4_reflex_2"] = {model = "models/v_cod4_reflex.mdl", bone = "bod", rel = "", pos = Vector(-0.134, 1.621, 1.68), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85)},
			["md_cod4_eotech_v2"] = {model = "models/v_cod4_eotech.mdl", bone = "bod", rel = "", pos = Vector(-0.105, 1.621, 1.491), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
			-- ["md_cod4_eotech_v2"] = {model = "models/v_cod4_eotech.mdl", bone = "bod", rel = "", pos = Vector(-0.105, 1.621, 1.491), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899), skin = 1, bodygroups = {[2] = 1} },
			["md_cod4_aimpoint_v2"] = {model = "models/v_cod4_aimpoint.mdl", bone = "bod", rel = "", pos = Vector(-0.145, 1.621, 1.491), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},
			["md_cod4_acog_v2"] = {model = "models/v_cod4_acog.mdl", bone = "bod", rel = "", pos = Vector(-0.15, 1, 1.82), angle = Angle(0, -90, 0), size = Vector(0.899, 0.899, 0.899)},

			["md_fas2_aimpoint"] = {model = "models/c_fas2_aimpoint_rigged.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -5.551, 3.726), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), bodygroups = {} },
			["md_fas2_leupold"] = {model = "models/v_fas2_leupold.mdl", bone = "bod", rel = "", pos = Vector(-0.087, -1.979, 5.781), angle = Angle(0, 90, 0), size = Vector(1.799, 1.799, 1.799)},
			["md_fas2_leupold_mount"] = {model = "models/v_fas2_leupold_mounts.mdl", bone = "bod", rel = "", pos = Vector(-0.087, -1.979, 5.781), angle = Angle(0, 90, 0), size = Vector(1.799, 1.799, 1.799)},
			["md_fas2_eotech"] = {model = "models/c_fas2_eotech.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -5.551, 3.95), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},
			["md_fas2_eotech_stencil"] = {model = "models/c_fas2_eotech_stencil.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -5.551, 3.95), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},

			["larue_mount"] = {model = "models/c_larue_kkhx.mdl", bone = "bod", rel = "", pos = Vector(-0.364, -5.158, 4.567), angle = Angle(0, 90, 0), size = Vector(1.1, 1.1, 1.1)},
			["md_magnifier_scope"] = {model = "models/c_magnifier_scope.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -8.473, 3.979), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},

			["md_troyfrontsight_kk"] = {model = "models/c_troy_sight_front.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -12.547, 3.979), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},
			["md_troyrearsight_kk"] = {model = "models/c_troy_sight_rear.mdl", bone = "bod", rel = "", pos = Vector(-0.137, -8.556, 3.979), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), active = false},

			-- ["md_fas2_holo"] = {model = "models/lt_c/sci_fi/weapons/holo_sight.mdl", bone = "bod", rel = "", pos = Vector(-0.159, -1.267, 0.076), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
			["md_fas2_holo_aim"] = {model = "models/v_holo_sight_orig_hx.mdl", bone = "bod", rel = "", pos = Vector(-0.159, -1.267, 0.076), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
			["md_fas2_holo"] = {model = "models/v_holo_sight_kkrc.mdl", bone = "bod", rel = "", pos = Vector(-0.159, -1.267, 0.076), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},
			-- ["md_backup_reflex"] = { type = "Model", model = "models/c_docter.mdl", bone = "bod", rel = "", pos = Vector(-0.108, -12.504, 4.334), angle = Angle(0, 90, 0), size = Vector(1, 1, 1),},
			-- ["md_fas2_leupold_mount_2"] = {model = "models/v_fas2_leupold_rails.mdl", bone = "bod", rel = "", pos = Vector(-0.087, -1.979, 5.781), angle = Angle(0, 90, 0), size = Vector(1.799, 1.799, 1.799)},
			-- ["burriz"] = {model = "models/c_docter.mdl", bone = "bod", rel = "", pos = Vector(0.56, -6.808, 6.418), angle = Angle(0, 90, 45), size = Vector(0.8, 0.8, 0.8)},

			["md_flashlight_kk_rail"] = {model = "models/c_angled_rails.mdl", bone = "bod", rel = "", pos = Vector(-0.463, -11.655, 3.322), angle = Angle(0, 90, -90), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_flashlight_kk"] = {model = "models/c_flashlight_kk.mdl", bone = "bod", rel = "", pos = Vector(-1.905, -13.747, 4.506), angle = Angle(0, 90, 45), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["md_backup_reflex_rail"] = {model = "models/c_angled_rails.mdl", bone = "bod", rel = "", pos = Vector(0.212, -11.405, 3.319), angle = Angle(0, -90, -90), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_backup_reflex"] = {model = "models/c_docter.mdl", bone = "bod", rel = "", pos = Vector(1.018, -12.521, 3.862), angle = Angle(0, 90, 45), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },

			["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "bod", rel = "", pos = Vector(-0.129, -0.615, 1.12), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
			["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "bod", rel = "", pos = Vector(-0.575, -22.234, 0.326), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.699)},
			["md_m203"] = {model = "models/cw2/attachments/m203.mdl", bone = "bod", rel = "", pos = Vector(-2.02, 4.163, 5.436), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), animated = true},
			["md_hk416_bipod"] = {model = "models/c_bipod.mdl", bone = "bod", rel = "", pos = Vector(-0.182, -12.565, 1.807), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		}

		SWEP.WElements = {
			-- ["wm"] = { type = "Model", model = "models/weapons/W_cwkk_hk416.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), pos_dropped = Vector(0, 0, 0), angle = Angle(-3, 1, 180), angle_dropped = Angle(0, 0, 180), size = Vector(1, 1, 1),color = Color(0, 0, 0, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["wm_cod4"] = { type = "Model", model = "models/w_cod4_attachments.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.987, 0.952, -2.53), pos_dropped = Vector(12.987, 1.236, -1.843), angle = Angle(-3, 1, 179), angle_dropped = Angle(0, 90, 180), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_fas2_holo"] = { type = "Model", model = "models/lt_c/sci_fi/weapons/holo_sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.008, 1.103, -0.59), angle = Angle(-3, 1, 180), pos_dropped = Vector(5.008, 1.233, -0.394), angle_dropped = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_magnifier_scope"] = { type = "Model", model = "models/c_magnifier_scope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.064, 0.973, -5.766), angle = Angle(-3, 1, 180), pos_dropped = Vector(15.064, 1.187, -5.093), angle_dropped = Angle(0, 0, 180), size = Vector(1.7, 1.7, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, hide = true },
			["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.363, 0.973, -5.766), angle = Angle(-3, 1, 180), pos_dropped = Vector(12.363, 1.187, -5.093), angle_dropped = Angle(0, 0, 180), size = Vector(1.7, 1.7, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.44, 0.689, -0.466), pos_dropped = Vector(-0.44, 0.689, -0.466), angle = Angle(0, -89, 177), angle_dropped = Angle(0, -90, 180), size = Vector(1, 1, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.217, 3.348, -5.685), pos_dropped = Vector(-0.217, 3.348, -5.685), angle = Angle(-3, 1, 180), angle_dropped = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			/*with foldsight*/["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.086, 0.686, -6.568), pos_dropped = Vector(18.086, 1.034, -5.571), angle = Angle(3, -179, 180), angle_dropped = Angle(0, 180, 180), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			/*low mount*/["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint_rigged.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.131, 1.082, -5.283), pos_dropped = Vector(11.131, 1.260, -4.703), angle = Angle(-3, 1, 180), angle_dropped = Angle(0, 0, 180), size = Vector(1.7, 1.7, 1.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_hk416_bipod"] = { type = "Model", model = "models/c_bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.509, 0.904, -3.096), pos_dropped = Vector(20.509, 1.253, -2.027), angle = Angle(0, -89, 177), angle_dropped = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_fas2_leupold"] = { type = "Model", model = "models/v_fas2_leupold.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.541, 1.105, -7.764), pos_dropped = Vector(5.541, 1.248, -7.468), angle = Angle(-3, 1, 180), angle_dropped = Angle(0, 0, 180), size = Vector(2.299, 2.299, 2.299), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			["md_fas2_leupold_mount"] = { type = "Model", model = "models/v_fas2_leupold_mounts.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.541, 1.105, -7.764), pos_dropped = Vector(5.541, 1.248, -7.468), angle = Angle(-3, 1, 180), angle_dropped = Angle(0, 0, 180), size = Vector(2.299, 2.299, 2.299), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
			/*short barrel*/["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.519, 1.092, -7.007), pos_dropped = Vector(9.040, 1.228, -6.526), angle = Angle(0, 91, 3), angle_dropped = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		}

		SWEP.CompM4SBoneMod = {
			["ard"] = { scale = Vec1, pos = Vec0, angle = Ang0}
		}

		SWEP.CompM4SBoneMod_peq = { // bonemod uses SCK OUTPUT form
			["boner"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 0) },
			["rear01"] = { scale = Vec1, pos = Vec0, angle = Angle(-82, 0, 0) },
			["rear02"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 10) },
			["front01"] = { scale = Vec1, pos = Vec0, angle = Angle(-65, 0, 0) },
			["front02"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 0) },
			["ard"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 0) }
		}

		SWEP.CompM4SBoneMod_3x = {
			["boner"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["rear01"] = { scale = Vec0, pos = Vec0, angle = Ang0},
			["rear02"] = { scale = Vec0, pos = Vec0, angle = Ang0},
			["front01"] = { scale = Vec1, pos = Vec0, angle = Angle(180, 0, 0) },
			["front02"] = { scale = Vec1, pos = Vec0, angle = Angle(0, 0, 145) },
			["ard"] = { scale = Vec0, pos = Vec0, angle = Ang0}
		}

		SWEP.CompM4SBoneMod_def = {
			["boner"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["rear01"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["rear02"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["front01"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["front02"] = { scale = Vec1, pos = Vec0, angle = Ang0},
			["ard"] = { scale = Vec1, pos = Vec0, angle = Ang0}
		}

		SWEP.ForeGripHoldPos = {
			["Bip01 L UpperArm"]	= {pos = Vector(0, 0, 0), angle = Angle(-0.5, -4.5, 5)},
			["Bip01 L Finger3"]		= {pos = Vector(0, 0, 0), angle = Angle(0, 28.024, 0)},
			["Bip01 L Finger41"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -41.731, 0)},
			["Bip01 L Clavicle"]	= {pos = Vector(0, 0, 0), angle = Angle(-1.104, -6.309, -2.337)},
			["Bip01 L Finger22"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -52.359, 0)},
			["Bip01 L Finger31"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -19.549, 0)},
			["Bip01 L Finger02"]	= {pos = Vector(0, 0, 0), angle = Angle(14.552, -21.324, 0)},
			["Bip01 L Finger11"]	= {pos = Vector(0, 0, 0), angle = Angle(4.489, -47.452, 0)},
			["Bip01 L Finger4"]		= {pos = Vector(0, 0, 0), angle = Angle(0, 55, 0)},
			["Bip01 L Finger1"]		= {pos = Vector(0, 0, 0), angle = Angle(6.344, -24.75, -6.077)},
			["Bip01 L Finger0"]		= {pos = Vector(0, 0, 0), angle = Angle(-25.786, -21.994, 27.545)},
			["Bip01 L Finger32"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -47.031, 0)},
			["Bip01 L Hand"]		= {pos = Vector(0, 0, 0), angle = Angle(-6.211, -3.247, 71.694)},
			["Bip01 L ForeTwist"]	= {pos = Vector(0, 0, 0), angle = Angle(-1, 0, 55.839)},
			["Bip01 L Finger21"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -8.82, 0)},
			["Bip01 L Finger2"]		= {pos = Vector(0, 0, 0), angle = Angle(2.484, 4.798, 0)},
			["Bip01 L Finger01"]	= {pos = Vector(0, 0, 0), angle = Angle(18.684, 0.316, 0)},
			["Bip01 L Finger42"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -65.405, 0)}
		}

		SWEP.M203HoldPos = {
			["Bip01 L Clavicle"] = {pos = Vector(1.481, 0, 0.419), angle = Angle(-5.737, 0, 0)}
		}

		SWEP.ForegripOverridePos = {
			["bg_hk416_cmag"] = {
				["Bip01 L UpperArm"] = {pos = Vector(-1.864, 0.043, -1.872), angle = Angle(0, 8.812, 0)}
			},

			["md_anpeq15"] = {
				["Bip01 L Finger0"] = {pos = Vector(0, 0, 0), angle = Angle(6.092, 5.56, 0)},
			},

			["cmag_anpeq"] = {
				["Bip01 L Finger02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -11.707, 0) },
				["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(8.852, 5.321, 0) },
				["Bip01 L UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(-1.864, 0.043, -1.872), angle = Angle(0, 8.812, 0) },
			},

			["bipod_active"] = {
				-- ["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-15.216, 12.923, -5.027), angle = Angle(0, -39.274, 0) },
				["Bip01 L Finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
				["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-10.825, 0.407, -3.204), angle = Angle(0, 0, 0) },
				["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 7.447, 0) },
				["Bip01 L Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
				["Bip01 L Finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
				["Bip01 L Finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
			},
		}

		SWEP.LaserPosAdjust = Vector(0, 0, 0)
		SWEP.LaserAngAdjust = Angle(0, 0, 0)

		SWEP.AttachmentPosDependency = {
			["md_saker"] = {
				["bg_hk416_longbarrel"] = Vector(-0.129, -3.713, 1.12),
			},
			["md_anpeq15"] = {
				["bg_hk416_foldsight"] = Vector(-0.019, -10.223, 4.448),
				["md_cod4_aimpoint_v2"] = Vector(-0.912, -11.664, 3.447),
				-- ["md_fas2_holo"] = Vector(-0.912, -11.664, 3.447),
				-- ["md_backup_reflex"] = Vector(-0.912, -11.664, 3.447),
			},
			["md_fas2_aimpoint"] = {
				["md_magnifier_scope"] = Vector(-0.137, -8.473, 3.979),
				-- ["md_anpeq15"] = Vector(-0.137, -5.551, 3.95),
			},
			["md_fas2_eotech"] = {
				["md_magnifier_scope"] = Vector(-0.137, -8.473, 3.979),
			},
			["md_cod4_reflex"] = {
				["md_magnifier_scope"] = Vector(-0.135, -1.877, 1.87),
			},
			["md_cod4_aimpoint_v2"] = {
				["md_magnifier_scope"] = Vector(-0.145, -1.433, 2.049),
			},
			["md_cod4_eotech_v2"] = {
				["md_magnifier_scope"] = Vector(-0.105, -1.359, 1.491),
			},
			["md_fas2_holo"] = {
				["md_magnifier_scope"] = Vector(-0.159, -2.336, 0.075),
			},
			["md_magnifier_scope"] = {
				["bg_hk416_foldsight"] = Vector(-0.137, -8.912, 3.979),
			},
		}
		SWEP.AttachmentAngDependency = {
			["md_anpeq15"] = {
				["md_cod4_aimpoint_v2"] = Angle(0, -90, 90),
				-- ["md_fas2_holo"] = Angle(0, -90, 90),
			},
		}

		SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

		SWEP.IronsightPos = Vector(2.111, -2, 0.101)			//new rear sight
		SWEP.IronsightAng = Vector(0.203, -0.015, 0)

		SWEP.FoldSightPos = Vector(2.111, -1, 0.225)			//BATTLE SIGHTS
		SWEP.FoldSightAng = Vector(0.096, -0.009, 0)

		SWEP.TroySightPos = Vector(2.118, -1, 0.179)			//MD BATTLE SIGHTS
		SWEP.TroySightAng = Vector(-0.02, -0.019, 0)

		SWEP.CoD4ReflexPos = Vector(2.11, -2, 0.29)
		SWEP.CoD4ReflexAng = Vector(0, 0, 0)

		SWEP.CoD4ReflexPos_mag3x = Vector(2.111, -3.5, 0.112)
		SWEP.CoD4ReflexAng_mag3x = Vector(0, 0, 0)

		SWEP.EoTech552Pos = Vector(2.111, -2.2, 0.042)
		SWEP.EoTech552Ang = Vector(0, -0.2, 0)

		SWEP.EoTech552Pos_mag3x = Vector(2.125, -3.5, 0.046)
		SWEP.EoTech552Ang_mag3x = Vector(0, 0, 0)

		SWEP.EoTech553Pos = Vector(2.132, -2.201, -0.04)
		SWEP.EoTech553Ang = Vector(0.4, 0, 0)

		SWEP.EoTech553Pos_mag3x = Vector(2.131, -3.5, -0.038)
		SWEP.EoTech553Ang_mag3x = Vector(0, 0, 0)

		SWEP.CoD4TascoPos = Vector(2.119, -2, 0.59)
		SWEP.CoD4TascoAng = Vector(0, 0, 0)

		SWEP.CoD4TascoPos_mag3x = Vector(2.121, -3.5, 0.043)
		SWEP.CoD4TascoAng_mag3x = Vector(0, 0, 0)

		SWEP.FAS2AimpointPos = Vector(2.114, -2, 0.282)
		SWEP.FAS2AimpointAng = Vector(0.056, -0.051, 0)

		SWEP.FAS2AimpointPos_mag3x = Vector(2.121, -3.5, 0.035)
		SWEP.FAS2AimpointAng_mag3x = Vector(0, 0, 0)

		-- SWEP.FAS2AimpointPos_lam = Vector(2.114, -2, 0.057)
		-- SWEP.FAS2AimpointAng_lam = Vector(0.056, -0.051, 0)

		SWEP.CoD4ACOGPos = Vector(2.095, -2, 0.1)
		SWEP.CoD4ACOGAng = Vector(-0.062, -0.036, 0)

		SWEP.LeupoldPos = Vector(2.163, -2, -0.068)
		SWEP.LeupoldAng = Vector(0.144, 0.094, 0)

		SWEP.HoloPos = Vector(2.078, 0, -0.04)
		SWEP.HoloAng = Vector(0, 0, 0)

		SWEP.HoloPos_mag3x = Vector(2.076, -2, -0.035)
		SWEP.HoloAng_mag3x = Vector(0, 0, 0)

		SWEP.BackupReflexPos = Vector(2.138, -12, 0.412)
		SWEP.BackupReflexAng = Vector(0, 0, 0)

		SWEP.BackupReflexPos = Vector(3.881, -2, 1.241)
		SWEP.BackupReflexAng = Vector(0, 0, 45)

		SWEP.AlternativePos = Vector(-0.16, 1.493, 0.801)
		SWEP.AlternativeAng = Vector(0, -1.043, 1.19)

		SWEP.M203Pos = Vector(-0.16, 0, 0.801)
		SWEP.M203Ang = Vector(0, -1.043, 1.19)

		SWEP.CustomizePos = Vector(-5.54, 2.516, -0.764)
		SWEP.CustomizeAng = Vector(21.302, -28.997, -18.444)

		SWEP.SprintPos = Vector(-2.161, -0.621, -1.081)
		SWEP.SprintAng = Vector(-15.775, -42.013, 26.052)

		SWEP.MagnifierPos = Vector(2.121, -2.5, 0.035)
		SWEP.MagnifierAng = Vector(0.361, 0, 0)

		SWEP.DrawCrosshair = false
		SWEP.AimSwayIntensity = 0.6

		SWEP.CustomizationMenuScale = 0.0135

		SWEP.WorldShellEjectionAttachmentID = 4
	end

	function SWEP:fireAnimFunc()
		local cyc = 0
		local clip = self:Clip1()

		if self:isAiming() or self.dt.BipodDeployed or self.ActiveAttachments.md_foregrip or self.ActiveAttachments.md_m203 then
			cyc = 1
		end

		if clip > 1 then
			self:sendWeaponAnim("fire",1,cyc)
		else
			self:sendWeaponAnim("fire_dry",1,cyc)
		end
	end //*/

	SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
	SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
	SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
	SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 3}
	SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}

	SWEP.LuaViewmodelRecoil = true

	SWEP.Attachments = {
		-- {header = "Sight", offset = {550, -475}, atts = {"md_cod4_reflex","md_fas2_eotech","md_fas2_holo","md_cod4_acog_v2","md_fas2_leupold"}},
		{header = "Sight", offset = {550, -475}, atts = {"bg_hk416_foldsight","md_reflex","md_eotech","md_aimpoint_","md_acog"}},
		{header = "Barrel ext", offset = {-100, -475}, atts = {"bg_hk416_longbarrel"}},
		{header = "Barrel", offset = {-600, -475}, atts = {"md_saker"}},
		{header = "Side Rail", offset = {-600, -25}, atts = {"bg_hk416_railcover"}},
		{header = "Handguard", offset = {-600, 425}, atts = {"md_foregrip", "md_hk416_bipod", "md_m203"}},
		{header = "Magazine", offset = {0, 500}, atts = {"bg_hk416_34rndmag", "bg_hk416_cmag"}},
		{header = "Stock", offset = {650, 600}, atts = {"bg_hk416_heavystock", "bg_hk416_nostock"}},
		["+reload"] = {header = "Ammo", offset = {1000, 510}, atts = {"am_magnum", "am_matchgrade"}},
	}

	if CustomizableWeaponry_KK_EXTRA then

	end

	SWEP.AttachmentDependencies = {
		["md_magnifier_scope"] = {"md_cod4_reflex","md_cod4_eotech_v2","md_cod4_aimpoint_v2","md_fas2_eotech","md_fas2_aimpoint","md_fas2_holo"},
	}

	SWEP.AttachmentExclusions = {
		["bg_hk416_cmag"] = {"md_m203"},
		["md_backup_reflex"] = {"md_cod4_reflex","md_cod4_eotech_v2","md_cod4_aimpoint_v2","md_fas2_eotech","md_fas2_aimpoint","md_hk416_bipod","md_fas2_holo"},
	}

	SWEP.Animations = {
		fire = {"Sshoot1", "Sshoot2", "Sshoot3"},
		fire_dry = "Sshoot_last",
		reload = "Sreload1_tacticool",
		reload_empty = "Sreload1",
		idle = "Sidle",
		draw = "Sdraw"
	}

	SWEP.Sounds = {
		Sdraw = {
			[1] = {time = 0.17, sound = "CW_KK_HK416_BOLTBACK"},
			[2] = {time = 0.5, sound = "CW_KK_HK416_BOLTRELEASE"}
		},
		Sreload1 = {
			[1] = {time = 0.38, sound = "CW_KK_HK416_CLIPOUT"},
			[2] = {time = 0.83, sound = "CW_KK_HK416_MAGDROP"},
			[3] = {time = 1.04, sound = "CW_KK_HK416_CLIPIN"},
			[4] = {time = 2, sound = "CW_KK_HK416_BOLTCATCH"}
		},
		Sreload1_tacticool = {
			[1] = {time = 0.38, sound = "CW_KK_HK416_CLIPOUT"},
			[2] = {time = 0.83, sound = "CW_KK_HK416_MAGDROP"},
			[3] = {time = 1.04, sound = "CW_KK_HK416_CLIPIN"},
		},
	}

	SWEP.FireSound = "CW_KK_HK416_FIRE"
	SWEP.FireSoundSuppressed = "CW_KK_HK416_FIRE_SUPPRESSED"

	SWEP.SpeedDec = 30

	SWEP.Slot = 3
	SWEP.SlotPos = 0
	SWEP.NormalHoldType = "ar2"
	SWEP.RunHoldType = "passive"
	SWEP.FireModes = {"auto", "3burst", "semi"}
	-- SWEP.FireModes = {"auto","semi","double","bolt","pump","break","2burst","3burst","safe"}
	SWEP.Base = "cw_base"
	SWEP.Category = "BASH Weapons"

	SWEP.Author			= "Spy & Knife Kitty"
	SWEP.Contact		= ""
	SWEP.Purpose		= ""
	SWEP.Instructions	= ""

	SWEP.ViewModelFOV	= 70
	SWEP.ViewModelFlip	= true
	SWEP.ViewModel = "models/weapons/v_cwkk_hk416.mdl"
	SWEP.WorldModel = "models/weapons/w_cwkk_hk416.mdl"
	-- SWEP.ShowWorldModel = false

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cwkk_hk416.mdl"
	SWEP.WMPos = Vector(0,0,0)
	SWEP.WMAng = Vector(-3,1,180)

	SWEP.Spawnable			= true
	SWEP.AdminSpawnable		= true

	SWEP.Primary.ClipSize		= 30
	SWEP.Primary.DefaultClip	= 0
	SWEP.Primary.Automatic		= true
	SWEP.Primary.Ammo			= "556x45"

	SWEP.FireDelay = 0.066666666666667
	SWEP.Recoil = 1.05

	SWEP.HipSpread = 0.045
	SWEP.AimSpread = 0.003
	SWEP.VelocitySensitivity = 1.8
	SWEP.MaxSpreadInc = 0.04
	SWEP.SpreadPerShot = 0.007
	SWEP.SpreadCooldown = 0.13
	SWEP.Shots = 1
	SWEP.Damage = 32
	SWEP.DeployTime = 0.6

	SWEP.ReloadSpeed = 1
	SWEP.ReloadTime = 1.55
	SWEP.ReloadTime_Empty = 2
	SWEP.ReloadHalt = 2
	SWEP.ReloadHalt_Empty = 2.65
	-- SWEP.SnapToIdlePostReload = true

	function SWEP:IndividualThink()

	end

	if CLIENT then
		function SWEP:getMuzzlePosition()
			if self.CustomizeMenuAlpha > 0 then
				return self.CW_VM:GetAttachment(1)
			end

			// 1 - default barrel, 2 - shell, 3 - long barrel
			if self.ActiveAttachments.bg_hk416_longbarrel then
				self.MuzzleAttachmentName = "muzzle_long"
				return self.CW_VM:GetAttachment(3)
			else
				self.MuzzleAttachmentName = "1"
				return self.CW_VM:GetAttachment(1)
			end
		end

		-- function SWEP:getWorldAttachments()
			-- if self.ActiveAttachments.bg_hk416_longbarrel then
				-- return 2, 1
			-- end

			-- return 1, 1
		-- end

		local magBone

		function SWEP:RenderTargetFunc()
			if self.ActiveAttachments.bg_hk416_longbarrel then
				self.WorldMuzzleAttachmentID = 2
			else
				self.WorldMuzzleAttachmentID = 1
			end

			local wm = self.WMEnt
			local isAiming = self:isAiming()
			self:getMuzzlePosition()

			wm:SetBodygroup(self.SightBGs.main, self.CW_VM:GetBodygroup(self.SightBGs.main))

			if self.ActiveAttachments.bg_hk416_silencer then
				if self.ActiveAttachments.bg_hk416_longbarrel then
					self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_on)
					wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_on)
				else
					self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.on)
					wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.on)
				end
			-- elseif self.ActiveAttachments.md_saker then
				-- if isAiming then
					-- self.AttachmentModelsVM.md_saker.active = false
					-- if self.ActiveAttachments.bg_hk416_longbarrel then
						-- self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_on)
					-- else
						-- self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.on)
					-- end
				-- else
					-- self.AttachmentModelsVM.md_saker.active = true
					-- if self.ActiveAttachments.bg_hk416_longbarrel then
						-- self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_off)
						-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_off)
					-- else
						-- self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.off)
						-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.off)
					-- end
				-- end
			else
				if self.ActiveAttachments.bg_hk416_longbarrel then
					self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_off)
					wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_off)
				else
					self:setBodygroup(self.SilencerBGs.main, self.SilencerBGs.off)
					wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.off)
				end
			end

			local fent = self.AttachmentModelsVM.md_troyfrontsight_kk.ent
			local rent = self.AttachmentModelsVM.md_troyrearsight_kk.ent

			if not (self.AimPos == self.TroySightPos and self.AimAng == self.TroySightAng) then
				//fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, -85))
				//rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, -85))
			else
				fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, 0))
				rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, 0))
			end

			if self.ActiveAttachments.md_cod4_eotech_v2 then
				self.AttachmentModelsVM.md_cod4_eotech_v2.ent:SetSkin(1)
			end

			if self.ActiveAttachments.md_magnifier_scope then
				if self.ActiveAttachments.md_cod4_reflex then
					self.AttachmentModelsVM.larue_mount.active = true
				end

				if self.ActiveAttachments.md_cod4_aimpoint_v2 then
					self.AttachmentModelsVM.larue_mount.active = true
					self.AttachmentModelsVM.md_cod4_aimpoint_v2.ent:SetBodygroup(1,1)
				end
			else
				self.AttachmentModelsVM.larue_mount.active = false
				self.AttachmentModelsVM.md_cod4_aimpoint_v2.ent:SetBodygroup(1,0)
			end

			-- if self.ActiveAttachments.bg_hk416_nostock then
				-- self:setBodygroup(7,1)
			-- else
				self:setBodygroup(7,0)
			-- end

			local loaded, empty
			if self.ActiveAttachments.bg_hk416_cmag then
				loaded = self.MagBGs.round100
				empty = self.MagBGs.round100_empty
			elseif self.ActiveAttachments.bg_hk416_34rndmag then
				loaded = self.MagBGs.round34
				empty = self.MagBGs.round34_empty
			else
				loaded = self.MagBGs.regular
				empty = self.MagBGs.regular_empty
			end

			local cycle = self.CW_VM:GetCycle()
			local lowAmmo = self:Clip1() < 2

			local reloadingEmpty = (self.Sequence == self.Animations.reload_empty) and cycle < 0.3
			local pullingEmptyMag = (self.Sequence == self.Animations.reload) and lowAmmo and cycle < 0.3
			local idleEmpty = (self.Sequence != self.Animations.reload_empty) and (self.Sequence != self.Animations.reload) and lowAmmo

			if reloadingEmpty or pullingEmptyMag or idleEmpty then		//mag bullets
				self:setBodygroup(self.MagBGs.main,empty)
				wm:SetBodygroup(self.MagBGs.main,empty)
			else
				self:setBodygroup(self.MagBGs.main,loaded)
				wm:SetBodygroup(self.MagBGs.main,loaded)
			end

			if not magBone then
				magBone = self.CW_VM:LookupBone("c")
			else
				if self.unloadedMagazine and (cycle < 0.3 or cycle == 1) then
					self.CW_VM:ManipulateBoneScale(magBone, Vec0)
				else
					self.CW_VM:ManipulateBoneScale(magBone, Vec1)
				end
			end

			if self.ActiveAttachments.md_fas2_aimpoint then
				local aimEnt = self.AttachmentModelsVM.md_fas2_aimpoint.ent
				local lulz = aimEnt:GetManipulateBoneAngles(aimEnt:LookupBone("ard"))
				lulz = (lulz.p + FrameTime() * 0.5) % 360
				self.CompM4SBoneMod["ard"].angle = Angle(lulz - 180, 0, 0)

				if self.ActiveAttachments.md_magnifier_scope then
					aimEnt:SetBodygroup(2, 1)
					self.CompM4SBoneMod = self.CompM4SBoneMod_3x

					self.AttachmentModelsVM.larue_mount.active = false
				elseif self.ActiveAttachments.md_anpeq15 and (not self.ActiveAttachments.md_magnifier_scope) then
					aimEnt:SetBodygroup(2, 0)
					self.CompM4SBoneMod = self.CompM4SBoneMod_peq
				else
					aimEnt:SetBodygroup(2, 0)
					self.CompM4SBoneMod = self.CompM4SBoneMod_def
				end
			end

			local movePeq = self.AttachmentModelsVM.md_cod4_aimpoint_v2.active //or self.AttachmentModelsVM.md_fas2_holo.active

			if self.ActiveAttachments.md_anpeq15 then
				if movePeq then // anpeq mounted on side
					-- self.AttachmentModelsVM.md_anpeq15.pos = self.AttachmentPosDependency.md_anpeq15.md_cod4_aimpoint_v2
					-- self.AttachmentModelsVM.md_anpeq15.angle = self.AttachmentAngDependency.md_anpeq15.md_cod4_aimpoint_v2
					self.LaserPosAdjust = Vector(0.5, 0, 0.15)
					self.LaserAngAdjust = Angle(0, 179.74, 0)
				else // anpeq mounted on top
					self.LaserPosAdjust = Vector(0.5, 0, 0.15)
					self.LaserAngAdjust = Angle(0, 179.6, 0)
				end
			end

			self.ForegripOverride = false
			if self.ActiveAttachments.md_foregrip or self.ActiveAttachments.md_m203 then
				self.ForeGripOffsetCycle_Reload = 0.775
				self.ForeGripOffsetCycle_Reload_Empty = 0.825
				return
			elseif self.ActiveAttachments.md_hk416_bipod and self.dt.BipodDeployed then
				self.ForeGripOffsetCycle_Reload = 0.75
				self.ForeGripOffsetCycle_Reload_Empty = 0.79
				self.ForegripParent = "bipod_active"
				self.ForegripOverride = true
				return
			end

			if self.ActiveAttachments.bg_hk416_cmag then
				if self.ActiveAttachments.md_anpeq15 and movePeq then
					self.ForegripParent = "cmag_anpeq"
					self.ForegripOverride = true
				else
					self.ForegripParent = "bg_hk416_cmag"
					self.ForegripOverride = true
				end
			elseif self.ActiveAttachments.md_anpeq15 and movePeq then
				self.ForegripParent = "md_anpeq15"
				self.ForegripOverride = true
			end
		end // rtf end */

		function SWEP:WElementThink()
			-- local wm = self.WElements["wm"].modelEnt

			// bodygrouped models

			-- if self.ActiveAttachments.bg_hk416_silencer then
				-- if self.ActiveAttachments.bg_hk416_longbarrel then
					-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_on)
				-- else
					-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.on)
				-- end
			-- else
				-- if self.ActiveAttachments.bg_hk416_longbarrel then
					-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.long_off)
				-- else
					-- wm:SetBodygroup(self.SilencerBGs.main, self.SilencerBGs.off)
				-- end
			-- end

			-- if self.ActiveAttachments.bg_hk416_cmag then
				-- wm:SetBodygroup(self.MagBGs.main,self.MagBGs.round100)
			-- elseif self.ActiveAttachments.bg_hk416_34rndmag then
				-- wm:SetBodygroup(self.MagBGs.main,self.MagBGs.round34)
			-- else
				-- wm:SetBodygroup(self.MagBGs.main,self.MagBGs.regular)
			-- end

			-- if self.ActiveAttachments.bg_hk416_foldsight then
				-- wm:SetBodygroup(self.SightBGs.main,self.SightBGs.foldsight)
			-- elseif self:getActiveAttachmentInCategory(1) then
				-- wm:SetBodygroup(self.SightBGs.main,self.SightBGs.none)
			-- else
				-- wm:SetBodygroup(self.SightBGs.main,self.SightBGs.carryhandle)
			-- end

			-- if self.ActiveAttachments.bg_hk416_heavystock then
				-- wm:SetBodygroup(self.StockBGs.main,self.StockBGs.heavy)
			-- elseif self.ActiveAttachments.bg_hk416_nostock then
				-- wm:SetBodygroup(self.StockBGs.main,self.StockBGs.none)
			-- else
				-- wm:SetBodygroup(self.StockBGs.main,self.StockBGs.regular)
			-- end

			-- if self.ActiveAttachments.bg_hk416_railcover then
				-- wm:SetBodygroup(self.ForegripBGs.main,self.ForegripBGs.covered)
			-- else
				-- wm:SetBodygroup(self.ForegripBGs.main,self.ForegripBGs.regular)
			-- end

			-- if self.ActiveAttachments.bg_hk416_paint1 then
				-- self.WElements["wm"].skin = 1
			-- elseif self.ActiveAttachments.bg_hk416_paint2 then
				-- self.WElements["wm"].skin = 2
			-- else
				-- self.WElements["wm"].skin = 0
			-- end

			/*
			if self.ActiveAttachments.md_cod4_reflex then
				self.WElements["wm_cod4"].modelEnt:SetBodygroup(1,1)
			elseif self.ActiveAttachments.md_cod4_eotech_v2 then
				self.WElements["wm_cod4"].modelEnt:SetBodygroup(1,2)
			elseif self.ActiveAttachments.md_cod4_aimpoint_v2 then
				self.WElements["wm_cod4"].modelEnt:SetBodygroup(1,3)
			elseif self.ActiveAttachments.md_cod4_acog_v2 then
				self.WElements["wm_cod4"].modelEnt:SetBodygroup(1,4)
			else
				self.WElements["wm_cod4"].modelEnt:SetBodygroup(1,0)
			end
			*/

			// single models

			if self.ActiveAttachments.md_hk416_bipod then
				self.WElements.md_hk416_bipod.hide = false
				if self.dt.BipodDeployed then
					self.WElements.md_hk416_bipod.modelEnt:SetBodygroup(1,1)
				else
					self.WElements.md_hk416_bipod.modelEnt:SetBodygroup(1,0)
				end
			else
				self.WElements.md_hk416_bipod.hide = true
			end

			if self.ActiveAttachments.md_fas2_aimpoint then
				self.WElements.md_fas2_aimpoint.hide = false
				local aimEnt = self.WElements.md_fas2_aimpoint.modelEnt
				for key,value in pairs(self.CompM4SBoneMod) do
					aimEnt:ManipulateBoneScale(aimEnt:LookupBone(key), value.scale)
					aimEnt:ManipulateBonePosition(aimEnt:LookupBone(key), value.pos)
					aimEnt:ManipulateBoneAngles(aimEnt:LookupBone(key), value.angle)
				end
				-- if self.ActiveAttachments.md_anpeq15 then
					-- aimEnt:SetBodygroup(2,1)
					-- self.WElements.md_fas2_aimpoint.pos = Vector(11.131, 1.082, -5.646)
					-- self.WElements.md_fas2_aimpoint.pos_dropped = Vector(11.131, 1.260, -5.065)
				-- else
				if self.ActiveAttachments.md_magnifier_scope then
					aimEnt:SetBodygroup(2,1)
					self.WElements.md_fas2_aimpoint.pos = Vector(11.131, 1.082, -5.646)
					self.WElements.md_fas2_aimpoint.pos_dropped = Vector(15.001, 1.259, -5.066)
				else
					aimEnt:SetBodygroup(2,0)
					self.WElements.md_fas2_aimpoint.pos = Vector(11.131, 1.082, -5.283)
					self.WElements.md_fas2_aimpoint.pos_dropped = Vector(11.131, 1.260, -4.703)
				end
			else
				self.WElements.md_fas2_aimpoint.hide = true
			end

			if self.ActiveAttachments.md_anpeq15 then
				self.WElements.md_anpeq15.hide = false
				if self.ActiveAttachments.bg_hk416_foldsight then
					self.WElements.md_anpeq15.pos = Vector(18.086, 0.686, -6.568)
					self.WElements.md_anpeq15.pos_dropped = Vector(18.086, 1.034, -5.571)
				else
					self.WElements.md_anpeq15.pos = Vector(19.676, 0.686, -6.645)
					self.WElements.md_anpeq15.pos_dropped = Vector(19.676, 1.034, -5.571)
				end
			else
				self.WElements.md_anpeq15.hide = true
			end

			if self.ActiveAttachments.md_m203 then
				self.WElements.md_m203.hide = false

				for i=5, self.WElements.md_m203.modelEnt:GetBoneCount() do

					self.WElements.md_m203.modelEnt:ManipulateBoneScale(i, Vec0)
				end
			else
				self.WElements.md_m203.hide = true
			end

			if self.ActiveAttachments.md_foregrip then
				self.WElements.md_foregrip.hide = false
			else
				self.WElements.md_foregrip.hide = true
			end

			if self.ActiveAttachments.md_fas2_leupold then
				self.WElements.md_fas2_leupold.hide = false
				self.WElements.md_fas2_leupold_mount.hide = false
			else
				self.WElements.md_fas2_leupold.hide = true
				self.WElements.md_fas2_leupold_mount.hide = true
			end

			if self.ActiveAttachments.md_saker then
				self.WElements.md_saker.hide = false
				if self.ActiveAttachments.bg_hk416_longbarrel then
					self.WElements.md_saker.pos = Vector(12.598, 1.026, -7.218)
					self.WElements.md_saker.pos_dropped = Vector(13.119, 1.210, -6.534)
				else
					self.WElements.md_saker.pos = Vector(8.519, 1.092, -7.007)
					self.WElements.md_saker.pos_dropped = Vector(9.040, 1.228, -6.526)
				end
			else
				self.WElements.md_saker.hide = true
			end

			if self.ActiveAttachments.md_fas2_eotech then
				self.WElements.md_fas2_eotech.hide = false
			else
				self.WElements.md_fas2_eotech.hide = true
			end

			if self.ActiveAttachments.md_fas2_holo then
				self.WElements.md_fas2_holo.hide = false
				local holoEnt = self.WElements.md_fas2_holo.modelEnt

				if holoEnt then
					local clipSize = self.Primary.ClipSize
					local clip = self:Clip1()
					local clipp = math.Clamp((clip/clipSize), 0, 1)

					local hp
					if IsValid(self.Owner) then
						hp = self.Owner:Health()
					else
						hp = 0
					end
					local hpp = math.Clamp((hp / 100), 0, 1)

					local ammoVec = Vector((1 - (clipp)) * (-0.895), 0, 0)
					local healthVec = Vector((1 - (hpp)) * (-0.895), 0, 0)

					holoEnt:ManipulateBonePosition(holoEnt:LookupBone("holo_ammo"), ammoVec)
					holoEnt:ManipulateBonePosition(holoEnt:LookupBone("holo_heat"), healthVec)
				end
			else
				self.WElements.md_fas2_holo.hide = true
			end

		end
	end

	if USE_OLD_WELEMENTS then

		if CLIENT then
			CustomizableWeaponry.callbacks:addNew("initialize", "KK_HK416", function(wep) // instead of copy pasting 50+ lines of func, 5 lines can do even more
				if wep and wep:GetClass() == "cw_kk_hk416" then
					wep:CreateModels(wep.WElements)
				end
			end)

			local Vec0, Ang0 = Vector(0, 0, 0), Angle(0, 0, 0)
			local TargetPos, TargetAng, cos1, sin1, tan, ws, rs, mod, EA, delta, sin2, mul, vm, muz, muz2, tr, att
			local td = {}
			local LerpVector, LerpAngle, Lerp = LerpVector, LerpAngle, Lerp

			local reg = debug.getregistry()
			local GetVelocity = reg.Entity.GetVelocity
			local Length = reg.Vector.Length
			local Right = reg.Angle.Right
			local Up = reg.Angle.Up
			local Forward = reg.Angle.Forward
			local RotateAroundAxis = reg.Angle.RotateAroundAxis
			local GetBonePosition = reg.Entity.GetBonePosition

			local ManipulateBonePosition, ManipulateBoneAngles = reg.Entity.ManipulateBonePosition, reg.Entity.ManipulateBoneAngles

			local wm, pos, ang
			SWEP.wRenderOrder = nil

			function SWEP:DrawWorldModel()
				if self.dt.Safe then
					if self.CHoldType != self.RunHoldType then
						self:SetHoldType(self.RunHoldType)
						self.CHoldType = self.RunHoldType
					end
				else
					if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
						if self.CHoldType != self.RunHoldType then
							self:SetHoldType(self.RunHoldType)
							self.CHoldType = self.RunHoldType
						end
					else
						if self.CHoldType != self.NormalHoldType then
							self:SetHoldType(self.NormalHoldType)
							self.CHoldType = self.NormalHoldType
						end
					end
				end

				-- /*
				if self.DrawTraditionalWorldModel then
					self:DrawModel()
				else
					wm = self.WMEnt

					if IsValid(wm) then
						if IsValid(self.Owner) then
							pos, ang = GetBonePosition(self.Owner, self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))

							if pos and ang then
								RotateAroundAxis(ang, Right(ang), self.WMAng[1])
								RotateAroundAxis(ang, Up(ang), self.WMAng[2])
								RotateAroundAxis(ang, Forward(ang), self.WMAng[3])

								pos = pos + self.WMPos[1] * Right(ang)
								pos = pos + self.WMPos[2] * Forward(ang)
								pos = pos + self.WMPos[3] * Up(ang)

								wm:SetRenderOrigin(pos)
								wm:SetRenderAngles(ang)
								wm:DrawModel()
							end
						else
							wm:SetRenderOrigin(self:GetPos())
							wm:SetRenderAngles(self:GetAngles())
							wm:DrawModel()
							wm:DrawShadow()
						end
					else
						self:DrawModel()
					end
				end  //*/

				self:WElementThink()

				if (!self.WElements) then return end

				if (!self.wRenderOrder) then
					self.wRenderOrder = {}

					for k, v in pairs( self.WElements ) do
						if (v.type == "Model") then
							table.insert(self.wRenderOrder, 1, k)
						elseif (v.type == "Sprite" or v.type == "Quad") then
							table.insert(self.wRenderOrder, k)
						end
					end
				end

				if (IsValid(self.Owner)) then
					bone_ent = self.Owner
				else
					// when the weapon is dropped
					bone_ent = self
					-- bone_ent = self.WElements["wm"].modelEnt
					-- bone_ent = self.WMEnt
				end

				for k, name in pairs( self.wRenderOrder ) do

					local v = self.WElements[name]
					if (!v) then self.wRenderOrder = nil break end
					if (v.hide) then continue end

					local pos, ang

					if (v.bone) then
						pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
					else
						pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
					end

					if (!pos) then continue end

					local model = v.modelEnt
					local sprite = v.spriteMaterial

					if (v.type == "Model" and IsValid(model)) then

						if IsValid(self.Owner) then
							model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
							ang:RotateAroundAxis(ang:Up(), v.angle.y)
							ang:RotateAroundAxis(ang:Right(), v.angle.p)
							ang:RotateAroundAxis(ang:Forward(), v.angle.r)
						else
							model:SetPos(pos + ang:Forward() * v.pos_dropped.x + ang:Right() * v.pos_dropped.y + ang:Up() * v.pos_dropped.z )
							ang:RotateAroundAxis(ang:Up(), v.angle_dropped.y)
							ang:RotateAroundAxis(ang:Right(), v.angle_dropped.p)
							ang:RotateAroundAxis(ang:Forward(), v.angle_dropped.r)
						end

						model:SetAngles(ang)
						//model:SetModelScale(v.size)
						local matrix = Matrix()
						matrix:Scale(v.size)
						model:EnableMatrix( "RenderMultiply", matrix )

						if (v.material == "") then
							model:SetMaterial("")
						elseif (model:GetMaterial() != v.material) then
							model:SetMaterial( v.material )
						end

						if (v.skin and v.skin != model:GetSkin()) then
							model:SetSkin(v.skin)
						end

						if (v.bodygroup) then
							for k, v in pairs( v.bodygroup ) do
								if (model:GetBodygroup(k) != v) then
									model:SetBodygroup(k, v)
								end
							end
						end

						if (v.surpresslightning) then
							render.SuppressEngineLighting(true)
						end

						render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
						render.SetBlend(v.color.a/255)
						model:DrawModel()
						render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)

						if (v.surpresslightning) then
							render.SuppressEngineLighting(false)
						end

					-- elseif (v.type == "Sprite" and sprite) then

						-- local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
						-- render.SetMaterial(sprite)
						-- render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)

					-- elseif (v.type == "Quad" and v.draw_func) then

						-- local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
						-- ang:RotateAroundAxis(ang:Up(), v.angle.y)
						-- ang:RotateAroundAxis(ang:Right(), v.angle.p)
						-- ang:RotateAroundAxis(ang:Forward(), v.angle.r)

						-- cam.Start3D2D(drawpos, ang, v.size)
							-- v.draw_func( self )
						-- cam.End3D2D()
					end
				end
			end

			function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

				local bone, pos, ang
				if (tab.rel and tab.rel != "") then

					local v = basetab[tab.rel]

					if (!v) then return end

					// Technically, if there exists an element with the same name as a bone
					// you can get in an infinite loop. Let's just hope nobody's that stupid.
					pos, ang = self:GetBoneOrientation( basetab, v, ent )

					if (!pos) then return end

					pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)

				else

					bone = ent:LookupBone(bone_override or tab.bone)

					if (!bone) then return end

					pos, ang = Vector(0,0,0), Angle(0,0,0)
					local m = ent:GetBoneMatrix(bone)
					if (m) then
						pos, ang = m:GetTranslation(), m:GetAngles()
					end

					if (IsValid(self.Owner) and self.Owner:IsPlayer() and
						ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
						ang.r = -ang.r // Fixes mirrored models
					end

				end

				return pos, ang
			end

			function SWEP:CreateModels( tab )

				if (!tab) then return end

				// Create the clientside models here because Garry says we can't do it in the render hook
				for k, v in pairs( tab ) do
					if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and
							string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then

						v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
						if (IsValid(v.modelEnt)) then
							v.modelEnt:SetPos(self:GetPos())
							v.modelEnt:SetAngles(self:GetAngles())
							v.modelEnt:SetParent(self)
							v.modelEnt:SetNoDraw(true)
							v.createdModel = v.model
						else
							v.modelEnt = nil
						end

					elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite)
						and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then

						local name = v.sprite.."-"
						local params = { ["$basetexture"] = v.sprite }
						// make sure we create a unique name based on the selected options
						local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
						for i, j in pairs( tocheck ) do
							if (v[j]) then
								params["$"..j] = 1
								name = name.."1"
							else
								name = name.."0"
							end
						end

						v.createdSprite = v.sprite
						v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)

					end
				end

			end

			/**************************
				Global utility code
			**************************/

			// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
			// Does not copy entities of course, only copies their reference.
			// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
			function table.FullCopy( tab )

				if (!tab) then return nil end

				local res = {}
				for k, v in pairs( tab ) do
					if (type(v) == "table") then
						res[k] = table.FullCopy(v) // recursion ho!
					elseif (type(v) == "Vector") then
						res[k] = Vector(v.x, v.y, v.z)
					elseif (type(v) == "Angle") then
						res[k] = Angle(v.p, v.y, v.r)
					else
						res[k] = v
					end
				end

				return res
			end

		end // if CLIENT
	end // if USE_OLD_WELEMENTS
end // if CW2
