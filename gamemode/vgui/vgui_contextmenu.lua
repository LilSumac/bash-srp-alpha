local BASH = BASH;
BASH.ContextMenu = {};
BASH.ContextMenu.Open = false;

function BASH:OnContextMenuOpen()
    if self:GUIOpen() then return false end;
    if self:GUIOccupied() then return false end;
    if self.ContextMenu.Open then return false end;
    if !LocalPlayer():Alive() then return false end;

    self.ContextMenu.Open = true;
    gui.EnableScreenClicker(true);

    if !self.ContextMenu.AlertLabel then
        self.ContextMenu.AlertLabel = vgui.Create("DPanel");
        self.ContextMenu.AlertLabel:SetSize(250, 113);
        self.ContextMenu.AlertLabel:SetPos(SCRW - 250, -113);
        self.ContextMenu.AlertLabel.Paint = function()
            local hidden = 0;
            for id, alert in pairs(self.Alerts) do
                if !alert:IsVisible() then
                    hidden = hidden + 1;
                end
            end

            draw.SimpleText("Total Props: " .. LocalPlayer():GetEntry("Props"), "BASHFontLarge", 245, 5, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
            draw.SimpleText("Maximum Props: " .. LocalPlayer():GetEntry("MaxProps"), "BASHFontLarge", 245, 32, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
            draw.SimpleText("Total Alerts: " .. table.Count(self.Alerts), "BASHFontLarge", 245, 59, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
            draw.SimpleText("Hidden Alerts: " .. hidden, "BASHFontLarge", 245, 86, color_white, TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
        end
        self.ContextMenu.AlertLabel:MoveTo(SCRW - 250, 0, 0.5, 0, 1);
    end

    if !self.ContextMenu.Buttons then
        self.ContextMenu.Buttons = vgui.Create("DPanel");
        self.ContextMenu.Buttons:SetSize(200, 75);
        self.ContextMenu.Buttons:SetPos(0, -75);
        self.ContextMenu.Buttons.Paint = function(self) end;
        self.ContextMenu.Buttons:MoveTo(0, 0, 0.5, 0, 1);

        local charMenu = self:CreateButton(5, 5, 190, 20, self.ContextMenu.Buttons);
        charMenu.PaintOver = function(self, width, height)
            local drawColor = Color(255, 255, 255, 255);
            if self.Entered then
                drawColor = Color(125, 125, 255, 255);
            end

            draw.SimpleText("Open Character Menu", "BASHFontHeavy", width / 2, height / 2, drawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        end
        charMenu.Action = function()
            self:OnContextMenuClose();
            self:CreateCharacterMenu();
        end

        local changeName = self:CreateButton(5, 30, 190, 20, self.ContextMenu.Buttons);
        changeName.PaintOver = function(self, width, height)
            local drawColor = Color(255, 255, 255, 255);
            if self.Entered then
                drawColor = Color(125, 125, 255, 255);
            end

            draw.SimpleText("Change Name", "BASHFontHeavy", width / 2, height / 2, drawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        end
        changeName.Action = function()
            self:OnContextMenuClose()

            local chars = 32;
            local name = vgui.Create("DFrame");
            name:SetSize(300, 75);
            name:Center();
            name:SetTitle("");
            name:ShowCloseButton(false);
            name:SetDraggable(false);
            name:MakePopup();
            name.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
                draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
                draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
                draw.SimpleText("Name", "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
            end

            local box = vgui.Create("DTextEntry", name);
            box:SetSize(285, 20);
            box:SetPos(5, 25);
            box:SetValue(LocalPlayer():GetEntry("Name"));
            box.OnValueChanged = function(self, text)
                self:SetValue(ChokeString(text, chars));
            end
            box.PaintOver = function(self, w, h)
                DisableClipping(true);
                draw.SimpleText("Characters left: " .. tostring(chars - string.len(self:GetValue())), "BASHFontHeavy", 0, h + 8, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
                DisableClipping(false);
            end

            local close = vgui.Create("DButton", name);
            close:SetPos(name:GetWide() - 25, 5);
            close:SetSize(20, 20);
            close:SetFont("marlett");
            close:SetText("r");
            close.Paint = function() end;
            close.DoClick = function()
                name:Remove();
            end

            surface.SetFont("BASHFontHeavy");
            local x, y = surface.GetTextSize("Update");
            local send = self:CreateTextButton("Update", "BASHFontHeavy", name:GetWide() - x - 23, name:GetTall() - y - 11, name);
            send.Action = function()
                LocalPlayer():UpdateEntry("Name", box:GetValue());
                name:Remove();
            end
        end

        local changeDesc = self:CreateButton(5, 55, 190, 20, self.ContextMenu.Buttons);
        changeDesc.PaintOver = function(self, width, height)
            local drawColor = Color(255, 255, 255, 255);
            if self.Entered then
                drawColor = Color(125, 125, 255, 255);
            end

            draw.SimpleText("Change Description", "BASHFontHeavy", width / 2, height / 2, drawColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
        end
        changeDesc.Action = function()
            self:OnContextMenuClose()

            local chars = 500;
            local desc = vgui.Create("DFrame");
            desc:SetSize(300, 200);
            desc:Center();
            desc:SetTitle("");
            desc:ShowCloseButton(false);
            desc:SetDraggable(false);
            desc:MakePopup();
            desc.Paint = function(self, w, h)
                draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
                draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
                draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
                draw.SimpleText("Description", "BASHFontHeavy", 5, 5, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
            end

            local box = vgui.Create("DTextEntry", desc);
            box:SetSize(290, 145);
            box:SetPos(5, 25);
            box:SetMultiline(true);
            box:SetValue(LocalPlayer():GetEntry("Description"));
            box.OnValueChanged = function(self, text)
                self:SetValue(ChokeString(text, 500));
            end
            box.PaintOver = function(self, w, h)
                DisableClipping(true);
                draw.SimpleText("Characters left: " .. tostring(chars - string.len(self:GetValue())), "BASHFontHeavy", 0, h + 8, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
                DisableClipping(false);
            end

            local close = vgui.Create("DButton", desc);
            close:SetPos(desc:GetWide() - 25, 5);
            close:SetSize(20, 20);
            close:SetFont("marlett");
            close:SetText("r");
            close.Paint = function() end;
            close.DoClick = function()
                desc:Remove();
            end

            surface.SetFont("BASHFontHeavy");
            local x, y = surface.GetTextSize("Update");
            local send = self:CreateTextButton("Update", "BASHFontHeavy", desc:GetWide() - x - 23, desc:GetTall() - y - 11, desc);
            send.Action = function()
                LocalPlayer():UpdateEntry("Description", box:GetValue());
                desc:Remove();
            end
        end
    end

    return false;
end

function BASH:OnContextMenuClose()
    if self:GUIOpen() then return false end;
    if !self.ContextMenu.Open then return false end;

    self.ContextMenu.Open = false;
    gui.EnableScreenClicker(false);

    if self.ContextMenu.AlertLabel then
        self.ContextMenu.AlertLabel:MoveTo(SCRW - 250, -113, 0.5, 0, 1, function()
            self.ContextMenu.AlertLabel:Remove();
            self.ContextMenu.AlertLabel = nil;
        end);
    end

    if self.ContextMenu.Buttons then
        self.ContextMenu.Buttons:MoveTo(0, -75, 0.5, 0, 1, function()
            self.ContextMenu.Buttons:Remove();
            self.ContextMenu.Buttons = nil;
        end);
    end

    CloseDermaMenus();

    return false;
end

function BASH:PlayerButtonUp(ply, button)
    if button == MOUSE_RIGHT then
        if self.ContextMenu.Open then
            /*  Entity Stuff
            local dir = gui.ScreenToVector(gui.MousePos());
            local traceData = {};
            traceData.start = LocalPlayer():EyePos();
            traceData.endpos = LocalPlayer():EyePos() + dir * 300;
            traceData.filter = LocalPlayer();
            local trace = util.TraceLine(traceData);
            if LocalPlayer():IsStaff() and trace.Hit and !trace.HitWorld and trace.Entity and trace.Entity:IsValid() and trace.Entity:IsPlayer() then
                local menu = DermaMenu();
                menu:AddOption("Kick", function()

                end):SetImage("icon16/bell_add.png");
                menu:AddOption("Ban", function()

                end):SetImage("icon16/bell_delete.png");
                menu:AddSpacer();
                menu:AddOption("Close"):SetImage("icon16/delete.png");
                menu:Open();
                return;
            end
            */

            local menu = DermaMenu();
            menu:AddOption("Report a Problem", function()
                self:OnContextMenuClose()

                Derma_StringRequest("Report a Problem",
                                    "Please describe your problem. Short and sweet, please! Someone will be with you to assist momentarily.",
                                    "",
                                    function(text)
                                        if LocalPlayer().LastReport and CurTime() - LocalPlayer().LastReport < 15 then
                                            self:CreateNotif("Please wait " .. math.ceil((LocalPlayer().LastReport + 15) - CurTime()) .. " seconds before submitting another report.", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                            return;
                                        end

                                        if !LocalPlayer():GetEntry("CharLoaded") then
                                            self:CreateNotif("You must have a character loaded to report something!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                            return;
                                        end

                                        LocalPlayer().LastReport = CurTime();
                                        local data = {
                                            ID = RandomString(8),
                                            Filter = ALERT_HELPER,
                                            Pos = LocalPlayer():GetPos(),
                                            Message = text,
                                            Time = os.date("[%d/%m/%Y] %X", os.time()),
                                            Symbol = '!',
                                            Color = Color(204, 0, 0),
                                            OwnerName = LocalPlayer():Name(),
                                            OwnerChar = LocalPlayer():GetEntry("Name"),
                                            OwnerID = LocalPlayer():GetEntry("BASHID")
                                        };

                                        self:RegisterAlert(data);
                                        self:CreateNotif("Your report has been submitted. Standby...", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                        surface.PlaySound("bash/gui/report.wav");

                                        netstream.Start("BASH_New_Alert", data);
                                    end);
            end):SetImage("icon16/exclamation.png");
            menu:AddOption("Request Assistance", function()
                self:OnContextMenuClose()

                Derma_StringRequest("Request Assistance",
                                    "Need something? Have a question? Keep it simple, someone will be with you shortly!",
                                    "",
                                    function(text)
                                        if LocalPlayer().LastReport and CurTime() - LocalPlayer().LastReport < 15 then
                                            self:CreateNotif("Please wait " .. math.ceil((LocalPlayer().LastReport + 15) - CurTime()) .. " seconds before requesting assistance.", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                            return;
                                        end

                                        if !LocalPlayer():GetEntry("CharLoaded") then
                                            self:CreateNotif("You must have a character loaded to request something!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                            return;
                                        end

                                        LocalPlayer().LastReport = CurTime();
                                        local data = {
                                            ID = RandomString(8),
                                            Filter = ALERT_HELPER,
                                            Pos = LocalPlayer():GetPos(),
                                            Message = text,
                                            Time = os.date("[%d/%m/%Y] %X", os.time()),
                                            Symbol = '?',
                                            Color = Color(0, 102, 204),
                                            OwnerName = LocalPlayer():Name(),
                                            OwnerChar = LocalPlayer():GetEntry("Name"),
                                            OwnerID = LocalPlayer():GetEntry("BASHID")
                                        };

                                        self:RegisterAlert(data);
                                        self:CreateNotif("Your request has been submitted. Standby...", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                                        surface.PlaySound("bash/gui/request.wav");

                                        netstream.Start("BASH_New_Alert", data);
                                    end);
            end):SetImage("icon16/information.png");
            local hasConnectedPDA = false;
            local pdas = LocalPlayer():GetPDAs();
            for index, pda in pairs(pdas) do
                if pda.SIMCardSlot != "" then
                    hasConnectedPDA = true;
                end
            end
            if hasConnectedPDA and LocalPlayer():HasFlag("w") then
                menu:AddOption("Create PDA Alert", function()
                    self:OnContextMenuClose()

                    if !LocalPlayer():GetEntry("CharLoaded") then
                        self:CreateNotif("You must have a character loaded to request something!", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                        return;
                    end

                    local createPDAnotif = vgui.Create("DFrame");
                    createPDAnotif:SetTitle("Alert Info");
                	createPDAnotif:SetSize(300, 400);
                	createPDAnotif:Center();
                	createPDAnotif:MakePopup();
                	createPDAnotif:ShowCloseButton(false);
                	createPDAnotif:SetDraggable(false);
                    createPDAnotif.Paint = function(self, w, h)
                        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
                    	draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
                    	draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
                    end

                    local close = vgui.Create("DButton", createPDAnotif);
                	close:SetPos(createPDAnotif:GetWide() - 25, 5);
                	close:SetSize(20, 20);
                	close:SetFont("marlett");
                	close:SetText("r");
                	close.Paint = function() end;
                	close.DoClick = function()
                		createPDAnotif:Remove();
                	end

                    local x = 5;
                    local y = 20;
                    local messageLabel = vgui.Create("DLabel", createPDAnotif);
                    messageLabel:SetPos(x, y);
                    messageLabel:SetFont("BASHFontHeavy");
                    messageLabel:SetText(FormatString("Enter the message that PDA users will see in the alert info.", "BASHFontHeavy", 290));
                    messageLabel:SizeToContents();
                    y = y + messageLabel:GetTall() + 5;

                    local messageEntry = vgui.Create("DTextEntry", createPDAnotif);
                    messageEntry:SetPos(x, y);
                    messageEntry:SetSize(200, 20);
                    y = y + messageEntry:GetTall() + 5;

                    local symbolLabel = vgui.Create("DLabel", createPDAnotif);
                    symbolLabel:SetPos(x, y);
                    symbolLabel:SetFont("BASHFontHeavy");
                    symbolLabel:SetText(FormatString("Pick the symbol that PDA users will see on the alert.", "BASHFontHeavy", 290));
                    symbolLabel:SizeToContents();
                    y = y + symbolLabel:GetTall() + 5;

                    local symbolEntry = vgui.Create("DComboBox", createPDAnotif);
                    symbolEntry:SetPos(x, y);
                    symbolEntry:SetSize(100, 20);
                    symbolEntry:SetValue("!");
                    symbolEntry:AddChoice("!");
                    symbolEntry:AddChoice("?");
                    symbolEntry:AddChoice("+");
                    symbolEntry:AddChoice("*");
                    symbolEntry:AddChoice("E");
                    symbolEntry:AddChoice("T");
                    symbolEntry:AddChoice("A");
                    symbolEntry:AddChoice("O");
                    symbolEntry:AddChoice("I");
                    symbolEntry:AddChoice("N");
                    symbolEntry:AddChoice("S");
                    symbolEntry:AddChoice("H");
                    symbolEntry:AddChoice("R");
                    symbolEntry:AddChoice("D");
                    y = y + symbolEntry:GetTall() + 5;

                    local colorLabel = vgui.Create("DLabel", createPDAnotif);
                    colorLabel:SetPos(x, y);
                    colorLabel:SetFont("BASHFontHeavy");
                    colorLabel:SetText(FormatString("Pick the color that PDA users will see on the alert.", "BASHFontHeavy", 290));
                    colorLabel:SizeToContents();
                    y = y + colorLabel:GetTall() + 5;

                    local colorPicker = vgui.Create("DColorMixer", createPDAnotif);
                    colorPicker:SetPos(x, y);
                    colorPicker:SetSize(290, 200);
                    colorPicker:SetPalette(false);
                    colorPicker:SetAlphaBar(false);
                    colorPicker:SetWangs(false);
                    colorPicker:SetColor(color_red);

                    surface.SetFont("BASHFontHeavy");
                    local x, y = surface.GetTextSize("Create");
                    local send = BASH:CreateTextButton("Create", "BASHFontHeavy", createPDAnotif:GetWide() - x - 23, createPDAnotif:GetTall() - y - 11, createPDAnotif);
                    send.Action = function()
                        local data = {
                            ID = RandomString(8),
                            Filter = ALERT_PDAS,
                            Pos = LocalPlayer():GetPos(),
                            Message = messageEntry:GetValue(),
                            Time = os.date("[%d/%m/%Y] %X", os.time()),
                            Symbol = symbolEntry:GetValue(),
                            Color = colorPicker:GetColor(),
                            OwnerName = LocalPlayer():Name(),
                            OwnerChar = LocalPlayer():GetEntry("Name"),
                            OwnerID = LocalPlayer():GetEntry("BASHID")
                        };

                        self:RegisterAlert(data);
                        self:CreateNotif("Your PDA alert has been created.", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
                        surface.PlaySound("bash/gui/request.wav");

                        netstream.Start("BASH_New_Alert", data);
                        createPDAnotif:Remove();
                    end
                end):SetImage("icon16/transmit_add.png");
            end
            menu:AddOption("Show All Alerts", function()
                self:ShowAlerts(true);
            end):SetImage("icon16/bell_add.png");
            menu:AddOption("Hide All Alerts", function()
                self:ShowAlerts(false);
            end):SetImage("icon16/bell_delete.png");
            menu:AddSpacer();
            menu:AddOption("Close"):SetImage("icon16/delete.png");
            menu:Open();
        end
    end
end

hook.Add("HUDPaint", "ShowContextHelp", function()
    if BASH.ContextMenu.Open then
        draw.SimpleText("Left-/Right-click for additional options.", "BASHFontLarge", SCRW / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
    end
end);
