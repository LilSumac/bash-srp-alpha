local BASH = BASH;
BASH.ActionMenu = {};
BASH.ActionMenu.Open = false;
BASH.ActionMenu.Object = nil;
BASH.ActionMenu.Data = {};

function BASH:CreateActionMenu(ent)
	self:RemoveActionMenu();
	self.ActionMenu.Open = true;

	self.ActionMenu.Object = self:CreatePanel(CENTER_X, CENTER_Y, 0, 0);
	self.ActionMenu.Object.Entity = ent;
	self.ActionMenu.Object.Alpha = 255;
	self.ActionMenu.Object.Actions = {};

	local pos = ent:GetPos();
	local startPos = pos:ToScreen();
	self.ActionMenu.Object:SetPos(startPos.x, startPos.y);

	if ent:GetClass() == "bash_item" then
		if !ent:GetTable().ItemData then return end;

		for text, func in pairs(ent:GetTable().ItemData.Actions) do
			surface.SetFont("BASHFontHeavy");
			local w, h = surface.GetTextSize(text);

			if w > self.ActionMenu.Object:GetWide() - 16 then
				self.ActionMenu.Object:SetWide(w + 18);
			end

			self.ActionMenu.Object:SetHeight(self.ActionMenu.Object:GetTall() + h + 2);
			self.ActionMenu.Object.Actions[text] = func;
		end
	elseif ent:GetClass() == "bash_storage" then
		if !ent:GetNWBool("InUse") then
			self.ActionMenu.Object.Actions["Open Storage"] = function(ply, ent)
				local owner = ent:GetTable().Owner;
				local pass = ent:GetTable().Password;
				if owner and owner != LocalPlayer():GetEntry("BASHID") and pass and pass != "" then
					Derma_StringRequest("Storage Unlock", "Please enter the storage password below.", "",
							function(text)
								if text != ent:GetNWString("Password") then
									Derma_Message("Password incorrect!", "Storage Unlock", "Accept");
									return;
								else
									netstream.Start("BASH_Request_Storage", {ent});
								end
							end,
							function() end,
							"Unlock");
				else
					netstream.Start("BASH_Request_Storage", {ent});
				end
			end;

			surface.SetFont("BASHFontHeavy");
			local w, h = surface.GetTextSize("Open Storage");

			if w > self.ActionMenu.Object:GetWide() - 16 then
				self.ActionMenu.Object:SetWide(w + 18);
			end

			self.ActionMenu.Object:SetHeight(self.ActionMenu.Object:GetTall() + h + 2);
		else
			self.ActionMenu.Object.Actions["In Use..."] = function() end;

			surface.SetFont("BASHFontHeavy");
			local w, h = surface.GetTextSize("In Use...");

			if w > self.ActionMenu.Object:GetWide() - 16 then
				self.ActionMenu.Object:SetWide(w + 18);
			end

			self.ActionMenu.Object:SetHeight(self.ActionMenu.Object:GetTall() + h + 2);
		end
	elseif ent:GetClass() == "bash_stockpile" then
		if !ent:GetNWBool("InUse") then
			self.ActionMenu.Object.Actions["Open Stockpile"] = function(ply, ent)
				local faction = LocalPlayer():GetEntry("Faction");
				local factionData = self.Factions[faction];
				if !factionData then return end;
				if !factionData.HasStockpile then
					LocalPlayer():PrintChat("Your faction does not have a stockpile!");
					return;
				end
				if !LocalPlayer():HasFlag("s") and !LocalPlayer():HasFlag("x") then
					LocalPlayer():PrintChat("You don't have permission to access your faction's stockpile!");
					return;
				end

				netstream.Start("BASH_Request_Stockpile", {ent, faction});
			end;

			surface.SetFont("BASHFontHeavy");
			local w, h = surface.GetTextSize("Open Stockpile");

			if w > self.ActionMenu.Object:GetWide() - 16 then
				self.ActionMenu.Object:SetWide(w + 18);
			end

			self.ActionMenu.Object:SetHeight(self.ActionMenu.Object:GetTall() + h + 2);
		else
			self.ActionMenu.Object.Actions["In Use..."] = function() end;

			surface.SetFont("BASHFontHeavy");
			local w, h = surface.GetTextSize("In Use...");

			if w > self.ActionMenu.Object:GetWide() - 16 then
				self.ActionMenu.Object:SetWide(w + 18);
			end

			self.ActionMenu.Object:SetHeight(self.ActionMenu.Object:GetTall() + h + 2);
		end
	end

	self.ActionMenu.Object.Think = function(self)
		if !self.Entity or !self.Entity:IsValid() then
			BASH:RemoveActionMenu();
			return;
		end
		local lastX, lastY = self:GetPos();
		local pos = self.Entity:GetPos();
		local screenPos = pos:ToScreen();

		if lastX != screenPos.x or lastY != screenPos.y then
			local sizeX, sizeY = self:GetSize();
			local diffX = (screenPos.x - (self:GetWide() / 2)) - lastX;
			local diffY = (screenPos.y - (self:GetTall() / 2)) - lastY;
			lastX = lastX + (diffX * 0.25);
			lastY = lastY + (diffY * 0.25);

			self:SetPos(lastX, lastY);
		end
	end
	self.ActionMenu.Object.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, self.Alpha));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, self.Alpha));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, self.Alpha));

		local index = 0;
		local posX, posY = self:GetPos();
		for text, func in pairs(self.Actions) do
			if PositionIsInArea(CENTER_X, CENTER_Y, posX, posY + (index * 16), posX + w, posY + ((index + 1) * 16)) then
				draw.SimpleText(text, "BASHFontHeavy", w / 2, (index * 16), Color(180, 180, 180, self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

				if input.IsMouseDown(MOUSE_LEFT) then
					if func then
						func(LocalPlayer(), self.Entity);
					end

					BASH:RemoveActionMenu();
					return;
				end
			else
				draw.SimpleText(text, "BASHFontHeavy", w / 2, (index * 16), Color(255, 255, 255, self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
			end

			index = index + 1;
		end

		local entName;
		if self.Entity:GetTable().ItemData then
			entName = self.Entity:GetTable().ItemData.Name;
		elseif self.Entity:GetTable().InventoryName then
			entName = self.Entity:GetTable().InventoryName;
		elseif self.Entity:GetClass() == "bash_stockpile" then
			entName = "Stockpile";
		elseif self.Entity:GetClass() == "bash_storage" then
			local invData = self.Entity:GetNWString("InventoryID", "");
			invData = BASH.Inventories[invData];
			if !invData then
				entName = "Storage";
			else
				entName = invData.Name;
			end
		else
			entName = "Storage";
		end

		DisableClipping(true);
		draw.SimpleTextOutlined(entName, "BASHFontHeavy", w / 2, -2, Color(200, 200, 200, self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, self.Alpha));
		draw.Circle(CENTER_X - posX - 3, CENTER_Y - posY - 3, 6, 20, Color(255, 255, 255, 200));
		//draw.SimpleTextOutlined("X", "BASHFontHeavy", CENTER_X - posX, CENTER_Y - posY, Color(200, 200, 200, self.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, self.Alpha));
		DisableClipping(false);
	end
end

function BASH:RemoveActionMenu()
	self.ActionMenu.Open = false;

	if self.ActionMenu.Object and self.ActionMenu.Object:IsValid() then
		self.ActionMenu.Object.Entity = nil;
		self.ActionMenu.Object.Alpha = 0;
		self.ActionMenu.Object.Actions = nil;
		self.ActionMenu.Object:Remove();
	end
end

function BASH:DrawActionMenu()
	local menu = self.ActionMenu.Object;
	if !menu or !menu:IsValid() then return end;
	if !menu.Entity or !menu.Entity:IsValid() then return end;

	local posX, posY = menu:GetPos();
	if !PositionIsInArea(CENTER_X, CENTER_Y, posX - 100, posY - 100, posX + menu:GetWide() + 100, posY + menu:GetTall() + 100) or
		(LocalPlayer():EyePos() - menu.Entity:GetPos()):Length() > 120 then

		menu.Alpha = math.Clamp(menu.Alpha - 250 * FrameTime(), 0, 255);

		if menu.Alpha <= 0 or input.IsMouseDown(MOUSE_LEFT) then
			self:RemoveActionMenu();
			return;
		end
	elseif menu.Alpha < 255 then
		menu.Alpha = math.Clamp(menu.Alpha + 220 * FrameTime(), 0, 255);
	end
end

netstream.Hook("BASH_ActionMenu_Start", function(data)
	local ent = data;
	if !ent then return end;

	BASH:CreateActionMenu(ent);
end);
