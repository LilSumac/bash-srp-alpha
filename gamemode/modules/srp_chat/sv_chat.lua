local BASH = BASH;

netstream.Hook("BASH_Send_Chat", function(ply, data)
	local text = data[1];
	local consoleText = data[2];
	local commandID = data[3];

	BASH:HandleChat(ply, text, consoleText, commandID);
end);

function BASH:HandleChat(ply, text, consoleText, commandID)
	local commandData;
	for _, data in pairs(CHAT_TYPES) do
		if data.ID == commandID then
			commandData = data;
		end
	end
	if !commandData then
		commandData = CHAT_TYPES.SAY;
	end

	if commandID == CHAT_TYPES.OOC.ID then
		if !self.MutedPlayers then
			self.MutedPlayers = {};
		end
		if self.MutedPlayers[ply:SteamID()] then
			ply:PrintChat("You are muted in OOC.");
			return;
		elseif CurTime() - ply:GetEntry("LastOOC") > self.OOCDelay and !ply:IsStaff() then
			ply:UpdateEntry("LastOOC", CurTime());
		elseif !ply:IsStaff() then
			ply:PrintChat("Please wait " .. math.ceil((ply:GetEntry("LastOOC") + self.OOCDelay) - CurTime()) .. " seconds before typing in OOC.");
			return;
		end
	end

	local recipients = {ply};
	if commandData.Range then
		if commandData.Range == 0 then
			for _, newPly in pairs(player.GetAll()) do
				if newPly:IsPlayer() and newPly:GetEntry("CharLoaded") and newPly != ply then
					table.insert(recipients, newPly);
				end
			end
		else
			local nearby = ents.FindInSphere(ply:GetPos(), commandData.Range);
			for _, newPly in pairs(nearby) do
				if newPly:IsPlayer() and newPly:GetEntry("CharLoaded") and newPly != ply then
					table.insert(recipients, newPly);
				end
			end
		end
	else
		if commandData.Run then
			commandData.Run(ply, text);
			return;
		end
	end

	if commandID != CHAT_TYPES.UTIL.ID then
		MsgCon(color_white, consoleText, true);
	end
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, consoleText, commandID});
end

function CHAT_TYPES.RADIO.Run(ply, text, lang, jumb)
	if !ply:HasItem("radio_handheld") then
		ply:PrintChat("You don't have a radio to use!");
		return;
	end
	if ply:GetEntry("Frequency") == 0 then
		ply:PrintChat("You have not set your frequency!");
		return;
	end

	local freq = ply:GetEntry("Frequency");
	if lang and jumb then
		local recipients, jumbRecipients = {}, {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 250);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end

		local message = "[RADIO] " .. ply:GetEntry("Name") .. ": " .. text;
		local jumbledMessage = "[RADIO] " .. ply:GetEntry("Name") .. ": " .. jumb;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. message, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, message, message, CHAT_TYPES.RADIO.ID});
		netstream.Start(jumbRecipients, "BASH_Return_Chat", {ply, jumbledMessage, jumbledMessage, CHAT_TYPES.RADIO.ID});
	else
		local recipients = {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					table.insert(recipients, _ply);
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 250);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					table.insert(recipients, _ply);
				end
			end
		end

		local text = "[RADIO] " .. ply:GetEntry("Name") .. ": " .. text;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. text, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, CHAT_TYPES.RADIO.ID});
	end
end

function CHAT_TYPES.RWHISP.Run(ply, text, lang, jumb)
	if !ply:HasItem("radio_handheld") then
		ply:PrintChat("You don't have a radio to use!");
		return;
	end
	if ply:GetEntry("Frequency") == 0 then
		ply:PrintChat("You have not set your frequency!");
		return;
	end

	local freq = ply:GetEntry("Frequency");
	if lang and jumb then
		local recipients, jumbRecipients = {}, {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 50);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end

		local message = "[RADIO - WHISPER] " .. ply:GetEntry("Name") .. ": " .. text;
		local jumbledMessage = "[RADIO - WHISPER] " .. ply:GetEntry("Name") .. ": " .. jumb;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. message, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, message, message, CHAT_TYPES.RWHISP.ID});
		netstream.Start(jumbRecipients, "BASH_Return_Chat", {ply, jumbledMessage, jumbledMessage, CHAT_TYPES.RWHISP.ID});
	else
		local recipients = {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					table.insert(recipients, _ply);
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 50);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					table.insert(recipients, _ply);
				end
			end
		end

		local text = "[RADIO - WHISPER] " .. ply:GetEntry("Name") .. ": " .. text;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. text, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, CHAT_TYPES.RWHISP.ID});
	end
end

function CHAT_TYPES.RYELL.Run(ply, text, lang, jumb)
	if !ply:HasItem("radio_handheld") then
		ply:PrintChat("You don't have a radio to use!");
		return;
	end
	if ply:GetEntry("Frequency") == 0 then
		ply:PrintChat("You have not set your frequency!");
		return;
	end

	local freq = ply:GetEntry("Frequency");
	if lang and jumb then
		local recipients, jumbRecipients = {}, {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 750);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					if _ply:HasQuirk(lang) then
						table.insert(recipients, _ply);
					else
						table.insert(jumbRecipients, _ply);
					end
				end
			end
		end

		local message = "[RADIO - YELL] " .. ply:GetEntry("Name") .. ": " .. text;
		local jumbledMessage = "[RADIO - YELL] " .. ply:GetEntry("Name") .. ": " .. jumb;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. message, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, message, message, CHAT_TYPES.RYELL.ID});
		netstream.Start(jumbRecipients, "BASH_Return_Chat", {ply, jumbledMessage, jumbledMessage, CHAT_TYPES.RYELL.ID});
	else
		local recipients = {};
		for _, _ply in pairs(player.GetAll()) do
			if CheckPly(_ply) and CheckChar(_ply) then
				if freq == _ply:GetEntry("Frequency") then
					table.insert(recipients, _ply);
				end
			end
		end
		local nearby = ents.FindInSphere(ply:GetPos(), 750);
		for _, _ply in pairs(nearby) do
			if CheckPly(_ply) and CheckChar(_ply) and ply != _ply then
				if !table.HasValue(recipients, _ply) then
					table.insert(recipients, _ply);
				end
			end
		end

		local text = "[RADIO - YELL] " .. ply:GetEntry("Name") .. ": " .. text;
		MsgCon(color_white, "[" .. ply:GetEntry("Frequency") .. "] " .. text, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, CHAT_TYPES.RYELL.ID});
	end
end

function CHAT_TYPES.LEVENT.Run(ply, text)
	if !ply:IsStaff() and !ply:HasFlag("e") and !ply:HasFlag("b") and !ply:IsTrader() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local nearby = ents.FindInSphere(ply:GetPos(), 2000);
	local recipients = {ply};
	for _, _ply in pairs(nearby) do
		if CheckPly(_ply) and CheckChar(_ply) and _ply != ply then
			table.insert(recipients, _ply);
		end
	end

	local text = "[LOCAL-EVENT] **" .. text .. "**";
	local console = "(" .. ply:GetEntry("Name") .. " [" .. ply:Name() .. "] has used /levent.)\n**[LOCAL-EVENT] " .. text .. "**";
	MsgCon(color_white, console);
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, console, CHAT_TYPES.LEVENT.ID});
end

function CHAT_TYPES.EVENT.Run(ply, text)
	if !ply:IsStaff() and !ply:HasFlag("e") and !ply:HasFlag("b") then
		ply:PrintChat("You can't do that!");
		return;
	end

	local recipients = {};
	for _, _ply in pairs(player.GetAll()) do
		if CheckPly(_ply) and CheckChar(_ply) then
			table.insert(recipients, _ply);
		end
	end

	local text = "[EVENT] **" .. text .. "**";
	local console = "(" .. ply:GetEntry("Name") .. " [" .. ply:Name() .. "] has used /event.)\n**[EVENT] " .. text .. "**";
	MsgCon(color_white, console);
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, console, CHAT_TYPES.EVENT.ID});
end

function CHAT_TYPES.ADMIN.Run(ply, text)
	if !ply:IsStaff() then
		ply:PrintChat("You're not authorized to use this chat!");
		return;
	end

	local recipients = {};
	for _, _ply in pairs(player.GetAll()) do
		if CheckPly(_ply) and CheckChar(_ply) then
			if _ply:IsStaff() then
				table.insert(recipients, _ply);
			end
		end
	end

	local text = "[ADMIN] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. "): " .. text;
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, CHAT_TYPES.ADMIN.ID});
end

function CHAT_TYPES.BROAD.Run(ply, text)
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local recipients = {};
	for _, _ply in pairs(player.GetAll()) do
		if CheckPly(_ply) and CheckChar(_ply) then
			table.insert(recipients, _ply);
		end
	end

	local text = "[BROADCAST] " .. text;
	local console = "(" .. ply:GetEntry("Name") .. " [" .. ply:Name() .. "] has used /broadcast.)\n" .. text;
	MsgCon(color_white, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. " / " .. ply:GetEntry("BASHID") .. "] has used /broadcast.\n" .. text);
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, console, CHAT_TYPES.BROAD.ID});
end

function CHAT_TYPES.ADMIN.Run(ply, text)
	if !ply:IsStaff() then
		ply:PrintChat("You're not authorized to use this chat!");
		return;
	end

	local recipients = {};
	for _, _ply in pairs(player.GetAll()) do
		if CheckPly(_ply) and CheckChar(_ply) then
			if _ply:IsStaff() then
				table.insert(recipients, _ply);
			end
		end
	end

	local text = "[ADMIN] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. "): " .. text;
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, CHAT_TYPES.ADMIN.ID});
end
