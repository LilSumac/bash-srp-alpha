local BASH = BASH;

function BASH:HelpApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("Help", "BASHFontHeavy", 377, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
		surface.SetDrawColor(color_white);
	end

	self.PDA.Content.Scroll = vgui.Create("BASHScroll", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 468);
	self.PDA.Content.Scroll:SetPos(1, 1);
	self.PDA.Content.Scroll.Content = self:CreatePanel(0, 0, 713, 0, self.PDA.Content.Scroll);
	self.PDA.Content.Scroll.Content.Paint = function(self, w, h)
		draw.NoTexture();
		local x = 5;
		local y = 5;
		for index, button in pairs(BASH.PDA.Buttons) do
			draw.RoundedBox(16, x, y, 64, 64, Color(0, 0, 0, 200));
			draw.RoundedBox(16, x + 1, y + 1, 62, 62, Color(75, 75, 75, 200));
			draw.RoundedBox(16, x + 2, y + 2, 60, 60, button.Color);
			surface.SetMaterial(button.Logo);
			surface.SetDrawColor(color_white);
			surface.DrawTexturedRectUV(x + 16, y + 16, 32, 32, 0, 0, 1, 1);
			y = y + 69;
		end
	end

	local x = 72;
	local y = 5;
	for index, button in pairs(self.PDA.Buttons) do
		local infoName = vgui.Create("DLabel", self.PDA.Content.Scroll.Content);
		infoName:SetPos(x, y);
		infoName:SetFont("BASHFontHeavy");
		infoName:SetTextColor(button.Color);
		infoName:SetText(FormatString(button.InfoName, "BASHFontHeavy", 620));
		infoName:SizeToContents();
		y = y + infoName:GetTall();

		local infoDesc = vgui.Create("DLabel", self.PDA.Content.Scroll.Content);
		infoDesc:SetPos(x, y);
		infoDesc:SetFont("BASHFontHeavy");
		infoDesc:SetTextColor(color_white);
		infoDesc:SetText(FormatString(button.InfoDesc, "BASHFontHeavy", 620));
		infoDesc:SizeToContents();
		y = (index * 64) + ((index + 1) * 5);
	end

	self.PDA.Content.Scroll.Content:SetTall(y);
	self.PDA.Content.Scroll:AddItem(self.PDA.Content.Scroll.Content);
end

function BASH:ScoreboardApp(sims)
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("STALKERs In Your Area", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);

		if table.Count(sims) == 0 then
			draw.SimpleText("No available signals.", "BASHFontApp", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			draw.SimpleText("Handle", "BASHFontLight", 110, 12, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			draw.SimpleText("Status", "BASHFontLight", 283, 12, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			draw.SimpleText("Title", "BASHFontLight", 543, 12, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end

	if table.Count(sims) == 0 then return end;

	self.PDA.Content.Scroll = vgui.Create("BASHScroll", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 443);
	self.PDA.Content.Scroll:SetPos(1, 26);
	self.PDA.Content.ScrollContent = {};
	local index = 1;
	local y = 0;

	for sim, data in pairs(sims) do
		self.PDA.Content.ScrollContent[index] = vgui.Create("Panel", self.PDA.Content.Scroll);
		self.PDA.Content.ScrollContent[index]:SetSize(680, 40);
		self.PDA.Content.ScrollContent[index]:SetPos(10, y);
		self.PDA.Content.ScrollContent[index].Paint = function(self, w, h)
			draw.NoTexture();

			local col = Color(100, 100, 100, 150);
			if index % 2 == 0 then
				col = Color(200, 200, 200, 150);
			end
			draw.RoundedBox(8, 0, 2, w, h - 4, col);

			draw.SimpleText(data.Handle, "BASHFontLarge", 99, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			if data.Status == "Online" then
				draw.SimpleText(data.Status, "BASHFontLarge", 272, 20, color_green, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			elseif data.Status == "Away" then
				draw.SimpleText(data.Status, "BASHFontLarge", 272, 20, Color(210, 120, 50, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			elseif data.Status == "Busy" then
				draw.SimpleText(data.Status, "BASHFontLarge", 272, 20, Color(200, 50, 50, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
			draw.SimpleText(data.Title, "BASHFontLight", 532, 20, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
		self.PDA.Content.ScrollContent[index].OnMousePressed = function(self, mouse)
			if mouse != MOUSE_RIGHT then return end;

			local options = DermaMenu();
			options:AddOption("Copy Handle to Clipboard", function()
					SetClipboardText(data.Handle);
					BASH:CreateNotif("Handle copied to clipboard!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
				end):SetImage("icon16/cog.png");
			options:AddSpacer();
			options:AddOption("Close", function() end):SetImage("icon16/cross.png");
			options:Open();
		end
		self.PDA.Content.ScrollContent[index]:SetVisible(true);
		self.PDA.Content.Scroll:AddItem(self.PDA.Content.ScrollContent[index]);
		index = index + 1;
		y = y + 40;
	end
end
netstream.Hook("BASH_Request_Online_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;
	BASH:ScoreboardApp(data);
end);

function BASH:BountyApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("Bounty Board", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		draw.SimpleText("Bounties are posted and maintained by sysadmins, who do not represent the motive or payment of these bounties.", "BASHFontSmall", 30, 505, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);

		if !BASH.Bounties then
			draw.SimpleText("Fetching bounties...", "BASHFontApp", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		elseif table.Count(BASH.Bounties) == 0 then
			draw.SimpleText("No bounties available.", "BASHFontApp", w / 2, (h / 2) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText("All is right in the Zone.", "BASHFontLight", w / 2, (h / 2) + 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		end
	end

	self.PDA.Content.ScrollContent = {};
	local function populateBounties()
		if self.PDA.Content.ScrollContent[1] then
			for index, panel in pairs(self.PDA.Content.ScrollContent) do
				if panel and panel:IsValid() then
					panel:Remove();
				end
			end
		end

		self.PDA.Content.ScrollContent = {};
		local bounties = self.Bounties;
		local index = 1;
		local y = 0;

		surface.SetFont("BASHFontHeavy");
		local statusColor = Color(255, 255, 255, 255);
		local statusLength, _ = surface.GetTextSize("Bounty Status: ");
		for id, data in pairs(bounties) do
			if data.Status == "OPEN" then
				statusColor = Color(100, 150, 50, 255);
			elseif data.Status == "FROZEN" then
				statusColor = Color(50, 150, 150, 255);
			elseif data.Status == "COMPLETED" or data.Status == "CLOSED" then
				statusColor = Color(150, 50, 50, 255);
			end

			self.PDA.Content.ScrollContent[index] = vgui.Create("Panel", self.PDA.Content.Scroll);
			self.PDA.Content.ScrollContent[index]:SetSize(690, 100);
			self.PDA.Content.ScrollContent[index]:SetPos(5, y + 5);
			self.PDA.Content.ScrollContent[index].Paint = function(self, w, h)
				draw.NoTexture();

				surface.SetDrawColor(Color(150, 150, 150, 255));
				surface.DrawOutlinedRect(0, 0, w, h);

				draw.SimpleText(data.Target .. ": " .. data.Price .. " ru", "BASHFontLarge", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText("Owner: " .. data.Owner, "BASHFontHeavy", w - 5, 5, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText("Bounty Status: ", "BASHFontHeavy", 5, h - 5, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
				draw.SimpleText(data.Status, "BASHFontLarge", statusLength + 5, h - 2, statusColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
				draw.SimpleText("ID: " .. id, "BASHFontSmall", w - 5, h - 5, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP);
			end
			self.PDA.Content.ScrollContent[index].OnMousePressed = function(self, mouse)
				if mouse != MOUSE_RIGHT then return end;

				local options = DermaMenu();
				options:AddOption("Copy ID to Clipboard", function()
						SetClipboardText(id);
						BASH:CreateNotif("Bounty ID copied to clipboard!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					end):SetImage("icon16/cog.png");
				options:AddSpacer();
				options:AddOption("Close", function() end):SetImage("icon16/cross.png");
				options:Open();
			end
			self.PDA.Content.ScrollContent[index]:SetVisible(true);

			local descLabel = vgui.Create("DLabel", self.PDA.Content.ScrollContent[index]);
			descLabel:SetPos(5, 30);
			descLabel:SetFont("BASHFontHeavy");
			descLabel:SetText(FormatString(data.Desc, "BASHFontLight", 610));
			descLabel:SizeToContents();

			self.PDA.Content.Scroll:AddItem(self.PDA.Content.ScrollContent[index]);
			index = index + 1;
			y = y + 105;
		end

		self.PDA.Content.Scroll.Populated = true;
	end

	self.PDA.Content.Scroll = vgui.Create("DScrollPanel", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 468);
	self.PDA.Content.Scroll:SetPos(1, 1);
	self.PDA.Content.Scroll:SetVisible(false);
	self.PDA.Content.Scroll.VBar.Paint = function() end;
	self.PDA.Content.Scroll.Populated = false;
	self.PDA.Content.Scroll.VBar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("5", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("6", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
	end
	self.PDA.Content.Scroll:SetVisible(true);
	self.PDA.Content.Scroll.Think = function()
		if self.Bounties and self.Bounties != "" and !self.PDA.Content.Scroll.Populated then
			populateBounties();
		end
	end
end
netstream.Hook("BASH_Send_Bounties_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;
	BASH.Bounties = data;
	BASH:BountyApp();
end);

function BASH:AdvertApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("Adverts and Announcements", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);

		if !BASH.Adverts then
			draw.SimpleText("Fetching adverts...", "BASHFontApp", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		elseif table.Count(BASH.Adverts) == 0 then
			draw.SimpleText("No adverts available.", "BASHFontApp", w / 2, (h / 2) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText("The network is quiet.", "BASHFontLight", w / 2, (h / 2) + 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		end
	end

	self.PDA.Content.ScrollContent = {};
	local function populateAdverts()
		if self.PDA.Content.ScrollContent[1] then
			for index, panel in pairs(self.PDA.Content.ScrollContent) do
				if panel and panel:IsValid() then
					panel:Remove();
				end
			end
		end

		self.PDA.Content.ScrollContent = {};
		local adverts = self.Adverts;
		local index = 1;
		local y = 0;

		surface.SetFont("BASHFontHeavy");
		for id, data in pairs(adverts) do
			self.PDA.Content.ScrollContent[index] = vgui.Create("Panel", self.PDA.Content.Scroll);
			self.PDA.Content.ScrollContent[index]:SetSize(690, 100);
			self.PDA.Content.ScrollContent[index]:SetPos(5, y + 5);
			self.PDA.Content.ScrollContent[index].Paint = function(self, w, h)
				draw.NoTexture();

				surface.SetDrawColor(Color(150, 150, 150, 255));
				surface.DrawOutlinedRect(0, 0, w, h);

				draw.SimpleText(data.Title, "BASHFontLarge", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText("Owner: " .. data.Owner, "BASHFontHeavy", w - 5, 5, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText("ID: " .. id, "BASHFontSmall", w - 5, h - 5, COLOR_WHITE, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP);
			end
			self.PDA.Content.ScrollContent[index].OnMousePressed = function(self, mouse)
				if mouse != MOUSE_RIGHT then return end;

				local options = DermaMenu();
				options:AddOption("Copy ID to Clipboard", function()
						SetClipboardText(id);
						BASH:CreateNotif("Advert ID copied to clipboard!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					end):SetImage("icon16/cog.png");
				options:AddSpacer();
				options:AddOption("Close", function() end):SetImage("icon16/cross.png");
				options:Open();
			end
			self.PDA.Content.ScrollContent[index]:SetVisible(true);

			local descLabel = vgui.Create("DLabel", self.PDA.Content.ScrollContent[index]);
			descLabel:SetPos(5, 30);
			descLabel:SetFont("BASHFontHeavy");
			descLabel:SetText(FormatString(data.Desc, "BASHFontLight", 610));
			descLabel:SizeToContents();

			self.PDA.Content.Scroll:AddItem(self.PDA.Content.ScrollContent[index]);
			index = index + 1;
			y = y + 105;
		end

		self.PDA.Content.Scroll.Populated = true;
	end

	self.PDA.Content.Scroll = vgui.Create("DScrollPanel", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 468);
	self.PDA.Content.Scroll:SetPos(1, 1);
	self.PDA.Content.Scroll:SetVisible(false);
	self.PDA.Content.Scroll.VBar.Paint = function() end;
	self.PDA.Content.Scroll.Populated = false;
	self.PDA.Content.Scroll.VBar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("5", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("6", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
	end
	self.PDA.Content.Scroll:SetVisible(true);
	self.PDA.Content.Scroll.Think = function()
		if self.Adverts and self.Adverts != "" and !self.PDA.Content.Scroll.Populated then
			populateAdverts();
		end
	end
end
netstream.Hook("BASH_Send_Adverts_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;
	BASH.Adverts = data;
	BASH:AdvertApp();
end);

function BASH:ContactsApp()
	self.PDA.Content.Paint = function(self, w, h)
		draw.NoTexture();
		draw.SimpleText("Contacts and Messaging", "BASHFontHeavy", w / 2, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
	end

	self.PDA.Content.Container.Right = vgui.Create("DPanel", self.PDA.Content.Container);
	self.PDA.Content.Container.Right:SetPos(357, 1);
	self.PDA.Content.Container.Right:SetSize(357, 468);
	self.PDA.Content.Container.Right.Paint = function(self, w, h)
		draw.NoTexture();

		if BASH.ChatData and self.ContactSIM and self.ContactChat and self.ContactChatID then
			draw.SimpleText(BASH.ChatData[self.ContactSIM].Handle, "BASHFontLarge", w / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		end
	end

	netstream.Start("BASH_Request_Messages", self.PDA.SIMCard);
end
function BASH:RefreshContacts()
	if self.PDA.Content.Container.Left and self.PDA.Content.Container.Left:IsValid() then
		self.PDA.Content.Container.Left:Remove();
		self.PDA.Content.Container.Left = nil;
	end

	self.PDA.Content.Container.Left = vgui.Create("DPanel", self.PDA.Content.Container);
	self.PDA.Content.Container.Left:SetPos(1, 1);
	self.PDA.Content.Container.Left:SetSize(356, 468);
	self.PDA.Content.Container.Left.Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBox(0, w - 1, 0, 1, h, color_black);
	end

	self.PDA.Content.Container.Left.Scroll = vgui.Create("BASHScroll", self.PDA.Content.Container.Left);
	self.PDA.Content.Container.Left.Scroll:SetSize(336, 448);
	self.PDA.Content.Container.Left.Scroll:SetPos(10, 10);
	self.PDA.Content.Container.Left.ScrollContent = {};
	local index = 2;
	local y = 0;

	self.PDA.Content.Container.Left.ScrollContent[1] = self:CreateButton(10, y, 316, 40, self.PDA.Content.Container.Left.Scroll);
	self.PDA.Content.Container.Left.ScrollContent[1].Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBox(8, 0, 2, w, h - 4, Color(0, 150, 0));

		draw.SimpleText("+", "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Container.Left.ScrollContent[1].Action = function()
		Derma_StringRequest("Add Contact", "Enter the handle of the person you would like to contact.", "",
				function(text)
					netstream.Start("BASH_New_Message", {self.PDA.SIMCard, text});
				end,
				function() end,
				"Start Chat");
	end
	self.PDA.Content.Container.Left.ScrollContent[1]:SetVisible(true);
	self.PDA.Content.Container.Left.Scroll:AddItem(self.PDA.Content.Container.Left.ScrollContent[1]);
	y = y + 40;

	for sim, chatData in pairs(self.ChatData) do
		if isstring(chatData) then continue end;
		self.PDA.Content.Container.Left.ScrollContent[index] = self:CreateButton(10, y, 316, 40, self.PDA.Content.Container.Left.Scroll);
		self.PDA.Content.Container.Left.ScrollContent[index].ContactSIM = sim;
		self.PDA.Content.Container.Left.ScrollContent[index].ContactChatID = chatData.ChatID;
		self.PDA.Content.Container.Left.ScrollContent[index].ContactChat = chatData.Chat;
		self.PDA.Content.Container.Left.ScrollContent[index].Paint = function(self, w, h)
			draw.NoTexture();

			local col = Color(100, 100, 100, 150);
			if index % 2 == 0 then
				col = Color(200, 200, 200, 150);
			end
			draw.RoundedBox(8, 0, 2, w, h - 4, col);
			draw.SimpleText(chatData.Handle, "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if BASH.PDANotifs and BASH.PDANotifs[BASH.PDA.SIMCard] and BASH.PDANotifs[BASH.PDA.SIMCard][self.ContactChatID] then
				draw.SimpleText("!", "BASHFontLarge", w - 5, h / 2, color_red, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
			end
		end
		self.PDA.Content.Container.Left.ScrollContent[index].Action = function(self)
			if BASH.PDANotifs and BASH.PDANotifs[BASH.PDA.SIMCard] and BASH.PDANotifs[BASH.PDA.SIMCard][self.ContactChatID] then
				BASH.PDANotifs[BASH.PDA.SIMCard][self.ContactChatID] = nil;
				if table.Count(BASH.PDANotifs[BASH.PDA.SIMCard]) == 0 then
					BASH.MessageNotif[BASH.PDA.SIMCard] = nil;
				end
			end
			BASH.PDA.Content.Container.Right.ContactSIM = sim;
			BASH.PDA.Content.Container.Right.ContactChatID = chatData.ChatID;
			BASH.PDA.Content.Container.Right.ContactChat = chatData.Chat;
			BASH:RefreshMessages();
		end
		self.PDA.Content.Container.Left.ScrollContent[index]:SetVisible(true);
		self.PDA.Content.Container.Left.Scroll:AddItem(self.PDA.Content.Container.Left.ScrollContent[index]);
		y = y + 40;
		index = index + 1;
	end
end
function BASH:RefreshMessages()
	if !self.PDA.Content.Container.Right or !self.PDA.Content.Container.Right:IsValid() then return end;
	if !self.PDA.Content.Container.Right.ContactSIM or
	   !self.PDA.Content.Container.Right.ContactChatID or
	   !self.PDA.Content.Container.Right.ContactChat then return end;

	if self.PDA.Content.Container.Right.Chat and self.PDA.Content.Container.Right.Chat:IsValid() then
		self.PDA.Content.Container.Right.Chat:Remove();
		self.PDA.Content.Container.Right.Chat = nil;
	end

	if self.PDA.Content.Container.Right.ChatWrapper and self.PDA.Content.Container.Right.ChatWrapper:IsValid() then
		self.PDA.Content.Container.Right.ChatWrapper:Remove();
		self.PDA.Content.Container.Right.ChatWrapper = nil;
	end

	if self.PDA.Content.Container.Right.Options and self.PDA.Content.Container.Right.Options:IsValid() then
		self.PDA.Content.Container.Right.Options:Remove();
		self.PDA.Content.Container.Right.Options = nil;
	end

	self.PDA.Content.Container.Right.Options = BASH:CreateButton(300, 5, 20, 20, self.PDA.Content.Container.Right);
	self.PDA.Content.Container.Right.Options:SetText("...");
	self.PDA.Content.Container.Right.Options.Paint = function(self, w, h)
		draw.SimpleText("...", "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Container.Right.Options.Action = function(self)
		local options = DermaMenu();
		options:AddOption("Block Contact", function()
				netstream.Start("BASH_Block_Contact", {BASH.PDA.SIMCard, BASH.PDA.Content.Container.Right.ContactSIM});
			end):SetImage("icon16/user_delete.png");
		options:AddSpacer();
		options:AddOption("Close", function() end):SetImage("icon16/cross.png");
		options:Open();
	end

	self.PDA.Content.Container.Right.Chat = vgui.Create("BASHScroll", self.PDA.Content.Container.Right);
	self.PDA.Content.Container.Right.Chat:SetSize(337, 388);
	self.PDA.Content.Container.Right.Chat:SetPos(10, 40);
	self.PDA.Content.Container.Right.Chat.Lines = {};

	local x = 5;
	local y = 5;
	local ownsMessage = false;
	for index, line in pairs(self.PDA.Content.Container.Right.ContactChat) do
		ownsMessage = line.Sender == self.PDA.SIMCard;

		self.PDA.Content.Container.Right.Chat.Lines[index] = vgui.Create("DLabel", self.PDA.Content.Container.Right.Chat);
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetFont("BASHFontHeavy");
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetText(FormatString(line.Message, "BASHFontHeavy", 317));
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetPos(x, y);
		self.PDA.Content.Container.Right.Chat.Lines[index]:SizeToContents();
		if !ownsMessage then
			self.PDA.Content.Container.Right.Chat.Lines[index]:SetColor(Color(200, 200, 200));
		else
			self.PDA.Content.Container.Right.Chat.Lines[index]:SetPos(317 - self.PDA.Content.Container.Right.Chat.Lines[index]:GetWide(), y);
			self.PDA.Content.Container.Right.Chat.Lines[index]:SetColor(color_green);
		end
		self.PDA.Content.Container.Right.Chat:AddItem(self.PDA.Content.Container.Right.Chat.Lines[index]);
		y = y + self.PDA.Content.Container.Right.Chat.Lines[index]:GetTall() + 10;
	end
	self.PDA.Content.Container.Right.Chat:PerformLayout();
	self.PDA.Content.Container.Right.Chat.VBar:SetScroll(math.huge);

	local posX, posY = self.PDA.Content.Container.Right:LocalToScreen(0, 0);
	self.PDA.Content.Container.Right.ChatWrapper = vgui.Create("DFrame");
	self.PDA.Content.Container.Right.ChatWrapper:SetSize(337, 20);
	self.PDA.Content.Container.Right.ChatWrapper:SetPos(posX + 10, posY + 438);
	self.PDA.Content.Container.Right.ChatWrapper:SetTitle("");
	self.PDA.Content.Container.Right.ChatWrapper:ShowCloseButton(false);
	self.PDA.Content.Container.Right.ChatWrapper:SetDraggable(false);
	self.PDA.Content.Container.Right.ChatWrapper:MakePopup();
	self.PDA.Content.Container.Right.ChatWrapper.Paint = function() end;

	self.PDA.Content.Container.Right.ChatBox = vgui.Create("DTextEntry", self.PDA.Content.Container.Right.ChatWrapper);
	self.PDA.Content.Container.Right.ChatBox:SetSize(337, 20);
	self.PDA.Content.Container.Right.ChatBox:SetPos(0, 0);
	self.PDA.Content.Container.Right.ChatBox:SetValue("Enter to send a message...");
	self.PDA.Content.Container.Right.ChatBox.TextCleared = false;
	self.PDA.Content.Container.Right.ChatBox.LastMessage = 0;
	self.PDA.Content.Container.Right.ChatBox.OnMousePressed = function(self, mouse)
		if mouse == MOUSE_LEFT and !self.TextCleared then
			self:SetValue("");
		end
	end
	self.PDA.Content.Container.Right.ChatBox.OnKeyCodeTyped = function(self, key)
		if CurTime() - self.LastMessage < 3 then return end;

		if key == KEY_ENTER then
			local text = self:GetValue();
			if string.gsub(text, " ", "") != "" then
				self:SetText("");
				self.LastMessage = CurTime();
				netstream.Start("BASH_Send_Message", {BASH.PDA.SIMCard, BASH.PDA.Content.Container.Right.ContactSIM, BASH.PDA.Content.Container.Right.ContactChatID, text});
			end
		end
	end
end
function BASH:HandleNewMessage(sender, chatID, message)
	if !self.PDA.Content.Container.Left or !self.PDA.Content.Container.Left:IsValid() or
	   !self.PDA.Content.Container.Right or !self.PDA.Content.Container.Right:IsValid() then return end;
	if self.PDA.Content.Container.Right.ContactChatID != chatID then return end;

	local index = #self.PDA.Content.Container.Right.ContactChat + 1;
	local x = 5;
	local y = 10 + self.PDA.Content.Container.Right.Chat:GetCanvas():GetTall();
	local ownsMessage = sender == self.PDA.SIMCard;

	self.PDA.Content.Container.Right.Chat.Lines[index] = vgui.Create("DLabel", self.PDA.Content.Container.Right.Chat);
	self.PDA.Content.Container.Right.Chat.Lines[index]:SetFont("BASHFontHeavy");
	self.PDA.Content.Container.Right.Chat.Lines[index]:SetText(FormatString(message, "BASHFontHeavy", 326));
	self.PDA.Content.Container.Right.Chat.Lines[index]:SetPos(x, y);
	self.PDA.Content.Container.Right.Chat.Lines[index]:SizeToContents();
	if !ownsMessage then
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetColor(Color(200, 200, 200));
	else
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetPos(312 - self.PDA.Content.Container.Right.Chat.Lines[index]:GetWide(), y);
		self.PDA.Content.Container.Right.Chat.Lines[index]:SetColor(color_green);
	end
	self.PDA.Content.Container.Right.Chat:AddItem(self.PDA.Content.Container.Right.Chat.Lines[index]);
	self.PDA.Content.Container.Right.Chat:PerformLayout();
	self.PDA.Content.Container.Right.Chat.VBar:SetScroll(math.huge);
end

function BASH:EconApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("Economy Statistics", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		draw.SimpleText("Approximate data collected by sysadmins in cooperation with anonymous sources.", "BASHFontSmall", 30, 505, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();

		if !BASH.EconomyStats then
			draw.SimpleText("Calculating...", "BASHFontApp", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			draw.RoundedBoxEx(8, 1, h - ((BASH.EconomyStats.ValueIn / 1000000) * 320), 143, (BASH.EconomyStats.ValueIn / 1000000) * 320, Color(50, 100, 50, 255), true, true);
			draw.SimpleText("Value In", "BASHFontLight", 71, h - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText(tostring(BASH.EconomyStats.ValueIn) .. " ru", "BASHFontSmall", 71, h - ((BASH.EconomyStats.ValueIn / 1000000) * 320) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);

			draw.RoundedBoxEx(8, 144, h - ((BASH.EconomyStats.ValueOut / 1000000) * 320), 143, (BASH.EconomyStats.ValueOut / 1000000) * 320, Color(150, 50, 50, 255), true, true);
			draw.SimpleText("Value Out", "BASHFontLight", 214, h - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText(tostring(BASH.EconomyStats.ValueOut) .. " ru", "BASHFontSmall", 214, h - ((BASH.EconomyStats.ValueOut / 1000000) * 320) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);

			draw.RoundedBoxEx(8, 287, h - ((BASH.EconomyStats.FloatingCash / 1000000) * 320), 143, (BASH.EconomyStats.FloatingCash / 1000000) * 320, Color(150, 150, 50, 255), true, true);
			draw.SimpleText("Floating Cash", "BASHFontLight", 357, h - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText(tostring(BASH.EconomyStats.FloatingCash) .. " ru", "BASHFontSmall", 357, h - ((BASH.EconomyStats.FloatingCash / 1000000) * 320) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);

			draw.RoundedBoxEx(8, 430, h - ((BASH.EconomyStats.CashMoved / 1000000) * 320), 143, (BASH.EconomyStats.CashMoved / 1000000) * 320, Color(50, 50, 150, 255), true, true);
			draw.SimpleText("Cash Moved", "BASHFontLight", 500, h - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText(tostring(BASH.EconomyStats.CashMoved) .. " ru", "BASHFontSmall", 500, h - ((BASH.EconomyStats.CashMoved / 1000000) * 320) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);

			draw.RoundedBoxEx(8, 573, h - ((BASH.EconomyStats.CashFired / 1000000) * 320), 142, (BASH.EconomyStats.CashFired / 1000000) * 320, Color(200, 150, 50, 255), true, true);
			draw.SimpleText("Cash Fired", "BASHFontLight", 643, h - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText(tostring(BASH.EconomyStats.CashFired) .. " ru", "BASHFontSmall", 643, h - ((BASH.EconomyStats.CashFired / 1000000) * 320) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
		end

		surface.SetDrawColor(Color(200, 150, 50, 200));
		surface.DrawLine(1, 150, w, 150);
		draw.SimpleText("1 000 000 ru", "BASHFontSmall", 2, 148, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);

		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
	end

	netstream.Start("BASH_Send_Econ");
end

function BASH:GroupApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("ZoneGroups", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);

		if !BASH.Groups then
			draw.SimpleText("Fetching groups...", "BASHFontApp", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		elseif table.Count(BASH.Groups) == 0 then
			draw.SimpleText("No groups available.", "BASHFontApp", w / 2, (h / 2) - 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.SimpleText("Two heads are better than one.", "BASHFontLight", w / 2, (h / 2) + 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		end
	end

	self.PDA.Content.ScrollContent = {};
	local function populateGroups()
		if self.PDA.Content.ScrollContent[1] then
			for index, panel in pairs(self.PDA.Content.ScrollContent) do
				if panel and panel:IsValid() then
					panel:Remove();
				end
			end
		end

		self.PDA.Content.ScrollContent = {};
		local groups = self.Groups;
		local index = 1;
		local x, y = 0, 0;
		for id, data in pairs(groups) do
			self.PDA.Content.ScrollContent[index] = vgui.Create("Panel", self.PDA.Content.Scroll);
			self.PDA.Content.ScrollContent[index]:SetSize(340, 200);
			self.PDA.Content.ScrollContent[index]:SetPos(x + 5, y + 5);
			self.PDA.Content.ScrollContent[index].Paint = function(self, w, h)
				local statusColor = color_white;
				if data.Hiring == "OPEN" then
					statusColor = Color(100, 150, 50, 255);
				elseif data.Hiring == "???" then
					statusColor = Color(210, 120, 50, 255);
				elseif data.Hiring == "CLOSED" then
					statusColor = Color(150, 50, 50, 255);
				end

				draw.NoTexture();

				surface.SetDrawColor(Color(150, 150, 150, 255));
				surface.DrawOutlinedRect(0, 0, w, h);

				surface.SetFont("BASHFontHeavy");
				local textX = surface.GetTextSize("Enlistment: ");
				draw.SimpleText(data.Name, "BASHFontLarge", w / 2, 5, data.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
				draw.SimpleText("Leader: " .. data.Leader, "BASHFontLight", 5, h - 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
				draw.SimpleText("Enlistment: ", "BASHFontHeavy", 5, h - 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
				draw.SimpleText(data.Hiring, "BASHFontHeavy", 5 + textX, h - 5, statusColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
				draw.SimpleText("ID: " .. id, "BASHFontSmall", w - 5, h - 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP);
			end
			self.PDA.Content.ScrollContent[index].OnMousePressed = function(self, mouse)
				if mouse != MOUSE_RIGHT then return end;

				local options = DermaMenu();
				options:AddOption("Copy ID to Clipboard", function()
						SetClipboardText(id);
						BASH:CreateNotif("Group ID copied to clipboard!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					end):SetImage("icon16/cog.png");
				options:AddSpacer();
				options:AddOption("Close", function() end):SetImage("icon16/cross.png");
				options:Open();
			end
			self.PDA.Content.ScrollContent[index]:SetVisible(true);

			local descLabel = vgui.Create("DLabel", self.PDA.Content.ScrollContent[index]);
			descLabel:SetPos(5, 30);
			descLabel:SetFont("BASHFontHeavy");
			descLabel:SetText(FormatString(data.Desc, "BASHFontLight", 340));
			descLabel:SizeToContents();

			self.PDA.Content.Scroll:AddItem(self.PDA.Content.ScrollContent[index]);
			index = index + 1;
			if index % 2 == 0 then
				x = x + 345;
			else
				x = 0;
				y = y + 205;
			end
		end

		self.PDA.Content.Scroll.Populated = true;
	end

	self.PDA.Content.Scroll = vgui.Create("DScrollPanel", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 468);
	self.PDA.Content.Scroll:SetPos(1, 1);
	self.PDA.Content.Scroll:SetVisible(false);
	self.PDA.Content.Scroll.VBar.Paint = function() end;
	self.PDA.Content.Scroll.Populated = false;
	self.PDA.Content.Scroll.VBar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("5", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("6", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Scroll.VBar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
	end
	self.PDA.Content.Scroll:SetVisible(true);
	self.PDA.Content.Scroll.Think = function()
		if self.Groups and self.Groups != "" and !self.PDA.Content.Scroll.Populated then
			populateGroups();
		end
	end
end
netstream.Hook("BASH_Send_Groups_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;
	BASH.Groups = data;
	BASH:GroupApp();
end);

function BASH:MapApp()
	self.PDA.Content.Paint = function(self, w, h)
		draw.NoTexture();
		draw.SimpleText("GEOZone", "BASHFontHeavy", w / 2, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	if self.PDA.Content.Container and self.PDA.Content.Container:IsValid() then
		if self.PDA.Content.Container.Blips then
			for index, panel in pairs(self.PDA.Content.Container.Blips) do
				panel:Remove();
				self.PDA.Content.Container.Blips[index] = nil;
			end
		end

		self.PDA.Content.Container:Remove();
		self.PDA.Content.Container = nil;
	end

	local map = game.GetMap();
	local bounds = self[map].Bounds;
	local towers = ents.FindByClass("bash_network_tower");
	local stashes = self.PDA.MemoryData.MapData or {};
	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);

	local renderView = {};
	renderView.angles = Angle(90, 90, 0);
	renderView.w = 715;
	renderView.h = 470;
	renderView.ortho = true;
	renderView.ortholeft = -6629.37;
	renderView.orthoright = 6629.37;
	renderView.orthotop = -4000;
	renderView.orthobottom = 4000;
	renderView.drawviewmodel = true;
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();

		for _, ply in pairs(player.GetAll()) do
			if ply:GetEntry("CharLoaded") then
				ply.tempRenderModel = ply:GetModel();
				ply:SetModel("models/props_junk/PopCan01a.mdl");
				ply:SetNoDraw(true)
			end
		end

		local posX, posY = self:LocalToScreen(0, 0);
		/*local old_rt = render.GetRenderTarget();
		local old_w, old_h = ScrW(), ScrH();
		render.SetViewPort(posX, posY, w, h);
		render.Clear(0, 0, 0, 0);
		cam.Start2D();
			renderView.origin = LocalPlayer():GetPos() + Vector(0, 0, 4000);
			renderView.x = posX;
			renderView.y = posY;

			render.RenderView(renderView);
		cam.End2D();
		render.SetViewPort(0, 0, old_w, old_h);
		render.SetRenderTarget(old_rt);*/

		renderView.origin = LocalPlayer():GetPos() + Vector(0, 0, 4000);
		renderView.x = posX;
		renderView.y = posY;

		render.RenderView(renderView);

		for _, ply in pairs(player.GetAll()) do
			if ply:GetEntry("CharLoaded") then
				ply:SetModel(ply.tempRenderModel);
				ply:SetNoDraw(false)
			end
		end

		draw.Circle(w / 2, h / 2, 6, 30, color_black);
		draw.Circle(w / 2, h / 2, 5, 30, color_blue);

		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
	end
	self.PDA.Content.Container.OnMousePressed = function(self, mouse)
		if mouse == MOUSE_RIGHT then
			local options = DermaMenu();
			options:AddOption("Add Stash Data", function()
				Derma_StringRequest("Add Stash Data", "Paste a generated stash data string into the field below.", "",
						function(text)
							local data = util.JSONToTable(text);
							if !text or !data or !data.ID or !data.Pos or !data.Password then
								Derma_Message("Invalid stash data!", "Add Stash Data", "Accept");
								return;
							end

							netstream.Start("BASH_Add_StashData", {BASH.PDA.MemorySlot, text});
						end,
						function() end,
						"Add Stash");
			end):SetImage("icon16/map_add.png");
			options:AddSpacer();
			options:AddOption("Close"):SetImage("icon16/delete.png");
			options:Open();
		end
	end

	self.PDA.Content.Container.Blips = {};
	local index = 1;
	local pos = LocalPlayer():GetPos();
	local portX, portY = self.PDA.Content.Container:GetSize();
	for _, tower in pairs(towers) do
		self.PDA.Content.Container.Blips[index] = self:CreatePanel(0, 0, 24, 24, self.PDA.Content.Container);
		self.PDA.Content.Container.Blips[index].Symbol = "T";
		self.PDA.Content.Container.Blips[index].Color = Color(100, 0, 0);
		self.PDA.Content.Container.Blips[index].Think = function(self)
			local pos = LocalPlayer():GetPos();
			local towerPos = tower:GetPos();
			local towerX = pos.x - towerPos.x;
			local towerY = pos.y - towerPos.y;
			local screenX = (portX / 2) - ((towerX / 13258.74) * portX);
			local screenY = (portY / 2) + ((towerY / 8000) * portY);
			local newX = math.Clamp(screenX - 12, 5, self:GetParent():GetWide() - 29);
			local newY = math.Clamp(screenY - 12, 5, self:GetParent():GetTall() - 29);
			self:SetPos(newX, newY);
		end
		self.PDA.Content.Container.Blips[index].Paint = function(self, w, h)
			local alpha = 200 * math.abs(math.sin(RealTime()));
			local bgCol = Color(20, 20, 20, 255);
			local fgCol = Color(self.Color.r, self.Color.g, self.Color.b, alpha);
			draw.RoundedBox(4, 0, 0, w, h, bgCol);
			draw.RoundedBox(4, 1, 1, w - 2, h - 2, fgCol);
			draw.SimpleText(self.Symbol, "BASHFontHeavy", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if self.Entered then
				local mouseX, mouseY = self:CursorPos();
				surface.SetFont("BASHFontHeavy");
				local textX, _ = surface.GetTextSize("Tower");
				DisableClipping(true);
				draw.RoundedBox(0, mouseX + 5, mouseY - 25, textX + 10, 20, color_black);
				draw.SimpleText("Tower", "BASHFontHeavy", mouseX + 10, mouseY - 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);
				DisableClipping(false);
			end
		end
		self.PDA.Content.Container.Blips[index].OnCursorEntered = function(self)
			self.Entered = true;
		end
		self.PDA.Content.Container.Blips[index].OnCursorExited = function(self)
			self.Entered = false;
		end

		index = index + 1;
	end

	local stashX, stashY;
	for _, data in pairs(stashes) do
		data = util.JSONToTable(data);
		if !data.ID or !data.Pos or !data.Password then continue end;

		self.PDA.Content.Container.Blips[index] = self:CreatePanel(0, 0, 24, 24, self.PDA.Content.Container);
		self.PDA.Content.Container.Blips[index].Entered = false;
		self.PDA.Content.Container.Blips[index].Symbol = "S";
		self.PDA.Content.Container.Blips[index].Color = Color(150, 100, 0);
		self.PDA.Content.Container.Blips[index].Think = function(self)
			local pos = LocalPlayer():GetPos();
			local stashX = pos.x - data.Pos.x;
			local stashY = pos.y - data.Pos.y;
			local screenX = (portX / 2) - ((stashX / 13258.74) * portX);
			local screenY = (portY / 2) + ((stashY / 8000) * portY);
			local newX = math.Clamp(screenX - 12, 5, self:GetParent():GetWide() - 29);
			local newY = math.Clamp(screenY - 12, 5, self:GetParent():GetTall() - 29);
			self:SetPos(newX, newY);
		end
		self.PDA.Content.Container.Blips[index].Paint = function(self, w, h)
			local alpha = 200 * math.abs(math.sin(RealTime()));
			local bgCol = Color(20, 20, 20, 255);
			local fgCol = Color(self.Color.r, self.Color.g, self.Color.b, alpha);
			draw.RoundedBox(4, 0, 0, w, h, bgCol);
			draw.RoundedBox(4, 1, 1, w - 2, h - 2, fgCol);
			draw.SimpleText(self.Symbol, "BASHFontHeavy", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if self.Entered then
				local mouseX, mouseY = self:CursorPos();
				surface.SetFont("BASHFontHeavy");
				local textX, textY = surface.GetTextSize("ID: " .. data.ID .. "\nPassword: " .. data.Password);
				DisableClipping(true);
				draw.RoundedBox(0, mouseX + 5, mouseY - textY - 5, textX + 10, textY + 5, color_black);
				draw.SimpleText("ID: " .. data.ID, "BASHFontHeavy", mouseX + 10, mouseY - 25, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);
				draw.SimpleText("Password: " .. data.Password, "BASHFontHeavy", mouseX + 10, mouseY - 10, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);
				DisableClipping(false);
			end
		end
		self.PDA.Content.Container.Blips[index].OnCursorEntered = function(self)
			self.Entered = true;
		end
		self.PDA.Content.Container.Blips[index].OnCursorExited = function(self)
			self.Entered = false;
		end
		self.PDA.Content.Container.Blips[index].OnMousePressed = function(self, mouse)
			if mouse == MOUSE_LEFT then
				local options = DermaMenu();
				options:AddOption("Remove Stash Data", function()
					Derma_Query("Are you sure you want to delete this stash data from your PDA?", "Remove Stash Data", "Cancel", function() end, "Delete", function()
						netstream.Start("BASH_Remove_StashData", {BASH.PDA.MemorySlot, data.ID});
					end);
				end):SetImage("icon16/map_delete.png");
				options:AddSpacer();
				options:AddOption("Close"):SetImage("icon16/delete.png");
				options:Open();
			end
		end

		index = index + 1;
	end

	for id, alert in pairs(self.Alerts) do
		if alert.Filter != ALERT_PDAS then continue end;

		self.PDA.Content.Container.Blips[index] = self:CreatePanel(0, 0, 24, 24, self.PDA.Content.Container);
		self.PDA.Content.Container.Blips[index].Symbol = alert.Symbol;
		self.PDA.Content.Container.Blips[index].Color = alert.Color;
		self.PDA.Content.Container.Blips[index].Think = function(self)
			if !alert.x or !alert.y then return end;
			local pos = LocalPlayer():GetPos();
			local alertX = pos.x - alert.Pos.x;
			local alertY = pos.y - alert.Pos.y;
			local screenX = (portX / 2) - ((alertX / 13258.74) * portX);
			local screenY = (portY / 2) + ((alertY / 8000) * portY);
			local newX = math.Clamp(screenX - 12, 5, self:GetParent():GetWide() - 29);
			local newY = math.Clamp(screenY - 12, 5, self:GetParent():GetTall() - 29);
			self:SetPos(newX, newY);
		end
		self.PDA.Content.Container.Blips[index].Paint = function(self, w, h)
			local alpha = 200 * math.abs(math.sin(RealTime()));
			local bgCol = Color(20, 20, 20, 255);
			local fgCol = Color(self.Color.r, self.Color.g, self.Color.b, alpha);
			draw.RoundedBox(4, 0, 0, w, h, bgCol);
			draw.RoundedBox(4, 1, 1, w - 2, h - 2, fgCol);
			draw.SimpleText(self.Symbol, "BASHFontHeavy", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if self.Entered then
				local mouseX, mouseY = self:CursorPos();
				surface.SetFont("BASHFontHeavy");
				local textX, _ = surface.GetTextSize("Alert");
				DisableClipping(true);
				draw.RoundedBox(0, mouseX + 5, mouseY - 25, textX + 10, 20, color_black);
				draw.SimpleText("Alert", "BASHFontHeavy", mouseX + 10, mouseY - 15, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);
				DisableClipping(false);
			end
		end
		self.PDA.Content.Container.Blips[index].OnCursorEntered = function(self)
			self.Entered = true;
		end
		self.PDA.Content.Container.Blips[index].OnCursorExited = function(self)
			self.Entered = false;
		end
		self.PDA.Content.Container.Blips[index].OnMousePressed = function(self, mouse)
			if mouse == MOUSE_LEFT then
				local options = DermaMenu();
				options:AddOption("Alert Info", function()
					local alertInfo = vgui.Create("BASHAlertInfo");
					alertInfo:AttachAlert(alert);
					alertInfo:Format();
				end):SetImage("icon16/user.png");
				options:AddSpacer();
				options:AddOption("Close"):SetImage("icon16/delete.png");
				options:Open();
			end
		end

		index = index + 1;
	end
end

function BASH:NotesApp()
	self.PDA.Content.Paint = function(self, w, h)
		draw.NoTexture();
		draw.SimpleText("Notes", "BASHFontHeavy", w / 2, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	if self.PDA.Content.Container and self.PDA.Content.Container:IsValid() then
		self.PDA.Content.Container:Remove();
		self.PDA.Content.Container = nil;
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
	end

	self.PDA.Content.Container.Right = vgui.Create("DPanel", self.PDA.Content.Container);
	self.PDA.Content.Container.Right:SetPos(357, 1);
	self.PDA.Content.Container.Right:SetSize(357, 468);
	self.PDA.Content.Container.Right.Paint = function() end;

	if self.PDA.Content.Container.Left and self.PDA.Content.Container.Left:IsValid() then
		self.PDA.Content.Container.Left:Remove();
		self.PDA.Content.Container.Left = nil;
	end

	self.PDA.Content.Container.Left = vgui.Create("DPanel", self.PDA.Content.Container);
	self.PDA.Content.Container.Left:SetPos(1, 1);
	self.PDA.Content.Container.Left:SetSize(356, 468);
	self.PDA.Content.Container.Left.Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBox(0, w - 1, 0, 1, h, color_black);
	end

	self.PDA.Content.Container.Left.Scroll = vgui.Create("BASHScroll", self.PDA.Content.Container.Left);
	self.PDA.Content.Container.Left.Scroll:SetSize(336, 448);
	self.PDA.Content.Container.Left.Scroll:SetPos(10, 10);
	self.PDA.Content.Container.Left.ScrollContent = {};
	local index = 2;
	local y = 0;

	self.PDA.Content.Container.Left.ScrollContent[1] = self:CreateButton(10, y, 316, 40, self.PDA.Content.Container.Left.Scroll);
	self.PDA.Content.Container.Left.ScrollContent[1].Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBox(8, 0, 2, w, h - 4, Color(0, 150, 0));

		draw.SimpleText("+", "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Container.Left.ScrollContent[1].Action = function()
		Derma_StringRequest("Create Note", "Enter a title for your note.", "",
				function(text)
					if self.PDA.MemoryData and self.PDA.MemoryData.Notes[text] then
						Derma_Message("You already have a note with this title!", "Note Error", "Accept");
						return;
					else
						netstream.Start("BASH_New_Note", {self.PDA.MemorySlot, text});
					end
				end,
				function() end,
				"Create Note");
	end
	self.PDA.Content.Container.Left.ScrollContent[1]:SetVisible(true);
	self.PDA.Content.Container.Left.Scroll:AddItem(self.PDA.Content.Container.Left.ScrollContent[1]);
	y = y + 40;

	for title, note in pairs(self.PDA.MemoryData.Notes) do
		self.PDA.Content.Container.Left.ScrollContent[index] = self:CreateButton(10, y, 316, 40, self.PDA.Content.Container.Left.Scroll);
		self.PDA.Content.Container.Left.ScrollContent[index].Title = title;
		self.PDA.Content.Container.Left.ScrollContent[index].NoteData = note;
		self.PDA.Content.Container.Left.ScrollContent[index].Paint = function(self, w, h)
			draw.NoTexture();

			local col = Color(100, 100, 100, 150);
			if index % 2 == 0 then
				col = Color(200, 200, 200, 150);
			end
			draw.RoundedBox(8, 0, 2, w, h - 4, col);
			draw.SimpleText(title, "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
		self.PDA.Content.Container.Left.ScrollContent[index].Action = function(self)
			BASH.PDA.Content.Container.Right.Title = title;
			BASH.PDA.Content.Container.Right.NoteData = note;
			BASH:RefreshNote();
		end
		self.PDA.Content.Container.Left.ScrollContent[index]:SetVisible(true);
		self.PDA.Content.Container.Left.Scroll:AddItem(self.PDA.Content.Container.Left.ScrollContent[index]);
		y = y + 40;
		index = index + 1;
	end
end
function BASH:RefreshNote()
	if !self.PDA.Content.Container.Right or !self.PDA.Content.Container.Right:IsValid() then return end;
	if !self.PDA.Content.Container.Right.Title or
	   !self.PDA.Content.Container.Right.NoteData then return end;

	if self.PDA.Content.Container.Right.Note and self.PDA.Content.Container.Right.Note:IsValid() then
		self.PDA.Content.Container.Right.Note:Remove();
		self.PDA.Content.Container.Right.Note = nil;
	end

	if self.PDA.Content.Container.Right.NoteWrapper and self.PDA.Content.Container.Right.NoteWrapper:IsValid() then
		self.PDA.Content.Container.Right.NoteWrapper:Remove();
		self.PDA.Content.Container.Right.NoteWrapper = nil;
	end

	if self.PDA.Content.Container.Right.NoteEditor and self.PDA.Content.Container.Right.NoteEditor:IsValid() then
		self.PDA.Content.Container.Right.NoteEditor:Remove();
		self.PDA.Content.Container.Right.NoteEditor = nil;
	end

	if self.PDA.Content.Container.Right.Options and self.PDA.Content.Container.Right.Options:IsValid() then
		self.PDA.Content.Container.Right.Options:Remove();
		self.PDA.Content.Container.Right.Options = nil;
	end

	self.PDA.Content.Container.Right.Options = BASH:CreateButton(300, 5, 20, 20, self.PDA.Content.Container.Right);
	self.PDA.Content.Container.Right.Options:SetText("...");
	self.PDA.Content.Container.Right.Options.Paint = function(self, w, h)
		draw.SimpleText("...", "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.PDA.Content.Container.Right.Options.Action = function(self)
		local options = DermaMenu();
		options:AddOption("Edit Title", function()
				Derma_StringRequest("Edit Title", "Enter your new note title.", BASH.PDA.Content.Container.Right.Title,
						function(text)
							if BASH.PDA.MemoryData and BASH.PDA.MemoryData.Notes[text] then
								Derma_Message("You already have a note with this title!", "Note Error", "Accept");
								return;
							else
								netstream.Start("BASH_Edit_Note", {BASH.PDA.MemorySlot, BASH.PDA.Content.Container.Right.Title, text});
							end
						end,
						function() end,
						"Edit Title");
			end):SetImage("icon16/page_white_edit.png");
		options:AddOption("Edit Note", function()
				if !BASH.PDA.Content.Container.Right.Note or !BASH.PDA.Content.Container.Right.Note:IsValid() then return end;
				local posX, posY = BASH.PDA.Content.Container.Right:LocalToScreen(0, 0);
				BASH.PDA.Content.Container.Right.NoteWrapper = vgui.Create("DFrame");
				BASH.PDA.Content.Container.Right.NoteWrapper:SetSize(337, 368);
				BASH.PDA.Content.Container.Right.NoteWrapper:SetPos(posX + 10, posY + 40);
				BASH.PDA.Content.Container.Right.NoteWrapper:SetTitle("");
				BASH.PDA.Content.Container.Right.NoteWrapper:ShowCloseButton(false);
				BASH.PDA.Content.Container.Right.NoteWrapper:SetDraggable(false);
				BASH.PDA.Content.Container.Right.NoteWrapper:MakePopup();
				BASH.PDA.Content.Container.Right.NoteWrapper.Paint = function() end;

				BASH.PDA.Content.Container.Right.NoteEditor = vgui.Create("DTextEntry", BASH.PDA.Content.Container.Right.NoteWrapper);
				BASH.PDA.Content.Container.Right.NoteEditor:SetPos(0, 0);
				BASH.PDA.Content.Container.Right.NoteEditor:SetSize(337, 368);
				BASH.PDA.Content.Container.Right.NoteEditor:SetMultiline(true);
				BASH.PDA.Content.Container.Right.NoteEditor:SetValue(BASH.PDA.Content.Container.Right.NoteData);
				local update = BASH:CreateButton(10, 408, 337, 20, BASH.PDA.Content.Container.Right);
				update:SetText("Update Note");
				update.Action = function()
					local text = BASH.PDA.Content.Container.Right.NoteEditor:GetValue();
					netstream.Start("BASH_Update_Note", {BASH.PDA.MemorySlot, BASH.PDA.Content.Container.Right.Title, text});
					BASH.PDA.Content.Container.Right.NoteWrapper:Remove();
					BASH.PDA.Content.Container.Right.NoteWrapper = nil;
					BASH.PDA.Content.Container.Right.NoteEditor:Remove();
					BASH.PDA.Content.Container.Right.NoteEditor = nil;
					BASH.PDA.Content.Container.Right.Note.Content:SetText(FormatString(text, "BASHFontHeavy", 322));
				end
			end):SetImage("icon16/page_white_edit.png");
		options:AddOption("Delete Note", function()
				netstream.Start("BASH_Delete_Note", {BASH.PDA.MemorySlot, BASH.PDA.Content.Container.Right.Title});
			end):SetImage("icon16/page_white_delete.png");
		options:AddSpacer();
		options:AddOption("Close", function() end):SetImage("icon16/cross.png");
		options:Open();
	end

	self.PDA.Content.Container.Right.Note = vgui.Create("BASHScroll", self.PDA.Content.Container.Right);
	self.PDA.Content.Container.Right.Note:SetSize(337, 388);
	self.PDA.Content.Container.Right.Note:SetPos(10, 40);
	self.PDA.Content.Container.Right.Note.Content = vgui.Create("DLabel", self.PDA.Content.Container.Right.Note);
	self.PDA.Content.Container.Right.Note.Content:SetPos(5, 5);
	self.PDA.Content.Container.Right.Note.Content:SetFont("BASHFontHeavy");
	self.PDA.Content.Container.Right.Note.Content:SetText(FormatString(self.PDA.Content.Container.Right.NoteData, "BASHFontHeavy", 322));
	self.PDA.Content.Container.Right.Note.Content:SizeToContents();
	self.PDA.Content.Container.Right.Note:AddItem(self.PDA.Content.Container.Right.Note.Content);
end

function BASH:SettingsApp()
	self.PDA.Content.Paint = function()
		draw.NoTexture();
		draw.SimpleText("Your Settings", "BASHFontHeavy", 377, 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	self.PDA.Content.Container = vgui.Create("DPanel", self.PDA.Content);
	self.PDA.Content.Container:SetPos(30, 30);
	self.PDA.Content.Container:SetSize(715, 470);
	self.PDA.Content.Container.Paint = function(self, w, h)
		draw.NoTexture();
		surface.SetDrawColor(Color(150, 150, 150, 255));
		surface.DrawOutlinedRect(0, 0, w, h);
	end

	self.PDA.Content.Scroll = vgui.Create("BASHScroll", self.PDA.Content.Container);
	self.PDA.Content.Scroll:SetSize(713, 468);
	self.PDA.Content.Scroll:SetPos(1, 1);

	local y = 10;
	local pdaLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	pdaLabel:SetPos(10, y);
	pdaLabel:SetFont("BASHFontLarge");
	pdaLabel:SetText("PDA Settings");
	pdaLabel:SizeToContents();
	self.PDA.Content.Scroll:AddItem(pdaLabel);
	y = y + pdaLabel:GetTall() + 5;

	local ghostModeLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	ghostModeLabel:SetPos(10, y);
	ghostModeLabel:SetFont("BASHFontHeavy");
	ghostModeLabel:SetText(FormatString("Ghost Mode: Enable to mask your connection to other STALKERs. You will not appear on the 'STALKERs In Your Area' app. However, you cannot access the app yourself.", "BASHFontHeavy", 690));
	ghostModeLabel:SizeToContents();
	self.PDA.Content.Scroll:AddItem(ghostModeLabel);
	y = y + ghostModeLabel:GetTall() + 5;

	local ghostMode = vgui.Create("DCheckBox", self.PDA.Content.Scroll);
	ghostMode:SetSize(75, 20);
	ghostMode:SetPos(10, y);
	ghostMode:SetValue(self.PDA.MemoryData.GhostMode);
	ghostMode.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));

		if self:GetChecked() then
			draw.RoundedBox(4, 2, 2, (w / 2) - 4, h - 4, Color(0, 0, 0, 255));
			draw.RoundedBox(4, 3, 3, (w / 2) - 6, h - 6, Color(50, 150, 50, 255));
		else
			draw.RoundedBox(4, (w / 2) + 1, 2, (w / 2) - 4, h - 4, Color(0, 0, 0, 255));
			draw.RoundedBox(4, (w / 2) + 2, 3, (w / 2) - 6, h - 6, Color(150, 50, 50, 255));
		end
	end
	ghostMode.OnChange = function(self, val)
		netstream.Start("BASH_Update_GhostMode", {BASH.PDA.MemorySlot, tobool(val)});
	end
	self.PDA.Content.Scroll:AddItem(ghostMode);
	local y = y + ghostMode:GetTall() + 10;

	local simLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	simLabel:SetPos(10, y);
	simLabel:SetFont("BASHFontLarge");
	simLabel:SetText("SIM Card Settings");
	simLabel:SizeToContents();
	self.PDA.Content.Scroll:AddItem(simLabel);
	y = y + simLabel:GetTall() + 5;

	local netHandleLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	netHandleLabel:SetPos(10, y);
	netHandleLabel:SetFont("BASHFontHeavy");
	netHandleLabel:SetText(FormatString("Net Handle: Your handle on STALKERnet. Other STALKERs will recognize your adverts and messages by this handle.", "BASHFontHeavy", 690));
	netHandleLabel:SizeToContents();
	netHandleLabel.PaintOver = function(self, w, h)
		DisableClipping(true);
		draw.SimpleText("Your current handle: " .. ((BASH.PDA.SIMData and BASH.PDA.SIMData.Handle) or "[NO SIM CARD]"), "BASHFontLight", 0, h + 4, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		DisableClipping(false);
	end
	self.PDA.Content.Scroll:AddItem(netHandleLabel);
	y = y + netHandleLabel:GetTall() + 22;

	local netHandle = self:CreateTextButton("Edit Handle", "BASHFontHeavy", 10, y, self.PDA.Content.Scroll);
	netHandle.Action = function()
		if !BASH.PDA.SIMData then return end;

		Derma_StringRequest(
			"Edit Net Handle",
			"Input a new handle here. Must be at least 4 and no more than 32 characters long.\nNo spaces or non-alphanumeric characters.",
			"",
			function(text)
				if string.len(text) < 4 or string.len(text) > 32 then
					self:CreateNotif("The handle you input is too short/long.", "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
					return;
				else
					local suggestion, replaces = string.gsub(text, "%W", "");

					if suggestion != text and replaces > 0 then
						self:CreateNotif("The handle you input contains illegal characters. Suggestion: " .. suggestion, "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
						return;
					end
				end

				netstream.Start("BASH_Update_Handle", {BASH.PDA.SIMCard, text});
				self:CreateNotif("Handle set to: " .. text .. ".", "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
			end,
			function(text) end,
			"Submit Handle",
			"Cancel"
		);
	end
	self.PDA.Content.Scroll:AddItem(netHandle);
	y = y + netHandle:GetTall() + 5;

	local statusLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	statusLabel:SetPos(10, y);
	statusLabel:SetFont("BASHFontHeavy");
	statusLabel:SetText(FormatString("Online Status: Your public status on STALKERnet.", "BASHFontHeavy", 690));
	statusLabel:SizeToContents();
	statusLabel.PaintOver = function(self, w, h)
		DisableClipping(true);
		draw.SimpleText("Your current status: " .. ((BASH.PDA.SIMData and BASH.PDA.SIMData.Status) or "[NO SIM CARD]"), "BASHFontLight", 0, h + 4, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		DisableClipping(false);
	end
	self.PDA.Content.Scroll:AddItem(statusLabel);
	y = y + statusLabel:GetTall() + 22;

	local status = vgui.Create("DComboBox", self.PDA.Content.Scroll);
	status:SetSize(100, 20);
	status:SetPos(10, y);
	status:SetValue((self.PDA.SIMData and self.PDA.SIMData.Status) or "[NO SIM CARD]");
	if self.PDA.SIMData then
		status:AddChoice("Online");
		status:AddChoice("Away");
		status:AddChoice("Busy");
	end
	status.OnSelect = function(self, index, value)
		netstream.Start("BASH_Update_Status", {BASH.PDA.SIMCard, value});
	end
	self.PDA.Content.Scroll:AddItem(status);
	y = y + status:GetTall() + 5;

	local titleLabel = vgui.Create("DLabel", self.PDA.Content.Scroll);
	titleLabel:SetPos(10, y);
	titleLabel:SetFont("BASHFontHeavy");
	titleLabel:SetText(FormatString("Title Message: A short message you can set for other online users to see.", "BASHFontHeavy", 690));
	titleLabel:SizeToContents();
	titleLabel.PaintOver = function(self, w, h)
		DisableClipping(true);
		draw.SimpleText("Your current title: " .. ((BASH.PDA.SIMData and BASH.PDA.SIMData.Title) or "[NO SIM CARD]"), "BASHFontLight", 0, h + 4, Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		DisableClipping(false);
	end
	self.PDA.Content.Scroll:AddItem(titleLabel);
	y = y + titleLabel:GetTall() + 22;

	local title = self:CreateTextButton("Edit Title", "BASHFontHeavy", 10, y, self.PDA.Content.Scroll);
	title.Action = function()
		if !BASH.PDA.SIMData then return end;

		Derma_StringRequest(
			"Edit Net Title",
			"Input a new title here. Must be no more than 24 characters long.",
			"",
			function(text)
				if string.len(text) > 24 then
					self:CreateNotif("The title you input is too short/long.", "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
					return;
				end

				netstream.Start("BASH_Update_Title", {BASH.PDA.SIMCard, text});
				self:CreateNotif("Title set to: " .. text .. ".", "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
			end,
			function(text) end,
			"Submit Title",
			"Cancel"
		);
	end
	self.PDA.Content.Scroll:AddItem(title);
	y = y + title:GetTall() + 5;
end
