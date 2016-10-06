local BASH = BASH;
BASH.Chat = {};
BASH.Chat.Object = nil;
BASH.Chat.InnerBox = {};
BASH.Chat.TextBox = {};
BASH.Chat.Tabs = {};
BASH.Chat.FilteredLines = {};
BASH.Chat.Filters = {
	"All",
	"OOC",
	"IC",
	"Radio",
	"PM",
	"Admin",
	"CMD"
};
BASH.Chat.CurrentTab = nil;
BASH.Chat.GhostLinesCache = {};
BASH.Chat.GhostLines = true;
BASH.Chat.GhostLinesY = SCRH - 244;
BASH.Chat.GhostLinesExtend = false;

function BASH:StartChat(isTeam) return true end;
function BASH:FinishChat() end;
function BASH:OnPlayerChat(ply, text, isTeam, isDead) return true end;

function BASH:CreateChat(chatTab)
	if self:GUIOpen() then return end;
	if self:GUIOccupied() then return end;
	self.Chat.GhostLines = false;
	self.Chat.Object = self:CreatePanel(25, SCRH - 250, 600, 225);
	self:CreateTextBox();

	/*  Experimental
	self.Chat.TextArea = self:CreatePanel(5, self.Chat.Object:GetTall() - 21, 590, 16, self.Chat.Object);
	self.Chat.TextArea.Paint = function(self, w, h)
		surface.SetDrawColor(color_white);
		surface.DrawOutlinedRect(0, 0, w, h);

		surface.SetFont("BASHFontLight");
		local offset = 0;
		local textLength = surface.GetTextSize(">" .. BASH.Chat.CurrentText .. "_");
		if textLength > w then
			offset = textLength - w + 3;
		end

		DisableClipping(false);
		draw.SimpleText(">" .. BASH.Chat.CurrentText .. "_", "BASHFontLight", 1 - offset, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		DisableClipping(true);
	end
	*/

	local function SetActiveBox(index)
		if self.Chat.CurrentTab == index then return end;

		if self.Chat.CurrentTab then
			self.Chat.Tabs[self.Chat.CurrentTab].AlwaysHighlight = false;
			self.Chat.InnerBox[self.Chat.CurrentTab]:SetVisible(false);
			self.Chat.InnerBox[self.Chat.CurrentTab].Content:SetVisible(false);
		end

		self.Chat.Tabs[index].AlwaysHighlight = true;
		self.Chat.InnerBox[index]:MoveToFront();
		self.Chat.InnerBox[index]:SetVisible(true);
		self.Chat.InnerBox[index].Content:SetVisible(true);
		if self.Chat.Tabs[index].Notification then
			self.Chat.Tabs[index].Notification = false;
		end

		self:FindFilteredLines(index);
		self.Chat.CurrentTab = index;
	end

	local buttonOffset = 30;
	for index, filter in pairs(self.Chat.Filters) do
		self.Chat.InnerBox[index] = vgui.Create("BASHScroll");
		self.Chat.InnerBox[index]:SetSize(598, 200);
		self.Chat.InnerBox[index]:SetPos(26, SCRH - 249);
		self.Chat.InnerBox[index]:SetVisible(false);

		self.Chat.InnerBox[index].Content = self:CreatePanel(0, 0, 583, 200, self.Chat.InnerBox[index]);
		self.Chat.InnerBox[index].Content:SetVisible(false);
		self.Chat.InnerBox[index].Content.Paint = function(self, paintX, paintY)
			local x = 5;
			local y = 5;

			if !BASH.Chat.Tabs[index].Lines then return end;

			for _, line in pairs(BASH.Chat.FilteredLines) do
				local lineExplode = string.Explode("\n", line.Text);

				for _, part in pairs(lineExplode) do
					local _, cutoff = BASH.Chat.InnerBox[index]:GetCanvas():GetPos();

					if y + cutoff > -20 then
						if BASH.Chat.Open then
							draw.SimpleText(part, line.Font, x, y, line.TextColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
						elseif !BASH:GUIOpen() then
							draw.SimpleTextOutlined(part, line.Font, x, y, Color(line.TextColor.r, line.TextColor.g, line.TextColor.b, line.Alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, line.Alpha));
						end
					end

					y = y + line.Height;
				end

				if line.Time + 5 < CurTime() then
					line.Alpha = math.Clamp(line.Alpha - 200 * FrameTime(), 0, 255);
				end
			end

			if paintY != y then
				self:SetTall(y);
				BASH.Chat.InnerBox[index]:PerformLayout();

				if BASH.Chat.InnerBox[index].VBar then
					BASH.Chat.InnerBox[index].VBar:SetScroll(math.huge);
				end
			end

			if !BASH.Chat.Open then
				BASH.Chat.InnerBox[index].VBar:SetScroll(math.huge);
				BASH.Chat.InnerBox[index].VBar:SetVisible(false);
			else
				BASH.Chat.InnerBox[index].VBar:SetVisible(true);
			end
		end

		self.Chat.InnerBox[index]:AddItem(self.Chat.InnerBox[index].Content);

		self.Chat.Tabs[index] = self:CreateTextButton(filter, "BASHFontHeavy", buttonOffset, ScrH() - self.Chat.Object:GetTall() - 44);
		self.Chat.Tabs[index].Enclosed = false;
		self.Chat.Tabs[index].TopLeft = true;
		self.Chat.Tabs[index].TopRight = true;
		self.Chat.Tabs[index].Action = function()
			SetActiveBox(index);
			self.Chat.TextBox.Object:RequestFocus();
		end

		if !self.Chat.Tabs[index].Lines then
			self.Chat.Tabs[index].Lines = {};

			for _, line in pairs(self.Chat.GhostLinesCache) do
				if table.HasValue(line.Filters, index) then
					table.insert(self.Chat.Tabs[index].Lines, line);
				end
			end
		end

		buttonOffset = buttonOffset + self.Chat.Tabs[index]:GetWide() + 5;
	end

	SetActiveBox(chatTab);
	self:FindFilteredLines(chatTab);
end

function BASH:CreateTextBox()
	self.Chat.TextBox.Wrapper = vgui.Create("DFrame");
	self.Chat.TextBox.Wrapper:SetSize(590, 16);
	self.Chat.TextBox.Wrapper:SetPos(30, SCRH - 46);
	self.Chat.TextBox.Wrapper:SetTitle("");
	self.Chat.TextBox.Wrapper:ShowCloseButton(false);
	self.Chat.TextBox.Wrapper:SetDraggable(false);
	self.Chat.TextBox.Wrapper:MakePopup();
	self.Chat.TextBox.Wrapper.Paint = function() end;

	self.Chat.TextBox.Object = vgui.Create("DTextEntry", self.Chat.TextBox.Wrapper);
	self.Chat.TextBox.Object:SetPos(0, 0);
	self.Chat.TextBox.Object:SetSize(590, 16);
	self.Chat.TextBox.Object:RequestFocus();
	self.Chat.TextBox.Object.OnKeyCodeTyped = function(self, key)
		if key == KEY_ESCAPE then
			LocalPlayer():UpdateEntry("IsTyping", false);
			BASH:RemoveChat();
			RunConsoleCommand("cancelselect", "")
		elseif key == KEY_ENTER then
			local text = self:GetValue();
			if string.gsub(text, " ", "") != "" then
				BASH:ParseChat(LocalPlayer(), text);
			end

			self:SetText("");
			LocalPlayer():UpdateEntry("IsTyping", false);
			BASH:RemoveChat();
		elseif self:GetValue() != "" and !LocalPlayer():GetEntry("IsTyping") then
			LocalPlayer():UpdateEntry("IsTyping", true);
		end
	end
end

function BASH:OpenChat(chatTab)
	if !self.Chat.Object then
		self:CreateChat(chatTab);
	else
		if self.Chat.Object and self.Chat.Object:IsValid() then
			self.Chat.Object:SetVisible(true);
			self.Chat.InnerBox[self.Chat.CurrentTab].VBar:SetVisible(true);
		end

		self:CreateTextBox();

		for index, button in pairs(self.Chat.Tabs) do
			if button and button:IsValid() then
				button:SetVisible(true);
			end
		end
	end

	self.Chat.Open = true;
	self.Chat.GhostLines = false;
end

function BASH:RemoveChat()
	if self.Chat.Object and self.Chat.Object:IsValid() then
		self.Chat.Object:SetVisible(false);
		self.Chat.InnerBox[self.Chat.CurrentTab].VBar:SetVisible(false);
	end

	if self.Chat.TextBox.Wrapper and self.Chat.TextBox.Wrapper:IsValid() then
		self.Chat.TextBox.Wrapper:Remove();
		self.Chat.TextBox.Object:Remove();
	end

	for index, button in pairs(self.Chat.Tabs) do
		if button and button:IsValid() then
			button:SetVisible(false);
		end
	end

	self.Chat.Open = false;
end

function BASH:AddLine(owner, text, consoleText, commandID)
	local commandData;
	for _, data in pairs(CHAT_TYPES) do
		if data.ID == commandID then
			commandData = data;
		end
	end
	if !commandData then
		commandData = CHAT_TYPES.SAY;
	end

	local toggleConvTypes = {
		CHAT_TYPES.SAY, CHAT_TYPES.WHISP,
		CHAT_TYPES.YELL, CHAT_TYPES.ME,
		CHAT_TYPES.MES, CHAT_TYPES.LME,
		CHAT_TYPES.LMES
	};

	//	THE FINAL FIIIIIIIIIIIIIIIIIIIX
	if !self.Chat.Object then
		local lineObj = {};
		lineObj.Owner = owner;
		lineObj.TextColor = commandData.TextColor;
		lineObj.Font = commandData.Font;
		lineObj.Alpha = 255;
		lineObj.Time = CurTime();
		lineObj.Filters = commandData.Filters or {};

		if !LocalPlayer().Convo then
			LocalPlayer().Convo = {};
		end
		if !isstring(owner) and owner:IsValid() then
			local id = (!isstring(owner) and owner:GetEntry("CharID")) or "NO-ID";
			local isConvType = false;
			for _, tab in pairs(toggleConvTypes) do
				if tab == commandData then isConvType = true break end;
			end
			if LocalPlayer().Convo[id] and isConvType then
				lineObj.TextColor = Color(153, 255, 204);
			end
		end

		surface.SetFont(lineObj.Font);
		local _, textHeight = surface.GetTextSize(text);
		lineObj.Text = FormatString(text, lineObj.Font, 572);
		lineObj.Height = textHeight;

		if self.Chat.GhostLinesExtend then
			self.Chat.GhostLinesY = self.Chat.GhostLinesY - textHeight;
		end

		table.insert(self.Chat.GhostLinesCache, lineObj);
		MsgC(lineObj.TextColor, consoleText .. '\n');

		return;
	end

	local logged = false;
	for _, index in pairs(commandData.Filters) do
		if !self.Chat.Tabs[index].Lines then
			self.Chat.Tabs[index].Lines = {};
		end

		local lineObj = {};
		lineObj.Owner = owner;
		lineObj.TextColor = commandData.TextColor;
		lineObj.Font = commandData.Font;
		lineObj.Alpha = 255;
		lineObj.Time = CurTime();


		if !LocalPlayer().Convo then
			LocalPlayer().Convo = {};
		end
		if !isstring(owner) and owner:IsValid() then
			local id = (!isstring(owner) and owner:GetEntry("CharID")) or "NO-ID";
			local isConvType = false;
			for _, tab in pairs(toggleConvTypes) do
				if tab == commandData then isConvType = true break end;
			end
			if LocalPlayer().Convo[id] and isConvType then
				lineObj.TextColor = Color(153, 255, 204);
			end
		end

		surface.SetFont(lineObj.Font);
		local _, textHeight = surface.GetTextSize(text);
		lineObj.Text = FormatString(text, lineObj.Font, 572);
		lineObj.Height = textHeight;

		table.insert(self.Chat.Tabs[index].Lines, lineObj);

		if !logged then
			MsgC(lineObj.TextColor, consoleText .. '\n');
			logged = true;
		end

		if index and index != self.Chat.CurrentTab && self.Chat.CurrentTab != 1 and index != 1 then
			self.Chat.Tabs[index].Notification = true;
		elseif index == self.Chat.CurrentTab then
			self.Chat.InnerBox[index].VBar:SetScroll(math.huge);
		end
	end

	self:FindFilteredLines(self.Chat.CurrentTab);
end

function BASH:FindFilteredLines(tab)
	if !self.Chat.Tabs[tab] or !self.Chat.Tabs[tab].Lines then return end;

	self.Chat.FilteredLines = {};

	for _, line in pairs(self.Chat.Tabs[tab].Lines) do
		table.insert(self.Chat.FilteredLines, line);
	end
end

local COMMAND_PREFIXES = {
	".", "/", "["
};
function BASH:ParseChat(ply, text)
	local consoleText = "";
	local isCommand = false;
	local commandFound = false;
	local commandData;
	local commandID = 1;
	local commandLen = 0;

	for keyword, command in pairs(self.ChatCMD) do
		local len = string.len(keyword);
		local textPrefix = string.sub(text, 1, len);

		if textPrefix == keyword and (text[len + 1] == "" or text[len + 1] == " ") then
			if string.len(text) <= string.len(keyword) then
				text = "";
			else
				if string.find(text, " ") then
					text = string.sub(text, string.find(text, " ") + 1);
				end
			end

			command.Func(ply, text);
			return;
		end
	end

	if table.HasValue(COMMAND_PREFIXES, string.GetChar(text, 1)) then
		isCommand = true;

		for _, data in pairs(CHAT_TYPES) do
			if data.Command then
				for __, cmd in pairs(data.Command) do
					local first, second = string.find(text, cmd, 0, true);
					if first == 1 and second == string.len(cmd) then
						if !data.AddSpace or (data.AddSpace and string.GetChar(text, second + 1) == ' ') then
							commandFound = true;
							commandData = data;
							commandID = data.ID;
							commandLen = string.len(cmd);
							if data.AddSpace then commandLen = commandLen + 1 end;
							break;
						end
					end
				end
			end
		end
	end

	if isCommand then
		if commandFound and commandData then
			if commandData.ServerFormat then
				text = string.sub(text, commandLen + 1);
				consoleText = text;
			else
				text, consoleText = commandData.Format(ply, string.sub(text, commandLen + 1));
			end
		elseif !commandFound then
			LocalPlayer():PrintChat("Invalid command '" .. string.Explode(" ", text)[1] .. "'!");
			return;
		end
	else
		commandID = CHAT_TYPES.SAY.ID;
		text, consoleText = CHAT_TYPES.SAY.Format(ply, text);
	end

	netstream.Start("BASH_Send_Chat", {text, consoleText, commandID});
end

netstream.Hook("BASH_Return_Chat", function(data)
	local owner = data[1];
	local text = data[2];
	local consoleText = data[3];
	local commandID = data[4];

	BASH:AddLine(owner, text, consoleText, commandID);
end);

hook.Add("HUDPaint", "BASH_GhostLines", function()
	if BASH.Chat.GhostLines then
		local x = 31;
		local y = BASH.Chat.GhostLinesY;

		for index, line in pairs(BASH.Chat.GhostLinesCache) do
			local lineExplode = string.Explode("\n", line.Text);

			for _, part in pairs(lineExplode) do
				draw.SimpleTextOutlined(part, line.Font, x, y, Color(line.TextColor.r, line.TextColor.g, line.TextColor.b, line.Alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0, 0, 0, line.Alpha));

				y = y + line.Height;
			end

			if line.Time + 5 < CurTime() then
				line.Alpha = math.Clamp(line.Alpha - 200 * FrameTime(), 0, 255);
			end
		end

		if y > SCRH - 50 then
			BASH.Chat.GhostLinesExtend = true;
		else
			BASH.Chat.GhostLinesExtend = false;
		end
	end
end);
