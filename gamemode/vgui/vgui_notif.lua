local BASH = BASH;
local NOTIF = {};

function NOTIF:Init()
	self.Text = nil;
	self.Type = nil;
end

function NOTIF:SetText(labelText, labelFont)
	self.Text = vgui.Create("DLabel", self);
	self.Text:SetPos(8, 4);
	self.Text:SetFont(labelFont)
	self.Text:SetText(labelText);
	self.Text:SetExpensiveShadow(1, Color(0, 0, 0, 190));
	self.Text:SizeToContents();
end

function NOTIF:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
end

vgui.Register("BASHNotif", NOTIF, "Panel");

function BASH:CreateNotif(text, font, pos, time)
	surface.SetFont(font);
	local x, y = surface.GetTextSize(text);
	local width, height = x + 16, y + 8;
	
	local notif = vgui.Create("BASHNotif");
	notif:SetSize(width, height);
	notif:SetText(text, font);
	notif.Type = pos;
	
	if pos == NOTIF_TOP_LEFT then
		notif:SetPos(0, -height);
		notif:MoveTo(0, 0, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(0, -height, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	elseif pos == NOTIF_TOP_CENT then
		notif:SetPos(CENTER_X - width / 2, -height);
		notif:MoveTo(CENTER_X - width / 2, 0, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(CENTER_X - width / 2, -height, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	elseif pos == NOTIF_TOP_RIGHT then
		notif:SetPos(SCRW - width, -height);
		notif:MoveTo(SCRW - width, 0, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(SCRW - width, -height, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	elseif pos == NOTIF_BOT_LEFT then
		notif:SetPos(0, SCRH + 1);
		notif:MoveTo(0, SCRH - height, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(0, SCRH + 1, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	elseif pos == NOTIF_BOT_CENT then
		notif:SetPos(CENTER_X - width / 2, SCRH + 1);
		notif:MoveTo(CENTER_X - width / 2, SCRH - height, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(CENTER_X - width / 2, SCRH + 1, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	elseif pos == NOTIF_BOT_RIGHT then
		notif:SetPos(SCRW - width, SCRH + 1);
		notif:MoveTo(SCRW - width, SCRH - height, 1, 0, 1);
		
		timer.Simple(time, function()
			notif:MoveTo(SCRW - width, SCRH + 1, 1, 0, 1, function(data, panel)
				panel:Remove();
			end);
		end);
	end
end