include("shared.lua");

ENT.RadiationDistance = 300;

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self.Entity:GetPos());
	self.Fraction = 0;
	self.Size = 80;
end

function ENT:OnRemove()
	if self.Emitter then
		self.Emitter:Finish();
	end
end

local matRefract = Material( "effects/strider_muzzle" )
function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 2000 then
		self.Fraction = 0.15 + math.sin(CurTime()) * 0.10;
		matRefract:SetFloat("$refractamount", self.Fraction);

		if render.GetDXLevel() >= 80 then
			render.UpdateRefractTexture();
			render.SetMaterial(matRefract);
			render.DrawQuadEasy(self.Entity:GetPos() + Vector(0, 0, 5),
						 (EyePos() - self.Entity:GetPos()):GetNormal(),
						 self.Size + math.sin(CurTime()) * 10, self.Size + math.sin(CurTime()) * 10,
						 Color(255, 255, 255, 15));
		end
	end
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
