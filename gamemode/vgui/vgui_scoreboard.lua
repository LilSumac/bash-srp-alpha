local BASH = BASH;
BASH.Scoreboard = {};
BASH.Scoreboard.Object = nil;
BASH.Scoreboard.Open = false;

function BASH:ScoreboardShow()
	if self.Scoreboard.Open then return end;
	if !CheckChar(LocalPlayer()) then return end;
	if self:GUIOpen() then return end;
	if self:GUIOccupied() then return end;

	gui.EnableScreenClicker(true);
	self.Scoreboard.Open = true;
	self.Scoreboard.Object = self:CreatePanel(0, 0, SCRW / 3, SCRH / 2);
	self.Scoreboard.Object:Center();
	self.Scoreboard.Object.PaintOver = function(self, w, h)
		draw.SimpleText("#!/BASH/SRP", "BASHFontLarge", w / 2, 5, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		draw.SimpleText("Hosted by The Wizard Tree", "BASHFontSmall", w / 2, 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end

	local container = vgui.Create("Panel", self.Scoreboard.Object);
	container:SetPos(5, 45);
	container:SetSize(self.Scoreboard.Object:GetWide() - 10, self.Scoreboard.Object:GetTall() - 70);

	local scroll = vgui.Create("BASHScroll", container);
	scroll:SetPos(0, 0);
	scroll:SetSize(container:GetWide(), container:GetTall());

	local players = player.GetAll();
	local cards = {};
	local y = 5;

	for _, ply in pairs(players) do
		if ply and ply != NULL then
			cards[ply] = vgui.Create("Panel", scroll);
			cards[ply]:SetPos(5, y);
			cards[ply]:SetSize(scroll:GetWide() - 25, 42);
			cards[ply].Paint = function(self, w, h)
				if ply == NULL or !ply:IsValid() then return end;
				draw.NoTexture();

				local textColor = color_white;
				if ply:GetEntry("Faction") and ply:GetEntry("Faction") != "loner" then
					local factionData = BASH.Factions[ply:GetEntry("Faction")];
					if factionData then
						draw.RoundedBox(0, 0, 0, w, h, factionData.Color);
						textColor = factionData.TextColor;
					end

					surface.SetDrawColor(Color(0, 0, 0, 255));
					surface.DrawOutlinedRect(0, 0, w, h);
					surface.DrawOutlinedRect(1, 1, w - 2, h - 2);
				else
					surface.SetDrawColor(Color(150, 150, 150, 255));
					surface.DrawOutlinedRect(0, 0, w, h);
				end

				draw.SimpleText(ply:Name(), "BASHFontHeavy", 45, 5, textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText(ply:SteamID(), "BASHFontLight", 45, 20, textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
				draw.SimpleText(ply:Ping(), "BASHFontLarge", w - 5, h / 2, textColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);

				if ply:GetEntry("Rank") and ply:GetEntry("Rank") != "Player" then
					draw.SimpleText(ply:GetEntry("Rank"), "BASHFontLight", w - 50, h / 2, textColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER);
				end
			end

			cards[ply].Icon = vgui.Create("DRoundedAvatar", cards[ply]);
			cards[ply].Icon:SetPos(5, 5);
			cards[ply].Icon:SetSize(32, 32);
			cards[ply].Icon.Avatar:SetPlayer(ply, 32);

			cards[ply].Icon.Click = vgui.Create("Button", cards[ply].Icon);
			cards[ply].Icon.Click:SetPos(0, 0);
			cards[ply].Icon.Click:SetSize(32, 32);
			cards[ply].Icon.Click:SetText("");
			cards[ply].Icon.Click.Paint = function() end;
			cards[ply].Icon.Click.OnMousePressed = function(self, mouse)
				local options = DermaMenu();
				options:AddOption("Steam Profile", function() ply:ShowProfile() end):SetImage("icon16/user.png");
				options:AddOption("Copy SteamID to Clipboard", function()
						SetClipboardText(ply:SteamID());
						BASH:CreateNotif("SteamID copied to clipboard!", "BASHFontHeavy", NOTIF_TOP_CENT, 3);
					end):SetImage("icon16/cog.png");
				options:AddSpacer();
				options:AddOption("Close", function() end):SetImage("icon16/cross.png");
				options:Open();
			end

			y = y + 47;
		end
	end
end

function BASH:ScoreboardHide()
	if !CheckChar(LocalPlayer()) then return end;

	if self.Scoreboard.Open and self.Scoreboard.Object:IsValid() then
		self.Scoreboard.Object:Remove();
		self.Scoreboard.Object = nil;
	end

	CloseDermaMenus();
	gui.EnableScreenClicker(false);
	self.Scoreboard.Open = false;
end
