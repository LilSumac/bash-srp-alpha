include("shared.lua");

local BASH = BASH;

function ENT:Draw()
	self.Entity:DrawModel();

	if self.Password != self:GetNWString("Password") then
		self.Password = self:GetNWString("Password");
	end
	if self.Owner != self:GetNWString("Owner") then
		self.Owner = self:GetNWString("Owner");
	end
	if !self.InventoryID and self:GetNWString("InventoryID") and self:GetNWString("InventoryID") != "" and self:GetNWString("Password") then
		local invID = self:GetNWString("InventoryID");
		local invData = BASH.Inventories[invID];

		self.InventoryID = invID;
		self.InventoryName = invData.Name;
	end
end
