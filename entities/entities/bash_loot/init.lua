AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local BASH = BASH;

function ENT:Initialize()
	self.IsLoot = true;
	self.LootID = "";
	self.Delay = 1800;
	self.LastSpawn = CurTime();
	self.LootEnt = NULL;
	self:GetTable().IsSafeRemoved = false;
	self:SetNWInt("Birth", CurTime());

	self.Entity:SetModel("models/props_trainstation/payphone_reciever001a.mdl");
	self.Entity:SetMoveType(MOVETYPE_NOCLIP);
	self.Entity:SetSolid(SOLID_BSP);
end

function ENT:SetID(id)
	self.LootID = id;
	BASH.LootEnts[id] = self.Entity;
end

function ENT:SetDelay(delay)
	self.Delay = delay;
end

function ENT:Think()
	if self.LootEnt:IsValid() then
		self.LastSpawn = CurTime();
		return;
	end

	if CurTime() - self.LastSpawn > self.Delay then
		local id, args = BASH:GetRandomItem(1);
		self.LootEnt = ents.Create("bash_item");
		self.LootEnt:SetItem(id, args);
		self.LootEnt:SetPos(self.Entity:GetPos());
		self.LootEnt:SetAngles(Angle(0, 0, 0));
		self.LootEnt:Spawn();
		self.LootEnt:Activate();
		self.LastSpawn = CurTime();
	end
end

function ENT:OnRemove()
	if BASH.LootEnts[self.LootID] then
		BASH.LootEnts[self.LootID] = nil;
	end
end
