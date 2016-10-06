local BASH = BASH;
local Player = FindMetaTable("Player");
BASH.Registry = {};
BASH.Registry.Variables = {};
BASH.Registry.Players = {};

function BASH.Registry:NewVariable(name, default, public, secure, isPlayerVar, initFunc)
	if !name or default == nil then return end;

	self.Variables[name] = {
		Default = default,
		Public = public,
		Secure = secure,
		PlayerVar = isPlayerVar or false,
		InitFunc = initFunc
	};
end

function Player:UpdateEntry(variable, value)
	if CLIENT then
		netstream.Start("BASH_Request_Update", {variable, value});
		return;
	end
	if !CheckPly(self) then return end;
	if !variable then return end;
	if value and isstring(value) and !string.find(variable, "Inv") then
		value = string.gsub(value, "#", "");
	end

	local plyID = self:UniqueID();
	if !BASH.Registry.Players[plyID] then return end;
	if !BASH.Registry.Variables[variable] then return end;

	if istable(variable) and istable(value) then
		for index, var in pairs(variable) do
			BASH.Registry.Players[plyID][var].Value = value[index] or BASH.Registry.Variables[var].Default;
		end

		BASH.Registry:Blink(self);
	else
		BASH.Registry.Players[plyID][variable].Value = value or BASH.Registry.Variables[variable].Default;
		BASH.Registry:Blink(self, variable, noInvUpdate);
	end
end

function Player:GetEntry(variable)
	if !CheckPly(self) then return end;

	local plyID = self:UniqueID();
	local entry;

	if !BASH.Registry.Players[plyID] then return end;

	if variable then
		entry = BASH.Registry.Players[plyID][variable];
		if !entry then return end;
		return entry.Value or entry.Default;
	else
		return BASH.Registry.Players[plyID];
	end
end

function BASH.Registry:Blink(ply, variable)
	if CLIENT then return end;
	if !CheckPly(ply) then return end;

	local plyID = ply:UniqueID();
	if !self.Players[plyID] then
		self.Players[plyID] = {};
	end

	local recipients = player.GetRegistered();
	if variable then
		local data = self.Players[plyID][variable];
		if !data then return end;

		netstream.Start((data.Public and recipients) or ply, "BASH_Registry_Blink", {plyID, variable, data.Value});
	else
		for var, data in pairs(self.Players[plyID]) do
			netstream.Start((data.Public and recipients) or ply, "BASH_Registry_Blink", {plyID, var, data.Value});
		end
	end
end

function Player:Register()
	if CLIENT then return end;
	if !CheckPly(self) then return end;
	if !self.SQLInitDone then
		netstream.Start(self, "BASH_Init_Messages", "Waiting for SQL data...");

		timer.Simple(0.5, function()
			self:Register();
		end);
		return;
	end

	netstream.Start(self, "BASH_Init_Messages", "Filling registry entry...");
	local plyID = self:UniqueID();
	BASH.Registry.Players[plyID] = {};

	for var, data in pairs(BASH.Registry.Variables) do
		BASH.Registry.Players[plyID][var] = {
			Default = data.Default,
			Value = (data.InitFunc and data.InitFunc(self)) or data.Default,
			Public = data.Public or false
		};
	end

	if self:HasFlag(FLAG_PLY, "d") then
		self:UpdateEntry("Rank", "Director");
	elseif self:HasFlag(FLAG_PLY, "a") then
		self:UpdateEntry("Rank", "Admin.");
	elseif self:HasFlag(FLAG_PLY, "q") then
		self:UpdateEntry("Rank", "Trial Admin.");
	elseif self:HasFlag(FLAG_PLY, "g") then
		self:UpdateEntry("Rank", "Volunteer");
	end

	local progress = 0;
	for plyID, registry in pairs(BASH.Registry.Players) do
		local ply = player.GetByUniqueID(plyID);

		if CheckPly(ply) then
			for var, data in pairs(registry) do
				if data.Public or ply == self then
					netstream.Start(self, "BASH_Registry_Blink", {plyID, var, data.Value});
				end
			end
		end

		progress = progress + 1;
		netstream.Start(self, "BASH_Init_Messages", "Requesting registry data (" .. math.Round((progress / table.Count(BASH.Registry.Players)) * 100) .. "%)...");
	end

	netstream.Start(self, "BASH_Init_Messages", "Touching things up...");
	//netstream.Start(self, "BASH_Init_Done");
	self.InitDone = true;
end

function Player:UnRegister()
	if CLIENT then return end;
	if !CheckPly(self) then return end;

	local plyID = self:UniqueID();
	if BASH.Registry.Players[plyID] then
		BASH.Registry.Players[plyID] = nil;
	end

	netstream.Start("BASH_Registry_Drop", plyID);
end

if CLIENT then
	netstream.Hook("BASH_Registry_Blink", function(data)
		if !CheckPly(LocalPlayer()) then return end;
		if !data[1] or !data[2] then return end;

		local plyID = data[1];
		if !BASH.Registry.Players[plyID] then
			BASH.Registry.Players[plyID] = {};
		end

		local var = data[2];
		if !BASH.Registry.Variables[var] then return end;
		if !BASH.Registry.Players[plyID][var] then
			BASH.Registry.Players[plyID][var] = {};
		end

		local val = data[3];
		BASH.Registry.Players[plyID][var].Value = data[3] or BASH.Registry.Variables[var].Default;

		if !LocalPlayer():GetEntry("CharLoaded") then return end;
		if plyID == LocalPlayer():UniqueID() and (string.sub(var, 1, 3) == "Inv" or var == "Clothing" or var == "Weapons" or var == "Artifacts") then
			BASH:RefreshInventory();
		elseif plyID == LocalPlayer():UniqueID() and var == "MaxStamina" then
			LocalPlayer():UpdateEntry("Stamina", math.Clamp(LocalPlayer():GetEntry("Stamina"), 0, LocalPlayer():GetEntry("MaxStamina")));
		end
	end);

	netstream.Hook("BASH_Registry_Drop", function(data)
		if !data[1] then return end;

		local plyID = data[1];
		if BASH.Registry.Players[plyID] then
			BASH.Registry.Players[plyID] = nil;
		end
	end);

	netstream.Hook("BASH_Init_Done", function(data)
		if !CheckPly(LocalPlayer()) then return end;
		LocalPlayer().InitDone = true;
	end);
else
	netstream.Hook("BASH_Request_Update", function(ply, data)
		if !CheckPly(ply) or !CheckChar(ply) then return end;
		if !data[1] then return end;

		local var = BASH.Registry.Variables[data[1]];
		if !var then return end;
		if var.Secure then return end;

		if data[1] == "Name" then
			MsgCon(color_green, ply:Name() .. " has changed their name from " .. BASH.Registry.Players[ply:UniqueID()]["Name"].Value .. " to " .. data[2] .. ".", true);
		end

		ply:UpdateEntry(data[1], data[2]);
	end);
end

/*
**	Base/SQL Variables
*/

/*  Player Variables  */
BASH.Registry:NewVariable("SteamID", 		"", 	true, true, true,
	function(ply)
		if !CheckPly(ply) then return end;
		return ply:SteamID();
	end);
BASH.Registry:NewVariable("BASHID", 		"", 	true, true, true,
	function(ply)
		if !CheckPly(ply) then return end;
		if !ply.PlyData then return end;
		return ply.PlyData["BASHID"];
	end);
BASH.Registry:NewVariable("PassedQuiz", 	0, 		false, false, true,
	function(ply)
		if !CheckPly(ply) then return end;
		if !ply.PlyData then return end;
		return tonumber(ply.PlyData["PassedQuiz"]);
	end);
BASH.Registry:NewVariable("PlayerFlags", 	"", 	true, true, true,
	function(ply)
		if !CheckPly(ply) then return end;
		if !ply.PlyData then return end;
		return ply.PlyData["PlayerFlags"];
	end);
BASH.Registry:NewVariable("Whitelists", 	"", 	true, true, true,
	function(ply)
		if !CheckPly(ply) then return end;
		if !ply.PlyData then return end;
		return ply.PlyData["Whitelists"];
	end);

/*  Character Variables  */
BASH.Registry:NewVariable("CharLoaded", 	false, 	true, true);
BASH.Registry:NewVariable("CharID", 		"", 	true, true);
BASH.Registry:NewVariable("Name", 			"", 	true, false);
BASH.Registry:NewVariable("Description", 	"", 	true, false);
BASH.Registry:NewVariable("Model", 			"", 	true, true);
BASH.Registry:NewVariable("Gender", 		"", 	true, true);
BASH.Registry:NewVariable("Faction", 		"", 	true, true);
BASH.Registry:NewVariable("IsPKed", 		false, 	false, true);
BASH.Registry:NewVariable("PKTime", 		-1, 	false, true);
BASH.Registry:NewVariable("Quirks", 		"", 	false, true);
BASH.Registry:NewVariable("CharFlags", 		"", 	true, true);
BASH.Registry:NewVariable("Rubles", 		0, 		false, false);
BASH.Registry:NewVariable("InvMain", 		"", 	false, false);
BASH.Registry:NewVariable("InvSec", 		"", 	false, false);
BASH.Registry:NewVariable("InvAcc", 		"", 	false, false);
BASH.Registry:NewVariable("Suit", 			"", 	false, true);
BASH.Registry:NewVariable("Acc", 			"", 	false, true);
BASH.Registry:NewVariable("Clothing",		"",		true,  false);
BASH.Registry:NewVariable("Weapons",		"",		true,  false);
BASH.Registry:NewVariable("Artifacts",		"",		true,  false);

/*  Local Variables  */
BASH.Registry:NewVariable("LastNotif", 		0, 		false, false);
BASH.Registry:NewVariable("IsHungry", 		0, 		false, false);
BASH.Registry:NewVariable("LastAte", 		0, 		false, false);
BASH.Registry:NewVariable("NextHungerNotif", 0, 	false, false);
BASH.Registry:NewVariable("IsThirsty", 		0, 		false, false);
BASH.Registry:NewVariable("LastDrank", 		0, 		false, false);
BASH.Registry:NewVariable("NextThirstNotif", 0, 	false, false);
BASH.Registry:NewVariable("BloodType", 		"", 	true, true);
BASH.Registry:NewVariable("LastLootGrant",	0, 		false, true);

/*  Misc. Variables  */
BASH.Registry:NewVariable("Rank", 			"Player", true, true);
BASH.Registry:NewVariable("Props",			0, 		false, true);
BASH.Registry:NewVariable("MaxProps",		20, 	false, true);
BASH.Registry:NewVariable("IsTyping", 		false, 	true, false);
BASH.Registry:NewVariable("Observing", 		false, 	false, false);
BASH.Registry:NewVariable("Stamina", 		0, 		false, false);
BASH.Registry:NewVariable("StaminaRegen", 	0, 		false, false);
BASH.Registry:NewVariable("MaxStamina", 	0, 		false, false);
BASH.Registry:NewVariable("Weight", 		0, 		false, false);
BASH.Registry:NewVariable("MaxWeight", 		0, 		false, false);
BASH.Registry:NewVariable("MaxHealth", 		100, 	false, false);
BASH.Registry:NewVariable("HealthRegen", 	0, 		false, false);
BASH.Registry:NewVariable("LastOOC", 		0, 		false, false);
BASH.Registry:NewVariable("Frequency", 		0, 		false, false);
BASH.Registry:NewVariable("Radiation", 		0, 		false, false);
BASH.Registry:NewVariable("AdminESP", 		false, 	false, true);
BASH.Registry:NewVariable("DrunkMul",		0,		true,  false);
