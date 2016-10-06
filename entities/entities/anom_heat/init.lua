AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.LastBurnt = 0;
ENT.Damage = 30;
ENT.Distance = 300;
ENT.RadiationDistance = 500;

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/watermelon01.mdl");
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetKeyValue("rendercolor", "150 255 150");
	self.Entity:SetKeyValue("renderamt", "alpha");
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet");

	self:MakeSprite("15", "240 80 80", "sprites/glow1.vmt", "10", "255");
	self:MakeSprite("23", "250 250 250", "sprites/glow1.vmt", "5", "150");

    local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		phys:Wake();
	end
end

function ENT:MakeSprite(fx, color, spritePath, scale, transity)
	local Sprite = ents.Create("env_sprite");
	Sprite:SetPos(self:GetPos());
	Sprite:SetKeyValue("renderfx", fx);
	Sprite:SetKeyValue("model", spritePath);
	Sprite:SetKeyValue("scale", scale);
	Sprite:SetKeyValue("spawnflags", "1");
	Sprite:SetKeyValue("angles", "0 0 0");
	Sprite:SetKeyValue("rendermode", "9");
	Sprite:SetKeyValue("renderamt", transity);
	Sprite:SetKeyValue("rendercolor", color);
	Sprite:Spawn();
	Sprite:Activate();
	Sprite:SetParent(self);
end

function ENT:Think()
	local burnt = false;
    for _, ent in pairs(ents.FindInSphere(self.Entity:GetPos(), self.Distance)) do
		if CheckPly(ent) and CheckChar(ent) and !ent:GetEntry("Observing") then
			if CurTime() - self.LastBurnt < 0.5 then continue end;

			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ent:GetPos()) / self.Distance, 0, 1);
			local damage = self.Damage;
			local dampener = 0;
			local suit, cond = ParseDouble(ent:GetEntry("Suit"));
			if suit != "" then
				local suitData = BASH.Items[suit];
				dampener = dampener + suitData.BurnResist;

				local suitDamage = damage * scale;
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
			burnt = true;
		end
	end

	if burnt then
		self.LastBurnt = CurTime();
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
