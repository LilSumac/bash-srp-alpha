AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.LastHurt = 0;
ENT.Damage = 35;
ENT.RadiationDistance = 1000;

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/watermelon01.mdl");
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetKeyValue("rendercolor", "150 255 150");
	self.Entity:SetKeyValue("renderamt", "0");
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet");

	self:MakeSprite("15", "100 100 100", "sprites/glow1.vmt", "10", "255");
	self:MakeSprite("23", "250 250 250", "sprites/glow1.vmt", "5", "150");

	local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		phys:Wake();
	end
end

function ENT:MakeSprite(fx, color, spritePath, scale, transity)
	local Sprite = ents.Create("env_sprite");
	Sprite:SetPos(self.Entity:GetPos());
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
    for _, ent in pairs(ents.FindInSphere(self.Entity:GetPos(), 400)) do
		if ent:IsProp() and ent:GetPhysicsObject():IsValid() and ent:GetPos():Distance(self:GetPos()) <= 300 then
			local dir = self:GetPos() - ent:GetPos();
			local force = -1 * dir * 20;
			ent:GetPhysicsObject():SetVelocity(force);
		elseif CheckPly(ent) and CheckChar(ent) and ent:GetPos():Distance(self:GetPos()) <= 350 and !ent:GetEntry("Observing") then
			local dir = self:GetPos() - ent:GetPos();
			local force = 5;

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

			local dampMul = math.Clamp(dampener / 40, 0, 1);
			force = math.Clamp(force * dampMul, 0, 5);
			force = force * dir;
			ent:SetVelocity(force);

			if CurTime() - self.LastHurt < 3 then continue end;
			if ent:GetPos():Distance(self:GetPos()) <= 1200 then
				hurt = true;
				local damage = self.Damage;
				damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
				ent:TakeDamage(damage, self.Entity);
			end
		end
	end

	if hurt then
		self:EmitSound("hgn/stalker/anom/gravy_blast1.mp3");
		self.LastHurt = CurTime();
	end

	local shake = ents.Create("env_shake");
	shake:SetKeyValue("duration", 1);
	shake:SetKeyValue("amplitude", 20);
	shake:SetKeyValue("radius", 900) ;
	shake:SetKeyValue("frequency", 100);
	shake:SetPos(self:GetPos());
	shake:Spawn();
	shake:Fire("StartShake", "", "0.6");
	shake:Fire("kill", "", 1);

	local exp = ents.Create("env_smoketrail");
	exp:SetKeyValue("startsize", "400");
	exp:SetKeyValue("endsize", "128");
	exp:SetKeyValue("spawnradius", "64");
	exp:SetKeyValue("minspeed", "1");
	exp:SetKeyValue("maxspeed", "2");
	exp:SetKeyValue("startcolor", "120 220 220");
	exp:SetKeyValue("endcolor", "220 140 220");
	exp:SetKeyValue("opacity", ".8");
	exp:SetKeyValue("spawnrate", "10");
	exp:SetKeyValue("lifetime", "1");
	exp:SetPos(self.Entity:GetPos());
	exp:SetParent(self.Entity);
    exp:Spawn();
	exp:Fire("kill", "", 0.5);

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
