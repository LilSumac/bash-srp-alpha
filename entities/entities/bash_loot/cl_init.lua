include("shared.lua");

local BASH = BASH;

function ENT:Draw()
	if LocalPlayer().HighlightLoot then
		local pos = LocalPlayer():EyePos() + LocalPlayer():EyeAngles():Forward() * 10;
		local ang = LocalPlayer():EyeAngles();
		ang = Angle(ang.p + 90, ang.y, 0);

		render.ClearStencil();
		render.SetStencilEnable(true);
			render.SetStencilWriteMask(255);
			render.SetStencilTestMask(255);
			render.SetStencilReferenceValue(15);
			render.SetStencilFailOperation(STENCILOPERATION_KEEP);
			render.SetStencilZFailOperation(STENCILOPERATION_REPLACE);
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE);
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS);
			render.SetBlend(0);
			self.Entity:SetModelScale(1.025, 0);
			self.Entity:SetRenderMode(RENDERMODE_TRANSALPHA);
			self.Entity:SetColor(color_green);
			self.Entity:DrawModel();
			self.Entity:SetModelScale(1, 0);
			render.SetBlend(1);
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL);
			cam.Start3D2D(pos, ang, 1);
					surface.SetDrawColor(math.Rand(200, 255), math.Rand(200, 255), math.Rand(200, 255), 255);
					surface.DrawRect(-ScrW(), -ScrH(), ScrW() * 2, ScrH() * 2);
			cam.End3D2D();
			self.Entity:DrawModel();
		render.SetStencilEnable(false);
	end
end
