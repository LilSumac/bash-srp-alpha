include("shared.lua")

ENT.RadiationDistance = 800;

function ENT:Initialize()
	self.Timer = 0;
	self.Emitter = ParticleEmitter(self.Entity:GetPos());
end

function ENT:Draw()
	self.Entity:DrawModel();
end

function ENT:Think()
	if self.Timer < CurTime() then
		local light = DynamicLight(self.Entity:EntIndex());
		if light then
			light.pos = self.Entity:LocalToWorld(self.Entity:OBBCenter()) + VectorRand() * 10;
			light.r = 50;
			light.g = 50;
			light.b = 50;
			light.brightness = 1;
			light.decay = 2048;
			light.size = 512;
			light.dietime = CurTime() + 0.5;
		end
		self.Timer = CurTime() + math.Rand(0.1, 2.5);
	end

	local particle = self.Emitter:Add("sprites/light_glow02_add", self.Entity:LocalToWorld(self.Entity:OBBCenter()) + VectorRand() * 5);
	particle:SetVelocity(Vector(0, 0, -50));
	particle:SetLifeTime(0);
	particle:SetDieTime(math.Rand(0.50, 0.75));
	particle:SetStartAlpha(50);
	particle:SetEndAlpha(0);
	particle:SetStartSize(math.random(4, 8));
	particle:SetEndSize(0);
	particle:SetColor(255, 255, 255);
	particle:SetAirResistance(10);

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
