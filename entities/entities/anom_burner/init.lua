AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.Blast = Sound("hgn/stalker/anom/burner_blow.mp3");
ENT.Death = Sound("ambient/fire/mtov_flame2.wav");
ENT.Burn = Sound("Fire.Plasma");
ENT.LastBurn = 0;
ENT.Damage = 30;
ENT.RadiationDistance = 500;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);
	self.Entity:SetCollisionBounds(Vector(-100, -100, -100), Vector(100, 100, 100));
	self.Entity:PhysicsInitBox(Vector(-100, -100, -100), Vector(100, 100, 100));

	self.BurnTime = 0;
end

function ENT:Think()
	if self.BurnTime and self.BurnTime >= CurTime() then
		local tbl = player.GetAll();
		tbl = table.Add(tbl, ents.FindByClass("npc*"));

		local burnt = false;
		for _, ent in pairs(tbl) do
			if ent:GetPos():Distance(self.Entity:GetPos()) < 150 then
				if CurTime() - self.LastBurn < 1 then continue end;
				if CheckPly(ent) and CheckChar(ent) and !ent:GetEntry("Observing") then
					local damage = self.Damage;
					local dampener = 0;
					local suit, cond = ParseDouble(ent:GetEntry("Suit"));
					if suit != "" then
						local suitData = BASH.Items[suit];
						dampener = dampener + suitData.BurnResist;

						local suitDamage = damage;
						cond = math.Clamp(math.Round(cond - (suitDamage / suitData.Durability), 1), 0, 100);
						ent:UpdateEntry("Suit", suit .. ";" .. cond);
					end
					local acc = ent:GetEntry("Acc");
					if acc != "" then
						local accData = BASH.Items[acc];
						dampener = dampener + accData.BurnResist;
					end
					local arts = ent:GetEntry("Artifacts");
					arts = util.JSONToTable(arts);
					for index, art in pairs(arts) do
						if art and art.ID then
							local artData = BASH.Items[art.ID];
							dampener = dampener + (artData.BurnResist * (art.Purity / 100));
						end
					end
					damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
					ent:TakeDamage(damage, self.Entity);
				elseif string.find(ent:GetClass(), "npc") then
					ent:TakeDamage(self.Damage);
				end

				burnt = true;
			end
		end

		if burnt then
			self.LastBurn = CurTime();
		end
	elseif self.BurnTime and self.BurnTime < CurTime() then
		self.BurnTime = nil;
		self.Entity:StopSound(self.Burn);
		self.Entity:EmitSound(self.Death, 150, 100);
		self.Entity:SetNWBool("Burn", false);
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
	if ent:IsItem() and ent:GetTable().ItemData.IsArtifact then return end;
	if self.BurnTime and self.BurnTime >= CurTime() then return end;

	self.BurnTime = CurTime() + 10;
	self.Entity:SetNWBool("Burn", true);
	self.Entity:EmitSound(self.Blast, 150, 100);
	self.Entity:EmitSound(self.Burn, 100, 100);
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS;
end
