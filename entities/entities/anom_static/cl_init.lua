include("shared.lua");

ENT.RadiationDistance = 400;
ENT.Size = 15;

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self.Entity:GetPos());
	self.Timer = 0;
	self.Alpha = 0;
end

function ENT:Think()
	if !self.Emitter or !self.Emitter:IsValid() then return end;
	
	if self.Timer < CurTime() then
		self.Timer = CurTime() + 0.75;

		local dist = LocalPlayer():GetPos():Distance(self:GetPos());

		if dist < 3000 then
			local vec = VectorRand();
			vec.z = math.Rand(-0.25, 0.25);
			local pos = self.Entity:GetPos() + vec * 150;
			local particle = self.Emitter:Add("effects/spark", pos);
			particle:SetVelocity(Vector(0, 0, 0));
			particle:SetColor(200, 200, 255);
			particle:SetDieTime(1.5);
			particle:SetStartAlpha(200);
			particle:SetEndAlpha(0);
			particle:SetStartSize(math.Rand(1, 3));
			particle:SetEndSize(0);
			particle:SetRoll(math.Rand(-360, 360));
			particle:SetRollDelta(math.Rand(-30, 30));
			particle:SetAirResistance(50);
			particle:SetGravity(Vector(0, 0, math.random(25, 50)));
		end
	end

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

function ENT:OnRemove()
	if self.Emitter then
		self.Emitter:Finish();
	end
end

local matGlow = Material("effects/yellowflare");
function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 3000 then
		self.Alpha = 100 + math.sin(CurTime()) * 100;
		render.SetMaterial(matGlow);
		render.DrawSprite(self.Entity:GetPos(), self.Size + math.sin(CurTime() * 3) * 10, self.Size + math.cos(CurTime() * 3) * 10, Color(200, 200, 255, self.Alpha));
	end
end
