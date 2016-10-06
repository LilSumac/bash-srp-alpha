AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.WeirdSounds = {
	Sound("ambient/levels/citadel/strange_talk1.wav"),
	Sound("ambient/levels/citadel/strange_talk3.wav"),
	Sound("ambient/levels/citadel/strange_talk4.wav"),
	Sound("ambient/levels/citadel/strange_talk5.wav"),
	Sound("ambient/levels/citadel/strange_talk6.wav"),
	Sound("ambient/levels/citadel/strange_talk7.wav"),
	Sound("ambient/levels/citadel/strange_talk8.wav"),
	Sound("ambient/levels/citadel/strange_talk9.wav"),
	Sound("ambient/levels/citadel/strange_talk10.wav"),
	Sound("ambient/levels/citadel/strange_talk11.wav")
};

ENT.Pain = {
	Sound("ambient/atmosphere/thunder1.wav"),
	Sound("ambient/atmosphere/thunder2.wav"),
	Sound("ambient/atmosphere/thunder3.wav"),
	Sound("ambient/atmosphere/thunder4.wav"),
	Sound("ambient/atmosphere/terrain_rumble1.wav"),
	Sound("ambient/atmosphere/hole_hit4.wav"),
	Sound("ambient/atmosphere/cave_hit5.wav")
};

ENT.Rape = Sound("ambient/explosions/citadel_end_explosion2.wav");

ENT.Damage = 50;
ENT.Distance = 1000;
ENT.RadiationDistance = 800;

function ENT:Initialize()
	self.Entity:SetModel("models/XQM/Rails/gumball_1.mdl");
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);

	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake();
	end

	self.SoundTime = 0;
	self.HurtSound = 0;
	self.Target = {};
end

function ENT:Think()
	if self.SoundTime < CurTime() then
		self.SoundTime = CurTime() + math.random(5, 10);
		self.Entity:EmitSound(table.Random(self.WeirdSounds), 100, math.random(130, 160));
	end

	if self.ExplodeTime then
		if self.HurtSound < CurTime() then
			self.HurtSound = CurTime() + math.Rand(0.5, 2.0);
			self.Entity:EmitSound(table.Random(self.Pain), 100, math.random(180, 200));
		end
	end

	if self.ExplodeTime and self.ExplodeTime < CurTime() then
		for _, ply in pairs(player.GetAll()) do
			if CheckPly(ply) and CheckChar(ply) and ply:Alive() and self.Entity:GetPos():Distance(ply:GetPos()) < 1000 then
				ply:SetDSP(0, false);
			end
		end

		self.Entity:Remove()
	end

	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() and self.Entity:GetPos():Distance(ply:GetPos()) < self.Distance and !ply:GetEntry("Observing") then
			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.Distance, 0, 1);

			util.ScreenShake(ply:GetPos(), scale * 2, scale * 15, 2, 100);

			local stamina = ply:GetEntry("Stamina");
			ply:UpdateEntry("Stamina", stamina - (4 * scale));
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

function ENT:Touch(ent)
	if math.random(1, 10) == 1 then
		self.Entity:Remove();
	end
end

function ENT:OnTakeDamage(dmg)
	local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		local fromPos = dmg:GetDamagePosition();
		local toPos = self.Entity:GetPos();
		if toPos.x > fromPos.x then
			phys:ApplyForceCenter((self.Entity:GetPos() - dmg:GetDamagePosition()):GetNormal() * dmg:GetDamageForce() * -2);
		else
			phys:ApplyForceCenter((self.Entity:GetPos() - dmg:GetDamagePosition()):GetNormal() * dmg:GetDamageForce() * 2);
		end
	end

	if self.HurtSound < CurTime() then
		self.HurtSound = CurTime() + 0.5;
		self.Entity:EmitSound(table.Random(self.Pain), 100, math.random(180, 200));
	end

	if math.random(1, 15) == 1 then
		self.Entity:SetNWBool("Explode", true);
		self.ExplodeTime = CurTime() + math.random(5, 20);
	end
end

function ENT:OnRemove()
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() and self.Entity:GetPos():Distance(ply:GetPos()) < 1000 and !ply:GetEntry("Observing") then
			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.Distance, 0, 1);
			local damage = self.Damage;
			local dampener = 0;
			local suit, cond = ParseDouble(ply:GetEntry("Suit"));
			if suit != "" then
				local suitData = BASH.Items[suit];
				dampener = dampener + suitData.BodyArmor;

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

			util.ScreenShake(ply:GetPos(), scale * 20, scale * 25, 2, 100);
		end
	end

	local effect = EffectData();
	effect:SetOrigin(self.Entity:GetPos());
	util.Effect("Explosion", effect, true, true);

	self.Entity:EmitSound(self.Rape, 100, 160);
end
