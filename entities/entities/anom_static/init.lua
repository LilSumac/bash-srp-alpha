AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.PreZap = {
	"weapons/physcannon/superphys_small_zap1.wav",
	"weapons/physcannon/superphys_small_zap2.wav",
	"weapons/physcannon/superphys_small_zap3.wav",
	"weapons/physcannon/superphys_small_zap4.wav"
};
ENT.ZapHit = {
	"weapons/physcannon/energy_disintegrate4.wav",
	"weapons/physcannon/energy_disintegrate5.wav"
};
ENT.ExplodeZap = {
	"ambient/explosions/explode_7.wav",
	"ambient/levels/labs/electric_explosion1.wav",
	"ambient/levels/labs/electric_explosion2.wav",
	"ambient/levels/labs/electric_explosion3.wav",
	"ambient/levels/labs/electric_explosion4.wav"
};

ENT.Damage = 50;
ENT.Distance = 300;
ENT.RadiationDistance = 400;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);
	self.Entity:SetCollisionBounds(Vector(-150, -150, -150), Vector(150, 150, 150));
	self.Entity:PhysicsInitBox(Vector(-150, -150, -150), Vector(150, 150, 150));

	self.SoundTime = 0;
end

function ENT:Touch(ent)
	if self.SetOff then return end

	if ent:IsPlayer() or string.find(ent:GetClass(), "npc") or string.find(ent:GetClass(), "prop_phys") then
		self.SetOff = CurTime() + 2;
	end
end

function ENT:Think()
	if self.SetOff and self.SetOff > CurTime() then
		if self.SoundTime < CurTime() then
			self.SoundTime = CurTime() + 0.3;

			local tbl = ents.FindByClass("prop_phys*");
			tbl = table.Add(tbl, ents.FindByClass("npc*"));
			tbl = table.Add(tbl, player.GetAll());

			for _, ent in pairs(tbl) do
				if ent:GetPos():Distance(self.Entity:GetPos()) < self.Distance then
					ent:EmitSound(table.Random(self.PreZap), 100, math.random(60, 80));
				end
			end
		end
	elseif self.SetOff and self.SetOff < CurTime() then
		self.Entity:Explode();
		self.SetOff = nil;
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

function ENT:Explode()
	local tbl = ents.FindByClass("prop_phys*");
	tbl = table.Add(tbl, ents.FindByClass("npc*"));
	tbl = table.Add(tbl, player.GetAll());

	for _, ent in pairs(tbl) do
		if ent:GetPos():Distance(self.Entity:GetPos()) < self.Distance then
			if CheckPly(ent) and CheckChar(ent) and ent:Alive() and !ent:GetEntry("Observing") then
				local effect = EffectData();
				effect:SetOrigin(ent:GetPos())
				util.Effect("electric_zap", effect)

				local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ent:GetPos()) / self.Distance, 0, 1);
				local damage = self.Damage;
				local dampener = 0;
				local suit, cond = ParseDouble(ent:GetEntry("Suit"));
				if suit != "" then
					local suitData = BASH.Items[suit];
					dampener = dampener + suitData.ElectroResist;

					local suitDamage = damage * scale;
					cond = math.Clamp(math.Round(cond - (suitDamage / suitData.Durability), 1), 0, 100);
					ent:UpdateEntry("Suit", suit .. ";" .. cond);
				end
				local acc = ent:GetEntry("Acc");
				if acc != "" then
					local accData = BASH.Items[acc];
					dampener = dampener + accData.ElectroResist;
				end
				local arts = ent:GetEntry("Artifacts");
				arts = util.JSONToTable(arts);
				for index, art in pairs(arts) do
					if art and art.ID then
						local artData = BASH.Items[art.ID];
						dampener = dampener + (artData.ElectroResist * (art.Purity / 100));
					end
				end

				damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
				ent:TakeDamage(damage * scale, self.Entity);

				util.ScreenShake(ent:GetPos(), scale * 20, scale * 25, 2, 100);
				ent:EmitSound(table.Random(self.ZapHit), 100, math.random(90, 110));
				self.Entity:DrawBeams(ent);
			elseif ent:IsProp() and ent:GetPhysicsObject():IsValid() then
				local dir = self:GetPos() - ent:GetPos();
				local force = -1 * dir * 20;
				ent:GetPhysicsObject():SetVelocity(force);
			end
		end
	end

	for i = 1, math.random(8, 12) do
		local vec = VectorRand();
		vec.z = math.Rand(-1.0, 0.5);

		local trace = {};
		trace.start = self.Entity:GetPos();
		trace.endpos = trace.start + vec * 500;
		local tr = util.TraceLine(trace);

		while tr.HitPos:Distance(self.Entity:GetPos()) < 50 or !tr.Hit do
			local vec = VectorRand();
			vec.z = math.Rand(-0.25, 0.50);

			local trace = {};
			trace.start = self.Entity:GetPos();
			trace.endpos = trace.start + vec * self.Distance;
			trace.filter = self.Entity;
			tr = util.TraceLine(trace);
		end

		self.Entity:DrawBeams(self.Entity, tr.HitPos);

		local effect = EffectData();
		effect:SetOrigin(tr.HitPos);
		util.Effect("electric_zap", effect);
	end

	self.Entity:EmitSound(table.Random(self.ExplodeZap), 100, math.random(90, 110));

	local effect = EffectData();
	effect:SetOrigin(self.Entity:GetPos());
	util.Effect("electric_bigzap", effect);
end

function ENT:DrawBeams(ent, pos)
	local target = ents.Create("info_target")
	target:SetPos(self.Entity:LocalToWorld(self.Entity:OBBCenter()));
	target:SetParent(self.Entity);
	target:SetName(tostring(self.Entity) .. math.random(1, 900));
	target:Spawn();
	target:Activate();

	local target2 = ents.Create("info_target");
	if pos then
		target2:SetPos(pos);
		target2:SetName(tostring(pos));
	else
		target2:SetPos(ent:LocalToWorld(ent:OBBCenter()));
		target2:SetParent(ent);
		target2:SetName(tostring(ent) .. math.random(1, 900));
	end
	target2:Spawn();
	target2:Activate();

	local laser = ents.Create("env_beam");
	laser:SetPos(self.Entity:GetPos());
	laser:SetKeyValue("spawnflags", "1");
	laser:SetKeyValue("rendercolor", "200 200 255");
	laser:SetKeyValue("texture", "sprites/laserbeam.spr");
	laser:SetKeyValue("TextureScroll", "1");
	laser:SetKeyValue("damage", "0");
	laser:SetKeyValue("renderfx", "6");
	laser:SetKeyValue("NoiseAmplitude", tostring(math.random(5, 20)));
	laser:SetKeyValue("BoltWidth", "1");
	laser:SetKeyValue("TouchType", "0");
	laser:SetKeyValue("LightningStart", target:GetName());
	laser:SetKeyValue("LightningEnd", target2:GetName());
	laser:SetOwner(self.Entity);
	laser:Spawn();
	laser:Activate();

	laser:Fire("kill", "", 0.2);
	target:Fire("kill", "", 0.2);
	target2:Fire("kill", "", 0.2);
end
