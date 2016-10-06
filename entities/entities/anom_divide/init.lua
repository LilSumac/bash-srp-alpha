AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.Blast = Sound("physics/nearmiss/whoosh_huge2.wav");
ENT.Blast2 = Sound("hgn/stalker/anom/gravy_blast1.mp3");
ENT.Damage = 20;
ENT.RadiationDistance = 300;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);
	self.Entity:SetCollisionBounds(Vector(-50, -50, -50), Vector(50, 50, 50));
	self.Entity:PhysicsInitBox(Vector(-50, -50, -50), Vector(50, 50, 50));

	self.LastHit = 0;
end

function ENT:Think()
	if self.BounceTime and self.BounceTime < CurTime() then
		self.BounceTime = nil;

		local tbl = player.GetAll();
		tbl = table.Add(tbl, ents.FindByClass("prop_phys*"));
		tbl = table.Add(tbl, ents.FindByClass("prop_veh*"));
		tbl = table.Add(tbl, ents.FindByClass("npc*"));

		local effect = EffectData();
		effect:SetOrigin(self.Entity:GetPos() + Vector(0, 0, 5));
		util.Effect("dust_burst", effect, true, true);

		self.Entity:EmitSound(self.Blast2, 100, 70);

		for _, ent in pairs(tbl) do
			if ent:GetPos():Distance(self.Entity:GetPos()) < 100 then
				if CheckPly(ent) and CheckChar(ent) and !ent:GetEntry("Observing") then
					local dir = (ent:GetPos() - self.Entity:GetPos()):GetNormal();
					ent:SetVelocity(dir * 2000);

					local damage = self.Damage;
					local dampener = 0;
					local suit, cond = ParseDouble(ent:GetEntry("Suit"));
					if suit != "" then
						local suitData = BASH.Items[suit];
						dampener = dampener + suitData.BodyArmor;

						local suitDamage = damage;
						cond = math.Clamp(math.Round(cond - (suitDamage / suitData.Durability), 1), 0, 100);
						ent:UpdateEntry("Suit", suit .. ";" .. cond);
					end
					local acc = ent:GetEntry("Acc");
					if acc != "" then
						local accData = BASH.Items[acc];
						dampener = dampener + accData.BodyArmor;
					end
					local arts = ent:GetEntry("Artifacts");
					arts = util.JSONToTable(arts);
					for index, art in pairs(arts) do
						if art and art.ID then
							local artData = BASH.Items[art.ID];
							dampener = dampener + (artData.ArmorBoost * (art.Purity / 100));
						end
					end
					damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
					ent:TakeDamage(damage, self.Entity);
				elseif string.find(ent:GetClass(), "npc") then
					ent:TakeDamage(self.Damage);
				elseif string.find(ent:GetClass(), "prop") then
					local phys = ent:GetPhysicsObject();
					if phys and phys:IsValid() then
						local dir = (self.Entity:GetPos() - ent:GetPos()):GetNormal();
						phys:ApplyForceCenter(dir * phys:GetMass() * 500);
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

function ENT:Touch(ent)
	if self.LastHit > CurTime() then return end;

	self.LastHit = CurTime() + 2;
	self.BounceTime = CurTime() + 0.5;
	self.Entity:EmitSound(self.Blast, 150, 150);
end
