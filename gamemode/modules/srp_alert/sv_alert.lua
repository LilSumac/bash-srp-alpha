local BASH = BASH;
BASH.Alerts = {};

function BASH:NewAlert(data)
	if !data then return end;

	local recipients = {};
	if data.Filter == ALERT_NONE then
		recipients = {};
		for _, ply in pairs(player.GetAll()) do
			if CheckPly(ply) and CheckChar(ply) then
				table.insert(recipients, ply);
			end
		end
	elseif data.Filter == ALERT_HELPER then
		for _, ply in pairs(player.GetAll()) do
			if CheckPly(ply) and CheckChar(ply) and ply:IsHelper() then
				table.insert(recipients, ply);
			end
		end
	elseif data.Filter == ALERT_PDAS then
		for index, sim in pairs(self.ConnectedPDAs) do
			local ply = self:GetSIMOwner(sim);
			if !table.HasValue(recipients, ply) then
				table.insert(recipients, ply);
			end
		end
	end

	self.Alerts[data.ID] = data;
	netstream.Start(recipients, "BASH_New_Alert_Return", data);
end

function BASH:SendAlerts(ply)
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	local alertSent = false;
	for id, alert in pairs(self.Alerts) do
		alertSent = false;

		/*
		if alert.OwnerID == ply:GetEntry("BASHID") then
			netstream.Start(ply, "BASH_New_Alert_Return", alert);
			continue;
		end
		*/
		if alert.Filter == ALERT_NONE then
			alertSent = true;
			netstream.Start(ply, "BASH_New_Alert_Return", alert);
		elseif alert.Filter == ALERT_HELPER then
			if ply:IsHelper() then
				alertSent = true;
				netstream.Start(ply, "BASH_New_Alert_Return", alert);
			end
		elseif alert.Filter == ALERT_PDAS then
			for index, sim in pairs(self.ConnectedPDAs) do
				local owner = self:GetSIMOwner(sim);
				if ply == owner then
					alertSent = true;
					netstream.Start(ply, "BASH_New_Alert_Return", alert);
				end
			end
		end

		if !alertSent then
			netstream.Start(ply, "BASH_Remove_Alert_Return", alert.ID);
		end
	end
end

hook.Add("OnLoadCharacter", "SendAlertsOnLoad", function(ply)
	timer.Simple(10, function()
		BASH:SendAlerts(ply);
	end);
end);

hook.Add("OnItemPickup", "SendAlertsOnPickup", function(ply, entData)
	timer.Simple(10, function()
		if string.sub(entData.ItemID, 1, 4) == "pda_" then
			BASH:SendAlerts(ply);
		end
	end);
end);

hook.Add("OnItemDrop", "SendAlertsOnDrop", function(ply, data)
	timer.Simple(10, function()
		if string.sub(data.ID, 1, 4) == "pda_" then
			BASH:SendAlerts(ply);
		end
	end);
end);

netstream.Hook("BASH_New_Alert", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	BASH:NewAlert(data);
end);

netstream.Hook("BASH_Remove_Alert", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	BASH.Alerts[data] = nil;
	for _, ply in pairs(player.GetAll()) do
		BASH:SendAlerts(ply);
	end
end);
