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

	self:GetTable().IsSafeRemoved = false;
end

/* For suits:
** (id, condition, inventory)
**
** For accessories:
** (id, inventory)
**
** For weapons:
** (id, condition, ammo, attachments)
**
** For attachments:
** (id, color)
**
** For artifacts:
** (id, purity, nameoverride)
**
** For PDAs:
** (id, simcardslot)
**
** For SIM cards:
** (id, iccid)
**
** For conditional items:
** (id, condition)
**
** For stackable items:
** (id, stacks)
*/
function ENT:SetItem(id, args)
	if !BASH.Items[id] then return end;

	local data = BASH.Items[id];
	self.RefID = id .. "~" .. RandomString(8);
	self.ItemID = id;
	self.ItemData = data;
	if istable(data.WorldModel) then
		self.OverrideModel = table.Random(data.WorldModel);
		self.Entity:SetModel(self.OverrideModel);
	else
		self.Entity:SetModel(data.WorldModel);
	end
	if data.ModelScale != 1 then
		self.Entity:SetModelScale(data.ModelScale, 0);
	end
	if data.ModelColor != Color(255, 255, 255) then
		self.Entity:SetRenderMode(RENDERMODE_TRANSCOLOR);
		self.Entity:SetColor(data.ModelColor);
	end
	self:SetNWString("ItemID", id);

	if data.IsSuit then
		self.Condition = args[1];
		self.Inventory = args[2];
	elseif data.IsAccessory then
		self.Inventory = args[1];
	elseif data.IsWeapon then
		self.Condition = args[1];
		self.Ammo = args[2];
		self.Attachments = args[3];
	elseif data.IsAttachment then
		self.CustomColor = args[1];
	elseif data.IsWritable then
		self.Writing = args[1];
	elseif data.IsConditional then
		self.Condition = args[1];
	elseif data.IsStackable then
		self.Stacks = args[1];
	elseif !data.NoProperties then
		hook.Call("AddItemProperties", BASH, data, args, self);
	end
end

function ENT:SetRPOwner(owner)
	if !self.OwnerSteamID or !self.OwnerCharID or !self.OwnerBASHID or !self.OwnerName then
		self.OwnerSteamID = owner:SteamID();
		self.OwnerCharID = owner:GetEntry("CharID");
		self.OwnerBASHID = owner:GetEntry("BASHID");
		self.OwnerName = owner:GetEntry("Name");
	end
end

function ENT:CheckForTransfer(user)
	if self.OwnerCharID and self.OwnerBASHID then
		if user:SteamID() == self.OwnerSteamID and user:GetEntry("BASHID") == self.OwnerBASHID and user:GetEntry("CharID") != self.OwnerCharID then
			return true;
		else
			return false;
		end
	else
		return false;
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

function ENT:OnRemove()
	if !self:GetTable().IsSafeRemoved then
		if !BASH.EconomyStats or !BASH.EconomyStats["ValueOut"] then return end;
		BASH:UpdateEconomy(BASH.EconomyStats["ValueOut"] + (self.ItemData.DefaultPrice * (self.Stacks or 1)), "ValueOut");
		hook.Call("OnUnsafeRemove", BASH, self);
	end
end
