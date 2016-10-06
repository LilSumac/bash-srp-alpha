local BASH = BASH;
local OBJ = {};

function OBJ:Init()
	self.Inv = self:GetParent().InvType;
	self.InvX = nil;
	self.InvY = nil;
	self.Entered = false;
	self.Dragging = false;
	LocalPlayer().Dragging = false;
	self.EntData = nil;
	self.ItemData = nil;
	self.View = nil;
	self.Hover = nil;
	self.Drag = nil;
	self.OverrideModel = nil;
	self.HoverString = "";
end

function OBJ:Think()
	if !self.ItemData or !self.EntData then return end;

	if self.Dragging then
		if !input.IsMouseDown(MOUSE_LEFT) then
			self.Dragging = false;
			LocalPlayer().Dragging = false;
			return;
		end

		if !self.Drag then
			self.Drag = vgui.Create("BASHInventoryDrag");
			local mouseX, mouseY = gui.MousePos();
			self.Drag.Home = self;
			self.Drag:SetPos(mouseX + 10, mouseY + 10);
			self.Drag:SetSize(50, 50);
			self.Drag:SetViewModel(self.OverrideModel or self.ItemData.WorldModel, self.ItemData.ModelColor);
		end
	else
		if self.Drag and self.Drag:IsValid() then
			local data = {
				FromInv = self.Inv,
				X = self.InvX,
				Y = self.InvY,
				ID = self.ItemData.ID,
				EntData = self.EntData,
				Obj = self
			};
			self.Drag:DoDrop(data);
			self.Drag:Remove();
			self.Drag = nil;
		end
	end

	if self.Entered and !self.Hover and !self.Dragging and !LocalPlayer().Dragging then
		self.Hover = vgui.Create("BASHInventoryHover");
		local mouseX, mouseY = gui.MousePos();
		self.Hover.Home = self;
		self.Hover:SetPos(mouseX - 255, mouseY - 55);
		self.Hover:SetSize(250, 50);
		self.Hover:SetInfo(self.EntData);
	elseif !self.Entered and self.Hover and self.Hover:IsValid() then
		self.Hover:Remove();
		self.Hover = nil;
	end

	local posX, posY = self:CursorPos();
	if posX < 0 or posX > 50 or posY < 0 or posY > 50 then
		self.Entered = false;
		if self.Hover and self.Hover:IsValid() then
			self.Hover:Remove();
			self.Hover = nil;
		end
	end
end

function OBJ:Paint(w, h)
	local bgColor = color_black;
	if self.Entered then bgColor = color_white end;
	draw.RoundedBox(4, 0, 0, w, h, bgColor);
	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));

	if !self.Hover and self.Entered and self.HoverString != "" then
		draw.NoTexture();
		local mX, mY = self:CursorPos();
		surface.SetFont("BASHFontHeavy");
		local w, h = surface.GetTextSize(self.HoverString);
		DisableClipping(true);
		draw.RoundedBox(0, mX - (w + 12), mY - (h + 6) - 4, w + 12, h + 6, color_black);
		draw.SimpleText(self.HoverString, "BASHFontHeavy", mX - 6, mY - (h + 6) - 1, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
		DisableClipping(false);
	end
end;

function OBJ:OnCursorEntered() self.Entered = true end;
function OBJ:OnCursorExited()
	self.Entered = false;

	if self.Hover and self.Hover:IsValid() then
		self.Hover:Remove();
	end
end

function OBJ:OnRemove()
	if self.Hover and self.Hover:IsValid() then
		self.Hover:Remove();
	end

	if self.Drag and self.Drag:IsValid() then
		self.Drag:Remove();
	end
end;

function OBJ:SetItem(entData)
	if !entData or !entData.ID then
		self.EntData = nil;
		self.ItemData = nil;

		if self.View and self.View:IsValid() then
			self.View:Remove();
			self.View = nil;
		end
		if self.Hover and self.Hover:IsValid() then
			self.Hover:Remove();
			self.Hover = nil;
		end
		if self.Drag and self.Drag:IsValid() then
			self.Drag:Remove();
			self.Drag = nil;
		end
		return;
	end

	local itemID = entData.ID;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;

	self.EntData = entData;
	self.ItemData = itemData;

	self.View = vgui.Create("BASHInventoryView", self);
	self.View:SetSize(50, 50);
	self.View:SetPos(0, 0);
	if istable(self.ItemData.WorldModel) then
		self.OverrideModel = table.Random(self.ItemData.WorldModel);
		self.View:SetViewModel(self.OverrideModel, self.ItemData.ModelColor);
	else
		self.View:SetViewModel(self.ItemData.WorldModel, self.ItemData.ModelColor);
	end
	self.View.OnMousePressed = function(self, mouse)
		if mouse == MOUSE_LEFT and !self:GetParent().Dragging then
			self:GetParent().Dragging = true;
			LocalPlayer().Dragging = true;
		elseif mouse == MOUSE_RIGHT then
			if self:GetParent().Inv > 4 then return end;
			self:GetParent():DoRightClick();
		end
	end

	if self.EntData.Inventory then
		local invTab = self.EntData.Inventory;
		if !BASH:InventoryIsEmpty(invTab.Content) then
			self.View.PaintInv = true;
		end
	end

	if self.EntData.Stacks and self.ItemData.IsStackable then
		self.View.PaintStack = true;
	end
end

function OBJ:DoRightClick()
	local options = DermaMenu();

	hook.Call("AddRightClickOptions", BASH, self, options);

	if self.ItemData.IsSuit then
		options:AddOption("Wear", function()
			if LocalPlayer():GetEntry("Suit") != "" then
				BASH:CreateNotif("You're already wearing a suit!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			elseif self.ItemData.NoClothing and LocalPlayer():HasClothing() then
				BASH:CreateNotif("You must remove your excess clothing to wear this suit!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			else
				netstream.Start("BASH_Wear_Suit", {self.EntData, self.Inv, self.InvX, self.InvY});
			end
		end):SetImage("icon16/user_gray.png");
		if LocalPlayer():IsTechnician() and self.EntData.Condition != 100 and self.EntData.Condition > 10 and self.Inv < 4 then
			options:AddOption("Repair (" .. math.floor(self.ItemData.DefaultPrice - ((self.EntData.Condition / 100) * self.ItemData.DefaultPrice)) .. " ru / " .. math.ceil((self.ItemData.MetalYield * 2) * ((100 - self.EntData.Condition) / 100)) .. " metal / " .. math.ceil((self.ItemData.FabricYield * 2) * ((100 - self.EntData.Condition) / 100)) .. " fabric)", function()
				local inv = self.Inv;
				local invString = "";
				if inv == INV_MAIN then
					invString = "InvMain";
				elseif inv == INV_SEC then
					invString = "InvSec";
				elseif inv == INV_ACC then
					invString = "InvAcc";
				elseif inv == INV_STORE then
					invString = "Storage";
				else return end;
				netstream.Start("BASH_Repair_Item", {invString, self.InvX, self.InvY});
			end):SetImage("icon16/wrench.png");
		end
		if LocalPlayer():IsTechnician() and self.EntData.Condition > 10 and self.ItemData.Upgradeable then
			for index, upgrade in pairs(self.ItemData.Upgrades) do
				local newItem = BASH.Items[upgrade[1]];
				if !newItem then continue end;

				local upgString = "Upgrade to " .. newItem.Name .. " (" .. self.ItemData.Name .. " / " .. upgrade[2] .. " ru / " .. upgrade[3]["fabric"] .. " fabric";
				if upgrade[4] then
					for ind, part in pairs(upgrade[4]) do
						local newPart = BASH.Items[part];
						if !newPart then continue end;
						upgString = upgString .. ((ind == 1 and " / ") or "") .. newPart.Name .. ((ind == #upgrade[4] and "") or ", ");
					end
				end
				upgString = upgString .. ")";

				options:AddOption(upgString, function()
					local inv = self.Inv;
					local invString = "";
					if inv == INV_MAIN then
						invString = "InvMain";
					elseif inv == INV_SEC then
						invString = "InvSec";
					elseif inv == INV_ACC then
						invString = "InvAcc";
					elseif inv == INV_STORE then
						invString = "Storage";
					else return end;
					netstream.Start("BASH_Upgrade_Item", {invString, self.InvX, self.InvY, index});
				end):SetImage("icon16/wrench_orange.png");
			end
		end
	elseif self.ItemData.IsWeapon then
		if LocalPlayer():IsTechnician() and self.EntData.Condition != 100 and self.EntData.Condition > 10 and self.Inv < 4 then
			options:AddOption("Repair (" .. math.floor(self.ItemData.DefaultPrice - ((self.EntData.Condition / 100) * self.ItemData.DefaultPrice)) .. " ru / " .. math.ceil((self.ItemData.MetalYield * 2) * ((100 - self.EntData.Condition) / 100)) .. " metal / " .. math.ceil((self.ItemData.FabricYield * 2) * ((100 - self.EntData.Condition) / 100)) .. " fabric)", function()
				local inv = self.Inv;
				local invString = "";
				if inv == INV_MAIN then
					invString = "InvMain";
				elseif inv == INV_SEC then
					invString = "InvSec";
				elseif inv == INV_ACC then
					invString = "InvAcc";
				elseif inv == INV_STORE then
					invString = "Storage";
				else return end;
				netstream.Start("BASH_Repair_Item", {invString, self.InvX, self.InvY});
			end):SetImage("icon16/wrench.png");
		end
		if LocalPlayer():IsTechnician() and self.EntData.Condition > 10 and self.ItemData.Upgradeable then
			for index, upgrade in pairs(self.ItemData.Upgrades) do
				local newItem = BASH.Items[upgrade[1]];
				if !newItem then continue end;

				local upgString = "Upgrade to " .. newItem.Name .. " (" .. self.ItemData.Name .. " / " .. upgrade[2] .. " ru / " .. upgrade[3]["metal"] .. " metal";
				if upgrade[4] then
					for ind, part in pairs(upgrade[4]) do
						local newPart = BASH.Items[part];
						if !newPart then continue end;
						upgString = upgString .. ((ind == 1 and " / ") or "") .. newPart.Name .. ((ind == #upgrade[4] and "") or ", ");
					end
				end
				upgString = upgString .. ")";

				options:AddOption(upgString, function()
					local inv = self.Inv;
					local invString = "";
					if inv == INV_MAIN then
						invString = "InvMain";
					elseif inv == INV_SEC then
						invString = "InvSec";
					elseif inv == INV_ACC then
						invString = "InvAcc";
					elseif inv == INV_STORE then
						invString = "Storage";
					else return end;
					netstream.Start("BASH_Upgrade_Item", {invString, self.InvX, self.InvY, index});
				end):SetImage("icon16/wrench_orange.png");
			end
		end

		if table.Count(self.ItemData.IncludedAttachments) > 0 then
			for slot, att in pairs(self.ItemData.IncludedAttachments) do
				local atts;
				if istable(self.EntData.Attachments) then
					atts = self.EntData.Attachments;
				elseif isstring(self.EntData.Attachments) then
					atts = util.JSONToTable(self.EntData.Attachments or "[]") or {};
				end
				if !atts then break end;

				if !atts[slot] or atts[slot] == "" then
					local attData = BASH:FindAttByID(att);
					if attData then
						options:AddOption("Attach " .. attData.Name, function()
							local inv = self.Inv;
							local invString = "";
							if inv == INV_MAIN then
								invString = "InvMain";
							elseif inv == INV_SEC then
								invString = "InvSec";
							elseif inv == INV_ACC then
								invString = "InvAcc";
							else return end;

							local invData = util.JSONToTable(LocalPlayer():GetEntry(invString));
							invData.Content[self.InvX][self.InvY].Attachments[slot] = att;
							LocalPlayer():UpdateEntry(invString, util.TableToJSON(invData));
							surface.PlaySound("cw/switch2.wav");
						end):SetImage("icon16/wrench_orange.png");
					end
				end
			end
		end

		if self.EntData.Attachments then
			local atts;
			if istable(self.EntData.Attachments) then
				atts = self.EntData.Attachments;
			else
				atts = util.JSONToTable(self.EntData.Attachments or "[]") or {};
			end

			for slot, att in pairs(atts) do
				local attData = BASH:FindAttByID((istable(att) and att.ent) or att);
				if !LocalPlayer():IsTechnician() and attData.RequiresTech then return end;

				options:AddOption("Remove " .. attData.Name, function()
					local inv = self.Inv;
					local invString = "";
					if inv == INV_MAIN then
						invString = "InvMain";
					elseif inv == INV_SEC then
						invString = "InvSec";
					elseif inv == INV_ACC then
						invString = "InvAcc";
					elseif inv == INV_STORE then
						invString = "Storage";
					else return end;
					netstream.Start("BASH_Remove_Attachment", {invString, self.InvX, self.InvY, slot, ((istable(att) and att.ent) or att), (istable(att) and att.col)});
				end):SetImage("icon16/wrench_orange.png");
			end
		end

		if self.EntData.Ammo > 0 then
			options:AddOption("Unload (" .. self.EntData.Ammo .. " rounds)", function()
				local inv = self.Inv;
				local invString = "";
				if inv == INV_MAIN then
					invString = "InvMain";
				elseif inv == INV_SEC then
					invString = "InvSec";
				elseif inv == INV_ACC then
					invString = "InvAcc";
				elseif inv == INV_STORE then
					invString = "Storage";
				else return end;
				netstream.Start("BASH_Unload_Weapon", {invString, self.InvX, self.InvY});
			end):SetImage("icon16/arrow_redo.png");
		end
	elseif self.ItemData.IsConditional then
		if LocalPlayer():IsTechnician() and self.EntData.Condition != 100 and self.EntData.Condition > 10 and self.Inv < 4 then
			options:AddOption("Repair (" .. math.floor(self.ItemData.DefaultPrice - ((self.EntData.Condition / 100) * self.ItemData.DefaultPrice)) .. " ru / " .. math.ceil((self.ItemData.MetalYield * 2) * ((100 - self.EntData.Condition) / 100)) .. "metal / " .. math.ceil((self.ItemData.FabricYield * 2) * ((100 - self.EntData.Condition) / 100)) .. " fabric)", function()
				local inv = self.Inv;
				local invString = "";
				if inv == INV_MAIN then
					invString = "InvMain";
				elseif inv == INV_SEC then
					invString = "InvSec";
				elseif inv == INV_ACC then
					invString = "InvAcc";
				elseif inv == INV_STORE then
					invString = "Storage";
				else return end;
				netstream.Start("BASH_Repair_Item", {invString, self.InvX, self.InvY});
			end):SetImage("icon16/wrench.png");
		end
	elseif self.ItemData.IsAccessory then
		options:AddOption("Wear", function()
			if LocalPlayer():GetEntry("Acc") != "" then
				BASH:CreateNotif("You're already wearing an accessory!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			elseif self.ItemData.NoClothing and LocalPlayer():HasClothing(self.ItemData.BodyPos) then
				BASH:CreateNotif("You must remove your '" .. self.ItemData.BodyPos .. "' article to wear this accessory!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			else
				netstream.Start("BASH_Wear_Acc", {self.EntData, self.Inv, self.InvX, self.InvY});
			end
		end):SetImage("icon16/user_gray.png");
	elseif self.ItemData.IsWritable then
		options:AddOption("Read", function()
			BASH:CloseInventory();
			netstream.Start("BASH_Request_Writing", self.EntData);
		end):SetImage("icon16/book_open.png");
	elseif self.ItemData.IsConsumable then
		options:AddOption(self.ItemData.ConsumeString, function()
			netstream.Start("BASH_Consume_Item", {self.ItemData.ConsumeVariable, self.ItemData.ConsumeEffect, self.ItemData.ID, self.Inv, self.InvX, self.InvY});
		end):SetImage(self.ItemData.ConsumeIcon);
	end

	if self.ItemData.IsStackable then
		if self.EntData.Stacks > 1 then
			options:AddOption("Drop One", function()
				local data = {
					FromInv = self.Inv,
					X = self.InvX,
					Y = self.InvY,
					ID = self.ItemData.ID,
					EntData = self.EntData
				};
				netstream.Start("BASH_Drop_Item", {data, 1});
			end):SetImage("icon16/arrow_down.png");

			options:AddOption("Drop Amount", function()
				Derma_StringRequest("Drop Amount", "How many would you like to drop? Range: 1 - " .. self.EntData.Stacks .. ".", "",
						function(text)
							local dropNum = tonumber(text);
							if !dropNum or dropNum < 0 then
								BASH:CreateNotif("Invalid drop input!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
								return;
							end

							local data = {
								FromInv = self.Inv,
								X = self.InvX,
								Y = self.InvY,
								ID = self.ItemData.ID,
								EntData = self.EntData
							};

							netstream.Start("BASH_Drop_Item", {data, math.min(dropNum, self.EntData.Stacks)});
						end,
						function() end,
						"Drop");
			end):SetImage("icon16/arrow_down.png");
		end

		options:AddOption("Drop All", function()
			local data = {
				FromInv = self.Inv,
				X = self.InvX,
				Y = self.InvY,
				ID = self.ItemData.ID,
				EntData = self.EntData
			};
			netstream.Start("BASH_Drop_Item", {data});
		end):SetImage("icon16/arrow_down.png");

		if self.EntData.Stacks > 1 then
			options:AddOption("Split Stack", function()
				Derma_StringRequest("Split Amount", "How many would you like to split away? Range: 1 - " .. self.EntData.Stacks - 1 .. ".", "",
						function(text)
							local splitNum = tonumber(text);
							if !splitNum or splitNum < 0 then
								BASH:CreateNotif("Invalid drop input!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
								return;
							end

							local data = {
								FromInv = self.Inv,
								X = self.InvX,
								Y = self.InvY,
								ID = self.ItemData.ID,
								EntData = self.EntData
							};

							netstream.Start("BASH_Divide_Item", {data, math.min(splitNum, self.EntData.Stacks - 1)});
						end,
						function() end,
						"Split");
			end):SetImage("icon16/arrow_divide.png");
		end

		if self.ItemData.ID == "money" then
			options:AddOption("Claim", function()
				local inv;
				local invString;
				if self.Inv == INV_MAIN then
					inv = LocalPlayer():GetEntry("InvMain");
					invString = "InvMain";
				elseif self.Inv == INV_SEC then
					inv = LocalPlayer():GetEntry("InvSec");
					invString = "InvSec";
				elseif self.Inv == INV_ACC then
					inv = LocalPlayer():GetEntry("InvAcc");
					invString = "InvAcc";
				elseif self.Inv == INV_STORE then
					netstream.Start("BASH_Claim_Money_Storage", {self.InvX, self.InvY});
					return;
				else return end;
				inv = util.JSONToTable(inv);
				local money = inv.Content[self.InvX][self.InvY].Stacks;
				inv.Content[self.InvX][self.InvY] = {};
				inv = util.TableToJSON(inv);
				LocalPlayer():UpdateEntry(invString, inv);
				netstream.Start("BASH_Claim_Money", money);
			end):SetImage("icon16/money_add.png");

			options:AddOption("Drop", function()
				local data = {
					FromInv = self.Inv,
					X = self.InvX,
					Y = self.InvY,
					ID = self.ItemData.ID,
					EntData = self.EntData
				};
				netstream.Start("BASH_Drop_Item", {data});
			end):SetImage("icon16/arrow_down.png");
		end
	elseif self.ItemData.ID == "radio_handheld" then
		options:AddOption("Set Frequency", function()
			Derma_StringRequest("Radio Frequency", "What do you want your frequency to be? Range: 88 - 108 (One decimal place allowed).", "",
					function(text)
						local freq = tonumber(text);
						if !freq or freq < 88 or freq > 108 then
							BASH:CreateNotif("Invalid frequency!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
							return;
						end

						local decimal = math.Round(freq % math.floor(freq), 5);
						if decimal != 0 then
							local str = tostring(decimal);
							if string.len(str) > 3 then
								BASH:CreateNotif("Invalid frequency!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
								return;
							end
						end

						LocalPlayer():UpdateEntry("Frequency", freq);
						BASH:CreateNotif("Frequency set to " .. freq .. ".", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
					end,
					function() end,
					"Set Frequency");
		end):SetImage("icon16/transmit_edit.png");

		options:AddOption("Drop", function()
			local data = {
				FromInv = self.Inv,
				X = self.InvX,
				Y = self.InvY,
				ID = self.ItemData.ID,
				EntData = self.EntData
			};
			netstream.Start("BASH_Drop_Item", {data});
		end):SetImage("icon16/arrow_down.png");
	else
		options:AddOption("Drop", function()
			local data = {
				FromInv = self.Inv,
				X = self.InvX,
				Y = self.InvY,
				ID = self.ItemData.ID,
				EntData = self.EntData
			};
			netstream.Start("BASH_Drop_Item", {data});
		end):SetImage("icon16/arrow_down.png");
	end
	options:AddSpacer();
	options:AddOption("Close"):SetImage("icon16/delete.png");
	options:Open();
end

vgui.Register("BASHInventoryObj", OBJ, "Panel");

local HOVER = {};

function HOVER:Init()
	self.ItemData = nil;
	self.EntData = nil;
	self.Preview = nil;
	self.Name = nil;
	self.Cond = nil;
	self.Desc = nil;
	self.Flavor = nil;
	self.Weight = nil;
end

function HOVER:Think()
	local mouseX, mouseY = gui.MousePos();
	local sizeX, sizeY = self:GetSize();
	self:SetPos(mouseX - sizeX - 5, mouseY - sizeY - 5);
end

function HOVER:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h, color_black);
	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
end

function HOVER:OnCursorEntered()
	self:GetParent().Entered = false;
end

function HOVER:SetInfo(entData)
	if !entData then return end;

	local itemID = entData.ID;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;

	self.EntData = entData;
	self.ItemData = itemData;
	self:Reformat();
end

function HOVER:Reformat()
	local data = self.ItemData;
	local newHeight = 0;

	local rarityColor = color_white;
	if data.Tier == 2 then
		rarityColor = Color(0, 200, 0);
	elseif data.Tier == 3 then
		rarityColor = Color(0, 80, 200);
	elseif data.Tier == 4 then
		rarityColor = Color(127, 0, 200);
	elseif data.Tier == 5 then
		rarityColor = Color(255, 128, 0);
	end

	local conditionColor = Color(0, 255, 0);
	if data.IsConditional then
		local hue = math.floor(self.EntData.Condition * 120 / 100);
		conditionColor = HSVToColor(hue, 0.9, 0.9);
	end

	self.Preview = vgui.Create("BASHInventoryView", self);
	self.Preview:SetSize(60, 60);
	self.Preview:SetPos(5, 5);
	self.Preview:SetViewModel(self.Home.OverrideModel or data.WorldModel, self.Home.ItemData.ModelColor);
	self.Preview.OnCursorEntered = function() end;
	self.Preview.OnCursorExited = function() end;

	self.Name = vgui.Create("DLabel", self);
	self.Name:SetPos(70, 5);
	self.Name:SetFont("BASHFontHeavy");
	self.Name:SetText(data.Name);
	self.Name:SetTextColor(rarityColor);
	self.Name:SizeToContents();

	if data.IsConditional then
		self.Cond = vgui.Create("DLabel", self);
		self.Cond:SetPos(self.Name:GetWide() + 75, 5);
		self.Cond:SetFont("BASHFontHeavy");
		self.Cond:SetText("[" .. self.EntData.Condition .. "%]");
		self.Cond:SetTextColor(conditionColor);
		self.Cond:SizeToContents();
	end

	self.Desc = vgui.Create("DLabel", self);
	self.Desc:SetPos(70, 20);
	self.Desc:SetFont("BASHFontLight");
	self.Desc:SetText(FormatString(data.Description, "BASHFontLight", 175));
	self.Desc:SizeToContents();

	self.Flavor = vgui.Create("DLabel", self);
	self.Flavor:SetPos(70, self.Name:GetTall() + self.Desc:GetTall() + 10);
	self.Flavor:SetFont("BASHFontFlavor");
	self.Flavor:SetText(FormatString(data.FlavorText, "BASHFontFlavor", 170));
	self.Flavor:SizeToContents();

	local weight = self.ItemData.Weight * (self.EntData.Stacks or 1);
	if self.EntData.Inventory and self.EntData.Inventory != "" and self.EntData.Inventory != "[]" then
		local itemInvTab = self.EntData.Inventory;
		for invX = 1, #itemInvTab.Content do
			for invY = 1, #itemInvTab.Content[1] do
				weight = weight + BASH:GetMultiInvWeight(itemInvTab.Content[invX][invY]);
			end
		end
	end
	self.Weight = vgui.Create("DLabel", self);
	self.Weight:SetPos(70, self.Name:GetTall() + self.Desc:GetTall() + self.Flavor:GetTall() + 15);
	self.Weight:SetFont("BASHFontLight");
	self.Weight:SetText("Weight: " .. weight .. "kg");
	self.Weight:SizeToContents();

	local _, lastPos = self.Weight:GetPos();
	self:SetHeight(lastPos + self.Weight:GetTall() + 10);

	if data.IsSuit then
		self.Preview:SetSize(60, 140);
		self.Preview:SetModel(data.PlayerModel);
		self.Preview:SetFOV(50);
		self.Preview:SetLookAt(Vector(0, 0, 40));
		self.Preview:SetCamPos(Vector(40, 0, 50));

		//local _, lastPos = self.Flavor:GetPos();
		self:SetWidth(math.max(20 + self.Preview:GetWide() + self.Name:GetWide() + self.Cond:GetWide(), 10 + self.Preview:GetWide() + self.Desc:GetWide()));
		self:SetHeight(math.max(self.Preview:GetTall() + 10, self.Name:GetTall() + self.Desc:GetTall() + self.Weight:GetTall() + self.Flavor:GetTall() + 20));

		local mouseX, mouseY = gui.MousePos();
		local sizeX, sizeY = self:GetSize();
		self:SetPos(mouseX - sizeX - 5, mouseY - sizeY - 5);
	end
end

vgui.Register("BASHInventoryHover", HOVER, "Panel");

local VIEW = {};

function VIEW:SetViewModel(model, color)
	self:SetModel(model);
	if color != Color(255, 255, 255) then
		self:SetColor(color);
	end

	local mn, mx = self.Entity:GetRenderBounds();
	local size = 0;
	size = math.max(size, math.abs(mn.x) + math.abs(mx.x));
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y));
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z));

	self:SetFOV(45);
	self:SetCamPos(Vector(size, size, size));
	self:SetLookAt((mn + mx) * 0.5);
end

function VIEW:OnCursorEntered()
	self:GetParent().Entered = true;
end

function VIEW:OnCursorExited()
	self:GetParent().Entered = false;
end

local invIcon = Material("icon16/package_go.png", "noclamp");
function VIEW:PaintOver(w, h)
	if self.PaintInv then
		surface.SetDrawColor(color_white);
		surface.SetMaterial(invIcon);
		surface.DrawTexturedRect(5, h - 21, 16, 16);
	end

	if self.PaintStack then
		draw.SimpleText(self:GetParent().EntData.Stacks, "BASHFontSmall", w - 5, 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
	end
end

function VIEW:LayoutEntity(ent) end;

vgui.Register("BASHInventoryView", VIEW, "DModelPanel");

local DRAG = {};

function DRAG:Think()
	local mouseX, mouseY = gui.MousePos();
	self:SetPos(mouseX + 10, mouseY + 10);
end

function DRAG:DoDrop(data)
	local mouseX, mouseY = gui.MousePos();
	local mainInv = BASH.Inventory.MainObject;
	local mainX, mainY, mainW, mainH;
	if mainInv and mainInv:IsValid() then
		mainX, mainY = mainInv:GetPos();
		mainW, mainH = mainInv:GetSize();
	end;

	local secInv = BASH.Inventory.SecObject;
	local secX, secY, secW, secH;
	if secInv and secInv:IsValid() then
		secX, secY = secInv:GetPos();
		secW, secH = secInv:GetSize();
	end;

	local accInv = BASH.Inventory.AccObject;
	local accX, accY, accW, accH;
	if accInv and accInv:IsValid() then
		accX, accY = accInv:GetPos();
		accW, accH = accInv:GetSize();
	end;

	local storeInv = BASH.Inventory.StoreObject;
	local storeX, storeY, storeW, storeH;
	if storeInv and storeInv:IsValid() then
		storeX, storeY = storeInv:GetPos();
		storeW, storeH = storeInv:GetSize();
	end;

	local cloInv = BASH.Inventory.ClothingObject;
	local cloX, cloY, cloW, cloH;
	if cloInv and cloInv:IsValid() then
		cloX, cloY = cloInv:GetPos();
		cloW, cloH = cloInv:GetSize();
	end

	local equInv = BASH.Inventory.EquipmentObject;
	local equX, equY, equW, equH;
	if equInv and equInv:IsValid() then
		equX, equY = equInv:GetPos();
		equW, equH = equInv:GetSize();
	end

	local toInv;
	local toInvObj;
	local toInvGrid;
	local itemData = BASH.Items[data.ID];
	if !itemData then return end;

	if mainInv and mainInv:IsValid() and PositionIsInArea(mouseX, mouseY, mainX, mainY, mainX + mainW, mainY + mainH) then
		toInv = "InvMain";
		toInvObj = BASH.Inventory.MainObject;
		toInvGrid = BASH.Inventory.MainGrid;
	elseif secInv and secInv:IsValid() and PositionIsInArea(mouseX, mouseY, secX, secY, secX + secW, secY + secH) then
		if secInv.NoInventory then return end;
		toInv = "InvSec";
		toInvObj = BASH.Inventory.SecObject;
		toInvGrid = BASH.Inventory.SecGrid;
	elseif accInv and accInv:IsValid() and PositionIsInArea(mouseX, mouseY, accX, accY, accX + accW, accY + accH) then
		if accInv.NoInventory then return end;
		toInv = "InvAcc";
		toInvObj = BASH.Inventory.AccObject;
		toInvGrid = BASH.Inventory.AccGrid;
	elseif storeInv and storeInv:IsValid() and PositionIsInArea(mouseX, mouseY, storeX, storeY, storeX + storeW, storeY + storeH) then
		toInv = "InvStore";
		toInvObj = BASH.Inventory.StoreObject;
		toInvGrid = BASH.Inventory.StoreGrid;
	elseif cloInv and cloInv:IsValid() and PositionIsInArea(mouseX, mouseY, cloX, cloY, cloX + cloW, cloY + cloH) then
		toInv = "Clothing";
		toInvObj = BASH.Inventory.ClothingObject;
		toInvGrid = BASH.Inventory.ClothingGrid;
	elseif equInv and equInv:IsValid() and PositionIsInArea(mouseX, mouseY, equX, equY, equX + equW, equY + equH) then
		toInv = "Weapons";
		toInvObj = BASH.Inventory.EquipmentObject;
		toInvGrid = BASH.Inventory.EquipmentGrid;
	else
		toInv, toInvObj, toInvGrid = hook.Call("FindInventoryDrop", BASH, mouseX, mouseY);
	end

	if !toInv or !toInvObj then
		data.Obj = nil;					// Cannot network GUI panels! :0
		local options = DermaMenu();

		local invData = data.EntData.Inventory;
		if !invData or BASH:InventoryIsEmpty(invData.Content) then
			options:AddOption("Scrap", function()
						netstream.Start("BASH_Scrap_Item", data);
					end):SetImage("icon16/cog.png");
		end

		if !itemData.IsStackable then
			options:AddOption("Drop", function()
					netstream.Start("BASH_Drop_Item", {data});
				end):SetImage("icon16/arrow_down.png");
		else
			if data.EntData.Stacks > 1 then
				options:AddOption("Drop One", function()
						netstream.Start("BASH_Drop_Item", {data, 1});
					end):SetImage("icon16/arrow_down.png");

				options:AddOption("Drop Amount", function()
						Derma_StringRequest("Drop Amount", "How many would you like to drop? Range: 1 - " .. data.EntData.Stacks .. ".", "",
							function(text)
								local dropNum = tonumber(text);
								if !dropNum or dropNum < 0 then
									BASH:CreateNotif("Invalid drop input!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
									return;
								end

								netstream.Start("BASH_Drop_Item", {data, math.min(dropNum, data.EntData.Stacks)});
							end,
							function() end,
							"Drop");
					end):SetImage("icon16/arrow_down.png");
			end

			options:AddOption("Drop All", function()
					netstream.Start("BASH_Drop_Item", {data});
				end):SetImage("icon16/arrow_down.png");
		end
		options:AddSpacer();
		options:AddOption("Close"):SetImage("icon16/delete.png");
		options:Open();

		return;
	end

	local fromInv = data.FromInv;
	if fromInv == INV_MAIN then
		fromInv = "InvMain";
	elseif fromInv == INV_SEC then
		fromInv = "InvSec";
	elseif fromInv == INV_ACC then
		fromInv = "InvAcc";
	elseif fromInv == INV_STORE then
		fromInv = "InvStore";
	elseif fromInv == INV_CLOTHING then
		fromInv = "Clothing";
	elseif fromInv == INV_EQUIP then
		fromInv = "Weapons";
	else
		fromInv = hook.Call("FindInventoryDropHome", BASH, fromInv);
	end
	if !isstring(fromInv) then return end;

	local handled = hook.Call("HandleInventoryDrop", BASH, self, data, toInv, toInvObj, toInvGrid, fromInv);
	if handled then return end;

	mouseX, mouseY = toInvObj:CursorPos();
	local curObj, curX, curY, curW, curH;
	if toInvObj == BASH.Inventory.EquipmentObject then
		for invX = 1, #toInvGrid do
			curObj = toInvGrid[invX];
			curX, curY = curObj:GetPos();
			curW, curH = curObj:GetSize();

			if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
				if curObj == self.Home then return end;

				if fromInv == toInv then
					local invData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
					local fromItem = invData[data.X];
					local toItem = invData[invX];
					if !toItem then continue end;
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];

					local wep = fromItem.ID;
					local wepData = BASH.Items[wep];
					if !wepData or !wepData.WeaponEntity then return end;
					if wepData.SteamIDs and !wepData.SteamIDs[LocalPlayer():SteamID()] then
						LocalPlayer():PrintChat("You are not authorized to equip this!");
						return;
					end
					if !fromItemData.IsWeapon then
						LocalPlayer():PrintChat("This is not a weapon!");
						return;
					elseif fromItemData.SlotType != curObj.SlotType then
						LocalPlayer():PrintChat("That type of weapon does not go there!");
						return;
					elseif toItem and toItem.ID then
						invData[data.X] = toItem;
						invData[invX] = fromItem;
					else
						invData[data.X] = {};
						invData[invX] = fromItem;
					end

					LocalPlayer():UpdateEntry("Weapons", util.TableToJSON(invData));
				else
					local fromInvData, toInvData;
					if fromInv == "InvStore" then
						fromInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
					else
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
					end
					toInvData = LocalPlayer():GetEntry("Weapons");
					toInvData = util.JSONToTable(toInvData);
					local fromItem = fromInvData.Content[data.X][data.Y];
					local toItem = toInvData[invX];
					if !toItem then continue end;
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];

					local wep = fromItem.ID;
					local wepData = BASH.Items[wep];
					if !wepData or !wepData.WeaponEntity then return end;
					if wepData.SteamIDs and !wepData.SteamIDs[LocalPlayer():SteamID()] then
						LocalPlayer():PrintChat("You are not authorized to equip this!");
						return;
					end
					if LocalPlayer():GetWeapon(wepData.WeaponEntity):IsValid() then
						LocalPlayer():PrintChat("You already have this weapon equipped!\n[[Garry's Mod does not support using two of the same weapon entities independently. Sorry!]]")
						return;
					elseif !fromItemData.IsWeapon then
						LocalPlayer():PrintChat("This is not a weapon!");
						return;
					elseif fromItemData.SlotType != curObj.SlotType then
						LocalPlayer():PrintChat("That type of weapon does not go there!");
						return;
					elseif toItem and toItem.ID then
						fromInvData.Content[data.X][data.Y] = toItem;
						toInvData[invX] = fromItem;

						local swapWep = toItem.ID;
						local swapWepData = BASH.Items[swapWep];
						if !swapWepData or !swapWepData.WeaponEntity then return end;
						local swapWepEnt = LocalPlayer():GetWeapon(swapWepData.WeaponEntity);
						if !swapWepEnt or !swapWepEnt:IsValid() then return end;
						if swapWepEnt:GetTable().ShotsFired and swapWepEnt:GetTable().ShotsFired > 0 then
							fromInvData.Content[data.X][data.Y].Condition = fromInvData.Content[data.X][data.Y].Condition - ((swapWepEnt:GetTable().ShotsFired / swapWepData.Durability) * 100);
						end
						netstream.Start("BASH_Remove_Weapon", {swapWepData.WeaponEntity, toItem.Ammo});
					else
						fromInvData.Content[data.X][data.Y] = {};
						toInvData[invX] = fromItem;
					end

					netstream.Start("BASH_Equip_Weapon", {wepData.WeaponEntity, fromItem.Ammo});

					if fromInv == "InvStore" then
						BASH.Inventory.StoreObject.Inventory = util.TableToJSON(fromInvData);
						LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
						BASH.Inventory.StoreObject:UpdateInventory();
					else
						LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
						LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
					end
				end
			end
		end
	elseif fromInv == "Weapons" then
		for invX = 1, #toInvGrid do
			for invY = 1, #toInvGrid[1] do
				curObj = toInvGrid[invX][invY];
				curX, curY = curObj:GetPos();
				curW, curH = curObj:GetSize();

				if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
					local fromInvData, toInvData;
					if toInv == "InvStore" then
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
						toInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
					else
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
						toInvData = util.JSONToTable(LocalPlayer():GetEntry(toInv));
					end
					fromInvData = LocalPlayer():GetEntry("Weapons");
					fromInvData = util.JSONToTable(fromInvData);
					local fromItem = fromInvData[data.X];
					local toItem = toInvData.Content[invX][invY];
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];

					local wep, wepData;
					wep = fromItem.ID;
					wepData = BASH.Items[wep];
					if !wepData or !wepData.WeaponEntity then return end;
					if wepData.SteamIDs and !wepData.SteamIDs[LocalPlayer():SteamID()] then
						LocalPlayer():PrintChat("You are not authorized to equip this!");
						return;
					end
					local wepEnt = LocalPlayer():GetWeapon(wepData.WeaponEntity);
					if !wepEnt or !wepEnt:IsValid() then return end;
					fromItem.Ammo = wepEnt:Clip1();
					if !toItemData then
						fromInvData[data.X] = {};
						toInvData.Content[invX][invY] = fromItem;
					elseif !toItemData.IsWeapon then
						LocalPlayer():PrintChat("The item you want to swap is not a weapon!");
						return;
					elseif toItemData.SlotType != fromItemData.SlotType then
						LocalPlayer():PrintChat("That type of weapon cannot be swapped there!");
						return;
					elseif toItemData.IsWeapon and toItemData.SlotType == fromItemData.SlotType then
						if LocalPlayer():GetWeapon(wep):IsValid() then
							LocalPlayer():PrintChat("You already have this weapon equipped!\n[[Garry's Mod does not support using two of the same weapon independently. Sorry!]]")
							return;
						end

						fromInvData[data.X] = toItem;
						toInvData.Content[invX][invY] = fromItem;

						local swapWep = toItem.ID;
						local swapWepData = BASH.Items[swapWep];
						if !swapWepData or !swapWepData.WeaponEntity then return end;
						netstream.Start("BASH_Equip_Weapon", {swapWepData.WeaponEntity, toItem.Ammo});
					end

					if wepEnt:GetTable().ShotsFired and wepEnt:GetTable().ShotsFired > 0 then
						toInvData.Content[invX][invY].Condition = toInvData.Content[invX][invY].Condition - ((wepEnt:GetTable().ShotsFired / wepData.Durability) * 100);
					end
					netstream.Start("BASH_Remove_Weapon", {wepData.WeaponEntity});

					if toInv == "InvStore" then
						LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
						BASH.Inventory.StoreObject.Inventory = util.TableToJSON(toInvData);
						BASH.Inventory.StoreObject:UpdateInventory();
					else
						LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
						LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
					end
				end
			end
		end
	elseif toInvObj == BASH.Inventory.ClothingObject then
		for index, bodyPart in pairs(BODY_PARTS) do
			curObj = toInvGrid[index];
			curX, curY = curObj:GetPos();
			curW, curH = curObj:GetSize();

			if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
				local suit, _ = ParseDouble(LocalPlayer():GetEntry("Suit"));
				local acc, _ = ParseDouble(LocalPlayer():GetEntry("Acc"));
				local suitData = BASH.Items[suit];
				if suitData and suitData.NoClothing then
					BASH:CreateNotif("You cannot put clothing over that suit!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
					return;
				end
				local accData = BASH.Items[acc];
				if accData and accData.NoClothing and bodyPart == accData.BodyPos then
					BASH:CreateNotif("You cannot put that article over that accessory!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
					return;
				end
				if curObj == self.Home then return end;
				if fromInv == toInv then return end;

				local fromInvData, toInvData;
				if fromInv == "InvStore" then
					fromInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
				else
					fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
				end
				toInvData = LocalPlayer():GetEntry("Clothing");
				toInvData = util.JSONToTable(toInvData);
				local fromItem = fromInvData.Content[data.X][data.Y];
				local toItem = toInvData[bodyPart];
				local fromItemData = BASH.Items[data.ID];
				local toItemData = BASH.Items[toItem];

				if !fromItemData.IsClothing then
					LocalPlayer():PrintChat("This is not an article of clothing!");
					return;
				elseif fromItemData.BodyPos != bodyPart then
					LocalPlayer():PrintChat("That article of clothing does not go there!");
					return;
				elseif toItem and toItem != "" then
					fromInvData.Content[data.X][data.Y] = {};
					fromInvData.Content[data.X][data.Y].ID = toItem;
					toInvData[bodyPart] = data.ID;
				else
					fromInvData.Content[data.X][data.Y] = {};
					toInvData[bodyPart] = data.ID;
				end

				if fromInv == "InvStore" then
					BASH.Inventory.StoreObject.Inventory = util.TableToJSON(fromInvData);
					LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
					BASH.Inventory.StoreObject:UpdateInventory();
				else
					LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
					LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
				end
			end
		end
	elseif fromInv == "Clothing" then
		for invX = 1, #toInvGrid do
			for invY = 1, #toInvGrid[1] do
				curObj = toInvGrid[invX][invY];
				curX, curY = curObj:GetPos();
				curW, curH = curObj:GetSize();

				if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
					local fromInvData, toInvData;
					if toInv == "InvStore" then
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
						toInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
					else
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
						toInvData = util.JSONToTable(LocalPlayer():GetEntry(toInv));
					end
					fromInvData = LocalPlayer():GetEntry("Clothing");
					fromInvData = util.JSONToTable(fromInvData);
					local fromItem = fromInvData[data.Obj.BodyPart];
					local toItem = toInvData.Content[invX][invY];
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];

					if !toItemData then
						fromInvData[data.Obj.BodyPart] = "";
						toInvData.Content[invX][invY] = {};
						toInvData.Content[invX][invY].ID = data.ID;
					elseif !toItemData.IsClothing then
						LocalPlayer():PrintChat("The item you want to swap is not an article of clothing!");
						return;
					elseif toItemData.BodyPos != bodyPart then
						LocalPlayer():PrintChat("That article of clothing cannot be swapped there!");
						return;
					elseif toItemData.IsClothing and toItemData.BodyPos == bodyPart then
						fromInvData[data.Obj.BodyPart] = toItem.ID;
						toInvData.Content[invX][invY] = {};
						toInvData.Content[invX][invY].ID = data.ID;
					else
						fromInvData[data.Obj.BodyPart] = "";
						toInvData.Content[invX][invY] = {};
						toInvData.Content[invX][invY].ID = data.ID;
					end

					if toInv == "InvStore" then
						LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
						BASH.Inventory.StoreObject.Inventory = util.TableToJSON(toInvData);
						BASH.Inventory.StoreObject:UpdateInventory();
					else
						LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
						LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
					end
				end
			end
		end
	else
		for invX = 1, #toInvGrid do
			for invY = 1, #toInvGrid[1] do
				curObj = toInvGrid[invX][invY];
				if !curObj or !curObj:IsValid() then return end;
				curX, curY = curObj:GetPos();
				curW, curH = curObj:GetSize();

				if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
					if curObj == self.Home then return end;

					if fromInv == toInv then
						local invData;
						if fromInv == "InvStore" then
							invData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
						else
							invData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
						end
						local fromItem = invData.Content[data.X][data.Y];
						local toItem = invData.Content[invX][invY];
						local fromItemData = BASH.Items[data.ID] or {};
						local toItemData = BASH.Items[toItem.ID] or {};

						local newFrom, newTo = hook.Call("DoInventoryDrop", BASH, fromItem, fromItemData, toItem, toItemData);
						if newFrom and newTo then
							invData.Content[data.X][data.Y] = newFrom;
							invData.Content[invX][invY] = newTo;
						elseif toItem.ID and toItem.ID == data.ID and fromItemData.IsStackable then
							local toStacks = invData.Content[invX][invY].Stacks;
							local toRemainingStacks = fromItemData.MaxStacks - toStacks;
							if toRemainingStacks > 0 then
								if data.EntData.Stacks <= toRemainingStacks then
									invData.Content[data.X][data.Y] = {};
									invData.Content[invX][invY].Stacks = data.EntData.Stacks + toStacks;
								else
									local remainingStacks = data.EntData.Stacks - toRemainingStacks;
									invData.Content[data.X][data.Y].Stacks = remainingStacks;
									invData.Content[invX][invY].Stacks = fromItemData.MaxStacks;
								end
							end
						/*		Fuck this case.
						elseif toItem.ID and toItemData.IsAttachment and fromItem.ID and fromItemData.IsWeapon then
							if toItemData.RequiresTech and !LocalPlayer():IsTechnician() then
								LocalPlayer():PrintChat("This attachment requires a technician to attach!");
								return;
							end

							local atts = fromItem.Attachments;
							if !istable(atts) then
								atts = util.JSONToTable(atts);
							end

							local canAttach = false;
							for index, attSlot in pairs(fromItemData.Attachments) do
								if attSlot.header == toItemData.AttachmentSlot then
									for ind, att in pairs(attSlot.atts) do
										if att == toItemData.AttachmentEnt then
											canAttach = true;
										end
									end

									if attSlot.dependencies then
										local hasDep = false;
										for dep, _ in pairs(attSlot.dependencies) do
											for __, depAtt in pairs(atts) do
												if depAtt == dep then
													hasDep = true;
												end
											end
										end
										if !hasDep then
											LocalPlayer():PrintChat("You're missing a dependent attachment for this particular attachment!");
											return;
										end
									end
									if attSlot.exclusions then
										local isExc = false;
										for excl, _ in pairs(attSlot.exclusions) do
											for __, exclAtt in pairs(atts) do
												if exclAtt == excl then
													isExc = true;
												end
											end
										end
										if !isExc then
											LocalPlayer():PrintChat("One of more attachments on this weapon is not compatible with this attachment!");
											return;
										end
									end
								end
							end
							if !canAttach then
								LocalPlayer():PrintChat("This attachment is not compatible with this weapon!");
								return;
							end

							if atts and atts[toItemData.AttachmentSlot] and atts[toItemData.AttachmentSlot] != "" then
								local prevAtt = atts[toItemData.AttachmentSlot];
								local newID;
								for id, item in pairs(BASH.Items) do
									if item.IsAttachment and item.AttachmentEnt == ((istable(prevAtt) and prevAtt.ent) or prevAtt) then
										newID = id;
									end
								end
								if !newID then return end;

								if toItemData.AttachmentSlot == "Sight" then
									atts[toItemData.AttachmentSlot] = {};
									atts[toItemData.AttachmentSlot].ent = toItemData.AttachmentEnt;
									atts[toItemData.AttachmentSlot].col = toItem.CustomColor or toItemData.DefaultColor;
								else
									atts[toItemData.AttachmentSlot] = toItemData.AttachmentEnt;
								end

								local newItem = fromItem;
								invData.Content[invX][invY] = fromItem;
								invData.Content[data.X][data.Y].ID = newID;
								invData.Content[data.X][data.Y].CustomColor = (istable(prevAtt) and prevAtt.col) or BASH.Items[invData.Content[data.X][data.Y].ID].DefaultColor;
							else
								invData.Content[data.X][data.Y] = {};

								if toItemData.AttachmentSlot == "Sight" then
									atts[toItemData.AttachmentSlot] = {};
									atts[toItemData.AttachmentSlot].ent = toItemData.AttachmentEnt;
									atts[toItemData.AttachmentSlot].col = toItem.CustomColor or toItemData.DefaultColor;
								else
									atts[toItemData.AttachmentSlot] = toItemData.AttachmentEnt;
								end

								invData.Content[invX][invY] = fromItem;
							end

							LocalPlayer():PrintChat("'" .. toItemData.Name .. "' attached to " .. fromItemData.Name .. "!");
						*/
						elseif fromItem.ID and fromItemData.IsAttachment and toItem.ID and toItemData.IsWeapon then
							if fromItemData.RequiresTech and !LocalPlayer():IsTechnician() then
								LocalPlayer():PrintChat("This attachment requires a technician to attach!");
								return;
							end

							local atts = toItem.Attachments;
							if !istable(atts) then
								atts = util.JSONToTable(atts);
							end

							local canAttach = false;
							for index, attSlot in pairs(toItemData.Attachments) do
								if attSlot.header == fromItemData.AttachmentSlot then
									for ind, att in pairs(attSlot.atts) do
										if att == fromItemData.AttachmentEnt then
											canAttach = true;
										end
									end
									for index2, attSlot2 in pairs(toItemData.Attachments) do
										if attSlot2.header != attSlot.header and attSlot2.exclusions then
											for excl, _ in pairs(attSlot2.exclusions) do
												if excl == fromItemData.AttachmentEnt and atts[attSlot2.header] and atts[attSlot2.header] != "" then
													LocalPlayer():PrintChat("One or more attachments on this weapon is not compatible with this attachment!");
													return;
												end
											end
										end
									end

									if attSlot.dependencies then
										local hasDep = false;
										for dep, _ in pairs(attSlot.dependencies) do
											for __, depAtt in pairs(atts) do
												if depAtt == dep then
													hasDep = true;
												end
											end
										end
										if !hasDep then
											LocalPlayer():PrintChat("You're missing a dependent attachment for this particular attachment!");
											return;
										end
									end
									if attSlot.exclusions then
										for excl, _ in pairs(attSlot.exclusions) do
											for __, exclAtt in pairs(atts) do
												if exclAtt == excl then
													LocalPlayer():PrintChat("One or more attachments on this weapon is not compatible with this attachment!");
													return;
												end
											end
										end
									end
								end
							end
							if !canAttach then
								LocalPlayer():PrintChat("This attachment is not compatible with this weapon!");
								return;
							end

							if atts and atts[fromItemData.AttachmentSlot] and atts[fromItemData.AttachmentSlot] != "" then
								local prevAtt = atts[fromItemData.AttachmentSlot];
								local attID;
								for id, item in pairs(BASH.Items) do
									if item.IsAttachment and item.AttachmentEnt == ((istable(prevAtt) and prevAtt.ent) or prevAtt) then
										attID = id;
									end
								end
								invData.Content[data.X][data.Y].ID = attID;
								invData.Content[data.X][data.Y].CustomColor = (istable(prevAtt) and prevAtt.col) or BASH.Items[attID].DefaultColor;

								if fromItemData.AttachmentSlot == "Sight" then
									atts[fromItemData.AttachmentSlot] = {};
									atts[fromItemData.AttachmentSlot].ent = fromItemData.AttachmentEnt;
									atts[fromItemData.AttachmentSlot].col = fromItem.CustomColor or fromItemData.DefaultColor;
								else
									atts[fromItemData.AttachmentSlot] = fromItemData.AttachmentEnt;
								end

								invData.Content[invX][invY] = toItem;
							else
								invData.Content[data.X][data.Y] = {};

								if fromItemData.AttachmentSlot == "Sight" then
									atts[fromItemData.AttachmentSlot] = {};
									atts[fromItemData.AttachmentSlot].ent = fromItemData.AttachmentEnt;
									atts[fromItemData.AttachmentSlot].col = fromItem.CustomColor or fromItemData.DefaultColor;
								else
									atts[fromItemData.AttachmentSlot] = fromItemData.AttachmentEnt;
								end

								invData.Content[invX][invY] = toItem;
							end

							surface.PlaySound("cw/switch2.wav");
							LocalPlayer():PrintChat("'" .. fromItemData.Name .. "' attached to " .. toItemData.Name .. "!");
						elseif toItem.ID and toItem.ID == "purity_analyser" and fromItemData and fromItemData.IsArtifact then
							local name = fromItemData.Name;
							local purity = fromItem.Purity;
							LocalPlayer():PrintChat("Analyzing...");
							timer.Simple(5, function()
								LocalPlayer():PrintChat("This " .. name .. " is " .. purity .. "% pure.");
							end);
							return;
						elseif fromItem.ID and fromItem.ID == "purity_analyser" and toItemData and toItemData.IsArtifact then
							local name = toItemData.Name;
							local purity = toItem.Purity;
							LocalPlayer():PrintChat("Analyzing...");
							timer.Simple(5, function()
								LocalPlayer():PrintChat("This " .. name .. " is " .. purity .. "% pure.");
							end);
							return;
						else
							invData.Content[data.X][data.Y] = toItem;
							invData.Content[invX][invY] = fromItem;
						end

						if fromInv == "InvStore" then
							BASH.Inventory.StoreObject.Inventory = util.TableToJSON(invData);
							BASH.Inventory.StoreObject:UpdateInventory();
						else
							LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(invData));
						end
					else
						local fromInvData, toInvData;
						if fromInv == "InvStore" then
							fromInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
							toInvData = util.JSONToTable(LocalPlayer():GetEntry(toInv));
						elseif toInv == "InvStore" then
							fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
							toInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
						else
							fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
							toInvData = util.JSONToTable(LocalPlayer():GetEntry(toInv));
						end
						local fromItem = fromInvData.Content[data.X][data.Y];
						local toItem = toInvData.Content[invX][invY];
						local fromItemData = BASH.Items[data.ID];
						local toItemData = BASH.Items[toItem.ID];

						if toInv == "InvSec" then
							local suit, _ = ParseDouble(LocalPlayer():GetEntry("Suit"));
							local suitData = BASH.Items[suit];
							if suitData then
								if fromItemData.ItemSize >= suitData.StorageSize then
									LocalPlayer():PrintChat("That item is too big to fit in that storage!");
									return;
								end
							end
						elseif toInv == "InvAcc" then
							local acc = LocalPlayer():GetEntry("Acc");
							local accData = BASH.Items[acc];
							if accData then
								if fromItemData.ItemSize >= accData.StorageSize then
									LocalPlayer():PrintChat("That item is too big to fit in that storage!");
									return;
								end
							end
						end

						local newFrom, newTo = hook.Call("DoInventoryDrop", BASH, fromItem, fromItemData, toItem, toItemData);
						if newFrom and newTo then
							fromInvData.Content[data.X][data.Y] = newFrom;
							toInvData.Content[invX][invY] = newTo;
						elseif toItem.ID and toItem.ID == data.ID and fromItemData.IsStackable then
							local toStacks = toInvData.Content[invX][invY].Stacks;
							local toRemainingStacks = fromItemData.MaxStacks - toStacks;
							if toRemainingStacks > 0 then
								if data.EntData.Stacks <= toRemainingStacks then
									fromInvData.Content[data.X][data.Y] = {};
									toInvData.Content[invX][invY].Stacks = data.EntData.Stacks + toStacks;
								else
									local remainingStacks = data.EntData.Stacks - toRemainingStacks;
									fromInvData.Content[data.X][data.Y].Stacks = remainingStacks;
									toInvData.Content[invX][invY].Stacks = fromItemData.MaxStacks;
								end
							end
						elseif toItem.ID and toItem.ID == "purity_analyser" and fromItemData and fromItemData.IsArtifact then
							local name = fromItemData.Name;
							local purity = fromItem.Purity;
							LocalPlayer():PrintChat("Analyzing...");
							timer.Simple(5, function()
								LocalPlayer():PrintChat("This " .. name .. " is " .. purity .. "% pure.");
							end);
							return;
						elseif fromItem.ID and fromItem.ID == "purity_analyser" and toItemData and toItemData.IsArtifact then
							local name = toItemData.Name;
							local purity = toItem.Purity;
							LocalPlayer():PrintChat("Analyzing...");
							timer.Simple(5, function()
								LocalPlayer():PrintChat("This " .. name .. " is " .. purity .. "% pure.");
							end);
							return;
						else
							fromInvData.Content[data.X][data.Y] = toItem;
							toInvData.Content[invX][invY] = fromItem;
						end

						if fromInv == "InvStore" then
							BASH.Inventory.StoreObject.Inventory = util.TableToJSON(fromInvData);
							LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
							BASH.Inventory.StoreObject:UpdateInventory();
						elseif toInv == "InvStore" then
							LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
							BASH.Inventory.StoreObject.Inventory = util.TableToJSON(toInvData);
							BASH.Inventory.StoreObject:UpdateInventory();
						else
							LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(fromInvData));
							LocalPlayer():UpdateEntry(toInv, util.TableToJSON(toInvData));
						end
					end
				end
			end
		end
	end

	self:GetParent().Entered = false;
	if self:GetParent().Hover and self:GetParent().Hover:IsValid() then
		self:GetParent().Hover:Remove();
		self:GetParent().Hover = nil;
	end
end

vgui.Register("BASHInventoryDrag", DRAG, "BASHInventoryView");
