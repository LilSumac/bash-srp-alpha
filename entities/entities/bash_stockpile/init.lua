AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local BASH = BASH;

function ENT:Initialize()
	self:SetModel("models/props/de_dust/du_crate_64x64.mdl");
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);

	local phys = self.Entity:GetPhysicsObject();
	if phys:IsValid() then
		phys:Wake();
	end

	self:SetNWBool("InUse", false);
end

function ENT:Think()
	if self:GetNWBool("InUse") and (!self:GetTable().User or !self:GetTable().User:IsValid()) then
		self:SetNWBool("InUse", false);
		self:GetTable().User = nil;
	end
end

function ENT:Use(ply)
	if !ply:GetTable().LastUseTime then
		ply:GetTable().LastUseTime = CurTime();
	elseif CurTime() - ply:GetTable().LastUseTime < 0.5 then
		return;
	end

	ply:GetTable().LastUseTime = CurTime();

	netstream.Start(ply, "BASH_ActionMenu_Start", self);
end
