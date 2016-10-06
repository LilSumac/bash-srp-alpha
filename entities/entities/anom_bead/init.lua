AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.Pain = {
	Sound("ambient/atmosphere/thunder1.wav"),
	Sound("ambient/atmosphere/thunder2.wav"),
	Sound("ambient/atmosphere/thunder3.wav"),
	Sound("ambient/atmosphere/thunder4.wav"),
	Sound("ambient/atmosphere/terrain_rumble1.wav"),
	Sound("ambient/atmosphere/hole_hit4.wav"),
	Sound("ambient/atmosphere/cave_hit5.wav")
};
ENT.Start = Sound("npc/strider/striderx_alert5.wav");
ENT.Die = Sound("NPC_Strider.OpenHatch");
ENT.Damage = 50;
ENT.Distance = 700;
ENT.RadiationDistance = 800;

function ENT:Initialize()
	self.Entity:SetModel("models/props_phx/misc/smallcannonball.mdl");
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);

	local phys = self.Entity:GetPhysicsObject();

	if IsValid(phys) then
		phys:Wake();
		phys:SetMaterial("gmod_silent");
	end

	self.Entity:StartMotionController();

	self.Entity:EmitSound(self.Start);
	self.SoundTime = 0;
	self.ExplodeTime = CurTime() + math.random(5, 15);
end

function ENT:PhysicsSimulate(phys, delta)
	phys:Wake();

	local traceData = {};
	traceData.start = self.Entity:GetPos();
	traceData.endpos = traceData.start + Vector(0, 0, -9000);
	traceData.filter = self.Entity;
	local trace = util.TraceLine(traceData);

	local pos = trace.HitPos + trace.HitNormal * (150 + math.sin(CurTime() * 3) * 100);
	phys:ApplyForceCenter((pos - self.Entity:GetPos()):GetNormal() * phys:GetMass() * 50);
end

function ENT:Think()
	if self.ExplodeTime and self.ExplodeTime < CurTime() then
		self.Entity:Remove();
	end

	if self.SoundTime < CurTime() then
		self.Entity:EmitSound(table.Random(self.Pain), 100, math.random(200, 220));
		self.SoundTime = CurTime() + math.Rand(0.5, 1.5);
	end

	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() and !ply:GetEntry("Observing") then
			if ply:GetPos():Distance(self:GetPos()) > self.RadiationDistance then continue end;

			local checkString = "Last" .. self.Entity:EntIndex() .. "Rads";
			if !ply[checkString] then
				ply[checkString] = 0;
			end

			//if CurTime() - ply[checkString] < 3 then continue end;

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

function ENT:OnRemove()
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and self.Entity:GetPos():Distance(ply:GetPos()) < self.Distance and !ply:GetEntry("Observing") then
			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.Distance, 0, 1);
			local damage = self.Damage;
			local dampener = 0;
			local suit, cond = ParseDouble(ply:GetEntry("Suit"));
			if suit != "" then
				local suitData = BASH.Items[suit];
				dampener = dampener + (suitData.BodyArmor * (cond / 100));

				local suitDamage = damage * scale;
				cond = math.Clamp(math.Round(cond - (suitDamage / suitData.Durability), 1), 0, 100);
				ply:UpdateEntry("Suit", suit .. ";" .. cond);
			end
			local acc = ply:GetEntry("Acc");
			if acc != "" then
				local accData = BASH.Items[acc];
				dampener = dampener + accData.BodyArmor;
			end
			local arts = ply:GetEntry("Artifacts");
			arts = util.JSONToTable(arts);
			for index, art in pairs(arts) do
				if art and art.ID then
					local artData = BASH.Items[art.ID];
					dampener = dampener + (artData.ArmorBoost * (art.Purity / 100));
				end
			end
			damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
			ply:TakeDamage(damage * scale, self.Entity);
		end
	end

	local effect = EffectData();
	effect:SetOrigin(self.Entity:GetPos());
	util.Effect("Explosion", effect, true, true);
	self.Entity:EmitSound(self.Die);
end
