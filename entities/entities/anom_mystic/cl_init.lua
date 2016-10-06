include("shared.lua");

ENT.RadiationDistance = 800;

function ENT:Initialize()
	self.Timer = 0;
end

function ENT:Think()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 3000 then
		if self.Timer < CurTime() then
			self.Timer = CurTime() + math.Rand(0.1, 2.5);

			local dlight = DynamicLight(self.Entity:EntIndex());
			if dlight then
				dlight.Pos = self.Entity:LocalToWorld(self.Entity:OBBCenter()) + VectorRand() * 10;
				dlight.r = 255;
				dlight.g = 255;
				dlight.b = 255;
				dlight.Brightness = 3;
				dlight.Decay = 2048;

				if self.Entity:GetNWBool("Explode", false) then
					dlight.size = 512;
				else
					dlight.size = 1024;
					self.Timer = CurTime() + math.Rand(0.1, 1.0);
				end

				dlight.DieTime = CurTime() + 2;
			end
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

function ENT:Draw()
	local dist = LocalPlayer():GetPos():Distance(self:GetPos());

	if dist < 3000 then
		if self.Entity:GetNWBool("Explode", false) then
			self.Entity:SetModelScale(math.Rand(0.8, 1.2));
		end

		self.Entity:DrawModel()
	end
end
