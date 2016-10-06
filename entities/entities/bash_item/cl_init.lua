include("shared.lua");

local BASH = BASH;

function ENT:Draw()
	self.Entity:DrawModel();
	
	if !self.ItemData and self:GetNWString("ItemID") and self:GetNWString("ItemID") != "" then
		local id = self:GetNWString("ItemID");
		local data = BASH.Items[id];
		if !data then return end;

		self.ItemID = id;
		self.ItemData = data;
	end
end