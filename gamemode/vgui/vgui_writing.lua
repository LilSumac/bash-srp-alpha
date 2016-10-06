local BASH = BASH;
BASH.Writing = {};
BASH.Writing.Open = false;
BASH.Writing.Data = nil;
BASH.Writing.Object = nil;

function BASH:CreateWriting(data, text)
    self.Writing.Open = true;
    self.Writing.Data = data;
    self.Writing.Text = text;
    self.Writing.Object = vgui.Create("DFrame");
    self.Writing.Object:Center();
    self.Writing.Object:SetSize(300, 400);
    self.Writing.Object:SetTitle("");
    self.Writing.Object:MakePopup();
    self.Writing.Object:ShowCloseButton(false);
    self.Writing.Object.Paint = function(_, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
    	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
    	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText(self.Items[data.ID or data.ItemID].Name, "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    self.Writing.Object.Scroll = vgui.Create("BASHScroll", self.Writing.Object);
    self.Writing.Object.Scroll:SetPos(5, 20);
    self.Writing.Object.Scroll:SetSize(290, 355);

    self.Writing.Object.Content = self:CreatePanel(0, 0, 274, 0, self.Writing.Object.Scroll);
    self.Writing.Object.Content.Paint = function()
        local formatted = FormatString(BASH.Writing.Text, "BASHFontLight", 274);
        local tab = string.Explode('\n', formatted);
        local yOffset = 0;
        for _, line in pairs(tab) do
            draw.SimpleText(line, "BASHFontLight", 0, yOffset, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
            yOffset = yOffset + 16;
        end
    end;

    local formatted = FormatString(text, "BASHFontLight", 274);
    local tab = string.Explode('\n', formatted);
    surface.SetFont("BASHFontLight");
    local _, textY = surface.GetTextSize(formatted);
    self.Writing.Object.Content:SetTall(textY + (#tab * 2) + 5);
    self.Writing.Object.Scroll:AddItem(self.Writing.Object.Content);

    surface.SetFont("BASHFontSmall");
    local closeX, _ = surface.GetTextSize("Close");
    self.Writing.Object.Close = self:CreateTextButton("Close", "BASHFontSmall", 278 - closeX, 378, self.Writing.Object);
    self.Writing.Object.Close.Action = function()
        self:CloseWriting();
    end

    if !isentity(data) then
        surface.SetFont("BASHFontSmall");
        local editX, _ = surface.GetTextSize("Edit");
        self.Writing.Object.Edit = self:CreateTextButton("Edit", "BASHFontSmall", 4, 378, self.Writing.Object);
        self.Writing.Object.Edit.Action = function()
            self:EditWriting();
        end
    end
end

function BASH:EditWriting()
    self.Writing.Object.Scroll:SetVisible(false);
    self.Writing.Object.Edit:SetVisible(false);

    if !self.Writing.Object.Field or !self.Writing.Object.Field:IsValid() then
        self.Writing.Object.Field = vgui.Create("DTextEntry", self.Writing.Object);
        self.Writing.Object.Field:SetPos(5, 20);
        self.Writing.Object.Field:SetSize(290, 355);
        self.Writing.Object.Field:SetMultiline(true);
        self.Writing.Object.Field:SetText(self.Writing.Text);
    else
        self.Writing.Object.Field:SetVisible(true);
    end

    if !self.Writing.Object.Save or !self.Writing.Object.Save:IsValid() then
        self.Writing.Object.Save = self:CreateTextButton("Save", "BASHFontSmall", 4, 378, self.Writing.Object);
        self.Writing.Object.Save.Action = function()
            self.Writing.Object.Scroll:SetVisible(true);
            self.Writing.Object.Edit:SetVisible(true);

            self.Writing.Text = self.Writing.Object.Field:GetValue();
            local formatted = FormatString(self.Writing.Text, "BASHFontLight", 274);
            local tab = string.Explode('\n', formatted);
            surface.SetFont("BASHFontLight");
            local _, textY = surface.GetTextSize(formatted);

            self.Writing.Object.Content:SetTall(textY + (#tab * 2) + 5);
            netstream.Start("BASH_Update_Writing", {self.Writing.Data.Writing, self.Writing.Object.Field:GetValue()});
            self.Writing.Object.Field:SetVisible(false);
            self.Writing.Object.Save:SetVisible(false);
        end
    else
        self.Writing.Object.Save:SetVisible(true);
    end
end

function BASH:CloseWriting()
    if !self.Writing.Open then return end;

    self.Writing.Object:Remove();
    self.Writing.Object = nil;
    self.Writing.Data = nil;
    self.Writing.Text = nil;
    self.Writing.Open = false;
end

netstream.Hook("BASH_Return_Writing", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;

    BASH:CreateWriting(data[1], data[2]);
end);
