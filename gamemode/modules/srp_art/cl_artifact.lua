local BASH = BASH;

local art = Material("bash-srp/icon/slot_art.png", "noclamp");
function BASH:CreateArtifactSlots()
	if !self.Inventory.ArtGrid then
		self.Inventory.ArtGrid = {};
	end
	local suit, _ = ParseDouble(LocalPlayer():GetEntry("Suit"));
	local suitObj = self.Items[suit];
	local suitSlots = 1;

	if suit != "" then
		suitSlots = suitObj.ArtifactSlots;
	end

	local acc = LocalPlayer():GetEntry("Acc");
	local accObj = self.Items[acc];

	if acc != "" then
		suitSlots = suitSlots + accObj.ArtifactSlots;
	end

	surface.SetFont("BASHFontHeavy");
	local eq, _ = surface.GetTextSize("Artifacts");

	local farX = self:GetWidestInventory();
	self.Inventory.ArtObject = vgui.Create("DFrame");
	self.Inventory.ArtObject.InvType = INV_ART;
	self.Inventory.ArtObject:SetSize(math.Clamp(10 + (50 * suitSlots) + (5 * (suitSlots - 1)), eq + 10, 1000), 80);
	self.Inventory.ArtObject:SetPos(SCRW - 10 - farX - self.Inventory.ArtObject:GetWide() - 10, SCRH - self.Inventory.EquipmentObject:GetTall() - self.Inventory.ClothingObject:GetTall() - 110);
	self.Inventory.ArtObject:SetDraggable(false);
	self.Inventory.ArtObject:SetTitle("");
	self.Inventory.ArtObject:ShowCloseButton(false);
	self.Inventory.ArtObject.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("Artifacts", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		local posX = 5;
		local posY = 25;
		for invX = 1, suitSlots do
			draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));
			posX = posX + 55;
		end
	end

	local arts = LocalPlayer():GetEntry("Artifacts");
	arts = util.JSONToTable(arts);
	local posX = 5;
	local posY = 25;
	for invX = 1, suitSlots do
		self.Inventory.ArtGrid[invX] = vgui.Create("BASHInventoryObj", self.Inventory.ArtObject);
		self.Inventory.ArtGrid[invX]:SetPos(posX, posY);
		self.Inventory.ArtGrid[invX]:SetSize(50, 50);
		self.Inventory.ArtGrid[invX].InvX = invX;
		self.Inventory.ArtGrid[invX].HoverString = "Artifact";
		self.Inventory.ArtGrid[invX].PaintOver = function(self, w, h)
			local arts = LocalPlayer():GetEntry("Artifacts");
			arts = util.JSONToTable(arts);
			if arts[invX] and arts[invX].ID then return end;

			surface.SetMaterial(art);
			surface.SetDrawColor(color_white);
			surface.DrawTexturedRectUV((w / 2) - 16, (h / 2) - 16, 32, 32, 0, 0, 1, 1);

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
		end
		if arts[invX] and arts[invX].ID then
			self.Inventory.ArtGrid[invX]:SetItem(arts[invX]);
		end

		posX = posX + 55;
	end
end
hook.Add("OnInventoryCreate", "CreateArtifactSlots", function()
	BASH:CreateArtifactSlots();
end);

hook.Add("OnInventoryClose", "RemoveArtifactSlots", function()
	if BASH.Inventory.ArtObject and BASH.Inventory.ArtObject:IsValid() then
		BASH.Inventory.ArtObject:Remove();
		BASH.Inventory.ArtGrid = {};
	end
end);

hook.Add("OnInventoryClear", "ClearArtifactSlots", function()
	if BASH.Inventory.ArtObject then
		for artGridX = 1, #BASH.Inventory.ArtGrid do
			if BASH.Inventory.ArtGrid[artGridX] and BASH.Inventory.ArtGrid[artGridX]:IsValid() then
				BASH.Inventory.ArtGrid[artGridX]:Remove();
				BASH.Inventory.ArtGrid[artGridX] = nil;
			end
		end
	end
end);

hook.Add("OnInventoryRefresh", "RefreshArtifactSlots", function()
	if BASH.Inventory.ArtObject and BASH.Inventory.ArtObject:IsValid() then
		local suit, _ = ParseDouble(LocalPlayer():GetEntry("Suit"));
		local suitObj = BASH.Items[suit];
		local suitSlots = 1;

		if suit != "" then
			suitSlots = suitObj.ArtifactSlots;
		end

		local acc = LocalPlayer():GetEntry("Acc");
		local accObj = BASH.Items[acc];

		if acc != "" then
			suitSlots = suitSlots + accObj.ArtifactSlots;
		end

		surface.SetFont("BASHFontHeavy");
		local eq, _ = surface.GetTextSize("Artifacts");

		local farX = BASH:GetWidestInventory();
		BASH.Inventory.ArtObject:SetSize(math.Clamp(10 + (50 * suitSlots) + (5 * (suitSlots - 1)), eq + 10, 1000), 80);
		BASH.Inventory.ArtObject:SetPos(SCRW - 10 - farX - BASH.Inventory.ArtObject:GetWide() - 10, SCRH - BASH.Inventory.EquipmentObject:GetTall() - BASH.Inventory.ClothingObject:GetTall() - 110);
		BASH.Inventory.ArtObject.Paint = function(self, w, h)
			draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
			draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
			draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
			draw.SimpleText("Artifacts", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

			local posX = 5;
			local posY = 25;
			for invX = 1, suitSlots do
				draw.RoundedBox(4, posX, posY, 50, 50, Color(75, 75, 75, 255));
				posX = posX + 55;
			end
		end

		local arts = LocalPlayer():GetEntry("Artifacts");
		arts = util.JSONToTable(arts);
		local posX = 5;
		local posY = 25;
		for invX = 1, suitSlots do
			BASH.Inventory.ArtGrid[invX] = vgui.Create("BASHInventoryObj", BASH.Inventory.ArtObject);
			BASH.Inventory.ArtGrid[invX]:SetPos(posX, posY);
			BASH.Inventory.ArtGrid[invX]:SetSize(50, 50);
			BASH.Inventory.ArtGrid[invX].InvX = invX;
			BASH.Inventory.ArtGrid[invX].HoverString = "Artifact";
			BASH.Inventory.ArtGrid[invX].PaintOver = function(self, w, h)
				local arts = LocalPlayer():GetEntry("Artifacts");
				arts = util.JSONToTable(arts);
				if arts[invX] and arts[invX].ID then return end;

				surface.SetMaterial(art);
				surface.SetDrawColor(color_white);
				surface.DrawTexturedRectUV((w / 2) - 16, (h / 2) - 16, 32, 32, 0, 0, 1, 1);

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
			end
			if arts[invX] and arts[invX].ID then
				BASH.Inventory.ArtGrid[invX]:SetItem(arts[invX]);
			end

			posX = posX + 55;
		end
	end
end);

hook.Add("FindInventoryDrop", "FindArtDrop", function(mouseX, mouseY)
	local artInv = BASH.Inventory.ArtObject;
	local artX, artY, artW, artH;
	if artInv and artInv:IsValid() then
		artX, artY = artInv:GetPos();
		artW, artH = artInv:GetSize();
	end

	local toInv, toInvObj, toInvGrid;
	if artInv and artInv:IsValid() and PositionIsInArea(mouseX, mouseY, artX, artY, artX + artW, artY + artH) then
		toInv = "Artifacts";
		toInvObj = BASH.Inventory.ArtObject;
		toInvGrid = BASH.Inventory.ArtGrid;
		return toInv, toInvObj, toInvGrid;
	end
end);

hook.Add("FindInventoryDropHome", "FindArtDropHome", function(fromInv)
	if fromInv == INV_ART then
		return "Artifacts";
	end
end);

hook.Add("HandleInventoryDrop", "HandleArtifactDrop", function(obj, data, toInv, toInvObj, toInvGrid, fromInv)
	if toInvObj != BASH.Inventory.ArtObject and fromInv != "Artifacts" then return end;

	local mouseX, mouseY = toInvObj:CursorPos();
	local curObj, curX, curY, curW, curH;
	if toInvObj == BASH.Inventory.ArtObject then
		for invX = 1, #toInvGrid do
			curObj = toInvGrid[invX];
			curX, curY = curObj:GetPos();
			curW, curH = curObj:GetSize();

			if PositionIsInArea(mouseX, mouseY, curX, curY, curX + curW, curY + curH) then
				if curObj == obj.Home then return true end;

				if fromInv == toInv then
					local invData = LocalPlayer():GetEntry("Artifacts");
					invData = util.JSONToTable(invData);
					local fromItem = invData[data.X];
					local toItem = invData[invX];
					if !toItem then continue end;
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];
					if toItem and toItem.ID then
						invData[data.X] = toItem;
						invData[invX] = fromItem;
					else
						invData[data.X] = {};
						invData[invX] = fromItem;
					end

					LocalPlayer():UpdateEntry(fromInv, util.TableToJSON(invData));
				else
					local fromInvData, toInvData;
					if fromInv == "InvStore" then
						fromInvData = util.JSONToTable(BASH.Inventory.StoreObject.Inventory);
					else
						fromInvData = util.JSONToTable(LocalPlayer():GetEntry(fromInv));
					end
					toInvData = LocalPlayer():GetEntry("Artifacts");
					toInvData = util.JSONToTable(toInvData);
					local fromItem = fromInvData.Content[data.X][data.Y];
					local toItem = toInvData[invX];
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem];

					if !fromItemData.IsArtifact then
						LocalPlayer():PrintChat("This is not an artifact!");
						return true;
					elseif toItem and toItem.ID then
						fromInvData.Content[data.X][data.Y] = toItem;
						toInvData[invX] = fromItem;
					else
						fromInvData.Content[data.X][data.Y] = {};
						toInvData[invX] = fromItem;
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
		end
	elseif fromInv == "Artifacts" and fromInv != toInv then
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
					fromInvData = LocalPlayer():GetEntry("Artifacts");
					fromInvData = util.JSONToTable(fromInvData);
					local fromItem = fromInvData[data.X];
					local toItem = toInvData.Content[invX][invY];
					local fromItemData = BASH.Items[data.ID];
					local toItemData = BASH.Items[toItem.ID];

					if !toItemData then
						fromInvData[data.X] = {};
						toInvData.Content[invX][invY] = fromItem;
					elseif !toItemData.IsArtifact then
						LocalPlayer():PrintChat("The item you want to swap is not an artifact!");
						return true;
					elseif toItemData.IsArtifact then
						fromInvData[data.X] = toItem;
						toInvData.Content[invX][invY] = fromItem;
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
	end

	return true;
end);

hook.Add("Think", "ArtifactHandleRads", function()
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) or !LocalPlayer():Alive() then return end
	if !LocalPlayer().LastArtThink then
		LocalPlayer().LastArtThink = 0;
	end
	if CurTime() - LocalPlayer().LastArtThink < 10 then return end;

	local arts = LocalPlayer():GetEntry("Artifacts");
	arts = util.JSONToTable(arts);
	local artData;
	local addRads = 0;
	local artsEquipped = false;
	for index, art in pairs(arts) do
		if art and art.ID then
			artData = BASH.Items[art.ID];
			if artData and artData.RadsPerMin then
				addRads = addRads + ((artData.RadsPerMin / 6) * (art.Purity / 100));
				artsEquipped = true;
			end
		end
	end

	if artsEquipped then
		local curRads = LocalPlayer():GetEntry("Radiation");
		LocalPlayer():UpdateEntry("Radiation", math.Clamp(curRads + addRads, 0, 100));
	end
	LocalPlayer().LastArtThink = CurTime();
end);
