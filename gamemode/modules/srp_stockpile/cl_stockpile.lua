local BASH = BASH;local BASH = BASH;
BASH.Stock = {};
BASH.Stock.Object = nil;
BASH.Stock.Open = false;
BASH.Stock.Grid = {};
BASH.Stock.Ent = nil;
local width = SCRW * 0.5;
local height = SCRH * 0.5;

netstream.Hook("BASH_Request_Stockpile_Return", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;

    local ent = data[1];
    local stock = data[2];
    if !ent or !stock then return end;

    if !BASH.Stock.Open then
        BASH:CreateStockpile(ent);
    end
    BASH:ReformatStock(stock);
end);

function BASH:CreateStockpile(ent)
	if self.Stock.Open then return end;

    local faction = LocalPlayer():GetEntry("Faction");
    local factionData = self.Factions[faction];
    if !factionData then return end;
	gui.EnableScreenClicker(true);
	self.Stock.Object = self:CreatePanel(0, 0, width, height);
	self.Stock.Object:Center();
	self.Stock.Object.PaintOver = function(self, w, h)
        surface.SetFont("BASHFontHeavy");
    	local textX, _ = surface.GetTextSize("Search");
		draw.SimpleText(factionData.Name .. " Stockpile", "BASHFontLarge", 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		draw.SimpleText("Search", "BASHFontHeavy", 5, 34, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
        draw.SimpleText("Hide Out-Of-Stock Items", "BASHFontHeavy", 215 + textX, 34, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

        if !BASH.Stock.Items then
            draw.SimpleText("Loading Stockpile...", "BASHFontLarge", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        end
	end
	self.Stock.Open = true;
    self.Stock.Ent = ent;

	local closeButton = vgui.Create("DButton", self.Stock.Object);
	closeButton:SetFont("marlett");
	closeButton:SetText("r");
	closeButton.Paint = function() end
	closeButton:SetColor(Color(255, 255, 255));
	closeButton:SetSize(20, 20);
	closeButton:SetPos(self.Stock.Object:GetWide() - 22, 2)
	closeButton.DoClick = function()
		self:CloseStockpile();
        netstream.Start("BASH_Close_Stockpile", ent);
	end

	surface.SetFont("BASHFontHeavy");
	local updateX, updateY = surface.GetTextSize("Refresh");
	local editButton = BASH:CreateTextButton("Refresh", "BASHFontHeavy", self.Stock.Object:GetWide() - updateX - 23, 24, self.Stock.Object);
	editButton.Action = function()
		netstream.Start("BASH_Request_Stockpile", {ent, faction});
	end

	surface.SetFont("BASHFontHeavy");
	local textX, _ = surface.GetTextSize("Search");
	local posX, posY = self.Stock.Object:GetPos();
    self.Stock.SearchWrapper = vgui.Create("DFrame");
	self.Stock.SearchWrapper:SetSize(200, 16);
	self.Stock.SearchWrapper:SetPos(posX + 10 + textX, posY + 34);
	self.Stock.SearchWrapper:SetTitle("");
	self.Stock.SearchWrapper:ShowCloseButton(false);
	self.Stock.SearchWrapper:SetDraggable(false);
	self.Stock.SearchWrapper:MakePopup();
	self.Stock.SearchWrapper.Paint = function() end;
	self.Stock.Search = vgui.Create("DTextEntry", self.Stock.SearchWrapper);
	self.Stock.Search:SetPos(0, 0);
	self.Stock.Search:SetSize(200, 16);
	self.Stock.Search.OnKeyCodeTyped = function(self, key)
		if key == KEY_ENTER then
			BASH:ReformatStock();
		end
	end

    local buttonX, _ = surface.GetTextSize("Hide Out-Of-Stock Items");
    self.Stock.HideNoStock = vgui.Create("DCheckBox", self.Stock.Object);
    self.Stock.HideNoStock:SetPos(20 + self.Stock.SearchWrapper:GetWide() + textX + buttonX, 34);
    self.Stock.HideNoStock:SetChecked(true);
    self.Stock.HideNoStock.OnChange = function(self, val)
        BASH:ReformatStock();
    end

	self.Stock.Container = self:CreatePanel(5, 60, width - 10, height - 65, self.Stock.Object);
	self.Stock.Container.Paint = function() end;
    self.Stock.Scroll = vgui.Create("BASHScroll", self.Stock.Container);
	self.Stock.Scroll:SetPos(0, 0);
	self.Stock.Scroll:SetSize(width - 10, height - 65);
end

function BASH:ReformatStock(stock)
	if !self.Stock.Open then return end;

    if stock then
        self.Stock.Items = stock;
    end

	for id, obj in pairs(self.Stock.Grid) do
		if obj and obj:IsValid() then
			obj:Remove();
			self.Stock.Grid[id] = nil;
		end
	end

	local searchEntry = self.Stock.Search:GetValue();
	local x, y = 0, 0;
    local num;
	for id, item in pairs(self.Items) do
        local num = self.Stock.Items[id] or 0;
		if (self.Stock.HideNoStock:GetChecked() and num == 0) or (string.gsub(searchEntry, " ", "") != "" and !string.find(string.lower(item.Name), string.lower(searchEntry), 1, false)) then continue end;

		self.Stock.Grid[id] = self:CreatePanel(x, y, 150, 150, self.Stock.Scroll);
        self.Stock.Grid[id].OnCursorEntered = function(self) self.Entered = true end;
        self.Stock.Grid[id].OnCursorExited = function(self) self.Entered = false end;
		self.Stock.Grid[id].Paint = function(self, w, h)
			draw.NoTexture();
            if self.Entered then
                surface.SetDrawColor(Color(0, 200, 0, 255));
            else
	            surface.SetDrawColor(Color(150, 150, 150, 255));
            end
			surface.DrawOutlinedRect(0, 0, w, h);
		end
        self.Stock.Grid[id].Entered = false;

		self.Stock.Grid[id].ItemView = vgui.Create("DModelPanel", self.Stock.Grid[id]);
		self.Stock.Grid[id].ItemView:SetPos(1, 1);
		self.Stock.Grid[id].ItemView:SetSize(148, 148);
		self.Stock.Grid[id].ItemView:SetModel((istable(item.WorldModel) and table.Random(item.WorldModel)) or item.WorldModel);
		if item.ModelColor != Color(255, 255, 255) then
			self.Stock.Grid[id].ItemView:SetColor(item.ModelColor);
		end

		local mn, mx = self.Stock.Grid[id].ItemView.Entity:GetRenderBounds();
		local size = 0;
		size = math.max(size, math.abs(mn.x) + math.abs(mx.x));
		size = math.max(size, math.abs(mn.y) + math.abs(mx.y));
		size = math.max(size, math.abs(mn.z) + math.abs(mx.z));

		self.Stock.Grid[id].ItemView:SetFOV(45);
		self.Stock.Grid[id].ItemView:SetCamPos(Vector(size, size, size));
		self.Stock.Grid[id].ItemView:SetLookAt((mn + mx) * 0.5);

		self.Stock.Grid[id].ItemView.PaintOver = function(self, w, h)
            num = BASH.Stock.Items[id] or 0;
			draw.SimpleText(item.Name, "BASHFontHeavy", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
			draw.SimpleText("Stored: " .. num, "BASHFontHeavy", w / 2, h - 5, (num > 0 and color_green) or color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
		end
		self.Stock.Grid[id].ItemView.LayoutEntity = function(ent) end;
        self.Stock.Grid[id].ItemView.OnCursorEntered = function(self) self:GetParent().Entered = true end;
        self.Stock.Grid[id].ItemView.OnCursorExited = function(self) self:GetParent().Entered = false end;
		self.Stock.Grid[id].ItemView.DoRightClick = function(self)
			local options = DermaMenu();

			if item.IsStackable then
				options:AddOption("Withdraw Amount", function()
                    if !LocalPlayer():HasFlag("s") then
                        BASH:CreateNotif("You're not allowed to withdraw an item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
                    end
					if num <= 0 then
						BASH:CreateNotif("This item is out of stock!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					Derma_StringRequest(
						"Withdraw " .. item.Name,
						"Enter the amount of the item you wish to withdraw. Max stacks for this item: " .. item.MaxStacks,
						"",
						function(text)
							local num2 = math.floor(tonumber(text));
							if !num2 or num2 < 1 then
								Derma_Message("Invalid input! Must be a number.", "Invalid Withdrawal", "Cancel");
								return;
							elseif num2 > item.MaxStacks then
								Derma_Message("Invalid input! Number must be less than or equal to the max stacks for this item.", "Invalid Withdrawal", "Cancel");
								return;
							end

							netstream.Start("BASH_Withdraw_Stockpile", {item.ID, num2, BASH.Stock.Ent});
						end,
						function(text) end,
						"Withdraw",
						"Cancel"
					);
				end):SetImage("icon16/database_delete.png");

				options:AddOption("Deposit Amount", function()
                    if !LocalPlayer():HasFlag("s") and !LocalPlayer():HasFlag("x") then
                        BASH:CreateNotif("You're not allowed to withdraw an item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
                    end
					if !LocalPlayer():HasItem(item.ID) then
						BASH:CreateNotif("You don't have any of this item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					Derma_StringRequest(
						"Deposit " .. item.Name,
						"Enter the amount of the item you wish to deposit. Keep in mind the inventory search order when depositing!",
						"",
						function(text)
							local num2 = math.floor(tonumber(text));
							if !num2 or num2 < 1 then
								Derma_Message("Invalid input! Must be a number.", "Invalid Purchase", "Cancel");
								return;
							end

							netstream.Start("BASH_Deposit_Stockpile", {item.ID, num2, BASH.Stock.Ent});
						end,
						function(text) end,
						"Deposit",
						"Cancel"
					);
				end):SetImage("icon16/database_add.png");
			else
				options:AddOption("Withdraw", function()
					if num <= 0 then
						BASH:CreateNotif("This item is out of stock!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					netstream.Start("BASH_Withdraw_Stockpile", {item.ID, 1, BASH.Stock.Ent});
				end):SetImage("icon16/database_delete.png");

				options:AddOption("Deposit", function()
					if !LocalPlayer():HasItem(item.ID) then
						BASH:CreateNotif("You don't have any of this item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					netstream.Start("BASH_Deposit_Stockpile", {item.ID, 1, BASH.Stock.Ent});
				end):SetImage("icon16/database_add.png");
			end

			options:AddOption("Print Description", function()
				LocalPlayer():PrintChat(item.Description);
			end):SetImage("icon16/printer.png");
			options:AddSpacer();
			options:AddOption("Close"):SetImage("icon16/delete.png");
			options:Open();
		end

		self.Stock.Scroll:AddItem(self.Stock.Grid[id]);

		x = x + 155;
		if x > self.Stock.Scroll:GetWide() - 15 then
			x = 0;
			y = y + 155;
		end
	end
end

function BASH:CloseStockpile()
	if !self.Stock.Open or !self.Stock.Object then return end;

	gui.EnableScreenClicker(false);
	self.Stock.Object:Remove();
	self.Stock.Object = nil;
    self.Stock.SearchWrapper:Remove();
    self.Stock.SearchWrapper = nil;
	self.Stock.Grid = {};
	self.Stock.Open = false;
end
