include("shared.lua");

ENT.RadiationDistance = 3000;

function ENT:Initialize()
	self.Emitter = ParticleEmitter(self.Entity:GetPos());
	self.VortexPos = self.Entity:GetPos() + Vector(0, 0, 2000);
	self.Alpha = 0;
	self.Timer = 0;
	self.DustTimer = 0;
	self.Fraction = 0;
	self.Size = 3500;

	self.Entity:SetRenderBounds(Vector() * -3500, Vector() * 3500);
end

local function DustThink(part)
	local dir = (part.VortexPos - part:GetPos()):GetNormal();
	local scale = math.Clamp(part.VortexPos:Distance(part:GetPos()), 0, 500) / 500;

	if scale < 0.1 and !part.Scale then
		part.Scale = math.Rand(0.8, 1.2);
	end

	if part.Scale then
		scale = part.Scale;
	end

	part:SetNextThink(CurTime() + 0.1);
	part:SetGravity(dir * (scale * 500));
end

function ENT:Think()
	if self.DustTimer < CurTime() then
		self.DustTimer = CurTime() + 0.1;

		local vec = VectorRand();
		vec.z = -0.1;

		local newpos = self.Entity:GetPos() + vec * 2000;

		local particle = self.Emitter:Add("effects/fleck_cement" .. math.random(1, 2), newpos);
		particle:SetVelocity(Vector(0, 0, math.random(50, 200)));
		particle:SetDieTime(8.0);
		particle:SetStartAlpha(255);
		particle:SetEndAlpha(255);
		particle:SetStartSize(math.Rand(5, 10));
		particle:SetEndSize(1);
		particle:SetRoll(math.random(-360, 360));
		particle:SetColor(100, 100, 100);
		particle:SetAirResistance(math.random(0, 15));
		particle:SetThinkFunction(DustThink);
		particle:SetNextThink(CurTime() + 0.1);
		particle.VortexPos = self.VortexPos;
	end

	if self.Entity:GetNWBool("Suck", false) and self.Timer < CurTime() then
		self.Timer = CurTime() + 8;
		self.RagTimer = CurTime() + 1;
	end

	if self.Timer > CurTime() and self.RagTimer < CurTime() then
		self.RagTimer = CurTime() + 0.2

		local tbl = ents.FindByClass("class C_HL2MPRagdoll");
		tbl = table.Add(tbl, ents.FindByClass("class C_ClientRagdoll"));

		for _, ent in pairs(tbl) do
			if ent:GetPos():Distance(self.VortexPos) < 3000 then
				local phys = ent:GetPhysicsObject()

				if phys and phys:IsValid() then
					local vel = (self.VortexPos - ent:GetPos()):GetNormal();
					local scale = math.Clamp((3000 - ent:GetPos():Distance(self.VortexPos)) / 3000, 0.6, 1.0);
					phys:ApplyForceCenter(vel * (scale * phys:GetMass() * 50000));
				end

				if self.Timer - CurTime() < 0.2 and ent:GetPos():Distance(self.VortexPos) < 700 and ent:GetClass() != "class C_HL2MPRagdoll" then
					ent:Remove()
				end
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

function ENT:OnRemove()
	if self.Emitter then
		self.Emitter:Finish();
	end
end

local matRefract = Material("effects/strider_bulge_dudv");
local matGlow = Material("effects/strider_muzzle");
function ENT:Draw()
	if self.Timer < CurTime() then
		self.Fraction = math.Approach(self.Fraction, 0.05 + math.sin(CurTime() * 0.5) * 0.02, 0.01);
	else
		self.Fraction = math.Approach(self.Fraction, (1 - (self.Timer - CurTime()) / 8) * 0.30, 0.01);
		self.Alpha = (1 - (self.Timer - CurTime()) / 8) * 100;

		render.SetMaterial(matGlow);
		render.DrawSprite(self.VortexPos, self.Size * 0.4 + math.sin(CurTime()) * 500, self.Size * 0.4 + math.sin(CurTime()) * 500, Color(200, 200, 255, self.Alpha));
	end

	matRefract:SetFloat("$refractamount", self.Fraction);

	if render.GetDXLevel() >= 80 then
		render.UpdateRefractTexture();
		render.SetMaterial(matRefract);
		render.DrawQuadEasy(self.VortexPos,
					 (EyePos() - self.VortexPos):GetNormal(),
					 self.Size + math.sin(CurTime()) * 500, self.Size + math.sin(CurTime()) * 500,
					 Color(255, 255, 255, 255));
	end
end
