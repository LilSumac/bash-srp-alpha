local BASH = BASH;
BASH.PDA = {};
BASH.PDA.Object = nil;
BASH.PDA.Open = false;
BASH.PDA.SIMCard = nil;
BASH.PDA.MemorySlot = nil;

local home = Material("bash-srp/icon/home.png", "noclamp");
local help = Material("bash-srp/icon/help.png", "noclamp");
local players = Material("bash-srp/icon/players.png", "noclamp");
local bounties = Material("bash-srp/icon/leaderboard.png", "noclamp");
local advert = Material("bash-srp/icon/advert.png", "noclamp");
local contacts = Material("bash-srp/icon/contacts.png", "noclamp");
local group = Material("bash-srp/icon/group.png", "noclamp");
local map = Material("bash-srp/icon/map.png", "noclamp");
local econ = Material("bash-srp/icon/econ.png", "noclamp");
local notes = Material("bash-srp/icon/notes.png", "noclamp");
local settings = Material("bash-srp/icon/settings.png", "noclamp");
local PDAImage = surface.GetTextureID("bash-srp/hud/pda");

local function ClearDock()
	for index, button in pairs(BASH.PDA.Buttons) do
		button:SetVisible(false);
	end

	BASH.PDA.Content:SetVisible(true);
	local preContent = BASH.PDA.Content:GetChildren();
	for index, panel in pairs(preContent) do
		if panel:IsValid() then
			panel:Remove();
		end
	end
end

local function GoHome()
	for index, button in pairs(BASH.PDA.Buttons) do
		button:SetVisible(true);
	end

	BASH.PDA.Content:SetVisible(false);
end

function BASH:CreatePDA(memory, simCard)
	if self:GUIOccupied() then return end;

	if !self.MessageNotif then
		self.MessageNotif = {};
	end

	gui.EnableScreenClicker(true);
	self.PDA.MemorySlot = tostring(memory);
	self.PDA.SIMCard = tostring(simCard);
	self.PDA.MemoryData = {};
	self.PDA.SIMData = {};
	self.PDA.CurrentApp = 0;
	self.PDA.Object = vgui.Create("DFrame");
	self.PDA.Object:SetSize(920, 690);
	self.PDA.Object:Center();
	self.PDA.Object:SetTitle("");
	self.PDA.Object:SetDraggable(false);
	self.PDA.Object:ShowCloseButton(false);
	self.PDA.Object.Paint = function()
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetTexture(PDAImage);
		surface.DrawTexturedRect(-60, -160, 1024, 1024);

		local x = 345;
		for index = 1, 5 do
			draw.RoundedBox(2, x, 35, 8, 8, Color(0, 0, 0, 255));

			if LocalPlayer():GetEntry("Connection") >= index then
				draw.RoundedBox(2, x + 2, 37, 4, 4, Color(100, 255, 100, 255));
			else
				draw.RoundedBox(2, x + 1, 36, 6, 6, Color(100, 100, 100, 255));
			end

			x = x + 12;
		end

		local connection = "";
		local color = color_white;

		if self.PDA.SIMCard == "" then
			connection = "No SIM Card";
			color = Color(255, 180, 0, 255);
		elseif LocalPlayer():GetEntry("Connection") > 0 then
			connection = "Connected to Network [GSM-SNET]";
			color = Color(100, 255, 100, 255);
		else
			connection = "No Signal";
			color = Color(255, 100, 100, 255);
		end

		draw.SimpleText(connection, "BASHFontHeavy", 374, 57, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	end
	self.PDA.Object.Think = function(self)
		if !vgui.CursorVisible() then
			gui.EnableScreenClicker(true);
		end
	end
	self.PDA.Open = true;

	local closeButton = vgui.Create("DButton", self.PDA.Object);
	closeButton:SetFont("BASHFontHeavy");
	closeButton:SetText(" ");
	closeButton.Paint = function() end;
	closeButton:SetColor(Color(255, 255, 255));
	closeButton:SetSize(40, 20);
	closeButton:SetPos(725, 26)
	closeButton.DoClick = function()
		self:ClosePDA();
	end

	self.PDA.MainContainer = vgui.Create("Panel", self.PDA.Object);
	self.PDA.MainContainer:SetSize(775, 530);
	self.PDA.MainContainer:SetPos(65, 80);
	self.PDA.MainContainer.Paint = function(self, w, h)
		draw.NoTexture();

		local blinkAlpha = (100 * math.abs(math.cos(RealTime()))) + 50;
		local color = Color(0, 0, 0, blinkAlpha);

		if !BASH.PDA.Content:IsVisible() then
			local x, y = 157, 96;
			for index = 1, 3 do
				draw.RoundedBox(0, 0, y, w, 74, color);
				draw.RoundedBox(0, x, 0, 74, h, color);
				x = x + 194;
				y = y + 133;
			end
		end

		if BASH.MessageNotif[BASH.PDA.SIMCard] then
			draw.SimpleText("New Message!", "BASHFontSmall", w - 25, 0, color_red, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
		end
	end

	self.PDA.Content = vgui.Create("Panel", self.PDA.MainContainer);
	self.PDA.Content:SetSize(775, 530);
	self.PDA.Content:SetPos(0, 0);
	self.PDA.Content:SetVisible(false);

	/* Buttons */
	self.PDA.HomeButton = vgui.Create("DButton", self.PDA.MainContainer);
	self.PDA.HomeButton:SetSize(20, 20);
	self.PDA.HomeButton:SetPos(0, 0);
	self.PDA.HomeButton:SetText("");
	self.PDA.HomeButton.Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(0, 0, 0, 255), false, false, false, true);
		draw.RoundedBoxEx(8, 0, 0, w - 1, h - 1, Color(75, 75, 75, 255), false, false, false, true);
		draw.RoundedBoxEx(8, 0, 0, w - 2, h - 2, Color(150, 150, 150, 255), false, false, false, true);

		surface.SetMaterial(home);
		surface.SetDrawColor(color_white);
		surface.DrawTexturedRectUV(0, 0, 16, 16, 0, 0, 1, 1);
	end
	self.PDA.HomeButton.DoClick = function()
		// Shitty fix. :^(
		if self.PDA.Content.Container and self.PDA.Content.Container.Right and self.PDA.Content.Container.Right.ChatWrapper and self.PDA.Content.Container.Right.ChatWrapper:IsValid() then
			self.PDA.Content.Container.Right.ChatWrapper:Remove();
			self.PDA.Content.Container.Right.ChatWrapper = nil;
		end

		self.PDA.CurrentApp = 0;
		GoHome();
	end

	self.PDA.HelpButton = vgui.Create("DButton", self.PDA.MainContainer);
	self.PDA.HelpButton:SetSize(20, 20);
	self.PDA.HelpButton:SetPos(755, 0);
	self.PDA.HelpButton:SetText("");
	self.PDA.HelpButton.Paint = function(self, w, h)
		draw.NoTexture();
		draw.RoundedBoxEx(8, 0, 0, w, h, Color(0, 0, 0, 255), false, false, true, false);
		draw.RoundedBoxEx(8, 1, 0, w - 1, h - 1, Color(75, 75, 75, 255), false, false, true, false);
		draw.RoundedBoxEx(8, 2, 0, w - 2, h - 2, Color(150, 150, 150, 255), false, false, true, false);

		surface.SetMaterial(help);
		surface.SetDrawColor(color_white);
		surface.DrawTexturedRectUV(4, 0, 16, 16, 0, 0, 1, 1);
	end
	self.PDA.HelpButton.DoClick = function()
		// Shitty fix. :^(
		if self.PDA.Content.Container and self.PDA.Content.Container.Right and self.PDA.Content.Container.Right.ChatWrapper and self.PDA.Content.Container.Right.ChatWrapper:IsValid() then
			self.PDA.Content.Container.Right.ChatWrapper:Remove();
			self.PDA.Content.Container.Right.ChatWrapper = nil;
		end

		self.PDA.CurrentApp = 0;
		ClearDock();
		self:HelpApp();
	end

	local appX = 162;
	local appY = 101;
	self.PDA.ScoreboardButton = self:CreateApp(appX, appY, players, Color(50, 50, 150, 200), true, false, self.PDA.MainContainer);
	self.PDA.ScoreboardButton.GhostBanned = true;
	self.PDA.ScoreboardButton.SIMNeeded = true;
	self.PDA.ScoreboardButton.InfoName = "STALKERs In Your Area";
	self.PDA.ScoreboardButton.InfoDesc = "People who own a PDA and are currently connected to the STALKERnet will appear here. Your presence can be hidden using 'GhostMode', which is found in the settings.\n[Requires SIM Card + Connection]";
	self.PDA.ScoreboardButton.Action = function()
		netstream.Start("BASH_Request_Online");
	end
	appX = appX + 194;

	self.PDA.LeaderButton = self:CreateApp(appX, appY, bounties, Color(150, 50, 50, 200), true, false, self.PDA.MainContainer);
	self.PDA.LeaderButton.SIMNeeded = true;
	self.PDA.LeaderButton.InfoName = "Bounty Board";
	self.PDA.LeaderButton.InfoDesc = "Bounties submitted by authorized network users will appear here. Contact an authorized superuser to create a bounty.\n[Requires Connection]";
	self.PDA.LeaderButton.Action = function()
		netstream.Start("BASH_Send_Bounties");
	end
	appX = appX + 194;

	self.PDA.AdvertButton = self:CreateApp(appX, appY, advert, Color(226, 121, 0, 200), true, false, self.PDA.MainContainer);
	self.PDA.AdvertButton.SIMNeeded = true;
	self.PDA.AdvertButton.InfoName = "Adverts and Announcements";
	self.PDA.AdvertButton.InfoDesc = "Job postings, advertisements, and other announcements from notable STALKERs will be publicly shown here.\n[Requires Connection]";
	self.PDA.AdvertButton.Action = function()
		netstream.Start("BASH_Send_Adverts");
	end
	appX = 162;
	appY = appY + 133;

	self.PDA.ContactsButton = self:CreateApp(appX, appY, contacts, Color(146, 78, 0, 200), true, false, self.PDA.MainContainer);
	self.PDA.ContactsButton.SIMNeeded = true;
	self.PDA.ContactsButton.InfoName = "Contacts and Messaging";
	self.PDA.ContactsButton.InfoDesc = "Your logged contacts and conversations will be accessible here.\n[Requires SIM Card + Connection]";
	self.PDA.ContactsButton.Action = function()
		self.PDA.CurrentApp = 1;

		if self.PDA.MessageNotif then
			self.PDA.MessageNotif = false;
		end

		self:ContactsApp();
	end
	appX = appX + 194;

	self.PDA.GroupButton = self:CreateApp(appX, appY, group, Color(200, 150, 150, 200), true, false, self.PDA.MainContainer);
	self.PDA.GroupButton.InfoName = "ZoneGroups";
	self.PDA.GroupButton.InfoDesc = "Look at the currently-known groups that inhabit the Zone.\n[Requires Connection]";
	self.PDA.GroupButton.Action = function()
		netstream.Start("BASH_Send_Groups");
	end
	appX = appX + 194;

	self.PDA.MapButton = self:CreateApp(appX, appY, map, Color(0, 50, 0, 200), false, false, self.PDA.MainContainer);
	self.PDA.MapButton.InfoName = "GEOzone";
	self.PDA.MapButton.InfoDesc = "A local area map that you can input location data into.";
	self.PDA.MapButton.Action = self.MapApp;
	appX = 162;
	appY = appY + 133;

	self.PDA.EconButton = self:CreateApp(appX, appY, econ, Color(50, 150, 50, 200), true, false, self.PDA.MainContainer);
	self.PDA.EconButton.SIMNeeded = true;
	self.PDA.EconButton.InfoName = "StackTrack";
	self.PDA.EconButton.InfoDesc = "An overview of the current local Zone economic atmosphere.\n[Requires Connection]";
	self.PDA.EconButton.Action = self.EconApp;
	appX = appX + 194;

	self.PDA.NotesButton = self:CreateApp(appX, appY, notes, Color(220, 220, 200, 200), false, false, self.PDA.MainContainer);
	self.PDA.NotesButton.InfoName = "Notes";
	self.PDA.NotesButton.InfoDesc = "Take notes stored on your physical memory.";
	self.PDA.NotesButton.Action = self.NotesApp;
	appX = appX + 194;

	self.PDA.SettingsButton = self:CreateApp(appX, appY, settings, Color(150, 150, 255, 200), false, false, self.PDA.MainContainer);
	self.PDA.SettingsButton.InfoName = "Settings";
	self.PDA.SettingsButton.InfoDesc = "Configure settings for your PDA and network profile.";
	self.PDA.SettingsButton.Action = self.SettingsApp;

	self.PDA.Buttons = {
		self.PDA.ScoreboardButton,
		self.PDA.LeaderButton,
		self.PDA.AdvertButton,
		self.PDA.ContactsButton,
		self.PDA.GroupButton,
		self.PDA.MapButton,
		self.PDA.EconButton,
		self.PDA.NotesButton,
		self.PDA.SettingsButton
	};

	netstream.Start("BASH_Request_Device", {self.PDA.MemorySlot, self.PDA.SIMCard});
end

function BASH:ClosePDA()
	if !self.PDA.Open or !self.PDA.Object then return end;

	// Shitty fix. :^(
	if self.PDA.Content.Container then
		if self.PDA.Content.Container.Right then
			if self.PDA.Content.Container.Right.ChatWrapper and self.PDA.Content.Container.Right.ChatWrapper:IsValid() then
				self.PDA.Content.Container.Right.ChatWrapper:Remove();
				self.PDA.Content.Container.Right.ChatWrapper = nil;
			end
			if self.PDA.Content.Container.Right.NoteWrapper and self.PDA.Content.Container.Right.NoteWrapper:IsValid() then
				self.PDA.Content.Container.Right.NoteWrapper:Remove();
				self.PDA.Content.Container.Right.NoteWrapper = nil;
			end
		end
	end

	gui.EnableScreenClicker(false);
	self.PDA.Object:Remove();
	self.PDA.Object = nil;
	self.PDA.CurrentApp = 0;
	self.PDA.Open = false;
end

netstream.Hook("BASH_Request_Device_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;

	BASH.PDA.MemoryData = data[1];
	BASH.PDA.SIMData = data[2];
end);

local PANEL = {};

function PANEL:Init()
	self:SetSize(64, 64);
	self:SetText("");
	self.Entered = false;
	self.Logo = players;
	self.Color = color_white;
	self.ConnectionNeeded = true;
	self.GhostBanned = false;
	self.SIMNeeded = false;
	self.Disabled = false;
	self.InfoName = "";
	self.InfoDesc = "";
	self.Action = nil;
end

function PANEL:OnCursorEntered()
	self.Entered = true;
end

function PANEL:OnCursorExited()
	self.Entered = false;
end

function PANEL:Paint(w, h)
	draw.NoTexture();

	draw.RoundedBox(16, 0, 0, w, h, Color(0, 0, 0, 200));
	draw.RoundedBox(16, 1, 1, w - 2, h - 2, Color(75, 75, 75, 200));
	draw.RoundedBox(16, 2, 2, w - 4, h - 4, self.Color);

	surface.SetMaterial(self.Logo);
	surface.SetDrawColor(color_white);
	surface.DrawTexturedRectUV((w / 2) - 16, (h / 2) - 16, 32, 32, 0, 0, 1, 1);

	if self.Disabled or ((self.ConnectionNeeded and LocalPlayer():GetEntry("Connection") == 0) or (self.GhostBanned and BASH.PDA.MemoryData and BASH.PDA.MemoryData.GhostMode)) or (self.SIMNeeded and !BASH.PDA.SIMData) then
		surface.SetDrawColor(Color(150, 0, 0, 255));
		surface.DrawLine(0, h, w, 0);
	end

	if self.Entered then
		local mX, mY = self:CursorPos();
		surface.SetFont("BASHFontHeavy");
		local w, h = surface.GetTextSize(self.InfoName);
		DisableClipping(true);
		draw.RoundedBox(0, mX, mY - (h + 6) - 4, w + 12, h + 6, color_black);
		draw.SimpleText(self.InfoName, "BASHFontHeavy", mX + 6, mY - (h + 6) - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		DisableClipping(false);
	end
end

function PANEL:DoClick()
	if self.Disabled or ((self.ConnectionNeeded and LocalPlayer():GetEntry("Connection") == 0) or (self.GhostBanned and BASH.PDA.MemoryData and BASH.PDA.MemoryData.GhostMode)) or (self.SIMNeeded and !BASH.PDA.SIMData) then
		surface.PlaySound("bash/gui/report.wav");
		return;
	end

	ClearDock();

	if self.Action then
		self.Action(BASH);
	end
end

vgui.Register("BASHApp", PANEL, "DButton");

function BASH:CreateApp(x, y, logo, color, connReq, disabled, parent)
	local newApp = vgui.Create("BASHApp", parent);
	newApp:SetPos(x, y);
	newApp.Logo = logo;
	newApp.Color = color;
	newApp.ConnectionNeeded = connReq;
	newApp.Disabled = disabled;
	return newApp;
end
