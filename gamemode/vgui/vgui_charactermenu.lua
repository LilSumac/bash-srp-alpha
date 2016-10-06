local BASH = BASH;
BASH.CharacterMenu = {};
BASH.CharacterMenu.Object = nil;
BASH.CharacterMenu.Open = false;
BASH.CharacterMenu.Closing = false;
BASH.CharacterMenu.Panes = {};
BASH.CharacterMenu.Blips = {};
BASH.CharacterMenu.LeadPane = 1;
BASH.CharacterMenu.MaxVisibleCharacters = nil;
BASH.CharacterMenu.ExtraSpace = 0;
BASH.CharacterMenu.BackgroundColor = Color(0, 0, 0, 0);
BASH.CharacterMenu.CurtainColor = Color(0, 0, 0, 0);
BASH.CharacterMenu.ForegroundPrimaryColor = Color(255, 255, 255, 0);
BASH.CharacterMenu.ForegroundSecondaryColor = Color(0, 0, 0, 125);
BASH.CharacterMenu.ForegroundTertiaryColor = Color(125, 125, 255, 0);

function BASH:CreateCharacterMenu()
	if !CheckPly(LocalPlayer()) then return end;
	self.CharacterMenu.Open = true;
	self.CharacterMenu.LeadPane = 1;

	gui.EnableScreenClicker(true);
	self.CharacterMenu.Closing = false;
	self.CharacterMenu.Object = self:CreatePanel(0, 0, SCRW, SCRH);
	self.CharacterMenu.Object.Paint = function()
		draw.RoundedBox(0, 0, 0, self.CharacterMenu.Object:GetWide(), SCRH, self.CharacterMenu.BackgroundColor);
		draw.SimpleText("#!/BASH/SRP/Alpha", "BASHFontLarge", SCRW / 2, SCRH * 0.1, self.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

		if self.CharacterMenu.Closing then return end;

		self.CharacterMenu.BackgroundColor.a = math.Approach(self.CharacterMenu.BackgroundColor.a, 200, 2);
		self.CharacterMenu.ForegroundPrimaryColor.a = math.Approach(self.CharacterMenu.ForegroundPrimaryColor.a, 255, 2);
		self.CharacterMenu.ForegroundSecondaryColor.a = math.Approach(self.CharacterMenu.ForegroundSecondaryColor.a, 255, 2);
		self.CharacterMenu.ForegroundTertiaryColor.a = math.Approach(self.CharacterMenu.ForegroundTertiaryColor.a, 255, 2);
	end

	self.CharacterMenu.Object.Selection = self:CreatePanel(SCRW * 0.125, SCRH, SCRW * 0.75, 256, self.CharacterMenu.Object);
	self.CharacterMenu.Object.Selection.Paint = function() end;
	self.CharacterMenu.Object.Selection:MoveTo(SCRW * 0.125, SCRH - 281, 1, 0, 1);

	self.CharacterMenu.Object.Selection.Left = self:CreateButton(0, 0, 28, 256, self.CharacterMenu.Object.Selection);
	self.CharacterMenu.Object.Selection.Left.Paint = function(self)
		if self.Entered then
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), BASH.CharacterMenu.ForegroundTertiaryColor);
		else
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), BASH.CharacterMenu.ForegroundPrimaryColor);
		end

		draw.RoundedBox(0, 1, 1, self:GetWide() - 2, self:GetTall() - 2, BASH.CharacterMenu.ForegroundSecondaryColor);

		if self.Entered then
			draw.SimpleText("3", "marlett", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			draw.SimpleText("3", "marlett", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end;
	self.CharacterMenu.Object.Selection.Left.Action = function()
		self:ShiftCharactersLeft();
	end

	self.CharacterMenu.Object.Selection.Right = self:CreateButton((SCRW * 0.75) - 28, 0, 28, 256, self.CharacterMenu.Object.Selection);
	self.CharacterMenu.Object.Selection.Right.Paint = function(self)
		if self.Entered then
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), BASH.CharacterMenu.ForegroundTertiaryColor);
		else
			draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), BASH.CharacterMenu.ForegroundPrimaryColor);
		end

		draw.RoundedBox(0, 1, 1, self:GetWide() - 2, self:GetTall() - 2, BASH.CharacterMenu.ForegroundSecondaryColor);

		if self.Entered then
			draw.SimpleText("4", "marlett", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			draw.SimpleText("4", "marlett", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end;
	self.CharacterMenu.Object.Selection.Right.Action = function()
		self:ShiftCharactersRight();
	end

	self.CharacterMenu.MaxVisibleCharacters = (SCRW * 0.75) / 256;
	self.CharacterMenu.ExtraSpace = (256 * (self.CharacterMenu.MaxVisibleCharacters / math.floor(self.CharacterMenu.MaxVisibleCharacters))) / 2;
	self.CharacterMenu.MaxVisibleCharacters = math.floor(self.CharacterMenu.MaxVisibleCharacters);

	if LocalPlayer():GetEntry("CharLoaded") and !LocalPlayer():GetEntry("IsPKed") then
		surface.SetFont("BASHFontLarge");
		local closeX, closeY = surface.GetTextSize("Close");

		self.CharacterMenu.Close = self:CreateButton(10, 10, closeX, closeY, self.CharacterMenu.Object);
		self.CharacterMenu.Close.Paint = function(self)
			if self.Entered then
				draw.SimpleText("Close", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				draw.SimpleText("Close", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		end
		self.CharacterMenu.Close.Action = function()
			self:CloseCharacterMenu();
		end
	end

	self:GetMenuBlips();
	self:PopulateCharacterMenu();
end

local points1, points2, points3;
function BASH:GetMenuBlips()
	if !IsEmpty(self.CharacterMenu.Blips) then return end;

	local x = SCRW;
	local y = 200;
	for id, data in pairs(self.CharacterMenu.Blips) do
		self.CharacterMenu.Blips[id].Object = self:CreatePanel(x, y, 50, 50, self.CharacterMenu.Object);
		self.CharacterMenu.Blips[id].Object.PaintOver = function(self, w, h)
			draw.SimpleText("!", "BASHFontApp", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if self.Entered then
				local formattedString = FormatString(data.message, "BASHFontHeavy", 250);
				surface.SetFont("BASHFontHeavy");
				local textX, textY = surface.GetTextSize(formattedString);
				points1 = {
					[1] = {x = -textX - 20, y = 20 - (textY / 2)},
					[2] = {x = -25, y = 20 - (textY / 2)},
					[3] = {x = -2, y = 25},
					[4] = {x = -25, y = 30 + (textY / 2)},
					[5] = {x = -textX - 20, y = 30 + (textY / 2)}
				};
				points2 = {
					[1] = {x = -textX - 19, y = 21 - (textY / 2)},
					[2] = {x = -26, y = 21 - (textY / 2)},
					[3] = {x = -3, y = 25},
					[4] = {x = -26, y = 29 + (textY / 2)},
					[5] = {x = -textX - 19, y = 29 + (textY / 2)}
				};
				points3 = {
					[1] = {x = -textX - 18, y = 22 - (textY / 2)},
					[2] = {x = -27, y = 22 - (textY / 2)},
					[3] = {x = -4, y = 25},
					[4] = {x = -27, y = 28 + (textY / 2)},
					[5] = {x = -textX - 18, y = 28 + (textY / 2)}
				};

				DisableClipping(true);
				draw.NoTexture();
				surface.SetDrawColor(color_black);
				surface.DrawPoly(points1);
				surface.SetDrawColor(Color(75, 75, 75, 255));
				surface.DrawPoly(points2);
				surface.SetDrawColor(Color(50, 50, 50, 255));
				surface.DrawPoly(points3);

				local textLines = string.Explode('\n', formattedString);
				for index, str in pairs(textLines) do
					draw.SimpleText(str, "BASHFontHeavy", -textX - 15, (20 - (textY / 2)) + ((index - 1) * (textY / #textLines)) + 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
				end
				DisableClipping(false);
			end
		end
		self.CharacterMenu.Blips[id].Object.Entered = false;
		self.CharacterMenu.Blips[id].Object.OnCursorEntered = function(self)
			self.Entered = true;
		end
		self.CharacterMenu.Blips[id].Object.OnCursorExited = function(self)
			self.Entered = false;
		end
		self.CharacterMenu.Blips[id].Object.OnMouseReleased = function(self)
			surface.PlaySound("bash/gui/click.wav");
			self:Remove();

			if data.func then
				data.func();
			end
		end
		self.CharacterMenu.Blips[id].Object:MoveTo(x - 70, y, 1, 0, 1);

		y = y + 70;
	end
end

function BASH:PopulateCharacterMenu()
	if !IsEmpty(self.CharacterMenu.Panes) then
		for _, pane in pairs(self.CharacterMenu.Panes) do
			pane:Remove();
			pane = nil;
		end
	end

	local function SetViewportModel(index, model)
		if !self.CharacterMenu.Panes[index].Viewport.Object then
			self.CharacterMenu.Panes[index].Viewport.Object = vgui.Create("DModelPanel", self.CharacterMenu.Panes[index].Viewport);
			self.CharacterMenu.Panes[index].Viewport.Object:SetSize(SCRW * 0.2, SCRW * 0.2);
			self.CharacterMenu.Panes[index].Viewport.Object:SetPos(0, 0);

			local oldSet = self.CharacterMenu.Panes[index].Viewport.Object.SetModel;
			self.CharacterMenu.Panes[index].Viewport.Object.SetModel = function(self, model)
				oldSet(self, model);

				local ent = self.Entity;
				local sequence = ent:LookupSequence("idle");

				if (sequence <= 0) then
					sequence = ent:LookupSequence("idle_subtle");
				end

				if (sequence <= 0) then
					sequence = ent:LookupSequence("batonidle2");
				end

				if (sequence <= 0) then
					sequence = ent:LookupSequence("idle_unarmed");
				end

				if (sequence <= 0) then
					sequence = ent:LookupSequence("idle01");
				end

				if (sequence > 0) then
					ent:ResetSequence(sequence);
				end
			end

			self.CharacterMenu.Panes[index].Viewport.Object:SetModel(model);
			self.CharacterMenu.Panes[index].Viewport.Object.LayoutEntity = function(self, ent)
				local x = gui.MouseX() / ScrW();
				local y = gui.MouseY() / ScrH();

				ent:SetPoseParameter("head_pitch", (y * 90) - 45);
				ent:SetPoseParameter("head_yaw", (x * 90) - 45);
				ent:SetIK(false);

				self:RunAnimation()
			end
			self.CharacterMenu.Panes[index].Viewport.Object:SetFOV(60);
			self.CharacterMenu.Panes[index].Viewport.Object:SetLookAt(Vector(0, 0, 40));
			self.CharacterMenu.Panes[index].Viewport.Object:SetCamPos(Vector(80, 0, 50));
		else
			self.CharacterMenu.Panes[index].Viewport.Object:SetModel(model);
		end
	end

	for index = 1, self.MaxCharacters do
		self.CharacterMenu.Panes[index] = self:CreateButton(14 + (self.CharacterMenu.ExtraSpace / 2) + (256 * (index - 1)), 0, 256, 256, self.CharacterMenu.Object.Selection);
		self.CharacterMenu.Panes[index].Selected = false;
		self.CharacterMenu.Panes[index].Character = nil;
		self.CharacterMenu.Panes[index].Think = function(self)
			if LocalPlayer().CharData and LocalPlayer().CharData[index] then
				self.Character = LocalPlayer().CharData[index];
			elseif self.Character and !LocalPlayer().CharData[index] then
				self.Character = nil;
			end
		end
		self.CharacterMenu.Panes[index].Paint = function(self, w, h)
			if (self.Entered or self.Selected) and !self.Disabled then
				surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
				surface.DrawOutlinedRect(0, 0, w, h);
				draw.SimpleText(index, "BASHFontLight", 10, 10, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
				surface.DrawOutlinedRect(0, 0, w, h);
				draw.SimpleText(index, "BASHFontLight", 10, 10, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end

			if !self.Character then
				if (self.Entered or self.Selected) and !self.Disabled then
					draw.SimpleText("...", "BASHFontLarge", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				else
					draw.SimpleText("...", "BASHFontLarge", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				end
			else
				local name = string.Explode(" ", self.Character["Name"]);
				local firstInitial = string.GetChar(name[1] or " ", 1);
				local secondInitial = "";

				if #name != 1 then
					secondInitial = string.GetChar(name[#name] or " ", 1)
				end

				if (self.Entered or self.Selected) and !self.Disabled then
					draw.SimpleText(firstInitial .. secondInitial, "BASHFontLarge", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					draw.SimpleText(name[1], "BASHFontHeavy", w / 2, (h / 2) - 20, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					if #name != 1 then
						draw.SimpleText(name[#name], "BASHFontHeavy", w / 2, (h / 2) + 20, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					end
				else
					draw.SimpleText(firstInitial .. secondInitial, "BASHFontLarge", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					draw.SimpleText(name[1], "BASHFontHeavy", w / 2, (h / 2) - 20, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					if #name != 1 then
						draw.SimpleText(name[#name], "BASHFontHeavy", w / 2, (h / 2) + 20, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					end
				end

				if self.Character.IsPKed then
					local bottomText = "";
					local pkTime = self.Character.PKTime;

					if pkTime == 0 then
						bottomText = "PERMA-KILL";
					elseif pkTime - os.time() > 0 then
						bottomText = SecondsToTime(pkTime - os.time());
					end
					draw.SimpleText("UNAVAILABLE", "BASHFontLarge", w / 2, 28, Color(200, 0, 0, BASH.CharacterMenu.ForegroundPrimaryColor.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
					draw.SimpleText(bottomText, "BASHFontLarge", w / 2, h - 28, Color(200, 0, 0, BASH.CharacterMenu.ForegroundPrimaryColor.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				end
			end
		end
		self.CharacterMenu.Panes[index].Action = function(self)
			BASH:ClearButtons();

			for _, button in pairs(BASH.CharacterMenu.Panes) do
				if button.Selected then
					button.Selected = false;
				end
			end

			self.Selected = true;

			if !self.Character then
				self.Create:SetVisible(true);
				return;
			end

			self.Load:SetVisible(true);
			self.Delete:SetVisible(true);
			self.Viewport:SetVisible(true);
			SetViewportModel(index, self.Character.Model);
		end

		if index < self.CharacterMenu.LeadPane or index >= self.CharacterMenu.LeadPane + self.CharacterMenu.MaxVisibleCharacters then
			self.CharacterMenu.Panes[index]:SetVisible(false);
		end

		surface.SetFont("BASHFontLarge");
		local loadX, loadY = surface.GetTextSize("Load");
		local deleteX, deleteY = surface.GetTextSize("Delete");
		local createX, createY = surface.GetTextSize("Create Character");

		self.CharacterMenu.Panes[index].Load = self:CreateButton(CENTER_X - loadX - 25, SCRH - loadY - 306, loadX, loadY, self.CharacterMenu.Object);
		self.CharacterMenu.Panes[index].Load.Paint = function(self)
			if BASH.CharacterMenu.Panes[index].Character.IsPKed then
				draw.SimpleText("Load", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, Color(120, 120, 120, BASH.CharacterMenu.ForegroundTertiaryColor.a), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			elseif self.Entered then
				draw.SimpleText("Load", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				draw.SimpleText("Load", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		end
		self.CharacterMenu.Panes[index].Load.Action = function(self)
			if BASH.CharacterMenu.Panes[index].Character and !BASH.CharacterMenu.Panes[index].Character.IsPKed then
				BASH:CloseCharacterMenu(BASH.CharacterMenu.Panes[index].Character.CharID);
			end
		end
		self.CharacterMenu.Panes[index].Load:SetVisible(false);

		self.CharacterMenu.Panes[index].Delete = self:CreateButton(CENTER_X + 25, SCRH - deleteY - 306, deleteX, deleteY, self.CharacterMenu.Object);
		self.CharacterMenu.Panes[index].Delete.Paint = function(self)
			if self.Entered then
				draw.SimpleText("Delete", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				draw.SimpleText("Delete", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		end
		self.CharacterMenu.Panes[index].Delete.Action = function()
			Derma_Query("Are you sure you want to delete this character? That CANNOT be reversed!",
						"Delete character?",
						"Cancel",
						function()
							return;
						end,
						"Delete",
						function()
							BASH:ClearButtons();

							for _, button in pairs(BASH.CharacterMenu.Panes) do
								if button.Selected then
									button.Selected = false;
								end
							end

							netstream.Start("BASH_Delete_Character", self.CharacterMenu.Panes[index].Character.CharID);

							if CheckChar(LocalPlayer()) and self.CharacterMenu.Close and self.CharacterMenu.Close:IsValid() then
								if self.CharacterMenu.Panes[index].Character.CharID == LocalPlayer():GetEntry("CharID") then
									self.CharacterMenu.Close:Remove();
									self.CharacterMenu.Close = nil;
								end
							end
						end);
		end
		self.CharacterMenu.Panes[index].Delete:SetVisible(false);

		self.CharacterMenu.Panes[index].Create = self:CreateButton(CENTER_X - (createX / 2), SCRH - createY - 306, createX, createY, self.CharacterMenu.Object);
		self.CharacterMenu.Panes[index].Create.Paint = function(self)
			if self.Entered then
				draw.SimpleText("Create Character", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				draw.SimpleText("Create Character", "BASHFontLarge", self:GetWide() / 2, self:GetTall() / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		end
		self.CharacterMenu.Panes[index].Create.Action = function()
			if LocalPlayer():GetEntry("CharLoaded") then
				BASH:CreateNotif("Please reconnect to create a character. This is to avoid possible exploits.", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
				return;
			end
			if self.CharacterMenu.Close and self.CharacterMenu.Close:IsValid() then
				self.CharacterMenu.Close:SetVisible(false);
			end
			self:DisablePanes(true);
			self.CharacterMenu.Object.Selection:MoveTo(SCRW * 0.125, SCRH, 1, 0, 1, function()
				self:CreateCharacterCreate(index);
			end);
		end
		self.CharacterMenu.Panes[index].Create:SetVisible(false);

		self.CharacterMenu.Panes[index].Viewport = self:CreatePanel(CENTER_X - (SCRW * 0.2) / 2, (SCRH * 0.1) + 25, SCRW * 0.2, SCRW * 0.2, self.CharacterMenu.Object);
		self.CharacterMenu.Panes[index].Viewport:SetVisible(false);
		self.CharacterMenu.Panes[index].Viewport.Paint = function() end;
	end
end

function BASH:NewBlip(message, func)
	if message and message != "" then
		self.CharacterMenu.Blips[RandomString(8)] = {message = message, func = func};
	end
end

function BASH:CloseCharacterMenu(charID)
	self.CharacterMenu.Closing = true;
	self.CharacterMenu.CloseCurtain = self:CreatePanel(0, 0, SCRW, SCRH);
	self.CharacterMenu.CloseCurtain.Paint = function(self)
		BASH.CharacterMenu.CurtainColor.a = math.Approach(BASH.CharacterMenu.CurtainColor.a, 255, 5);
		draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), BASH.CharacterMenu.CurtainColor);

		if BASH.CharacterMenu.CurtainColor.a == 255 then
			if self.Loading then return end;

			if charID then
				netstream.Start("BASH_Load_Character", charID);
			end

			timer.Simple(0.5, function()
				gui.EnableScreenClicker(false);
				BASH.CharacterMenu.Open = false;
				BASH.CharacterMenu.Object:Remove();
				self:Remove();
				LocalPlayer().PostSpawn = true;
			end);

			self.Loading = true;
		end
	end
end

function BASH:ClearButtons()
	for _, pane in pairs(self.CharacterMenu.Panes) do
		pane.Load:SetVisible(false);
		pane.Delete:SetVisible(false);
		pane.Create:SetVisible(false);
		pane.Viewport:SetVisible(false);
	end
end

function BASH:DisablePanes(disable)
	self:ClearButtons();

	for index, pane in pairs(self.CharacterMenu.Panes) do
		pane.Disabled = disable;
	end
end

function BASH:ShiftCharactersLeft()
	if self.CharacterMenu.LeadPane == 1 then return end;

	self.CharacterMenu.LeadPane = self.CharacterMenu.LeadPane - 1;

	for index, pane in pairs(self.CharacterMenu.Panes) do
		local x, _ = pane:GetPos();
		pane:SetPos(x + 256, 0);

		if index < self.CharacterMenu.LeadPane or index >= self.CharacterMenu.LeadPane + self.CharacterMenu.MaxVisibleCharacters then
			pane:SetVisible(false);
		else
			pane:SetVisible(true);
		end
	end
end

function BASH:ShiftCharactersRight()
	if self.CharacterMenu.LeadPane == self.MaxCharacters - self.CharacterMenu.MaxVisibleCharacters + 1 then return end;

	self.CharacterMenu.LeadPane = self.CharacterMenu.LeadPane + 1;

	for index, pane in pairs(self.CharacterMenu.Panes) do
		local x, _ = pane:GetPos();
		pane:SetPos(x - 256, 0);

		if index < self.CharacterMenu.LeadPane or index >= self.CharacterMenu.LeadPane + self.CharacterMenu.MaxVisibleCharacters then
			pane:SetVisible(false);
		else
			pane:SetVisible(true);
		end
	end
end

local chosenGender = 0;
local chosenModel, chosenFaction, chosenName, chosenDescription = "";
function BASH:CreateCharacterCreate(index)
	self:DisablePanes(true);

	self.CharacterMenu.CreateContainer = self:CreatePanel(0, SCRH * 0.15, SCRW, SCRH * 0.7, self.CharacterMenu.Object);
	self.CharacterMenu.CreateContainer.Paint = function() end;

	self.CharacterMenu.CreateViewport = vgui.Create("DModelPanel", self.CharacterMenu.CreateContainer);
	self.CharacterMenu.CreateViewport:SetPos(0, 0);
	self.CharacterMenu.CreateViewport:SetSize(SCRH * 0.5, SCRH * 0.5);
	self.CharacterMenu.CreateViewport:SetFOV(60);
	self.CharacterMenu.CreateViewport:SetLookAt(Vector(0, 0, 40));
	self.CharacterMenu.CreateViewport:SetCamPos(Vector(80, -50, 40));
	local oldSet = self.CharacterMenu.CreateViewport.SetModel;
	self.CharacterMenu.CreateViewport.SetModel = function(self, model)
		oldSet(self, model);

		local ent = self.Entity;
		local sequence = ent:LookupSequence("idle");

		if (sequence <= 0) then
			sequence = ent:LookupSequence("idle_subtle");
		end

		if (sequence <= 0) then
			sequence = ent:LookupSequence("batonidle2");
		end

		if (sequence <= 0) then
			sequence = ent:LookupSequence("idle_unarmed");
		end

		if (sequence <= 0) then
			sequence = ent:LookupSequence("idle01");
		end

		if (sequence > 0) then
			ent:ResetSequence(sequence);
		end
	end
	self.CharacterMenu.CreateViewport:SetModel("models/stalkertnb/bandit_male1.mdl");
	self.CharacterMenu.CreateViewport.LayoutEntity = function(self, ent)
		local x = gui.MouseX() / ScrW();
		local y = gui.MouseY() / ScrH();

		ent:SetPoseParameter("head_pitch", (y * 90) - 45);
		ent:SetPoseParameter("head_yaw", (x * 90) - 45);
		ent:SetIK(false);

		self:RunAnimation()
	end
	self.CharacterMenu.CreateViewport.Entity:SetMaterial("phoenix_storms/gear");

	self.CharacterMenu.CreateContent = self:CreatePanel(SCRH * 0.5, 0, SCRW - (SCRH * 0.5), SCRH * 0.7, self.CharacterMenu.CreateContainer);
	self.CharacterMenu.CreateContent.Loading = false;
	self.CharacterMenu.CreateContent.Paint = function(self, w, h)
		if self.Loading then
			curSin = math.abs(math.sin(RealTime()));
			curCos = math.abs(math.cos(RealTime()));
			draw.SimpleText("Creation in progress...", "ChatFont", w / 2, (h / 2) - 25, Color(255, 255, 255, 153), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
			draw.Circle(w / 2, (h / 2) + 35, curSin * 50, curSin * 100, Color(255, 255, 255, 153));
			draw.Circle(w / 2, (h / 2) + 35, curCos * 50, curCos * 100, Color(255, 255, 255, 153));
		end
	end;

	self.CharacterMenu.CreateContent.CurrentStage = 1;
	self.CharacterMenu.CreateContent.Stages = {
		"Faction",
		"Gender",
		"Model",
		"Identity"
	};
	self.CharacterMenu.CreateContent.Data = {};

	self.CharacterMenu.NextButton = self:CreateButton(self.CharacterMenu.CreateContent:GetWide() - 425, self.CharacterMenu.CreateContent:GetTall() - 75, 400, 50, self.CharacterMenu.CreateContent);
	self.CharacterMenu.NextButton.Paint = function(self, w, h)
		local text = "...";
		if BASH.CharacterMenu.CreateContent.CurrentStage == #BASH.CharacterMenu.CreateContent.Stages then
			text = "Complete";
		else
			text = "Next";
		end

		if self.Entered and !self.Disabled then
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(text, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(text, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end
	self.CharacterMenu.NextButton.Action = function(self)
		if BASH.CharacterMenu.CreateContent.CurrentStage == #BASH.CharacterMenu.CreateContent.Stages then
			local data = BASH.CharacterMenu.CreateContent.Data;

			if data.Faction and data.Gender and data.Model and data.Name and data.Description then
				if string.len(string.gsub(data.Name, " ", "")) < 4 then
					BASH:CreateNotif("Your name must be at least four characters long!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					return;
				end
				if string.len(string.gsub(data.Description, " ", "")) < 16 then
					BASH:CreateNotif("Your description must be at least 16 characters long!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					return;
				end

				self:Remove();
				BASH.CharacterMenu.BackButton:Remove();
				BASH.CharacterMenu.CreateContent.Content:Remove();
				BASH.CharacterMenu.CreateContent.Loading = true;
				BASH.CharacterMenu.CreateContent.Data.CharID = RandomString(16);
				netstream.Start("BASH_Create_Character", BASH.CharacterMenu.CreateContent.Data);
			else
				BASH:CreateNotif("You haven't entered all necessary data!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
			end
		else
			if BASH.CharacterMenu.CreateContent.Data[BASH.CharacterMenu.CreateContent.Stages[BASH.CharacterMenu.CreateContent.CurrentStage]] then
				BASH["Choose" .. BASH.CharacterMenu.CreateContent.Stages[BASH.CharacterMenu.CreateContent.CurrentStage + 1]](BASH);
			else
				BASH:CreateNotif("You haven't completed this step!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
			end
		end
	end

	self.CharacterMenu.BackButton = self:CreateButton(self.CharacterMenu.CreateContent:GetWide() - 850, self.CharacterMenu.CreateContent:GetTall() - 75, 400, 50, self.CharacterMenu.CreateContent);
	self.CharacterMenu.BackButton.Paint = function(self, w, h)
		local text = "...";
		if BASH.CharacterMenu.CreateContent.CurrentStage == 1 then
			text = "Cancel";
		else
			text = "Back";
		end

		if self.Entered and !self.Disabled then
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(text, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(text, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end
	self.CharacterMenu.BackButton.Action = function(self)
		if BASH.CharacterMenu.CreateContent.CurrentStage == 1 then
			self:Remove();
			BASH.CharacterMenu.CreateContainer:Remove();

			BASH:DisablePanes(false);
			BASH.CharacterMenu.Object.Selection:MoveTo(SCRW * 0.125, SCRH - 281, 1, 0, 1);

			if BASH.CharacterMenu.Close and BASH.CharacterMenu.Close:IsValid() then
				BASH.CharacterMenu.Close:SetVisible(true);
			end
		else
			BASH["Choose" .. BASH.CharacterMenu.CreateContent.Stages[BASH.CharacterMenu.CreateContent.CurrentStage - 1]](BASH);
		end
	end

	self:ChooseFaction();
end

function BASH:ChooseFaction()
	if self.CharacterMenu.CreateContent.Content then
		self.CharacterMenu.CreateContent.Content:Remove();
		self.CharacterMenu.CreateContent.Content = nil;
	end

	self.CharacterMenu.CreateContent.CurrentStage = 1;
	self.CharacterMenu.CreateContent.Content = self:CreatePanel(0, 0, self.CharacterMenu.CreateContent:GetWide(), self.CharacterMenu.CreateContent:GetTall() - 100, self.CharacterMenu.CreateContent);
	self.CharacterMenu.CreateContent.Content.Paint = function(self, w, h)
		draw.SimpleText("Pick your faction.", "BASHFontLargeItalic", w / 2, 5, Color(175, 175, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end

	local startString = "Click a faction to get a description.";
	surface.SetFont("BASHFontHeavy");
	local width, _ = surface.GetTextSize(startString);
	local descLabel = vgui.Create("DLabel", self.CharacterMenu.CreateContent.Content);
	descLabel:SetPos((self.CharacterMenu.CreateContent:GetWide() / 2) - (width / 2), 35);
	descLabel:SetFont("BASHFontHeavy");
	descLabel:SetTextColor(Color(175, 175, 255, 255));
	descLabel:SetText(startString);
	descLabel:SizeToContents();

	local index = 0;
	local y = 70;

	for id, data in pairs(self.Factions) do
		local factionPane = self:CreateButton((index * (self.CharacterMenu.CreateContent.Content:GetWide() / 4)) + 25, y, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, self.CharacterMenu.CreateContent.Content);
		factionPane.Data = data;
		factionPane.Paint = function(self, w, h)
			if !LocalPlayer():HasWhitelist(self.Data.ID) then
				surface.SetDrawColor(Color(150, 50, 50));
			elseif self.Entered or self.Selected then
				surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
			else
				surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
			end

			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(data.Name, "BASHFontHeavy", w / 2, h / 2, data.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			if self.Entered then
				local mouseX, mouseY = self:CursorPos();
				local pos, _ = self:GetPos();
				local align = TEXT_ALIGN_LEFT;

				if pos > self:GetParent():GetWide() / 2 then
					align = TEXT_ALIGN_RIGHT;
				end
			end
		end
		factionPane.Action = function(self)
			if descLabel:GetText() != self.Data.Description then
				surface.SetFont("BASHFontHeavy");
				local w, h = self:GetParent():GetSize();
				local width, _ = surface.GetTextSize(self.Data.Description);
				descLabel:SetPos((w / 2) - (width / 2), 35);
				descLabel:SetText(self.Data.Description);
				descLabel:SetTextColor(data.Color);
				descLabel:SizeToContents();
			end

			if LocalPlayer():HasWhitelist(self.Data.ID) then
				self.Selected = true;
				BASH.CharacterMenu.CreateContent.Data.Faction = self.Data.ID;
			else
				BASH:CreateNotif("You can't join this faction!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
			end
		end
		factionPane.Think = function(self)
			if BASH.CharacterMenu.CreateContent.Data.Faction != self.Data.ID and self.Selected then
				self.Selected = false;
			elseif BASH.CharacterMenu.CreateContent.Data.Faction == self.Data.ID and !self.Selected then
				self.Selected = true;
			end
		end

		index = index + 1;

		if index >= 4 then
			index = 0;
			y = y + ((self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 25);
		end
	end
end

function BASH:ChooseGender()
	if self.CharacterMenu.CreateContent.Content then
		self.CharacterMenu.CreateContent.Content:Remove();
		self.CharacterMenu.CreateContent.Content = nil;
	end

	if self.CharacterMenu.CreateContent.Data.Model then
		self.CharacterMenu.CreateContent.Data.Model = nil;
		self.CharacterMenu.CreateViewport:SetModel("models/stalkertnb/bandit_male1.mdl");
		self.CharacterMenu.CreateViewport.Entity:SetMaterial("phoenix_storms/gear");
	end

	self.CharacterMenu.CreateContent.CurrentStage = 2;
	self.CharacterMenu.CreateContent.Content = self:CreatePanel(0, 0, self.CharacterMenu.CreateContent:GetWide(), self.CharacterMenu.CreateContent:GetTall() - 100, self.CharacterMenu.CreateContent);
	self.CharacterMenu.CreateContent.Content.Paint = function(self, w, h)
		draw.SimpleText("Pick your gender.", "BASHFontLargeItalic", w / 2, 5, Color(175, 175, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end

	local malePane = self:CreateButton((self.CharacterMenu.CreateContent.Content:GetWide() / 4) + 25, 50, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, self.CharacterMenu.CreateContent.Content);
	malePane.ID = "Male";
	malePane.Paint = function(self, w, h)
		if self.Entered or self.Selected then
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(self.ID, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(self.ID, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end
	malePane.Action = function(self)
		self.Selected = true;
		BASH.CharacterMenu.CreateContent.Data.Gender = self.ID;
	end
	malePane.Think = function(self)
		if BASH.CharacterMenu.CreateContent.Data.Gender != self.ID and self.Selected then
			self.Selected = false;
		elseif BASH.CharacterMenu.CreateContent.Data.Gender == self.ID and !self.Selected then
			self.Selected = true;
		end
	end

	local femalePane = self:CreateButton((2 * (self.CharacterMenu.CreateContent.Content:GetWide() / 4)) + 25, 50, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, (self.CharacterMenu.CreateContent.Content:GetWide() / 4) - 50, self.CharacterMenu.CreateContent.Content);
	femalePane.ID = "Female";
	femalePane.Paint = function(self, w, h)
		if self.Entered or self.Selected then
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundTertiaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(self.ID, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundTertiaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		else
			surface.SetDrawColor(BASH.CharacterMenu.ForegroundPrimaryColor);
			surface.DrawOutlinedRect(0, 0, w, h);
			draw.SimpleText(self.ID, "BASHFontHeavy", w / 2, h / 2, BASH.CharacterMenu.ForegroundPrimaryColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end
	femalePane.Action = function(self)
		self.Selected = true;
		BASH.CharacterMenu.CreateContent.Data.Gender = self.ID;
		//Derma_Message("The Zone is a very dangerous place and presents .", "Female Characters", "Continue");
	end
	femalePane.Think = function(self)
		if BASH.CharacterMenu.CreateContent.Data.Gender != self.ID and self.Selected then
			self.Selected = false;
		elseif BASH.CharacterMenu.CreateContent.Data.Gender == self.ID and !self.Selected then
			self.Selected = true;
		end
	end
end

function BASH:ChooseModel()
	if self.CharacterMenu.CreateContent.Content then
		self.CharacterMenu.CreateContent.Content:Remove();
		self.CharacterMenu.CreateContent.Content = nil;
	end

	self.CharacterMenu.CreateContent.CurrentStage = 3;
	self.CharacterMenu.CreateContent.Content = self:CreatePanel(0, 0, self.CharacterMenu.CreateContent:GetWide(), self.CharacterMenu.CreateContent:GetTall() - 100, self.CharacterMenu.CreateContent);
	self.CharacterMenu.CreateContent.Content.Paint = function(self, w, h)
		draw.SimpleText("Pick your model.", "BASHFontLargeItalic", w / 2, 5, Color(175, 175, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end

	local modelContainer = vgui.Create("DScrollPanel", self.CharacterMenu.CreateContent.Content);
	modelContainer:SetSize(524, 384);
	modelContainer:Center();
	local models = self.Factions[self.CharacterMenu.CreateContent.Data.Faction][self.CharacterMenu.CreateContent.Data.Gender .. "Models"];
	local modelX, modelY = 0, 0;
	for index, model in pairs(models) do
		local modelPane = vgui.Create("SpawnIcon", modelContainer);
		modelPane:SetSize(128, 128);
		modelPane:SetPos(modelX, modelY);
		modelPane:SetModel(model);
		modelPane.DoClick = function(self)
			if BASH.CharacterMenu.CreateViewport.Entity:GetMaterial() != "" then
				BASH.CharacterMenu.CreateViewport.Entity:SetMaterial("");
			end

			BASH.CharacterMenu.CreateViewport:SetModel(model);
			BASH.CharacterMenu.CreateContent.Data.Model = model;
		end

		modelX = modelX + 128;
		if modelX >= 512 then
			modelX = 0;
			modelY = modelY + 128;
		end
	end
end

function BASH:ChooseIdentity()
	if self.CharacterMenu.CreateContent.Content then
		self.CharacterMenu.CreateContent.Content:Remove();
		self.CharacterMenu.CreateContent.Content = nil;
	end

	self.CharacterMenu.CreateContent.CurrentStage = 4;
	self.CharacterMenu.CreateContent.Content = self:CreatePanel(0, 0, self.CharacterMenu.CreateContent:GetWide(), self.CharacterMenu.CreateContent:GetTall() - 100, self.CharacterMenu.CreateContent);
	self.CharacterMenu.CreateContent.Content.Paint = function(self, w, h)
		draw.SimpleText("Create your identity.", "BASHFontLargeItalic", w / 2, 5, Color(175, 175, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end

	local x, y = 25, 50;
	local nameLabel = vgui.Create("DLabel", self.CharacterMenu.CreateContent.Content);
	nameLabel:SetPos(x, y);
	nameLabel:SetFont("BASHFontHeavy");
	nameLabel:SetText("Name [4+ Characters]");
	nameLabel:SizeToContents();
	y = y + 20;

	local nameWrapper = vgui.Create("DFrame", self.CharacterMenu.CreateContent.Content);
	nameWrapper:SetSize(200, 16);
	nameWrapper:SetPos((SCRH * 0.5) + x, (SCRH * 0.15) + y);
	nameWrapper:SetTitle("");
	nameWrapper:ShowCloseButton(false);
	nameWrapper:SetDraggable(false);
	nameWrapper:MakePopup();
	nameWrapper.Paint = function() end;

	local nameInput = vgui.Create("DTextEntry", nameWrapper);
	nameInput:SetSize(200, 16);
	nameInput:SetPos(0, 0);
	nameInput:SetText(self.CharacterMenu.CreateContent.Data.Name or "");
	nameInput.Think = function(self)
		if string.gsub(self:GetText(), " ", "") != "" and self:GetText() != BASH.CharacterMenu.CreateContent.Data.Name then
			BASH.CharacterMenu.CreateContent.Data.Name = self:GetText();
		end
	end
	y = y + 20;

	local descLabel = vgui.Create("DLabel", self.CharacterMenu.CreateContent.Content);
	descLabel:SetPos(x, y);
	descLabel:SetFont("BASHFontHeavy");
	descLabel:SetText("Description [16+ Characters]");
	descLabel:SizeToContents();
	y = y + 20;

	local descWrapper = vgui.Create("DFrame", self.CharacterMenu.CreateContent.Content);
	descWrapper:SetSize(300, 100);
	descWrapper:SetPos((SCRH * 0.5) + x, (SCRH * 0.15) + y);
	descWrapper:SetTitle("");
	descWrapper:ShowCloseButton(false);
	descWrapper:SetDraggable(false);
	descWrapper:MakePopup();
	descWrapper.Paint = function() end;

	local descInput = vgui.Create("DTextEntry", descWrapper);
	descInput:SetSize(300, 100);
	descInput:SetPos(0, 0);
	descInput:SetText(self.CharacterMenu.CreateContent.Data.Description or "");
	descInput:SetMultiline(true);
	descInput.Think = function(self)
		if string.gsub(self:GetText(), " ", "") != "" and self:GetText() != BASH.CharacterMenu.CreateContent.Data.Description then
			BASH.CharacterMenu.CreateContent.Data.Description = self:GetText();
		end
	end
	y = y + 105;

	local quirkScroller = vgui.Create("DScrollPanel", self.CharacterMenu.CreateContent.Content);
	quirkScroller:SetSize(250, self.CharacterMenu.CreateContent.Content:GetTall() - y);
	quirkScroller:SetPos(x, y);

	local quirkWrapper = vgui.Create("DForm", quirkScroller);
	quirkWrapper:SetSize(quirkScroller:GetWide() - 32, quirkScroller:GetTall());
	quirkWrapper:SetPos(0, 0);
	quirkWrapper:SetSpacing(10);
	quirkWrapper:SetName("Quirks [Optional]");

	for id, quirk in SortedPairs(self.Quirks) do
		if !self.CharacterMenu.CreateContent.Data.Quirks then
			self.CharacterMenu.CreateContent.Data.Quirks = {};
		end

		local quirkBox = vgui.Create("DCheckBoxLabel", quirkWrapper);
		quirkBox:SetText(quirk.Name);
		quirkBox:SetValue(0);
		quirkBox:SizeToContents();
		quirkBox.ID = id;
		quirkBox.Data = quirk;
		quirkBox.Entered = false;
		quirkBox.OnCursorEntered = function(self)
			self.Entered = true;
		end
		quirkBox.OnCursorExited = function(self)
			self.Entered = false;
		end
		quirkBox.Label.OnCursorEntered = function(self)
			self:GetParent().Entered = true;
		end
		quirkBox.Label.OnCursorExited = function(self)
			self:GetParent().Entered = false;
		end
		quirkBox.OnChange = function(self, value)
			local quirks = BASH.CharacterMenu.CreateContent.Data.Quirks;

			for index, quirkID in pairs(quirks) do
				local quirkData = BASH.Quirks[quirkID];

				if quirkData.QuirkType == self.Data.QuirkType and quirkData.ID != self.ID then
					BASH:CreateNotif("You've already chosen a '" .. self.Data.QuirkType .. "' quirk!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					self:SetChecked(!value);
					return;
				end
			end

			if value then
				table.insert(quirks, self.ID);
			else
				if table.HasValue(quirks, self.ID) then
					table.remove(quirks, table.KeyFromValue(quirks, self.ID));
				end
			end
		end
		quirkBox.PaintOver = function(self, w, h)
			if self.Entered then
				local mouseX, mouseY = self:CursorPos();
				DisableClipping(true);
				draw.SimpleTextOutlined(self.Data.Description, "BASHFontHeavy", mouseX, mouseY, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black);
				DisableClipping(false);
			end
		end
		quirkWrapper:AddItem(quirkBox);
	end
end

netstream.Hook("BASH_Create_Character_Return", function(data)
	BASH:CloseCharacterMenu(data);
end);

netstream.Hook("BASH_Create_Character_Failure", function(data)
	BASH.CharacterMenu.Object:Remove();
	BASH:CreateCharacterMenu();
end);
