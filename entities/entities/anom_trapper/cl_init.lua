include("shared.lua");

ENT.RadiationDistance = 500;

local Heatwave = Material("effects/strider_bulge_dudv");
function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 3000 then
		self.Entity:DrawModel();

		local Size = 450;
		render.UpdateScreenEffectTexture();
		render.SetMaterial(Heatwave);
		if render.GetDXLevel() >= 90 then
			render.DrawSprite(self.Entity:GetPos(), Size, Size, Color(255, 0, 0, 25));
		end
	end
end

function ENT:IsTranslucent()
	return false;
end

function ENT:Think()
	if !LocalPlayer():GetEntry("CharLoaded") or !LocalPlayer():Alive() or LocalPlayer():GetEntry("Observing") then return end;
    if LocalPlayer():GetPos():Distance(self:GetPos()) > self.RadiationDistance then return end;
    if !LocalPlayer():HasItem("geiger_counter") then return end;

    local checkString = "Last" .. self.Entity:EntIndex() .. "Rads";
    if !LocalPlayer()[checkString] then
        LocalPlayer()[checkString] = 0;
    end

    local timeScale = math.Clamp(self.Entity:GetPos():Distance(LocalPlayer():GetPos()) / self.RadiationDistance, 0.1, 0.75);
    local timeDiff = CurTime() - LocalPlayer()[checkString];

    if timeDiff < timeScale then return end;
    surface.PlaySound("zavod_yantar/geiger_1.wav");
    LocalPlayer()[checkString] = CurTime();
end
