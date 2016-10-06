local BASH = BASH;

local function PrintItems(ply, cmd, args)
	for id, item in SortedPairs(BASH.Items) do
		MsgN(item.Name .. " - " .. id);
	end
end
concommand.Add("#!/items", PrintItems);

local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

local function enc(data)
    return ((data:gsub('.', function(x)
        local r, b = '', x:byte();
        for i = 8, 1, -1 do r = r .. (b % 2^i - b % 2^(i - 1) > 0 and '1' or '0') end;
        return r;
    end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end;
        local c = 0;
        for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2^(6 - i) or 0) end;
        return b:sub(c + 1, c + 1);
    end) .. ({'', '==', '='})[#data % 3 + 1]);
end

netstream.Hook("BASH_Request_Screencap", function(data)
    /*  WORKING - Low Quality
	local data = render.Capture({
		format = "jpeg",
		quality = 10,
		h = ScrH(),
		w = ScrW(),
		x = 0,
		y = 0
	});

    net.Start("BASH_Send_Screencap");
        net.WriteInt(#data, 32);
        net.WriteData(data, #data);
    net.SendToServer();
    */

    local data = render.Capture({
		format = "jpeg",
		quality = 70,
		h = ScrH(),
		w = ScrW(),
		x = 0,
		y = 0
	});

    local encoded = enc(data);
    local delay = 0.5;
	local index, loopIndex = 1, 1;

	repeat
        timer.Simple(delay, function()
    		net.Start("BASH_Send_Screencap");
    		net.WriteString(string.sub(encoded, index, index + 65000));
            index = index + 65001;
    		if index > string.len(encoded) then
    			net.WriteBool(true);
    		else
    			net.WriteBool(false);
    		end
    		net.SendToServer();
        end);
        loopIndex = loopIndex + 65001;
        delay = delay + 1;
	until loopIndex > string.len(encoded)
end);

netstream.Hook("BASH_Request_Charinfo", function(data)
	if !data then return end;
	MsgCon(color_green, data);
end);

netstream.Hook("BASH_Edit_CharFlags", function(data)
    if !data then return end;

    BASH.EditingFlags = true;
    local flags = data:GetEntry("CharFlags") or "";
    local edit = vgui.Create("DFrame");
    edit:SetSize(300, 75);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText(data:GetEntry("Name") .. ": Character Flags", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local box = vgui.Create("DTextEntry", edit);
    box:SetSize(285, 20);
    box:SetPos(5, 25);
    box:SetValue(flags or "");

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        edit:Remove();
        BASH.EditingFlags = false;
    end

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        local newFlags = box:GetValue();

        if !LocalPlayer():IsSumac() then
            if (string.find(flags, "d") and !string.find(newFlags, "d")) or (string.find(flags, "a") and !string.find(newFlags, "a")) or
               (string.find(flags, "q") and !string.find(newFlags, "q")) then
                LocalPlayer():PrintChat("Only a Director can demote people! (Flags q', 'a', and 'd' are rank flags)");
                return;
            elseif (!string.find(flags, "d") and string.find(newFlags, "d")) or (!string.find(flags, "a") and string.find(newFlags, "a")) or
                   (!string.find(flags, "q") and string.find(newFlags, "q")) then
                LocalPlayer():PrintChat("Only a Director can promote people! (Flags q', 'a', and 'd' are rank flags)");
                return;
            end
        end

        netstream.Start("BASH_Edit_CharFlags_Return", {data, box:GetValue()});
        edit:Remove();
        BASH.EditingFlags = false;
    end
end);

netstream.Hook("BASH_Edit_PlyFlags", function(data)
    if !data then return end;

    BASH.EditingFlags = true;
    local flags = data:GetEntry("PlayerFlags") or "";
    local edit = vgui.Create("DFrame");
    edit:SetSize(300, 75);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText(data:GetEntry("Name") .. ": Player Flags", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local box = vgui.Create("DTextEntry", edit);
    box:SetSize(285, 20);
    box:SetPos(5, 25);
    box:SetValue(flags or "");

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        edit:Remove();
        BASH.EditingFlags = false;
    end

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        local newFlags = box:GetValue();

        if !LocalPlayer():IsSumac() then
            if (string.find(flags, "d") and !string.find(newFlags, "d")) or (string.find(flags, "a") and !string.find(newFlags, "a")) or
               (string.find(flags, "q") and !string.find(newFlags, "q")) then
                LocalPlayer():PrintChat("Only a Director can demote people! (Flags 'g', 'q', 'a', 'e', and 'd' are rank flags)");
                return;
            elseif (!string.find(flags, "d") and string.find(newFlags, "d")) or (!string.find(flags, "a") and string.find(newFlags, "a")) or
                   (!string.find(flags, "q") and string.find(newFlags, "q")) then
                LocalPlayer():PrintChat("Only a Director can promote people! (Flags 'q', 'a', and 'd' are rank flags)");
                return;
            end
        end

        netstream.Start("BASH_Edit_PlyFlags_Return", {data, box:GetValue()});
        edit:Remove();
        BASH.EditingFlags = false;
    end
end);

netstream.Hook("BASH_Edit_Whitelists", function(data)
    if !data then return end;

    BASH.EditingWhitelists = true;
    local whitelists = data:GetEntry("Whitelists");
    if !whitelists then return end;
    local edit = vgui.Create("DFrame");
    edit:SetSize(200, 300);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText(data:GetEntry("Name") .. ": Whitelists", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local x = 5;
    local y = 20;
    local boxLabels = {};
    local boxes = {};
    local val = 0;
    for id, faction in pairs(BASH.Factions) do
        boxLabels[id] = vgui.Create("DLabel", edit);
        boxLabels[id]:SetPos(x, y);
        boxLabels[id]:SetFont("BASHFontHeavy");
        boxLabels[id]:SetText(faction.Name);
        boxLabels[id]:SizeToContents();
        y = y + boxLabels[id]:GetTall() + 5;

        boxes[id] = vgui.Create("DCheckBox", edit);
        boxes[id]:SetPos(x, y);
        boxes[id]:SetChecked(LocalPlayer():HasWhitelist(id));
        y = y + boxes[id]:GetTall() + 5;
    end

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        edit:Remove();
        BASH.EditingWhitelists = false;
    end

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        local newWhitelists = "";
        for id, box in pairs(boxes) do
            if box:GetChecked() then
                newWhitelists = newWhitelists .. id .. ";";
            end
        end

        netstream.Start("BASH_Edit_Whitelists_Return", {data, newWhitelists});
        edit:Remove();
        BASH.EditingWhitelists = false;
    end
end);

netstream.Hook("BASH_Play_Youtube", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
	if !data then return end;

	if BASH.Youtube and BASH.Youtube:IsValid() then
		BASH.Youtube:Remove();
	end

	BASH.Youtube = vgui.Create("HTML");
	BASH.Youtube:SetPos(0, 0);
	BASH.Youtube:SetSize(0, 0);
	BASH.Youtube:SetVisible(false);
	BASH.Youtube:OpenURL("http://www.youtube.com/watch?v=" .. data .. "&autoplay=1");
end);

netstream.Hook("BASH_Kill_Youtube", function(data)
	if !BASH.Youtube then return end;
	BASH.Youtube:Remove();
end);

netstream.Hook("BASH_Send_History", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

    local charID = data[1];
    local hist = data[2] or "";
    if !charID then return end;
    local target = player.GetByInfo("CharID", charID);
    if !target then
        LocalPlayer():PrintChat("No character was found with the ID '" .. charID .. "'!");
        return;
    end

    BASH.EditingHistory = true;
    local edit = vgui.Create("DFrame");
    edit:SetSize(500, 500);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText(target:GetEntry("Name") .. ": History", "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local box = vgui.Create("DTextEntry", edit);
    box:SetSize(490, 445);
    box:SetPos(5, 25);
    box:SetValue(hist or "");
    box:SetMultiline(true);

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        netstream.Start("BASH_Update_History", {charID});
        edit:Remove();
        BASH.EditingHistory = false;
    end

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        netstream.Start("BASH_Update_History", {charID, box:GetValue()});
        edit:Remove();
        BASH.EditingHistory = false;
    end
end);

netstream.Hook("BASH_Edit_Bounty", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

    local bountyID = data[1];
    local bounty = data[2];

    BASH.EditingBounty = true;
    local edit = vgui.Create("DFrame");
    edit:SetSize(260, 200);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText("Bounty Edit: " .. bountyID, "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        netstream.Start("BASH_Update_Bounty", {bountyID});
        edit:Remove();
        BASH.EditingHistory = false;
    end

    local y = 30;
    local descLabel = vgui.Create("DLabel", edit);
    descLabel:SetPos(5, y);
    descLabel:SetFont("BASHFontHeavy");
    descLabel:SetText("Description");
    descLabel:SizeToContents();
    y = y + descLabel:GetTall() + 5;

    local desc = vgui.Create("DTextEntry", edit);
    desc:SetSize(250, 60);
    desc:SetPos(5, y);
    desc:SetMultiline(true);
    desc:SetValue(bounty.Desc);
    y = y + desc:GetTall() + 5;

    local priceLabel = vgui.Create("DLabel", edit);
    priceLabel:SetPos(5, y);
    priceLabel:SetFont("BASHFontHeavy");
    priceLabel:SetText("Price");
    priceLabel:SizeToContents();
    y = y + priceLabel:GetTall() + 5;

    local price = vgui.Create("DTextEntry", edit);
    price:SetSize(100, 16);
    price:SetPos(5, y);
    price:SetValue(bounty.Price);
    y = y + price:GetTall() + 5;

    local statusLabel = vgui.Create("DLabel", edit);
    statusLabel:SetPos(5, y);
    statusLabel:SetFont("BASHFontHeavy");
    statusLabel:SetText("Status");
    statusLabel:SizeToContents();
    y = y + statusLabel:GetTall() + 5;

    local status = vgui.Create("DComboBox", edit);
	status:SetSize(100, 20);
	status:SetPos(5, y);
	status:SetValue(bounty.Status);
	status:AddChoice("OPEN");
	status:AddChoice("FROZEN");
	status:AddChoice("COMPLETED");
    status:AddChoice("CLOSED");

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        netstream.Start("BASH_Update_Bounty", {bountyID, desc:GetValue(), tonumber(price:GetValue()), status:GetValue()});
        edit:Remove();
        BASH.EditingBounty = false;
    end
end);

netstream.Hook("BASH_Edit_Advert", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

    local advertID = data[1];
    local advert = data[2];

    BASH.EditingAdvert = true;
    local edit = vgui.Create("DFrame");
    edit:SetSize(260, 200);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText("Advert Edit: " .. advertID, "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        netstream.Start("BASH_Update_Advert", {advertID});
        edit:Remove();
        BASH.EditingAdvert = false;
    end

    local y = 30;
    local titleLabel = vgui.Create("DLabel", edit);
    titleLabel:SetPos(5, y);
    titleLabel:SetFont("BASHFontHeavy");
    titleLabel:SetText("Title");
    titleLabel:SizeToContents();
    y = y + titleLabel:GetTall() + 5;

    local title = vgui.Create("DTextEntry", edit);
    title:SetSize(100, 16);
    title:SetPos(5, y);
    title:SetValue(advert.Title);
    y = y + title:GetTall() + 5;

    local descLabel = vgui.Create("DLabel", edit);
    descLabel:SetPos(5, y);
    descLabel:SetFont("BASHFontHeavy");
    descLabel:SetText("Description");
    descLabel:SizeToContents();
    y = y + descLabel:GetTall() + 5;

    local desc = vgui.Create("DTextEntry", edit);
    desc:SetSize(250, 60);
    desc:SetPos(5, y);
    desc:SetMultiline(true);
    desc:SetValue(advert.Desc);
    y = y + desc:GetTall() + 5;

    local ownerLabel = vgui.Create("DLabel", edit);
    ownerLabel:SetPos(5, y);
    ownerLabel:SetFont("BASHFontHeavy");
    ownerLabel:SetText("Owner");
    ownerLabel:SizeToContents();
    y = y + ownerLabel:GetTall() + 5;

    local owner = vgui.Create("DTextEntry", edit);
    owner:SetSize(100, 16);
    owner:SetPos(5, y);
    owner:SetValue(advert.Owner);
    y = y + owner:GetTall() + 5;

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        netstream.Start("BASH_Update_Advert", {advertID, title:GetValue(), desc:GetValue(), owner:GetValue()});
        edit:Remove();
        BASH.EditingAdvert = false;
    end
end);

netstream.Hook("BASH_Edit_Group", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

    local groupID = data[1];
    local group = data[2];

    BASH.EditingGroup = true;
    local edit = vgui.Create("DFrame");
    edit:SetSize(260, 200);
    edit:Center();
    edit:SetTitle("");
    edit:ShowCloseButton(false);
    edit:SetDraggable(false);
    edit:MakePopup();
    edit.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h,  Color(0, 0, 0, 255));
        draw.RoundedBox(4, 1, 1, w - 2, h - 2, Color(75, 75, 75, 255));
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, Color(50, 50, 50, 255));
        draw.SimpleText("Group Edit: " .. groupID, "BASHFontHeavy", 5, 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
    end

    local close = vgui.Create("DButton", edit);
    close:SetPos(edit:GetWide() - 25, 5);
    close:SetSize(20, 20);
    close:SetFont("marlett");
    close:SetText("r");
    close.Paint = function() end;
    close.DoClick = function()
        netstream.Start("BASH_Update_Group", {groupID});
        edit:Remove();
        BASH.EditingGroup = false;
    end

    local y = 30;
    local descLabel = vgui.Create("DLabel", edit);
    descLabel:SetPos(5, y);
    descLabel:SetFont("BASHFontHeavy");
    descLabel:SetText("Description");
    descLabel:SizeToContents();
    y = y + descLabel:GetTall() + 5;

    local desc = vgui.Create("DTextEntry", edit);
    desc:SetSize(250, 60);
    desc:SetPos(5, y);
    desc:SetMultiline(true);
    desc:SetValue(group.Desc);
    y = y + desc:GetTall() + 5;

    local leaderLabel = vgui.Create("DLabel", edit);
    leaderLabel:SetPos(5, y);
    leaderLabel:SetFont("BASHFontHeavy");
    leaderLabel:SetText("Leader");
    leaderLabel:SizeToContents();
    y = y + leaderLabel:GetTall() + 5;

    local leader = vgui.Create("DTextEntry", edit);
    leader:SetSize(150, 20);
    leader:SetPos(5, y);
    leader:SetValue(group.Leader);
    y = y + leader:GetTall() + 5;

    local statusLabel = vgui.Create("DLabel", edit);
    statusLabel:SetPos(5, y);
    statusLabel:SetFont("BASHFontHeavy");
    statusLabel:SetText("Enlistment");
    statusLabel:SizeToContents();
    y = y + statusLabel:GetTall() + 5;

    local status = vgui.Create("DComboBox", edit);
	status:SetSize(100, 20);
	status:SetPos(5, y);
	status:SetValue(group.Hiring);
	status:AddChoice("OPEN");
	status:AddChoice("???");
    status:AddChoice("CLOSED");

    surface.SetFont("BASHFontHeavy");
    local x, y = surface.GetTextSize("Update");
    local send = BASH:CreateTextButton("Update", "BASHFontHeavy", edit:GetWide() - x - 23, edit:GetTall() - y - 11, edit);
    send.Action = function()
        netstream.Start("BASH_Update_Group", {groupID, desc:GetValue(), leader:GetValue(), status:GetValue()});
        edit:Remove();
        BASH.EditingGroup = false;
    end
end);

netstream.Hook("BASH_Convo", function(data)
    if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

    LocalPlayer().Convo = data;
end);

netstream.Hook("BASH_Request_PatDown", function(data)
	if !CheckPly(LocalPlayer()) or !LocalPlayer():GetEntry("CharLoaded") then return end;
    if !data then return end;

	Derma_Query(
		data:GetEntry("Name") .. " is requesting to pat you down. If you are being robbed, you must accept.",
		"Pat-down Request",
		"Decline",
		function()
			netstream.Start("BASH_PatDown_Response", {false, data});
		end,
		"Accept",
		function()
			netstream.Start("BASH_PatDown_Response", {true, data});
		end
	);
end);
netstream.Hook("BASH_Send_PatDown", function(data)
	MsgCon(color_green, data);
end);
