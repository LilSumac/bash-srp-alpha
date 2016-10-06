local BASH = BASH;
local PANEL = {};

/*  Panel  */
function PANEL:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
end

vgui.Register("BASHPanel", PANEL, "Panel");

/*  Button  */
local BUTTON = {};

function BUTTON:Init()
	self.Text = "";
	self.Font = "BASHFontHeavy";
	self.TextWidth = 0;
	self.TextHeight = 0;

	self.Entered = false;
	self.Enclosed = true;
	self.TopLeft = false;
	self.TopRight = false;
	self.BottomLeft = false;
	self.BottomRight = false;
	self.AlwaysHighlight = false;
	self.Notification = false;
	
	self.Action = nil;
	self.Disabled = false;
end

function BUTTON:OnCursorEntered()
	self.Entered = true;
end

function BUTTON:OnCursorExited()
	self.Entered = false;
end

function BUTTON:OnMouseReleased()
	if self.Action and !self.Disabled then
		surface.PlaySound("bash/gui/click.wav");
		self:Action();
	end
end

function BUTTON:SetText(str, font)
	if font == nil then
		font = self.Font;
	end

	surface.SetFont(font);
	local w, h = surface.GetTextSize(str);

	self.TextWidth = w;
	self.TextHeight = h;
	w = w + 18;
	h = h + 6;

	self:SetSize(w, h);
	self.Text = str;
	self.Font = font;
end

function BUTTON:Paint(w, h)
	if self.Enclosed then
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		
		if self.Notification then
			draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(170, 70, 70, 255));
		else
			draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		end
		
		if self.Disabled then
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(120, 120, 120, 255), TEXT_ALIGN_CENTER);
		elseif self.AlwaysHighlight then
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(70, 70, 255, 255), TEXT_ALIGN_CENTER);
		elseif self.Entered then
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(125, 125, 255, 255), TEXT_ALIGN_CENTER);
		else
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER);
		end
	else
		draw.RoundedBoxEx(8, 0, 0, w, h,  Color(0, 0, 0, 255), topLeft, topRight, bottomLeft, bottomRight);
		draw.RoundedBoxEx(8, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255), topLeft, topRight, bottomLeft, bottomRight);
		
		if self.Notification then
			draw.RoundedBoxEx(8, 2, 2, w - 4, h - 4, Color(170, 70, 70, 255), topLeft, topRight, bottomLeft, bottomRight);
		else
			draw.RoundedBoxEx(8, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255), topLeft, topRight, bottomLeft, bottomRight);
		end
		
		if self.AlwaysHighlight then
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(70, 70, 255, 255), TEXT_ALIGN_CENTER);
		elseif self.Entered then
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(125, 125, 255, 255), TEXT_ALIGN_CENTER);
		else
			draw.DrawText(self.Text, self.Font, w / 2, (h / 2) - (self.TextHeight / 2), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER);
		end
	end
end

vgui.Register("BASHButton", BUTTON, "Panel");

/*  Scroll Panel  */
local SCROLL = {};

function SCROLL:Init()
	self.VBar.Paint = function() end;
	self.VBar.btnUp.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("5", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.VBar.btnDown.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
		draw.SimpleText("6", "marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
	self.VBar.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
		draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
		draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
	end
end

vgui.Register("BASHScroll", SCROLL, "DScrollPanel");

/*  Funcs  */
function BASH:CreatePanel(x, y, w, h, parent)
	local panel = vgui.Create("BASHPanel", parent);
	panel:SetPos(x, y);
	panel:SetSize(w, h);
	return panel;
end

function BASH:CreateButton(x, y, width, height, parent)
	local button = vgui.Create("BASHButton", parent);
	button:SetSize(width, height);
	button:SetPos(x, y);
	return button;
end

function BASH:CreateTextButton(text, font, x, y, parent)
	local button = vgui.Create("BASHButton", parent);
	button:SetText(text, font);
	button:SetPos(x, y);
	return button;
end