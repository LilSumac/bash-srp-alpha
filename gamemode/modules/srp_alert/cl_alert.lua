local BASH = BASH;
BASH.Alerts = {};

local ALERT = {};

function ALERT:Init()
	self:SetSize(48, 48);

	self.ID = "";
	self.Filter = ALERT_NONE;
	self.Pos = Vector(0, 0, 0);
	self.Message = "";
	self.Time = os.date("%X - %d/%m/%Y", os.time());
	self.Symbol = '!';
	self.Color = color_black;
	self.Alpha = 255;
	self.OwnerName = "Unknown";
	self.OwnerChar = "Unknown";
	self.OwnerID = "Unknown";
end

function ALERT:Think()
	local x = math.Clamp(self.Pos:ToScreen().x, 0, SCRW - 48);
	local y = math.Clamp(self.Pos:ToScreen().y, 0, SCRH - 40);
	self:SetPos(x, y);
end

function ALERT:Paint(w, h)
	self.Alpha = 200 * math.abs(math.sin(RealTime()));
	local bgCol = Color(20, 20, 20, 150);
	local fgCol = Color(self.Color.r, self.Color.g, self.Color.b, self.Alpha);

	if self:IsHovered() then
		bgCol = Color(255, 255, 255, 150);
	end

	draw.RoundedBox(4, 12, 0, 24, 24, bgCol);
	draw.RoundedBox(4, 13, 1, 22, 22, fgCol);

	draw.SimpleText(self.Symbol, "BASHFontHeavy", 24, 12, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText(math.Round(LocalPlayer():GetPos():Distance(self.Pos) / 52.49), "BASHFontLight", 24, 32, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function ALERT:OnMousePressed(mouse)
	if mouse == MOUSE_LEFT then
		local menu = DermaMenu();
		menu:AddOption("Info", function()
			local alertInfo = vgui.Create("BASHAlertInfo");
			alertInfo:AttachAlert(self);
			alertInfo:Format();
		end):SetImage("icon16/user.png");

		menu:AddOption("Hide Alert", function()
			self:SetVisible(false);
		end):SetImage("icon16/bell_delete.png");

		if LocalPlayer():GetEntry("CharLoaded") and (LocalPlayer():GetEntry("BASHID") == self.OwnerID) then
			menu:AddOption("Dismiss Alert", function()
				self:Remove();
				BASH.Alerts[self.ID] = nil;

				netstream.Start("BASH_Remove_Alert", self.ID);
			end):SetImage("icon16/cross.png");
		end

		menu:AddSpacer();
		menu:AddOption("Close"):SetImage("icon16/delete.png");
		menu:Open();
	end
end

vgui.Register("BASHAlert", ALERT, "Panel");

local ALERT_INFO = {};

function ALERT_INFO:Init()
	self:SetTitle("Alert Info");
	self:SetSize(300, 210);
	self:Center();
	self:MakePopup();
	self:ShowCloseButton(false);
	self:SetDraggable(false);
end

function ALERT_INFO:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
end

function ALERT_INFO:AttachAlert(parent)
	self.ID = parent.ID;
	self.Filter = parent.Filter;
	self.Pos = parent.Pos;
	self.Message = parent.Message;
	self.Time = parent.Time;
	self.Symbol = parent.Symbol;
	self.Color = parent.Color;
	self.Alpha = parent.Alpha;
	self.OwnerName = parent.OwnerName;
	self.OwnerChar = parent.OwnerChar;
	self.OwnerID = parent.OwnerID;
	self.IsIC = parent.Filter == ALERT_PDAS;
end

function ALERT_INFO:Format()
	local close = vgui.Create("DButton", self);
	close:SetPos(self:GetWide() - 25, 5);
	close:SetSize(20, 20);
	close:SetFont("marlett");
	close:SetText("r");
	close.Paint = function() end;
	close.DoClick = function()
		self:Remove();
	end

	local infoScroll = vgui.Create("BASHScroll", self);
	infoScroll:SetSize(300, 190);
	infoScroll:SetPos(0, 20);

	local x = 10;
	local y = 5;
	if self.IsIC then
		local messageLab = vgui.Create("DLabel", self);
		messageLab:SetPos(x, y);
		messageLab:SetFont("BASHFontHeavy");
		messageLab:SetText(FormatString(self.Message, "BASHFontHeavy", 280));
		messageLab:SizeToContents();
		infoScroll:AddItem(messageLab);
	else
		local ownerLab = vgui.Create("DLabel", self);
		ownerLab:SetPos(x, y);
		ownerLab:SetFont("BASHFontHeavy");
		ownerLab:SetText(FormatString("Character [Player / BASHID]: " .. self.OwnerChar .. " [" .. self.OwnerName .. " / " .. self.OwnerID .. "]", "BASHFontHeavy", 280));
		ownerLab:SizeToContents();
		infoScroll:AddItem(ownerLab);
		y = y + ownerLab:GetTall() + 2;

		local idLab = vgui.Create("DLabel", self);
		idLab:SetPos(x, y);
		idLab:SetFont("BASHFontHeavy");
		idLab:SetText("Alert ID: " .. self.ID);
		idLab:SizeToContents();
		infoScroll:AddItem(idLab);
		y = y + idLab:GetTall() + 2;

		local timeLab = vgui.Create("DLabel", self);
		timeLab:SetPos(x, y);
		timeLab:SetFont("BASHFontHeavy");
		timeLab:SetText("Alert Time: " .. self.Time);
		timeLab:SizeToContents();
		infoScroll:AddItem(timeLab);
		y = y + timeLab:GetTall() + 2;

		local textLab = vgui.Create("DLabel", self);
		textLab:SetPos(x, y);
		textLab:SetFont("BASHFontHeavy");
		textLab:SetText(FormatString("Message: " .. (self.Message or ""), "BASHFontHeavy", 280));
		textLab:SizeToContents();
		infoScroll:AddItem(textLab);
	end
end

vgui.Register("BASHAlertInfo", ALERT_INFO, "DFrame")

function BASH:RegisterAlert(data)
	local newAlert = vgui.Create("BASHAlert");
	newAlert.ID = data.ID or RandomString(8);
	newAlert.Filter = data.Filter or ALERT_NONE;
	newAlert.Pos = data.Pos or Vector(0, 0, 0);
	newAlert.Message = data.Message or "";
	newAlert.Time = data.Time or os.date("[%d/%m/%Y] %X", os.time());
	newAlert.Symbol = data.Symbol or '!';
	newAlert.Color = data.Color or color_black;
	newAlert.OwnerName = data.OwnerName or "Unknown";
	newAlert.OwnerChar = data.OwnerChar or "Unknown";
	newAlert.OwnerID = data.OwnerID or "Unknown";

	self.Alerts[data.ID] = newAlert;

	if !self:GUIOpen() and LocalPlayer():GetEntry("CharLoaded") and LocalPlayer():GetEntry("BASHID") != newAlert.OwnerID and newAlert.Filter != ALERT_PDAS then
		self:CreateNotif("You've received a new alert!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);

		if symbol == "!" then
			surface.PlaySound("bash/gui/report.wav");
		else
			surface.PlaySound("bash/gui/request.wav");
		end
	end
end

function BASH:ShowAlerts(show)
	for id, alert in pairs(self.Alerts) do
		alert:SetVisible(show);
	end
end

netstream.Hook("BASH_New_Alert_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;

	BASH:RegisterAlert(data);
end);

netstream.Hook("BASH_Remove_Alert_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
	if !data then return end;

	if BASH.Alerts[data] and BASH.Alerts[data]:IsValid() then
		BASH.Alerts[data]:Remove();
		BASH.Alerts[data] = nil;
	end
end);
