local BASH = BASH;
BASH.Market = {};
BASH.Market.Object = nil;
BASH.Market.Open = false;
BASH.Market.Grid = {};
local width = SCRW * 0.5;
local height = SCRH * 0.5;

function BASH:CreateMarket()
	if self.Market.Open then return end;

	gui.EnableScreenClicker(true);
	self.Market.Object = self:CreatePanel(0, 0, width, height);
	self.Market.Object:Center();
	self.Market.Object.PaintOver = function(self, w, h)
		draw.SimpleText("Marketplace", "BASHFontLarge", 5, 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		draw.SimpleText("Search", "BASHFontHeavy", 5, 34, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
	end
	self.Market.Open = true;

	local closeButton = vgui.Create("DButton", self.Market.Object);
	closeButton:SetFont("marlett");
	closeButton:SetText("r");
	closeButton.Paint = function() end
	closeButton:SetColor(Color(255, 255, 255));
	closeButton:SetSize(20, 20);
	closeButton:SetPos(self.Market.Object:GetWide() - 22, 2)
	closeButton.DoClick = function()
		self:CloseMarket();
	end

	surface.SetFont("BASHFontHeavy");
	local updateX, updateY = surface.GetTextSize("Refresh");
	local editButton = BASH:CreateTextButton("Refresh", "BASHFontHeavy", self.Market.Object:GetWide() - updateX - 23, 24, self.Market.Object);
	editButton.Action = function()
		netstream.Start("BASH_Send_Stock");
	end

	surface.SetFont("BASHFontHeavy");
	local textX, _ = surface.GetTextSize("Search");
	local posX, posY = self.Market.Object:GetPos();
    self.Market.SearchWrapper = vgui.Create("DFrame");
	self.Market.SearchWrapper:SetSize(200, 16);
	self.Market.SearchWrapper:SetPos(posX + 10 + textX, posY + 34);
	self.Market.SearchWrapper:SetTitle("");
	self.Market.SearchWrapper:ShowCloseButton(false);
	self.Market.SearchWrapper:SetDraggable(false);
	self.Market.SearchWrapper:MakePopup();
	self.Market.SearchWrapper.Paint = function() end;
	self.Market.Search = vgui.Create("DTextEntry", self.Market.SearchWrapper);
	self.Market.Search:SetPos(0, 0);
	self.Market.Search:SetSize(200, 16);
	self.Market.Search.OnKeyCodeTyped = function(self, key)
		if key == KEY_ENTER and string.gsub(self:GetValue(), " ", "") != "" then
			BASH:ReformatItems();
		end
	end

	self.Market.Container = self:CreatePanel(5, 60, width - 10, height - 65, self.Market.Object);
	self.Market.Container.Paint = function() end;
    self.Market.Scroll = vgui.Create("BASHScroll", self.Market.Container);
	self.Market.Scroll:SetPos(0, 0);
	self.Market.Scroll:SetSize(width - 10, height - 65);
end

function BASH:ReformatItems()
	if !self.Market.Open then return end;
	if !self.TraderStock then return end;

	for id, obj in pairs(self.Market.Grid) do
		if obj and obj:IsValid() then
			obj:Remove();
			self.Market.Grid[id] = nil;
		end
	end

	if !self.TraderStock then return end;
	local searchEntry = self.Market.Search:GetValue();
	local x, y = 0, 0;
	for id, item in SortedPairs(self.Items) do
		if item.Hidden or (string.gsub(searchEntry, " ", "") != "" and !string.find(string.lower(item.Name), string.lower(searchEntry), 1, false)) then continue end;
		if !self.TraderStock[id] then continue end;

		self.Market.Grid[id] = self:CreatePanel(x, y, (width / 5) - 10, (width / 5) - 10, self.Market.Scroll);
        self.Market.Grid[id].OnCursorEntered = function(self) self.Entered = true end;
        self.Market.Grid[id].OnCursorExited = function(self) self.Entered = false end;
		self.Market.Grid[id].Paint = function(self, w, h)
			draw.NoTexture();
            if self.Entered then
                surface.SetDrawColor(Color(0, 200, 0, 255));
            else
	            surface.SetDrawColor(Color(150, 150, 150, 255));
            end
			surface.DrawOutlinedRect(0, 0, w, h);
		end
        self.Market.Grid[id].Entered = false;

		self.Market.Grid[id].ItemView = vgui.Create("DModelPanel", self.Market.Grid[id]);
		self.Market.Grid[id].ItemView:SetPos(1, 1);
		self.Market.Grid[id].ItemView:SetSize((width / 5) - 12, (width / 5) - 12);
		self.Market.Grid[id].ItemView:SetModel((istable(item.WorldModel) and table.Random(item.WorldModel)) or item.WorldModel);
		if item.ModelColor != Color(255, 255, 255) then
			self.Market.Grid[id].ItemView:SetColor(item.ModelColor);
		end

		local mn, mx = self.Market.Grid[id].ItemView.Entity:GetRenderBounds();
		local size = 0;
		size = math.max(size, math.abs(mn.x) + math.abs(mx.x));
		size = math.max(size, math.abs(mn.y) + math.abs(mx.y));
		size = math.max(size, math.abs(mn.z) + math.abs(mx.z));

		self.Market.Grid[id].ItemView:SetFOV(45);
		self.Market.Grid[id].ItemView:SetCamPos(Vector(size, size, size));
		self.Market.Grid[id].ItemView:SetLookAt((mn + mx) * 0.5);

		self.Market.Grid[id].ItemView.PaintOver = function(self, w, h)
			local text, col;
			if BASH.TraderStock[id] > 0 then
				text = "Stock: " .. BASH.TraderStock[id];
				col = color_green;
			else
				text = "OUT OF STOCK";
				col = color_red;
			end
			draw.SimpleText(item.Name, "BASHFontSmall", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
			draw.SimpleText(text, "BASHFontSmall", w / 2, 20, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

			if item.DefaultStacks > 1 then
				draw.SimpleText(item.DefaultPrice .. " ru / " .. item.DefaultStacks, "BASHFontSmall", w / 2, h - 5, color_green, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			else
				draw.SimpleText(item.DefaultPrice .. " ru", "BASHFontSmall", w / 2, h - 5, color_green, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			end
		end
		self.Market.Grid[id].ItemView.LayoutEntity = function(ent) end;
        self.Market.Grid[id].ItemView.OnCursorEntered = function(self)
			self:GetParent().Entered = true;

			if item.IsSuit then
				self:SetModel(item.PlayerModel);
				local mn, mx = self.Entity:GetRenderBounds();
				local size = 0;
				size = math.max(size, math.abs(mn.x) + math.abs(mx.x));
				size = math.max(size, math.abs(mn.y) + math.abs(mx.y));
				size = math.max(size, math.abs(mn.z) + math.abs(mx.z));

				self:SetCamPos(Vector(size, size, size));
				self:SetLookAt((mn + mx) * 0.5);
			end
		end
        self.Market.Grid[id].ItemView.OnCursorExited = function(self)
			self:GetParent().Entered = false;

			if item.IsSuit then
				self:SetModel(item.WorldModel);
				local mn, mx = self.Entity:GetRenderBounds();
				local size = 0;
				size = math.max(size, math.abs(mn.x) + math.abs(mx.x));
				size = math.max(size, math.abs(mn.y) + math.abs(mx.y));
				size = math.max(size, math.abs(mn.z) + math.abs(mx.z));

				self:SetCamPos(Vector(size, size, size));
				self:SetLookAt((mn + mx) * 0.5);
			end
		end
		self.Market.Grid[id].ItemView.DoRightClick = function(self)
			local options = DermaMenu();

			if item.IsStackable then
				options:AddOption("Buy Amount (" .. item.DefaultPrice .. " ru)", function()
					if BASH.TraderStock[id] <= 0 then
						BASH:CreateNotif("This item is out of stock!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					if LocalPlayer():HasFlag("I") and !item.IsConsumable then
						BASH:CreateNotif("You're not authorized to buy that!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					Derma_StringRequest(
						"Purchase " .. item.Name,
						"Enter the amount of the item you wish to purchase. Max stacks for this item: " .. item.MaxStacks,
						"",
						function(text)
							local num = math.floor(tonumber(text));
							if !num or num < 1 then
								Derma_Message("Invalid input! Must be a number.", "Invalid Purchase", "Cancel");
								return;
							elseif num > item.MaxStacks then
								Derma_Message("Invalid input! Number must be less than or equal to the max stacks for this item.", "Invalid Purchase", "Cancel");
								return;
							elseif LocalPlayer():GetEntry("Rubles") < num * (item.DefaultPrice / item.DefaultStacks) then
								Derma_Message("Invalid input! You can't afford that many. (Cost of " .. num .. ": " .. num * item.DefaultPrice .. " - Your money: " .. LocalPlayer():GetEntry("Rubles") .. ")", "Invalid Purchase", "Cancel");
								return;
							end

							netstream.Start("BASH_Buy_Item", {item.ID, num});
						end,
						function(text) end,
						"Purchase",
						"Cancel"
					);
				end):SetImage("icon16/money_delete.png");

				options:AddOption("Sell Amount (" .. math.ceil(item.DefaultPrice / 2) .. " ru)", function()
					if !LocalPlayer():HasItem(item.ID) then
						BASH:CreateNotif("You don't have any of this item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					if LocalPlayer():HasFlag("I") then
						BASH:CreateNotif("You're not authorized to sell to the trader menu!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					Derma_StringRequest(
						"Sell " .. item.Name,
						"Enter the amount of the item you wish to sell. Keep in mind the inventory search order when selling!",
						"",
						function(text)
							local num = math.floor(tonumber(text));
							if !num or num < 1 then
								Derma_Message("Invalid input! Must be a number.", "Invalid Purchase", "Cancel");
								return;
							end

							netstream.Start("BASH_Sell_Item", {item.ID, num});
						end,
						function(text) end,
						"Sell",
						"Cancel"
					);
				end):SetImage("icon16/money_add.png");
			else
				options:AddOption("Buy (" .. item.DefaultPrice .. " ru)", function()
					if BASH.TraderStock[id] <= 0 then
						BASH:CreateNotif("This item is out of stock!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					elseif LocalPlayer():GetEntry("Rubles") < item.DefaultPrice then
						BASH:CreateNotif("You can't afford this item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					if LocalPlayer():HasFlag("I") and !item.IsConsumable then
						BASH:CreateNotif("You're not authorized to buy that!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					netstream.Start("BASH_Buy_Item", {item.ID, 1});
				end):SetImage("icon16/money_delete.png");

				options:AddOption("Sell (" .. math.ceil(item.DefaultPrice / 2) .. " ru)", function()
					if !LocalPlayer():HasItem(item.ID) then
						BASH:CreateNotif("You don't have any of this item!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					if LocalPlayer():HasFlag("I") then
						BASH:CreateNotif("You're not authorized to sell to the trader menu!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
						return;
					end

					netstream.Start("BASH_Sell_Item", {item.ID, 1});
				end):SetImage("icon16/money_add.png");
			end

			options:AddOption("Print Description", function()
				LocalPlayer():PrintChat(item.Description);
			end):SetImage("icon16/printer.png");
			options:AddSpacer();
			options:AddOption("Close"):SetImage("icon16/delete.png");
			options:Open();
		end

		self.Market.Scroll:AddItem(self.Market.Grid[id]);

		x = x + ((width / 5) - 5);
		if x > self.Market.Scroll:GetWide() - 50 then
			x = 0;
			y = y + ((width / 5) - 5);
		end
	end
end

function BASH:CloseMarket()
	if !self.Market.Open or !self.Market.Object then return end;

	gui.EnableScreenClicker(false);
	self.Market.Object:Remove();
	self.Market.Object = nil;
    self.Market.SearchWrapper:Remove();
    self.Market.SearchWrapper = nil;
	self.Market.Grid = {};
	self.Market.Open = false;
end

hook.Add("PlayerBindPress", "TraderMenuBind", function(ply, bind, pressed)
	if !pressed then return true end;
	if BASH:GUIOpen() then return true end;

	if ply:Alive() and ply:GetEntry("CharLoaded") then
		if bind == "gm_showspare1" then
			if !ply:IsTrader() and !ply:HasFlag("I") then
				ply:PrintChat("You don't have the auths to access this menu!");
				return true;
			end

			netstream.Start("BASH_Send_Stock");
			return true;
		end
	end
end);

netstream.Hook("BASH_Return_Stock", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;

	BASH.TraderStock = data;
	BASH:CreateMarket();
	BASH:ReformatItems();
end);
