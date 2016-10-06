AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.LastShock = 0;
ENT.Damage = 40;
ENT.RadiationDistance = 300;

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/watermelon01.mdl");
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetKeyValue("rendercolor", "150 255 150");
	self.Entity:SetKeyValue("renderamt", "0");
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet");
	self.Entity:DrawShadow(false);

    local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		phys:Wake();
	end
end

function ENT:Think()
	local tesla = ents.Create("point_tesla");
	tesla:SetPos(self.Entity:GetPos());
	tesla:SetKeyValue("targetname", "electroanom");
	tesla:SetKeyValue("m_flRadius", "300");
	tesla:SetKeyValue("m_SourceEntityName", "electroanom");
	tesla:SetKeyValue("m_Color", "255 255 255");
	tesla:SetKeyValue("beamcount_min", "4");
	tesla:SetKeyValue("beamcount_max", "8");
	tesla:SetKeyValue("texture", "sprites/physbeam.vmt");
	tesla:SetKeyValue("thick_min", "6");
	tesla:SetKeyValue("thick_max", "8");
	tesla:SetKeyValue("lifetime_min", "0.3");
	tesla:SetKeyValue("lifetime_max", "1");
	tesla:SetKeyValue("interval_min", "0");
	tesla:SetKeyValue("interval_max", "2");
	tesla:Spawn();
	tesla:Activate();
	tesla:Fire("turnon", "", 0);
	tesla:Fire("turnoff", "", 1);
	tesla:Fire("kill", "", 1);
	tesla:SetParent(self.Entity);
	tesla:SetOwner(self.Entity);

	self:EmitSound("hgn/stalker/anom/electra_idle1.wav", 80, 50);

	local shocked = false;
	for _, ent in pairs(ents.FindInSphere(self.Entity:GetPos(), 300)) do
		if CheckPly(ent) and CheckChar(ent) and ent:GetPos():Distance(self:GetPos()) <= 400 and !ent:GetEntry("Observing") then
			if CurTime() - self.LastShock < 3 then continue end;

			shocked = true;
			local damage = self.Damage;
			local dampener = 0;
			local suit, cond = ParseDouble(ent:GetEntry("Suit"));
			if suit != "" then
				local suitData = BASH.Items[suit];
				dampener = dampener + suitData.ElectroResist;

				local suitDamage = damage;
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
			ent:TakeDamage(damage, self.Entity);
		end
	end

	if shocked then
		self:EmitSound("hgn/stalker/anom/electra_blast1.mp3");
		local effect = EffectData();
		effect:SetOrigin(self.Entity:GetPos() + Vector(0, 0, 5));
		util.Effect("dust_burst", effect, true, true);
		self.LastShock = CurTime();
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

function ENT:OnRemove()
	if self.Hurt and self.Hurt:IsValid() then
		self.Hurt:Remove();
	end
end
