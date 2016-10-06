include("shared.lua");

ENT.RadiationDistance = 200;

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self.Entity:GetPos());
	self.Dist = self.Entity:OBBCenter():Distance(self.Entity:OBBMaxs());
end

function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos())

	if dist < 3000 then
		self.Entity:DrawModel();
	end
end

function ENT:Think()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 3000 then
		local particle = self.Emitter:Add("effects/muzzleflash" .. math.random(1,4), self.Entity:LocalToWorld(self.Entity:OBBCenter()) + VectorRand() * self.Dist);
		particle:SetVelocity(VectorRand() * 10);
		particle:SetLifeTime(0);
		particle:SetDieTime(math.Rand(0.50, 0.75));
		particle:SetStartAlpha(30);
		particle:SetEndAlpha(0);
		particle:SetStartSize(math.random(15, 30));
		particle:SetEndSize(math.random(3, 6));
		particle:SetColor(100, math.random(100, 150), math.random(150, 250));
		particle:SetAirResistance(50);
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
