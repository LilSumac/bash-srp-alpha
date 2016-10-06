local BASH = BASH;
local main = Material("bash-srp/icon/mainSlot.png", "noclamp");
local sec = Material("bash-srp/icon/secSlot.png", "noclamp");
local melee = Material("bash-srp/icon/meleeSlot.png", "noclamp");
BASH.Inventory = {};
BASH.Inventory.Open = false;
BASH.Inventory.MainObject = nil;
BASH.Inventory.SecObject = nil;
BASH.Inventory.AccObject = nil;
BASH.Inventory.StoreObject = nil
BASH.Inventory.EquipmentObject = nil;
BASH.Inventory.ClothingObject = nil;
BASH.Inventory.MainGrid = {};
BASH.Inventory.SecGrid = {};
BASH.Inventory.AccGrid = {};
BASH.Inventory.StoreGrid = {};
BASH.Inventory.EquipmentGrid = {};
BASH.Inventory.ClothingGrid = {};

function BASH:CloseInventory()
	if !self.Inventory.Open or !self.Inventory.MainObject then return end;

	self:ClearInventoryGUI();

	if self.Inventory.MainObject and self.Inventory.MainObject:IsValid() then
		self.Inventory.MainObject:Remove();
		self.Inventory.MainGrid = {};
	end

	if self.Inventory.SecObject and self.Inventory.SecObject:IsValid() then
		self.Inventory.SecObject:Remove();
		self.Inventory.SecGrid = {};
	end

	if self.Inventory.AccObject and self.Inventory.AccObject:IsValid() then
		self.Inventory.AccObject:Remove();
		self.Inventory.SecGrid = {};
	end

	if self.Inventory.EquipmentObject and self.Inventory.EquipmentObject:IsValid() then
		self.Inventory.EquipmentObject:Remove();
		self.Inventory.EquipmentGrid = {};
	end

	if self.Inventory.ClothingObject and self.Inventory.ClothingObject:IsValid() then
		self.Inventory.ClothingObject:Remove();
		self.Inventory.ClothingGrid = {};
	end

	if self.Inventory.StoreObject and self.Inventory.StoreObject:IsValid() then
		local newInv = self.Inventory.StoreObject.Inventory;
		local ent = self.Inventory.StoreObject.Ent;
		self.Inventory.StoreObject:Remove();
		self.Inventory.StoreGrid = {};

		netstream.Start("BASH_Update_Storage", {ent, newInv, true});
	end

	hook.Call("OnInventoryClose", self);

	gui.EnableScreenClicker(false);
	CloseDermaMenus();
	self.Inventory.Open = false;
end

function BASH:ToggleInventory()
	if self.Inventory.Open then
		self:CloseInventory();
	else
		self:CreateInventory();
	end
end

function BASH:CreateInventory()
	if self:GUIOpen() then return end;
	if self:GUIOccupied() then return end;

	gui.EnableScreenClicker(true);
	self.Inventory.Open = true;

	self:CreateMainInventory();

	local suit, _ = ParseDouble(LocalPlayer():GetEntry("Suit"));
	if suit != "" then
		self:CreateSecInventory();
	end

	local acc, _ = ParseDouble(LocalPlayer():GetEntry("Acc"));
	if acc != "" then
		self:CreateAccInventory();
	end

	self:CreateClothingSlots();
	self:CreateEquipmentSlots();

	hook.Call("OnInventoryCreate", self);
end

function BASH:GetWidestInventory()
	local main, sec, acc = 0, 0, 0;
	if self.Inventory.MainObject and self.Inventory.MainObject:IsValid() and self.Inventory.MainObject:IsVisible() then
		main = self.Inventory.MainObject:GetWide();
	end
	if self.Inventory.SecObject and self.Inventory.SecObject:IsValid() and self.Inventory.SecObject:IsVisible() then
		sec = self.Inventory.SecObject:GetWide();
	end
	if self.Inventory.AccObject and self.Inventory.AccObject:IsValid() and self.Inventory.AccObject:IsVisible() then
		acc = self.Inventory.AccObject:GetWide();
	end

	if main >= sec and main >= acc then return main
	elseif sec >= main and sec >= acc then return sec
	elseif acc >= main and acc >= sec then return acc end;
end

function BASH:ClearInventoryGUI()
	if self.Inventory.MainObject then
		for mainGridX = 1, #self.Inventory.MainGrid do
			for mainGridY = 1, #self.Inventory.MainGrid[1] do
				if self.Inventory.MainGrid[mainGridX][mainGridY]:IsValid() then
					self.Inventory.MainGrid[mainGridX][mainGridY]:Remove();
					self.Inventory.MainGrid[mainGridX][mainGridY] = nil;
				end
			end
		end
	end

	if self.Inventory.SecObject then
		for secGridX = 1, #self.Inventory.SecGrid do
			if !self.Inventory.SecGrid[1] then break end;
			for secGridY = 1, #self.Inventory.SecGrid[1] do
				if self.Inventory.SecGrid[secGridX][secGridY]:IsValid() then
					self.Inventory.SecGrid[secGridX][secGridY]:Remove();
					self.Inventory.SecGrid[secGridX][secGridY] = nil;
				end
			end
		end
	end

	if self.Inventory.AccObject then
		for accGridX = 1, #self.Inventory.AccGrid do
			if !self.Inventory.AccGrid[1] then break end;
			for accGridY = 1, #self.Inventory.AccGrid[1] do
				if self.Inventory.AccGrid[accGridX][accGridY]:IsValid() then
					self.Inventory.AccGrid[accGridX][accGridY]:Remove();
					self.Inventory.AccGrid[accGridX][accGridY] = nil;
				end
			end
		end
	end

	if self.Inventory.EquipmentObject then
		for equGridX = 1, #self.Inventory.EquipmentGrid do
			if self.Inventory.EquipmentGrid[equGridX]:IsValid() then
				self.Inventory.EquipmentGrid[equGridX]:Remove();
				self.Inventory.EquipmentGrid[equGridX] = nil;
			end
		end
	end

	if self.Inventory.ClothingObject then
		for cloGridX = 1, #self.Inventory.ClothingGrid do
			if self.Inventory.ClothingGrid[cloGridX]:IsValid() then
				self.Inventory.ClothingGrid[cloGridX]:Remove();
				self.Inventory.ClothingGrid[cloGridX] = nil;
			end
		end
	end

	if self.Inventory.StoreObject then
		for storeGridX = 1, #self.Inventory.StoreGrid do
			for storeGridY = 1, #self.Inventory.StoreGrid[1] do
				if self.Inventory.StoreGrid[storeGridX][storeGridY]:IsValid() then
					self.Inventory.StoreGrid[storeGridX][storeGridY]:Remove();
					self.Inventory.StoreGrid[storeGridX][storeGridY] = nil;
				end
			end
		end
	end

	hook.Call("OnInventoryClear", self);
end

function BASH:CreateMainInventory()
	local invMain = LocalPlayer():GetEntry("InvMain");
	invMain = util.JSONToTable(invMain);
	local invObj = self.Inventories[invMain.Name];
	if !invObj then return end;
	local invName = invObj.Name;

	self.Inventory.MainObject = vgui.Create("BASHPanel");
	self.Inventory.MainObject.InvType = INV_MAIN;
	self.Inventory.MainObject:SetSize(10 + (50 * invObj.SizeX) + (5 * (invObj.SizeX - 1)), 50 + (50 * invObj.SizeY) + (5 * (invObj.SizeY - 1)));
	self.Inventory.MainObject:SetPos(SCRW - 10 - self.Inventory.MainObject:GetWide(), SCRH - 10 - self.Inventory.MainObject:GetTall());
	self.Inventory.MainObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText(invName, "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		draw.SimpleText("Weight: " .. LocalPlayer():GetEntry("Weight") .. "/" .. LocalPlayer():GetEntry("MaxWeight"), "BASHFontSmall", 5, h - 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
		draw.SimpleText("Rubles: " .. LocalPlayer():GetEntry("Rubles"), "BASHFontSmall", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP);

		local posX = 5;
		local posY = 25;
		for invY = 1, invObj.SizeY do
			for invX = 1, invObj.SizeX do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));

				posX = posX + 55;
			end

			posX = 5;
			posY = posY + 55;
		end
	end

	local posX = 5;
	local posY = 25;
	for invX = 1, invObj.SizeX do
		self.Inventory.MainGrid[invX] = {};
		for invY = 1, invObj.SizeY do
			self.Inventory.MainGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.MainObject);
			self.Inventory.MainGrid[invX][invY].InvX = invX;
			self.Inventory.MainGrid[invX][invY].InvY = invY;
			self.Inventory.MainGrid[invX][invY]:SetPos(posX, posY);
			self.Inventory.MainGrid[invX][invY]:SetSize(50, 50);

			if invMain.Content[invX][invY].ID then
				self.Inventory.MainGrid[invX][invY]:SetItem(invMain.Content[invX][invY]);
			end

			posY = posY + 55;
		end

		posX = posX + 55;
		posY = 25;
	end
end

function BASH:CreateSecInventory()
	local invSec = LocalPlayer():GetEntry("InvSec");
	invSec = util.JSONToTable(invSec);
	local invObj = self.Inventories[invSec.Name];
	local invName = "Suit";
	if !invObj then
		invObj = {};
		local suit, cond = ParseDouble(LocalPlayer():GetEntry("Suit"));
		if self.Items[suit] then
			invName = self.Items[suit].Name;
		end
	else
		invName = invObj.Name;
	end

	self.Inventory.SecObject = vgui.Create("BASHPanel");
	self.Inventory.SecObject.InvType = INV_SEC;
	self.Inventory.SecObject:SetSize(10 + (50 * (invObj.SizeX or 4)) + (5 * ((invObj.SizeX or 4) - 1)), 50 + (50 * (invObj.SizeY or 1)) + (5 * ((invObj.SizeY or 1) - 1)));
	self.Inventory.SecObject:SetPos(SCRW - 10 - self.Inventory.SecObject:GetWide(), SCRH - 20 - self.Inventory.MainObject:GetTall() - self.Inventory.SecObject:GetTall());
	self.Inventory.SecObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText(invName, "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		if !invObj.SizeX or !invObj.SizeY then return end;
		local posX = 5;
		local posY = 25;
		for invY = 1, invObj.SizeY do
			for invX = 1, invObj.SizeX do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));

				posX = posX + 55;
			end

			posX = 5;
			posY = posY + 55;
		end
	end
	if !invObj.SizeX or !invObj.SizeY then self.Inventory.SecObject.NoInventory = true end;

	if invObj.SizeX and invObj.SizeY then
		local posX = 5;
		local posY = 25;
		for invX = 1, invObj.SizeX do
			self.Inventory.SecGrid[invX] = {};
			for invY = 1, invObj.SizeY do
				self.Inventory.SecGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.SecObject);
				self.Inventory.SecGrid[invX][invY].InvX = invX;
				self.Inventory.SecGrid[invX][invY].InvY = invY;
				self.Inventory.SecGrid[invX][invY]:SetPos(posX, posY);
				self.Inventory.SecGrid[invX][invY]:SetSize(50, 50);

				if invSec.Content[invX][invY].ID then
					self.Inventory.SecGrid[invX][invY]:SetItem(invSec.Content[invX][invY]);
				end

				posY = posY + 55;
			end

			posX = posX + 55;
			posY = 25;
		end
	end

	self.Inventory.SecObject.RemoveButton = self:CreateTextButton("Unequip", "BASHFontSmall", 4, self.Inventory.SecObject:GetTall() - 22, self.Inventory.SecObject);
	self.Inventory.SecObject.RemoveButton.Action = function()
		netstream.Start("BASH_Remove_Suit");
		BASH:RefreshInventory()
	end

	surface.SetFont("BASHFontSmall");
	local dropX, _ = surface.GetTextSize("Drop");

	self.Inventory.SecObject.DropButton = self:CreateTextButton("Drop", "BASHFontSmall", self.Inventory.SecObject:GetWide() - dropX - 22, self.Inventory.SecObject:GetTall() - 22, self.Inventory.SecObject);
	self.Inventory.SecObject.DropButton.Action = function()
		netstream.Start("BASH_Remove_Suit", true);
	end
end

function BASH:CreateAccInventory()
	local invAcc = LocalPlayer():GetEntry("InvAcc");
	invAcc = util.JSONToTable(invAcc);
	local invObj = self.Inventories[invAcc.Name];
	local invName = "Accessory";
	if !invObj then
		invObj = {};
		local acc, cond = ParseDouble(LocalPlayer():GetEntry("Acc"));
		if self.Items[acc] then
			invName = self.Items[acc].Name;
		end
	else
		invName = invObj.Name;
	end

	self.Inventory.AccObject = vgui.Create("BASHPanel");
	self.Inventory.AccObject.InvType = INV_ACC;
	self.Inventory.AccObject:SetSize(10 + (50 * (invObj.SizeX or 4)) + (5 * ((invObj.SizeX or 4) - 1)), 50 + (50 * (invObj.SizeY or 1)) + (5 * ((invObj.SizeY or 1) - 1)));
	self.Inventory.AccObject:SetPos(SCRW - 10 - self.Inventory.AccObject:GetWide(), SCRH - 20 - self.Inventory.MainObject:GetTall() - ((self.Inventory.SecObject and self.Inventory.SecObject:IsValid() and self.Inventory.SecObject:GetTall() + 10) or 0) - self.Inventory.AccObject:GetTall());
	self.Inventory.AccObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText(invName, "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		if !invObj.SizeX or !invObj.SizeY then return end;
		local posX = 5;
		local posY = 25;
		for invY = 1, invObj.SizeY do
			for invX = 1, invObj.SizeX do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));

				posX = posX + 55;
			end

			posX = 5;
			posY = posY + 55;
		end
	end
	if !invObj.SizeX or !invObj.SizeY then self.Inventory.AccObject.NoInventory = true end;

	if invObj.SizeX and invObj.SizeY then
		local posX = 5;
		local posY = 25;
		for invX = 1, invObj.SizeX do
			self.Inventory.AccGrid[invX] = {};
			for invY = 1, invObj.SizeY do
				self.Inventory.AccGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.AccObject);
				self.Inventory.AccGrid[invX][invY].InvX = invX;
				self.Inventory.AccGrid[invX][invY].InvY = invY;
				self.Inventory.AccGrid[invX][invY]:SetPos(posX, posY);
				self.Inventory.AccGrid[invX][invY]:SetSize(50, 50);

				if invAcc.Content[invX][invY].ID then
					self.Inventory.AccGrid[invX][invY]:SetItem(invAcc.Content[invX][invY]);
				end

				posY = posY + 55;
			end

			posX = posX + 55;
			posY = 25;
		end
	end

	self.Inventory.AccObject.RemoveButton = self:CreateTextButton("Unequip", "BASHFontSmall", 4, self.Inventory.AccObject:GetTall() - 22, self.Inventory.AccObject);
	self.Inventory.AccObject.RemoveButton.Action = function()
		netstream.Start("BASH_Remove_Acc");
	end

	surface.SetFont("BASHFontSmall");
	local dropX, _ = surface.GetTextSize("Drop");

	self.Inventory.AccObject.DropButton = self:CreateTextButton("Drop", "BASHFontSmall", self.Inventory.AccObject:GetWide() - dropX - 22, self.Inventory.AccObject:GetTall() - 22, self.Inventory.AccObject);
	self.Inventory.AccObject.DropButton.Action = function()
		netstream.Start("BASH_Remove_Acc", true);
	end
end

function BASH:CreateClothingSlots()
	local farX = self:GetWidestInventory();
	self.Inventory.ClothingObject = vgui.Create("DFrame");
	self.Inventory.ClothingObject.InvType = INV_CLOTHING;
	self.Inventory.ClothingObject:SetSize(280, 135);
	self.Inventory.ClothingObject:SetPos(SCRW - 10 - farX - self.Inventory.ClothingObject:GetWide() - 10, SCRH - 145);
	self.Inventory.ClothingObject:SetDraggable(false);
	self.Inventory.ClothingObject:SetTitle("");
	self.Inventory.ClothingObject:ShowCloseButton(false);
	self.Inventory.ClothingObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("Apparel", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		local posX = 5;
		local posY = 25;
		for invX = 1, 10 do
			if invX % 6 == 0 then
				posX = 5;
				posY = posY + 55;
			end

			draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));
			posX = posX + 55;
		end
	end

	local posX = 5;
	local posY = 25;
	local invClo = LocalPlayer():GetEntry("Clothing");
	invClo = util.JSONToTable(invClo);
	for index, bodyPart in pairs(BODY_PARTS) do
		if index % 6 == 0 then
			posX = 5;
			posY = posY + 55;
		end
		self.Inventory.ClothingGrid[index] = vgui.Create("BASHInventoryObj", self.Inventory.ClothingObject);
		self.Inventory.ClothingGrid[index]:SetPos(posX, posY);
		self.Inventory.ClothingGrid[index]:SetSize(50, 50);
		self.Inventory.ClothingGrid[index].BodyPart = bodyPart;
		self.Inventory.ClothingGrid[index].PaintOver = function(self, w, h)
			local clothing = LocalPlayer():GetEntry("Clothing");
			clothing = util.JSONToTable(clothing);
			if clothing[bodyPart] and clothing[bodyPart] != "" then return end;

			draw.SimpleText(bodyPart, "BASHFontSmall", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
		if invClo[bodyPart] and invClo[bodyPart] != "" then
			local data = {};
			data.ID = invClo[bodyPart];
			self.Inventory.ClothingGrid[index]:SetItem(data);
		end

		posX = posX + 55;
	end
end

function BASH:CreateEquipmentSlots()
	local slots = {};
	local index = 1;
	for slot, _ in pairs(EQUIP_PARTS) do slots[index] = slot index = index + 1 end;
	local suit = LocalPlayer():GetEntry("Suit");
	suit, _ = ParseDouble(suit);
	index = table.Count(slots) + 1;
	if suit != "" then
		local suitData = BASH.Items[suit];
		for _, slot in pairs(suitData.EquipSlots) do
			slots[index] = slot;
			index = index + 1;
		end
	end
	local accessory = LocalPlayer():GetEntry("Acc");
	local acc, cond = ParseDouble(accessory);
	index = table.Count(slots) + 1;
	if acc != "" then
		local accData = BASH.Items[acc];
		for _, slot in pairs(accData.EquipSlots) do
			slots[index] = slot;
			index = index + 1;
		end
	end
	table.sort(slots, function(a, b) return EQUIP_PARTS[a] < EQUIP_PARTS[b] end);

	surface.SetFont("BASHFontHeavy");
	local eq, _ = surface.GetTextSize("Equipment");

	local farX = self:GetWidestInventory();
	self.Inventory.EquipmentObject = vgui.Create("DFrame");
	self.Inventory.EquipmentObject.InvType = INV_EQUIP;
	self.Inventory.EquipmentObject:SetSize(10 + (#slots * 50) + ((#slots - 1) * 5), 80);
	self.Inventory.EquipmentObject:SetPos(SCRW - 10 - farX - self.Inventory.EquipmentObject:GetWide() - 10, SCRH - self.Inventory.ClothingObject:GetTall() - 100);
	self.Inventory.EquipmentObject:SetDraggable(false);
	self.Inventory.EquipmentObject:SetTitle("");
	self.Inventory.EquipmentObject:ShowCloseButton(false);
	self.Inventory.EquipmentObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("Equipment", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		local posX = 5;
		local posY = 25;
		for index, slot in pairs(slots) do
			draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));
			posX = posX + 55;
		end
	end

	local posX = 5;
	local posY = 25;
	local weps = LocalPlayer():GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	for index, slot in pairs(slots) do
		self.Inventory.EquipmentGrid[index] = vgui.Create("BASHInventoryObj", self.Inventory.EquipmentObject);
		self.Inventory.EquipmentGrid[index]:SetPos(posX, posY);
		self.Inventory.EquipmentGrid[index]:SetSize(50, 50);
		self.Inventory.EquipmentGrid[index].InvX = index;
		self.Inventory.EquipmentGrid[index].SlotType = slot;
		self.Inventory.EquipmentGrid[index].HoverString = slot;
		self.Inventory.EquipmentGrid[index].PaintOver = function(self, w, h)
			local equipment = LocalPlayer():GetEntry("Weapons");
			equipment = util.JSONToTable(equipment);
			if equipment[index] and equipment[index].ID and equipment[index].ID != "" then return end;

			if self.SlotType == "Primary" then
				surface.SetMaterial(main);
			elseif self.SlotType == "Secondary" then
				surface.SetMaterial(sec);
			else
				surface.SetMaterial(melee);
			end

			surface.SetDrawColor(color_white);
			surface.DrawTexturedRect((w / 2) - 16, (h / 2) - 16, 32, 32);

			if self.Entered then
				draw.NoTexture();
				local mX, mY = self:CursorPos();
				surface.SetFont("BASHFontHeavy");
				local w, h = surface.GetTextSize(self.HoverString);
				DisableClipping(true);
				draw.RoundedBox(0, mX - (w + 12), mY - (h + 6) - 4, w + 12, h + 6, color_black);
				draw.SimpleText(self.SlotType, "BASHFontHeavy", mX - 6, mY - (h + 6) - 1, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
				DisableClipping(false);
			end
		end
		if weps[index] and weps[index].ID and weps[index].ID != "" then
			self.Inventory.EquipmentGrid[index]:SetItem(weps[index]);
		end

		posX = posX + 55;
	end
end

function BASH:CreateStorage(ent, inv)
	self:CreateInventory();

	if self.Inventory.StoreObject and self.Inventory.StoreObject:IsValid() then
		self.Inventory.StoreObject:Remove();
		self.Inventory.StoreGrid = {};
	end

	local invID = ent:GetTable().InventoryID;
	local invObj = BASH.Inventories[invID];
	if !invObj then return end;
	local invStore = util.JSONToTable(inv);

	self.Inventory.StoreObject = vgui.Create("BASHPanel");
	self.Inventory.StoreObject.InvType = INV_STORE;
	self.Inventory.StoreObject.Inventory = inv;
	self.Inventory.StoreObject.Ent = ent;
	self.Inventory.StoreObject:SetSize(10 + (50 * invObj.SizeX) + (5 * (invObj.SizeX - 1)), 50 + (50 * invObj.SizeY) + (5 * (invObj.SizeY - 1)));
	self.Inventory.StoreObject:Center();
	self.Inventory.StoreObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText(invObj.Name, "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		local posX = 5;
		local posY = 25;
		for invY = 1, invObj.SizeY do
			for invX = 1, invObj.SizeX do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));

				posX = posX + 55;
			end

			posX = 5;
			posY = posY + 55;
		end
	end

	local posX = 5;
	local posY = 25;
	for invX = 1, invObj.SizeX do
		self.Inventory.StoreGrid[invX] = {};
		for invY = 1, invObj.SizeY do
			self.Inventory.StoreGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.StoreObject);
			self.Inventory.StoreGrid[invX][invY].InvX = invX;
			self.Inventory.StoreGrid[invX][invY].InvY = invY;
			self.Inventory.StoreGrid[invX][invY]:SetPos(posX, posY);
			self.Inventory.StoreGrid[invX][invY]:SetSize(50, 50);

			if invStore.Content[invX][invY].ID then
				self.Inventory.StoreGrid[invX][invY]:SetItem(invStore.Content[invX][invY]);
			end

			posY = posY + 55;
		end

		posX = posX + 55;
		posY = 25;
	end
	self.Inventory.StoreObject.UpdateInventory = function(self)
		BASH:RefreshInventory();
		local newInv = self.Inventory;

		netstream.Start("BASH_Update_Storage", {self.Ent, newInv, false});
	end

	surface.SetFont("BASHFontSmall");
	local closeX, _ = surface.GetTextSize("Close");

	self.Inventory.StoreObject.CloseButton = self:CreateTextButton("Close", "BASHFontSmall", self.Inventory.StoreObject:GetWide() - closeX - 22, self.Inventory.StoreObject:GetTall() - 22, self.Inventory.StoreObject);
	self.Inventory.StoreObject.CloseButton.Action = function()
		local newInv = self.Inventory.StoreObject.Inventory;
		local ent = self.Inventory.StoreObject.Ent;
		self.Inventory.StoreObject:Remove();
		self.Inventory.StoreGrid = {};

		netstream.Start("BASH_Update_Storage", {ent, newInv, true});
	end
end

function BASH:RefreshInventory()
	if !self.Inventory.Open then return end;

	CloseDermaMenus();
	self:ClearInventoryGUI();

	local invMain = LocalPlayer():GetEntry("InvMain");
	invMain = util.JSONToTable(invMain);
	local posX = 5;
	local posY = 25;
	for invX = 1, #invMain.Content do
		self.Inventory.MainGrid[invX] = {};
		for invY = 1, #invMain.Content[1] do
			self.Inventory.MainGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.MainObject);
			self.Inventory.MainGrid[invX][invY].InvX = invX;
			self.Inventory.MainGrid[invX][invY].InvY = invY;
			self.Inventory.MainGrid[invX][invY]:SetPos(posX, posY);
			self.Inventory.MainGrid[invX][invY]:SetSize(50, 50);

			if invMain.Content[invX][invY].ID then
				self.Inventory.MainGrid[invX][invY]:SetItem(invMain.Content[invX][invY]);
			end

			posY = posY + 55;
		end

		posX = posX + 55;
		posY = 25;
	end

	if self.Inventory.SecObject and self.Inventory.SecObject:IsValid() then
		local invSec = LocalPlayer():GetEntry("InvSec");
		invSec = util.JSONToTable(invSec);
		local posX = 5;
		local posY = 25;
		for invX = 1, #invSec.Content do
			self.Inventory.SecGrid[invX] = {};
			for invY = 1, #invSec.Content[1] do
				self.Inventory.SecGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.SecObject);
				self.Inventory.SecGrid[invX][invY].InvX = invX;
				self.Inventory.SecGrid[invX][invY].InvY = invY;
				self.Inventory.SecGrid[invX][invY]:SetPos(posX, posY);
				self.Inventory.SecGrid[invX][invY]:SetSize(50, 50);

				if invSec.Content[invX][invY].ID then
					self.Inventory.SecGrid[invX][invY]:SetItem(invSec.Content[invX][invY]);
				end

				posY = posY + 55;
			end

			posX = posX + 55;
			posY = 25;
		end
	end

	if self.Inventory.AccObject and self.Inventory.AccObject:IsValid() then
		local invAcc = LocalPlayer():GetEntry("InvAcc");
		invAcc = util.JSONToTable(invAcc);
		local posX = 5;
		local posY = 25;
		for invX = 1, #invAcc.Content do
			self.Inventory.AccGrid[invX] = {};
			for invY = 1, #invAcc.Content[1] do
				self.Inventory.AccGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.AccObject);
				self.Inventory.AccGrid[invX][invY].InvX = invX;
				self.Inventory.AccGrid[invX][invY].InvY = invY;
				self.Inventory.AccGrid[invX][invY]:SetPos(posX, posY);
				self.Inventory.AccGrid[invX][invY]:SetSize(50, 50);

				if invAcc.Content[invX][invY].ID then
					self.Inventory.AccGrid[invX][invY]:SetItem(invAcc.Content[invX][invY]);
				end

				posY = posY + 55;
			end

			posX = posX + 55;
			posY = 25;
		end
	end

	if self.Inventory.StoreObject and self.Inventory.StoreObject:IsValid() then
		local invStore = util.JSONToTable(self.Inventory.StoreObject.Inventory);
		local posX = 5;
		local posY = 25;
		for invX = 1, #invStore.Content do
			self.Inventory.StoreGrid[invX] = {};
			for invY = 1, #invStore.Content[1] do
				self.Inventory.StoreGrid[invX][invY] = vgui.Create("BASHInventoryObj", self.Inventory.StoreObject);
				self.Inventory.StoreGrid[invX][invY].InvX = invX;
				self.Inventory.StoreGrid[invX][invY].InvY = invY;
				self.Inventory.StoreGrid[invX][invY]:SetPos(posX, posY);
				self.Inventory.StoreGrid[invX][invY]:SetSize(50, 50);

				if invStore.Content[invX][invY].ID then
					self.Inventory.StoreGrid[invX][invY]:SetItem(invStore.Content[invX][invY]);
				end

				posY = posY + 55;
			end

			posX = posX + 55;
			posY = 25;
		end
	end

	if self.Inventory.ClothingObject and self.Inventory.ClothingObject:IsValid() then
		local farX = self:GetWidestInventory();
		self.Inventory.ClothingObject:SetSize(280, 135);
		self.Inventory.ClothingObject:SetPos(SCRW - 10 - farX - self.Inventory.ClothingObject:GetWide() - 10, SCRH - 145);

		local invClo = LocalPlayer():GetEntry("Clothing");
		invClo = util.JSONToTable(invClo);
		local posX = 5;
		local posY = 25;
		for index, bodyPart in pairs(BODY_PARTS) do
			if index % 6 == 0 then
				posX = 5;
				posY = posY + 55;
			end
			self.Inventory.ClothingGrid[index] = vgui.Create("BASHInventoryObj", self.Inventory.ClothingObject);
			self.Inventory.ClothingGrid[index]:SetPos(posX, posY);
			self.Inventory.ClothingGrid[index]:SetSize(50, 50);
			self.Inventory.ClothingGrid[index].BodyPart = bodyPart;
			self.Inventory.ClothingGrid[index].PaintOver = function(self, w, h)
				local clothing = LocalPlayer():GetEntry("Clothing");
				clothing = util.JSONToTable(clothing);
				if clothing[bodyPart] and clothing[bodyPart] != "" then return end;

				draw.SimpleText(bodyPart, "BASHFontSmall", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
			if invClo[bodyPart] and invClo[bodyPart] != "" then
				local data = {};
				data.ID = invClo[bodyPart];
				self.Inventory.ClothingGrid[index]:SetItem(data);
			end

			posX = posX + 55;
		end
	end

	if self.Inventory.EquipmentObject and self.Inventory.EquipmentObject:IsValid() then
		local slots = {};
		local index = 1;
		for slot, _ in pairs(EQUIP_PARTS) do slots[index] = slot index = index + 1 end;
		local suit = LocalPlayer():GetEntry("Suit");
		suit, _ = ParseDouble(suit);
		index = table.Count(slots) + 1;
		if suit != "" then
			local suitData = BASH.Items[suit];
			for _, slot in pairs(suitData.EquipSlots) do
				slots[index] = slot;
				index = index + 1;
			end
		end
		local accessory = LocalPlayer():GetEntry("Acc");
		local acc, cond = ParseDouble(accessory);
		index = table.Count(slots) + 1;
		if acc != "" then
			local accData = BASH.Items[acc];
			for _, slot in pairs(accData.EquipSlots) do
				slots[index] = slot;
				index = index + 1;
			end
		end
		table.sort(slots, function(a, b) return EQUIP_PARTS[a] < EQUIP_PARTS[b] end);

		local farX = self:GetWidestInventory();
		self.Inventory.EquipmentObject:SetSize(10 + (#slots * 50) + ((#slots - 1) * 5), 80);
		self.Inventory.EquipmentObject:SetPos(SCRW - 10 - farX - self.Inventory.EquipmentObject:GetWide() - 10, SCRH - self.Inventory.ClothingObject:GetTall() - 100);
		self.Inventory.EquipmentObject.Paint = function(self, w, h)
			draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
			draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
			draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
			draw.SimpleText("Equipment", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

			local posX = 5;
			local posY = 25;
			for index, slot in pairs(slots) do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));
				posX = posX + 55;
			end
		end

		local posX = 5;
		local posY = 25;
		local weps = LocalPlayer():GetEntry("Weapons");
		weps = util.JSONToTable(weps);
		for index, slot in pairs(slots) do
			self.Inventory.EquipmentGrid[index] = vgui.Create("BASHInventoryObj", self.Inventory.EquipmentObject);
			self.Inventory.EquipmentGrid[index]:SetPos(posX, posY);
			self.Inventory.EquipmentGrid[index]:SetSize(50, 50);
			self.Inventory.EquipmentGrid[index].InvX = index;
			self.Inventory.EquipmentGrid[index].SlotType = slot;
			self.Inventory.EquipmentGrid[index].PaintOver = function(self, w, h)
				local equipment = LocalPlayer():GetEntry("Weapons");
				equipment = util.JSONToTable(equipment);
				if equipment[index] and equipment[index].ID and equipment[index].ID != "" then return end;

				if self.SlotType == "Primary" then
					surface.SetMaterial(main);
				elseif self.SlotType == "Secondary" then
					surface.SetMaterial(sec);
				else
					surface.SetMaterial(melee);
				end

				surface.SetDrawColor(color_white);
				surface.DrawTexturedRect((w / 2) - 16, (h / 2) - 16, 32, 32);

				if self.Entered then
					draw.NoTexture();
					local mX, mY = self:CursorPos();
					surface.SetFont("BASHFontHeavy");
					local w, h = surface.GetTextSize(self.HoverString);
					DisableClipping(true);
					draw.RoundedBox(0, mX - (w + 12), mY - (h + 6) - 4, w + 12, h + 6, color_black);
					draw.SimpleText(self.SlotType, "BASHFontHeavy", mX - 6, mY - (h + 6) - 1, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
					DisableClipping(false);
				end
			end
			if weps[index] and weps[index].ID and weps[index].ID != "" then
				self.Inventory.EquipmentGrid[index]:SetItem(weps[index]);
			end

			posX = posX + 55;
		end
	end

	hook.Call("OnInventoryRefresh", self);
end

netstream.Hook("BASH_Refresh_Inventory", function(data)
	BASH:RefreshInventory();
end);

netstream.Hook("BASH_Wear_Item_Return", function(data)
	if BASH.Inventory.Open then
		if data == "Suit" then
			BASH:CreateSecInventory();

			if BASH.Inventory.AccObject and BASH.Inventory.AccObject:IsValid() then
				local accX, _ = BASH.Inventory.AccObject:GetPos();
				local _, secY = BASH.Inventory.SecObject:GetPos();
				BASH.Inventory.AccObject:SetPos(accX, secY - BASH.Inventory.AccObject:GetTall() - 10);
			end
		elseif data == "Acc" then
			BASH:CreateAccInventory();
		end
	end

	BASH:RefreshInventory();
end);

netstream.Hook("BASH_Remove_Item_Return", function(data)
	if BASH.Inventory.Open then
		if data == "Suit" then
			BASH.Inventory.SecObject:Remove();
			BASH.Inventory.SecObject = nil;

			if BASH.Inventory.AccObject and BASH.Inventory.AccObject:IsValid() then
				local accX, accY = BASH.Inventory.AccObject:GetPos();
				BASH.Inventory.AccObject:SetPos(accX, SCRH - BASH.Inventory.MainObject:GetTall() - BASH.Inventory.AccObject:GetTall() - 20);
			end
		elseif data == "Acc" then
			BASH.Inventory.AccObject:Remove();
			BASH.Inventory.AccObject = nil;
		end
	end

	BASH:RefreshInventory();
end);

netstream.Hook("BASH_Request_Storage_Return", function(data)
	if !data then return end;

	local ent = data[1];
	local inv = data[2];
	BASH:CreateStorage(ent, inv);
end);
