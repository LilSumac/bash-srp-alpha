AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
include("shared.lua");

local BASH = BASH;

function ENT:Initialize()
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	self:SetUseType(SIMPLE_USE);

	local phys = self.Entity:GetPhysicsObject();

	if phys:IsValid() then
		phys:Wake();
	end
end

function ENT:CreateInventory(inv, modelOverride, invOverride)
	if !inv then return end;

	local storeInv;
	local invData = BASH.Inventories[inv];
	local invModel = invData.Model

	if invOverride then
		storeInv = invOverride;
	else
		storeInv = {};
		storeInv.Name = inv;
		storeInv.Content = {};
		for invX = 1, invData.SizeX do storeInv.Content[invX] = {} for invY = 1, invData.SizeY do storeInv.Content[invX][invY] = {} end end;
		storeInv = util.TableToJSON(storeInv);
	end

	self:SetNWString("InventoryID", inv);
	self:SetNWString("Password", "");
	self:SetNWString("Owner", "");
	self:SetNWBool("InUse", false);

	self.InventoryID = inv;
	self.Inventory = storeInv;
	self.Password = "";
	self.ModelOverride = modelOverride;
	self.Entity:SetModel(modelOverride or invModel);
end

function ENT:SetRPOwner(id)
	self.Owner = id;
	self:SetNWString("Owner", id);
end

function ENT:SetPassword(pass)
	self.Password = pass;
	self:SetNWString("Password", pass);
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
