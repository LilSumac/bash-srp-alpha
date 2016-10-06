AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

ENT.RadiationDistance = 1000;

function ENT:Initialize()
	self.Entity:SetModel("models/props_junk/metal_paintcan001b.mdl");
	self.Entity:SetMoveType(MOVETYPE_NONE);
	self.Entity:SetSolid(SOLID_NONE);
	self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER);
	self.Entity:SetTrigger(true);
	self.Entity:SetNotSolid(true);
	self.Entity:DrawShadow(false);

	local phys = self.Entity:GetPhysicsObject();

	if phys and phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:Think()
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() and !ply:GetEntry("Observing") then
			if ply:GetPos():Distance(self:GetPos()) > self.RadiationDistance then continue end;

			local checkString = "Last" .. self.Entity:EntIndex() .. "Rads";
			if !ply[checkString] then
				ply[checkString] = 0;
			end

			//if CurTime() - ply[checkString] < 3 then continue end;

			local scale = 1 - math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.RadiationDistance, 0, 1);
			local timeScale = 2 * (math.Clamp(self.Entity:GetPos():Distance(ply:GetPos()) / self.RadiationDistance, 0, 1));
			local timeDiff = CurTime() - ply[checkString];

			if timeDiff < timeScale then continue end;

			local rads = 4 * scale;
			local curRads = ply:GetEntry("Radiation");
			ply:UpdateEntry("Radiation", math.Clamp(curRads + rads, 0, 100));
			ply[checkString] = CurTime();
		end
	end
end
