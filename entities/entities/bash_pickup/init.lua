AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_NONE);

	local phys = self.Entity:GetPhysicsObject();

	if phys:IsValid() then
		phys:Wake();
	end

    self:StartMotionController();
end

function ENT:SetPlayer(ply)
	self.Player = ply;
end

function ENT:SetTarget(ent)
	self.EntTarget = ent;
	ent:GetTable().PickupParent = self;
end

function ENT:OnRemove()
	if self.EntTarget and self.EntTarget:IsValid() then
		self.EntTarget:GetPhysicsObject():Wake();
	end
end

function ENT:PhysicsSimulate(phys, delta)
	if !self.Player or !self.Player:IsValid() then
		self:Remove();
		return;
	end

	if !self.Player:Alive() then
		self:Remove();
		return;
	end

	if !self.EntTarget or !self.EntTarget:IsValid() then
		self:Remove();
		return;
	end

	phys:Wake();

	self.ShadowParams = {};
	self.ShadowParams.secondstoarrive = 0.1;
	self.ShadowParams.pos = (self.Player:EyePos() + self.Player:GetAimVector() * 40);
	self.ShadowParams.ang = Angle(0, 0, 0);
	self.ShadowParams.maxangular = 5000;
	self.ShadowParams.maxangulardamp = 10000;
	if self.EntTarget:GetClass() == "prop_ragdoll" then
		self.ShadowParams.pos = (self.Player:EyePos() + self.Player:GetAngles():Forward() * 5);
		self.ShadowParams.maxspeed = 5000;
		self.ShadowParams.maxspeeddamp = 10000;
	else
		self.ShadowParams.maxspeed = 200;
		self.ShadowParams.maxspeeddamp = 200;
	end
	self.ShadowParams.dampfactor = 1;
	self.ShadowParams.teleportdistance = 45;
	self.ShadowParams.deltatime = delta;

	phys:ComputeShadowControl(self.ShadowParams);

	if !self.EntTarget or !self.EntTarget:IsValid() then
		self:Remove();
	end
end
