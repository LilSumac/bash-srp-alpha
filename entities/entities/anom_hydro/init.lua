AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.LastHurt = 0;
ENT.Damage = 30;
ENT.Distance = 400;
ENT.RadiationDistance = 500;

function ENT:Initialize()
	self.Entity:SetModel("models/props_borealis/bluebarrel001.mdl");
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetKeyValue("rendercolor", "150 150 255");
	self.Entity:SetKeyValue("renderamt", "0");
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet");
	self.Entity:SetModelScale(1.5);
	self:MakeSprite("15", "100 100 240", "sprites/glow1.vmt", "6", "255");
	self:MakeSprite("23", "250 250 250", "sprites/glow1.vmt", "2", "150");

	local gas = ents.Create("env_smokestack");
	gas:SetPos(self:GetPos());
	gas:SetKeyValue("InitialState", "1");
	gas:SetKeyValue("BaseSpread", "1");
	gas:SetKeyValue("SpreadSpeed", "5");
	gas:SetKeyValue("Speed", "5");
	gas:SetKeyValue("StartSize", "100");
	gas:SetKeyValue("EndSize", "2500");
	gas:SetKeyValue("Rate", "5");
	gas:SetKeyValue("JetLength", "50");
	gas:SetKeyValue("SmokeMaterial", "sprites/heatwave.vmt");
	gas:Spawn();
	gas:SetParent(self);
	gas:Fire("TurnOn", "", 0);

	local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		phys:EnableMotion(false)
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
	local hurt = false;
	for _, ent in pairs(ents.FindInSphere(self.Entity:GetPos(), self.Distance)) do
		if CheckPly(ent) and CheckChar(ent) and !ent:GetEntry("Observing") then
			if CurTime() - self.LastHurt < 0.5 then continue end;

			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ent:GetPos()) / self.Distance, 0, 1);
			local damage = self.Damage;
			local dampener = 0;
			local suit, cond = ParseDouble(ent:GetEntry("Suit"));
			if suit != "" then
				local suitData = BASH.Items[suit];
				dampener = dampener + suitData.BodyArmor;

				local suitDamage = damage * scale;
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
			hurt = true;
		end
	end

	if hurt then
		self.LastHurt = CurTime();
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
