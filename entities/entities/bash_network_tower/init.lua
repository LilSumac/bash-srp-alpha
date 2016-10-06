AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local BASH = BASH;

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self.Entity:SetModel("models/props_trainstation/pole_448connection002a.mdl");

	local phys = self.Entity:GetPhysicsObject();

	if phys:IsValid() then
		phys:EnableMotion(true);
		phys:Wake();
	end
end

function ENT:OnSpawn(ply, trace)
	self:SetPos(trace.HitPos + trace.HitNormal * 32);
	ply:UpdateEntry("ClosestTower", self.Entity);
end

function ENT:Think()
	local scan = player.GetAll();

	for index, ent in pairs(scan) do
		if ent:IsPlayer() and ent:Alive() and ent:GetEntry("CharLoaded") and ent:HasPDA() then
			if ent:GetEntry("ClosestTower") == self.Entity and CurTime() - ent:GetEntry("LastNetworkPing") > 0.2 then
				local newConnection = math.Clamp(math.floor(5000 / ent:GetPos():Distance(self.Entity:GetPos())), 0, 5);
				ent:UpdateEntry("Connection", newConnection);
			end
		end
	end
end
