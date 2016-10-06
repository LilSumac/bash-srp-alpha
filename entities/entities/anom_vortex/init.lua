AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.PreSuck = Sound("ambient/levels/labs/teleport_mechanism_windup5.wav");
ENT.SuckExplode = Sound("weapons/mortar/mortar_explode2.wav");
ENT.SuckBang = Sound("ambient/levels/labs/teleport_postblast_thunder1.wav");

ENT.WaitTime = 3;
ENT.SuckTime = 6;
ENT.SuckRadius = 700;
ENT.KillRadius = 100;
ENT.RadiationDistance = 1000;

function ENT:Initialize()
	self.Entity:SetMoveType(MOVETYPE_NONE)
	self.Entity:SetSolid(SOLID_NONE)

	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);

	self.Entity:SetCollisionBounds(Vector(-350, -350, -350), Vector(350, 350, 350));
	self.Entity:PhysicsInitBox(Vector(-350, -350, -350), Vector(350, 350, 350));

	self.VortexPos = self.Entity:GetPos() + Vector(0, 0, 250);
end

function ENT:Touch(ent)
	if self.SetOff then return end;
	if !ent or !ent:IsValid() then return end
	if ent:IsPlayer() and !ent:Alive() then return end;

	if ent:IsPlayer() or string.find(ent:GetClass(), "npc") or string.find(ent:GetClass(), "prop_phys") then
		self.SetOff = CurTime() + self.WaitTime;

		self.Entity:EmitSound(self.PreSuck);
		self.Entity:SetNWBool("Suck", true);
	end
end

function ENT:Think()
	if self.SetOff and self.SetOff < CurTime() and !self.VortexTime then
		self.VortexTime = CurTime() + self.SuckTime;
		self.Entity:SetNWBool("Suck", false);
	end

	if self.VortexTime and self.VortexTime > CurTime() then
		local tbl = ents.FindByClass("prop_phys*");
		tbl = table.Add(tbl, ents.FindByClass("prop_veh*"));
		tbl = table.Add(tbl, ents.FindByClass("npc*"));
		tbl = table.Add(tbl, player.GetAll());

		for _, ent in pairs(tbl) do
			if ent:GetPos():Distance(self.Entity:GetPos()) < self.SuckRadius then
				local vel = (self.VortexPos - ent:GetPos()):GetNormal();

				if CheckPly(ent) and CheckChar(ent) and ent:Alive() and !ent:GetEntry("Observing") then
					local scale = math.Clamp((self.SuckRadius - ent:GetPos():Distance(self.VortexPos)) / self.SuckRadius, 0.25, 1.00);

					if ent:GetPos():Distance(self.VortexPos) > self.KillRadius then
						ent:SetVelocity(vel * (scale * 500));
					else
						local suit, cond = ParseDouble(ent:GetEntry("Suit"));
						if suit != "" then
							local suitData = BASH.Items[suit];
							cond = math.Clamp(math.Round(cond - (600 / suitData.Durability), 1), 0, 100);
							ent:UpdateEntry("Suit", suit .. ";" .. cond);
						end
						ent:Kill();
					end
				else
					if ent:GetPos():Distance(self.VortexPos) > self.KillRadius / 2 then
						local phys = ent:GetPhysicsObject();

						if phys and phys:IsValid() then
							phys:ApplyForceCenter(vel * (phys:GetMass() * 500));
						end

					elseif !CheckPly(ent) then
						ent:Remove();
					end
				end
			end
		end
	elseif self.VortexTime and self.VortexTime < CurTime() then
		self.VortexTime = nil;
		self.SetOff = nil;

		self.Entity:EmitSound(self.SuckExplode, 100, math.random(100, 120));
		self.Entity:EmitSound(self.SuckBang, 100, math.random(120, 140));

		local effect = EffectData();
		effect:SetOrigin(self.VortexPos);
		util.Effect("vortex_bigexplode", effect, true, true);

		local tbl = ents.FindByClass("prop_phys*");
		tbl = table.Add(tbl, ents.FindByClass("prop_veh*"));
		tbl = table.Add(tbl, ents.FindByClass("npc*"));
		tbl = table.Add(tbl, player.GetAll());

		for _, ent in pairs(tbl) do
			if ent:GetPos():Distance(self.VortexPos) < self.KillRadius then
				if CheckPly(ent) and CheckChar(ent) then
					if ent:Alive() then
						ent:Kill();
					end
				else
					ent:Remove();
				end
			end
		end

		self.Entity:Remove();
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

	self.Entity:NextThink(CurTime());
    return true;
end
