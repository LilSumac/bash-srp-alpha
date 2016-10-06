AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
// SCK Name: mk11
// With mgainfier: mk11mag
//COVER: mk11cover

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "SR-25"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.Add("cw_mk11", "vgui/kills/cw_mk11", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_mk11")

	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.9
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8
	SWEP.FireMoveMod = 0.6

	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0

	SWEP.M203Pos = Vector(-0.562, -2.481, 0.24)
	SWEP.M203Ang = Vector(0, 0, 0)

	//SWEP.IronsightPos = Vector(2, 0, 0.68)
	//SWEP.IronsightAng = Vector(2.111, 0, 0)
	SWEP.IronsightPos = Vector(1.96, -0.403, 0.49)
	SWEP.IronsightAng = Vector(2.599, 0, 0)

	SWEP.ShortDotPos = Vector(1.94, 0, 0.97)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.CoD4ReflexPos = Vector(1.96, 0, 0.8)
	SWEP.CoD4ReflexAng = Vector(0.25, 0.2, 0)

	SWEP.EoTechPos = Vector(1.9, 0, 0.63)
	SWEP.EoTechAng = Vector(0, -0.1, 0)

	SWEP.CoD4TascoPos = Vector(1.96, 0, 1.15)
	SWEP.CoD4TascoAng = Vector(0, 0, 0)

	SWEP.EoTech552Pos = Vector(1.919, 0, 0.545)
	SWEP.EoTech552Ang = Vector(0, -0.1, 0)

	//SWEP.EoTech553Pos = Vector(1.98, 0, 0.55)
	SWEP.EoTech553Pos = Vector(1.95, 0, 0.55)
	SWEP.EoTech553Ang = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos = Vector(1.95, 0, 0.92)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)

	SWEP.AimpointPos = Vector(1.96, 0, 0.8)
	SWEP.AimpointAng = Vector(0, 0, 0)

	SWEP.MicroT1Pos = Vector(1.96, -1.407, 0.959)
	SWEP.MicroT1Ang = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(1.95, 0, 0.6)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.CoD4ACOGPos = Vector(1.95, 0, 0.7)
	SWEP.CoD4ACOGAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-4.444, -1, 0.082)
	SWEP.SprintAng = Vector(-12.849, -39.23, 0)

	SWEP.LeupoldPos = Vector(2.039, 0, 0.4)
	SWEP.LeupoldAng = Vector(0, 0, 0)
	SWEP.LeupoldAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.HoloPos = Vector(2.05, 0, 0.58)
	SWEP.HoloAng = Vector(0.5, 0.1, 0)

	SWEP.TroySightPos = Vector(1.929, 1, 0.85)
	SWEP.TroySightAng = Vector(0, -0.301, 0)
	SWEP.FoldSightPos = Vector(1.929, 1, 0.85)
	SWEP.FoldSightAng = Vector(0, -0.301, 0)

	SWEP.CantedPos = Vector(3.269, 0, 1.5)
	SWEP.CantedAng = Vector(0, 0, 45)

	SWEP.BFReflexPos  = Vector(1.95, 0, 0.98)
	SWEP.BFReflexAng  = Vector(0, 0, 0)

	SWEP.CoyotePos = Vector(1.95, 0, 1.059)
	SWEP.CoyoteAng = Vector(0, 0, 0)

	SWEP.MagnifierPos = Vector(1.96, 0, 0.6)
	SWEP.MagnifierAng = Vector(0, 0, 0)

	//Magnifer scopes
	SWEP.MagnifierScopeAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.CoD4ReflexPos_mag3x = Vector(1.9, 0, 0.55)
	SWEP.CoD4ReflexAng_mag3x = Vector(0, 0, 0)

	SWEP.EoTech552Pos_mag3x = Vector(1.91, 0, 0.57)
	SWEP.EoTech552Ang_mag3x = Vector(0, 0, 0)

	SWEP.EoTech553Pos_mag3x = Vector(1.99, 0, 0.57)
	SWEP.EoTech553Ang_mag3x = Vector(0, 0, 0)

	SWEP.CoD4TascoPos_mag3x = Vector(1.9, 0, 0.7)
	SWEP.CoD4TascoAng_mag3x = Vector(0, 0, 0)

	SWEP.FAS2AimpointPos_mag3x = Vector(1.95, 0, 0.8)
	SWEP.FAS2AimpointAng_mag3x = Vector(0, 0, 0)

	SWEP.HoloPos_mag3x = Vector(1.93, 0, 0.61)
	SWEP.HoloAng_mag3x = Vector(0, 0, 0)

	SWEP.RscopePos  = Vector(2, 0, 0.959)
	SWEP.RscopeAng = Vector(0 ,0, 0)
	SWEP.BFRIFLEAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.MW3SPos  = Vector(2, 0, 0.479)
	SWEP.MW3SAng = Vector(0 ,0 , 0)
	SWEP.MW3SAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.BackupReflexPos = Vector(3.839, 0, 1.48)
	SWEP.BackupReflexAng = Vector(0, 0, 45)

	SWEP.CustomizePos = Vector(-8.174, -1.27, -1.288)
	SWEP.CustomizeAng = Vector(17.954, -40.578, -18.357)

	SWEP.BackupSights = {["md_acog"] = {[1] = Vector(1.945, 0, -0.24), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = true
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.CoD4ACOGAxisAlign = {right = 0, up = 180, forward = 0}

	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.BaseArm = "Right_L_Arm"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	SWEP.M203CameraRotation = {p = -90, y = 0, r = -90}

if CustomizableWeaponry_KK_HK416 then
	SWEP.AttachmentModelsVM = {
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Base", rel = "", pos = Vector(0.17, 4.675, -3.05), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -8, max = 6.5, axis = "y", inverse = true}},

		["md_cyotesight"] = { type = "Model", model = "models/rageattachments/cyotesight.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -0.5, 0.75), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -13, max = 1.85, axis = "y", inverse = true}},
		["md_muzzlebrake"] = { type = "Model", model = "models/rageattachments/pistolmuzzlebreak.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -22.338, -0.5), angle = Angle(0, 90, 0), size = Vector(4.907, 1.399, 1.399)},
		["md_bfreflex"] = { type = "Model", model = "models/rageattachments/usareddot.mdl", bone = "Base", rel = "", pos = Vector(-0.051, -1, 0.699), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), adjustment = {min = -13, max = 1.85, axis = "y", inverse = true}},
		["larue_mount"] = { type = "Model", model = "models/c_larue_kkhx.mdl", bone = "Base", rel = "", pos = Vector(-0.401, -4.676, 1.299), angle = Angle(0, 90, 0), size = Vector(1.1, 1.1, 1.1)},
		["md_magnifier_scope"] = { type = "Model", model = "models/c_magnifier_scope.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -6.5, 0.699), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},
		["md_mw3scope"] = { type = "Model", model = "models/rageattachments/v_msrscope.mdl", bone = "Base", rel = "", pos = Vector(-0.2, 0, 0.25), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -11.6, max = 1.15, axis = "y", inverse = true}},
		["md_bfriflescope"] = { type = "Model", model = "models/rageattachments/sniperscopesv.mdl", bone = "Base", rel = "", pos = Vector(-0.05, 0.5, 1), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), adjustment = {min = -11.5, max = 2.3, axis = "y", inverse = true}},
		["md_cantedsights"] = { type = "Model", model = "models/rageattachments/cantedsightfront.mdl", bone = "Base", rel = "", pos = Vector(-0, -12.988, 0.8), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_couldbewhat"] = { type = "Model", model = "models/rageattachments/cantedsightrear.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 1, 0.699), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_fas2_eotech"] = { type = "Model", model = "models/c_fas2_eotech.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -3, 0.699), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), adjustment = {min = -15, max = -1.8, axis = "y", inverse = true}},
		["md_fas2_eotech_stencil"] = { type = "Model", model = "models/c_fas2_eotech_stencil.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -3, 0.699), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149)},
		["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "Base", rel = "", pos = Vector(-2.5, 10.199, 2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true},
		["md_backup_reflex_rail"] = { type = "Model", model = "models/c_angled_rails.mdl", bone = "Base", rel = "", pos = Vector(0.4, -9, 0.4), angle = Angle(0, -90, -90), size = Vector(1.2, 1.2, 1.2)},
		["md_backup_reflex"] = { type = "Model", model = "models/c_docter.mdl", bone = "Base", rel = "", pos = Vector(1.2, -10.2, 0.899), angle = Angle(0, 90, 45), size = Vector(0.898, 0.898, 0.898)},
		["md_cod4_acog_v2"] = { type = "Model", model = "models/v_cod4_acog.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 4, -1.558), angle = Angle(0, -90, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -8, max = 5.2, axis = "y", inverse = true}},
		["md_fas2_aimpoint"] = { type = "Model", model = "models/c_fas2_aimpoint_rigged.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -2.597, 0.4), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), adjustment = {min = -15, max = -1, axis = "y", inverse = true}},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(0.15, 5.714, -3.85), angle = Angle(0, 180, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -7, max = 8, axis = "y", inverse = true}},
		["md_cod4_aimpoint_v2"] = { type = "Model", model = "models/v_cod4_aimpoint.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 4.675, -1.75), angle = Angle(0, -90, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -7, max = 5.8, axis = "y", inverse = true}},
		["md_cod4_eotech_v2"] = { type = "Model", model = "models/v_cod4_eotech.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 4.5, -1.701), angle = Angle(0, -90, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -7.5, max = 5.6, axis = "y", inverse = true}},
		["md_troyfrontsight_kk"] = { type = "Model", model = "models/c_troy_sight_front.mdl", bone = "Base", rel = "", pos = Vector(-0.03, -14.801, 0.6), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), active = true},
		["md_troyrearsight_kk"] = { type = "Model", model = "models/c_troy_sight_rear.mdl", bone = "Base", rel = "", pos = Vector(-0.1, -5.801, 0.6), angle = Angle(0, 90, 0), size = Vector(1.149, 1.149, 1.149), active = true},
		["md_hk416_bipod"] = { type = "Model", model = "models/c_bipod.mdl", bone = "Base", rel = "", pos = Vector(0, -10.91, -1.5), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_cod4_reflex"] = { type = "Model", model = "models/v_cod4_reflex.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 4, -1.558), angle = Angle(0, -90, 0), size = Vector(0.85, 0.85, 0.85), adjustment = {min = -8.4, max = 5.85, axis = "y", inverse = true}},

		["md_fas2_holo"] = { type = "Model", model = "models/v_holo_sight_kkrc.mdl", bone = "Base", rel = "", pos = Vector(0, 3, -3.3), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), adjustment = {min = -9.1, max = 4.5, axis = "y", inverse = true}},
		["md_fas2_holo_aim"] = { type = "Model", model = "models/v_holo_sight_orig_hx.mdl", bone = "Base", rel = "", pos = Vector(0, 3, -3.1), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8)},

		["md_fas2_leupold_mount"] = { type = "Model", model = "models/v_fas2_leupold_mounts.mdl", bone = "Base", rel = "", pos = Vector(0, 2, 2.5), angle = Angle(0, 90, 0), size = Vector(1.799, 1.799, 1.799)},
		["md_fas2_leupold"] = { type = "Model", model = "models/v_fas2_leupold.mdl", bone = "Base", rel = "", pos = Vector(0, 2, 2.596), angle = Angle(0, 90, 0), size = Vector(1.799, 1.799, 1.799)},
		["bg_hk416_silencer"] = { type = "Model", model = "models/cw2/attachments/9mmsuppressor.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -21, -1), angle = Angle(0, 0, 0), size = Vector(0.949, 1.728, 0.949)},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -5, -2.1), angle = Angle(0, -180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(-1, -10.91, 0), angle = Angle(-180, 90, -90), size = Vector(0.5, 0.5, 0.5), adjustment = {min = -13, max = -9.5, axis = "y", inverse = true}},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.4, 12, -9.5), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), adjustment = {min = 0, max = 13, axis = "y", inverse = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 1, 1.399), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), adjustment = {min = -12.5, max = 2.5, axis = "y", inverse = true}},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(-0.5, -18, -3.401), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(0.23, 5.714, -4), angle = Angle(0, 180, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -6, max = 7.5, axis = "y", inverse = true}},
	}
	else
	SWEP.AttachmentModelsVM = {
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "Base", rel = "", pos = Vector(0.17, 4.675, -3.05), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -8, max = 6.5, axis = "y", inverse = true}},
		["md_cyotesight"] = { type = "Model", model = "models/rageattachments/cyotesight.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -0.5, 0.75), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -13, max = 1.85, axis = "y", inverse = true}},
		["md_muzzlebrake"] = { type = "Model", model = "models/rageattachments/pistolmuzzlebreak.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -22.338, -0.5), angle = Angle(0, 90, 0), size = Vector(4.907, 1.399, 1.399)},
		["md_bfreflex"] = { type = "Model", model = "models/rageattachments/usareddot.mdl", bone = "Base", rel = "", pos = Vector(-0.051, -1, 0.699), angle = Angle(0, 90, 0), size = Vector(0.8, 0.8, 0.8), adjustment = {min = -13, max = 1.85, axis = "y", inverse = true}},
		["md_mw3scope"] = { type = "Model", model = "models/rageattachments/v_msrscope.mdl", bone = "Base", rel = "", pos = Vector(-0.2, 0, 0.25), angle = Angle(0, 90, 0), size = Vector(0.75, 0.75, 0.75), adjustment = {min = -11.6, max = 1.15, axis = "y", inverse = true}},
		["md_bfriflescope"] = { type = "Model", model = "models/rageattachments/sniperscopesv.mdl", bone = "Base", rel = "", pos = Vector(-0.05, 0.5, 1), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), adjustment = {min = -11.5, max = 2.3, axis = "y", inverse = true}},
		["md_cantedsights"] = { type = "Model", model = "models/rageattachments/cantedsightfront.mdl", bone = "Base", rel = "", pos = Vector(-0, -12.988, 0.8), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_couldbewhat"] = { type = "Model", model = "models/rageattachments/cantedsightrear.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 1, 0.699), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_m203"] = { type = "Model", model = "models/cw2/attachments/m203.mdl", bone = "Base", rel = "", pos = Vector(-2.5, 10.199, 2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), animated = true},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Base", rel = "", pos = Vector(0.15, 5.714, -3.85), angle = Angle(0, 180, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -7, max = 8, axis = "y", inverse = true}},
		["md_saker"] = { type = "Model", model = "models/cw2/attachments/556suppressor.mdl", bone = "Base", rel = "", pos = Vector(-0.101, -5, -2.1), angle = Angle(0, -180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "Base", rel = "", pos = Vector(-1, -10.91, 0), angle = Angle(-180, 90, -90), size = Vector(0.5, 0.5, 0.5), adjustment = {min = -13, max = -9.5, axis = "y", inverse = true}},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Base", rel = "", pos = Vector(-0.4, 12, -9.5), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), adjustment = {min = 0, max = 13, axis = "y", inverse = true}},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "Base", rel = "", pos = Vector(-0.101, 1, 1.399), angle = Angle(0, 0, 0), size = Vector(0.349, 0.349, 0.349), adjustment = {min = -12.5, max = 2.5, axis = "y", inverse = true}},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Base", rel = "", pos = Vector(-0.5, -18, -3.401), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Base", rel = "", pos = Vector(0.23, 5.714, -4), angle = Angle(0, 180, 0), size = Vector(0.898, 0.898, 0.898), adjustment = {min = -6, max = 7.5, axis = "y", inverse = true}},
	}

end

	if CustomizableWeaponry_KK_HK416 then
	function SWEP:RenderTargetFunc()
	local wm = self.WMEnt
	local isAiming = self:isAiming()

			wm:SetBodygroup(self.SightBGs.main, self.CW_VM:GetBodygroup(self.SightBGs.main))
				local fent = self.AttachmentModelsVM.md_troyfrontsight_kk.ent
				local rent = self.AttachmentModelsVM.md_troyrearsight_kk.ent

				if not (self.AimPos == self.TroySightPos and self.AimAng == self.TroySightAng) then
					fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, -85))
					rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, -85))
					fent:ManipulateBonePosition(rent:LookupBone("boner"), Vector(0, 0, 850))
					rent:ManipulateBonePosition(rent:LookupBone("boner"), Vector(0, 0, 850))
				else
					fent:ManipulateBoneAngles(fent:LookupBone("sight"), Angle(0, 0, 0))
					rent:ManipulateBoneAngles(rent:LookupBone("sight"), Angle(0, 0, 0))
					fent:ManipulateBonePosition(rent:LookupBone("boner"), Vector(0, 0, 0))
					rent:ManipulateBonePosition(rent:LookupBone("boner"), Vector(0, 0, 0))
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

		end
	end

	SWEP.CompM4SBoneMod = {
		["ard"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(31.445, 0, 0) }
	}

	SWEP.M203HoldPos = {
		["Right_L_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(3.519, -0.5, 2.036), angle = Angle(0, 0, 0) }
	}

	SWEP.ForeGripHoldPos = {
		["Right_U_Arm"] = { scale = Vector(1, 1, 1), pos = Vector(-12.782, -7.6, -5.301), angle = Angle(51.124, 57.514, -42.605) }
	}


	SWEP.AttachmentPosDependency = {
		["md_fas2_aimpoint"] = {
			["md_magnifier_scope"] = Vector(-0.1, -7, 0.5),
		},
		["md_fas2_eotech"] = {
			["md_magnifier_scope"] = Vector(-0.08, -8, 0.65)
		},
		["md_cod4_reflex"] = {
			["md_magnifier_scope"] = Vector(-0.137, -0.1,-1.3),
		},
		["md_cod4_aimpoint_v2"] = {
			["md_magnifier_scope"] = Vector(-0.145, 0, -1.3),
		},
		["md_cod4_eotech_v2"] = {
			["md_magnifier_scope"] = Vector(-0.1, -0.5,-1.75),
		},
		["md_fas2_holo"] = {
			["md_magnifier_scope"] = Vector(-0.1, -1.9, -3.3),
		},
		}

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(-0.1, 180, 3)
	SWEP.CustomizationMenuScale = 0.011
end

SWEP.SightBGs		= {main = 3, carryhandle = 0, foldsight = 2, none = 2, foldfold = 3}
SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
SWEP.StockBGs = {main = 2, regular = 0, heavy = 1, sturdy = 1}
SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}
SWEP.LuaViewmodelRecoil = true

SWEP.AttachmentDependencies = {
	["md_magnifier_scope"] = {"md_cod4_reflex","md_cod4_eotech_v2","md_cod4_aimpoint_v2","md_fas2_eotech","md_fas2_aimpoint","md_fas2_holo"},
	["md_cantedsights"] = {"md_bfriflescope", "md_mw3scope", "md_bfreflex", "md_cyotesight"}
}
SWEP.AttachmentExclusions = {
	["md_backup_reflex"] = {"bg_hk416_foldsight", "md_bfreflex", "md_cyotesight", "md_cod4_reflex","md_cod4_eotech_v2","md_cod4_aimpoint_v2","md_fas2_eotech","md_fas2_aimpoint","md_fas2_holo", "md_bfriflescope", "md_mw3scope"}
}
//lua_run Entity(1):GetViewModel():SetBodygroup(3,2)
//Thanks to Knife Kitty and Rage
//CustomizableWeaponry_KK_HK416
//CustomizableWeaponry_Fluffy_Zorua

	SWEP.Attachments = {[1] = {header = "Sight", offset = {100, -450},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_schmidt_shortdot"}},
		[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
		[3] = {header = "Handguard", offset = {-250, 150}, atts = {"md_foregrip", "md_m203"}},
		[4] = {header = "Rail", offset = {-250, 600}, atts = {"md_anpeq15"}},
		["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_magnum", "am_matchgrade"}},
	}


SWEP.Animations = {fire = {"shoot1", "shoot2"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}

SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_MK11_DRAW"}},
	//[2] = {time = 0, sound = "CW_MK11_LOCK"}},

	reload = {
	[1] = {time = 0.5, sound = "CW_MK11_MAGOUT"},
	[2] = {time = 1.6, sound = "CW_MK11_MAGIN"},
	[3] = {time = 2.35, sound = "CW_MK11_BOLTBACK"}}}

SWEP.SpeedDec = 43

SWEP.ADSFireAnim = false
SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "BASH Weapons"

SWEP.Author			= "White Snow"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= true
SWEP.ViewModel		= "models/weapons/mk11/v_snipr_mk11.mdl"
SWEP.WorldModel		= "models/weapons/mk11/w_snipr_mk11.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/mk11/w_snipr_mk11.mdl"
SWEP.WMPos = Vector(-1, -1, -0.2)
SWEP.WMAng = Vector(-3,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "762x51"
SWEP.magType = "brMag"

SWEP.FireDelay = 0.065
SWEP.FireSound = "CW_MK11_FIRE"
SWEP.FireSoundSuppressed = "CW_MK11_FIRE_SUPPRESSED"
SWEP.Recoil = 1.1

SWEP.HipSpread = 0.02
SWEP.AimSpread = 0.0015
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.17
SWEP.Shots = 1
SWEP.Damage = 65
SWEP.DeployTime = 1

SWEP.ReloadSpeed = 1.1
SWEP.ReloadTime = 2.1
SWEP.ReloadTime_Empty = 2.8
SWEP.ReloadHalt = 0.1
SWEP.ReloadHalt_Empty = 0.1
SWEP.SnapToIdlePostReload = true
