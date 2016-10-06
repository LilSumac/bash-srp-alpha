AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.Awaken = Sound("ambient/atmosphere/cave_hit5.wav");
ENT.Coughs = {
	Sound("ambient/voices/cough1.wav"),
	Sound("ambient/voices/cough2.wav"),
	Sound("ambient/voices/cough3.wav"),
	Sound("ambient/voices/cough4.wav"),
	Sound("ambient/voices/citizen_beaten3.wav"),
	Sound("ambient/voices/citizen_beaten4.wav")
};

ENT.WaitTime = 5;
ENT.KillRadius = 2000;
ENT.Damage = 5;
ENT.RadiationDistance = 3000;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);

	self.Entity:EmitSound(self.Awaken, 500, 80);

	self.Timer = CurTime() + self.WaitTime;
	self.KillTime = CurTime() + 60;
	self.DamageTimer = 0;

	local trace = {};
	trace.start = self.Entity:GetPos();
	trace.endpos = trace.start + Vector(2500, 2500, 0);
	local tr = util.TraceLine(trace);

	self.Left = trace.start + Vector(2500, 2500, 0);
	if tr.Hit then
		self.Left = tr.HitPos;
	end

	trace = {};
	trace.start = self.Entity:GetPos();
	trace.endpos = trace.start + Vector(-2500, -2500, 0);
	tr = util.TraceLine(trace);

	self.Right = trace.start + Vector(-2500, -2500, 0);
	if tr.Hit then
		self.Right = tr.HitPos;
	end
end

function ENT:Think()
	if self.Timer > CurTime() then return end

	for _, ply in pairs(player.GetAll()) do
		local pos = ply:GetPos();
		pos.z = self.Entity:GetPos().z;

		if pos:Distance(self.Entity:GetPos()) < self.KillRadius then
			if ply:HasRespiration() or !ply:GetEntry("Observing") then continue end;

			for index = 1, 3 do
				local vec = Vector(math.random(self.Right.x, self.Left.x), math.random(self.Right.y, self.Left.y), self.Entity:GetPos().z);
				local trace = {};
				trace.start = vec;
				trace.endpos = ply:GetPos() + Vector(0, 0, 30);
				trace.filter = self.Entity;
				local tr = util.TraceLine(trace);

				if tr.Entity == ply then
					ply.CoughTimer = ply.CoughTimer or 0;

					if ply.CoughTimer < CurTime() then
						ply:EmitSound(table.Random(self.Coughs), 90, 100, 1, CHAN_AUTO);
						ply.CoughTimer = CurTime() + math.Rand(1.5, 3.0);
					end

					if self.DamageTimer < CurTime() then
						ply:TakeDamage(self.Damage, self.Entity);
						self.DamageTimer = CurTime() + 3;
					end
				end
			end
		end
	end

	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() and !ply:GetEntry("Observing") then
			if ply:GetPos():Distance(self:GetPos()) > self.RadiationDistance then continue end;

			local checkString = "Last" .. self.Entity:EntIndex() .. "Rads";
			if !ply[checkString] then
				ply[checkString] = 0;
			end

			local timeScale = 2 * (math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.RadiationDistance, 0, 1));
			local timeDiff = CurTime() - ply[checkString];

			if timeDiff < timeScale then continue end;

			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.RadiationDistance, 0, 1);
			local rads = 4 * scale;
			local curRads = ply:GetEntry("Radiation");
			ply:UpdateEntry("Radiation", math.Clamp(curRads + rads, 0, 100));
			ply[checkString] = CurTime();
		end
	end
end
