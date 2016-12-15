local BASH = BASH;
local Player = FindMetaTable("Player");

hook.Add("OnInit", "LoadSIMs", function()
	BASH:LoadSIMs();
	BASH:LoadPDAs();
	BASH:GetBounties();
	BASH:GetAdverts();
	BASH:GetGroups();
	timer.Simple(5, function()
		BASH:CalculateEconomy();
	end);
end);

hook.Add("InitPostEntity", "PDASpawnTowers", function()
	BASH:SpawnTowers();
end);

hook.Add("DBReconnect", "RecalcEcon", function()
	BASH:CalculateEconomy();
end);

hook.Add("Think", "HandleTowers", function()
	if !BASH.LastNetworkPing then
		BASH.LastNetworkPing = CurTime();
	end

	if CurTime() - BASH.LastNetworkPing < 5 then return end;

	local pingedNetwork = false;
	local tableReset = false;
	for _, ply in pairs(player.GetAll()) do
		if ply:GetEntry("CharLoaded") then
			if ply:HasPDA() then
				if !tableReset then
					BASH.ConnectedPDAs = {};
					tableReset = true;
				end

				local invs = {"InvMain", "InvSec", "InvAcc"};
				for index, invString in pairs(invs) do
					local inv = ply:GetEntry(invString);
					inv = util.JSONToTable(inv);

					for invX = 1, #inv.Content do
						for invY = 1, #inv.Content[1] do
							local item = inv.Content[invX][invY];
							local itemData = BASH.Items[item.ID];
							if !itemData then continue end;

							if itemData.IsPDA and item.SIMCardSlot != "" and item.MemorySlot != "" and BASH.PDAData[item.MemorySlot] and !BASH.PDAData[item.MemorySlot].GhostMode then
								table.insert(BASH.ConnectedPDAs, item.SIMCardSlot);
							end
						end
					end
				end

				pingedNetwork = true;
			end
		end
	end

	if pingedNetwork then
		BASH.LastNetworkPing = CurTime();
	end
end);

hook.Add("AddItemProperties", "AddPDAProperties", function(itemData, args, ent)
	if !itemData.IsPDA and !itemData.IsSIMCard then return end;

	if ent and ent:IsValid() then
		if itemData.IsPDA then
			ent:GetTable().SIMCardSlot = args[1];
			ent:GetTable().MemorySlot = args[2];
		elseif itemData.IsSIMCard then
			ent:GetTable().ICCID = args[1];
		end
		return true;
	else
		local newItemTab = {};
		if itemData.IsPDA then
			newItemTab.SIMCardSlot = args[1];
			newItemTab.MemorySlot = args[2];
		elseif itemData.IsSIMCard then
			newItemTab.ICCID = args[1];
		end
		return newItemTab;
	end
end);

hook.Add("GetItemProperties", "GetPDAProperties", function(itemData, entData)
	if !itemData.IsPDA and !itemData.IsSIMCard then return end;

	local args = {};
	if itemData.IsPDA then
		if entData then
			args[1] = entData.SIMCardSlot;
			args[2] = entData.MemorySlot;
		else
			args[1] = "";
			args[2] = RandomString(24);
			BASH:NewPDAData(args[2]);
		end
	elseif itemData.IsSIMCard then
		if entData then
			args[1] = entData.ICCID;
		else
			args[1] = "#89380" .. tostring(math.random(1000000, 9999999));
			BASH:NewSIMCardData(args[1]);
		end
	end
	return args;
end);

hook.Add("OnScrapItem", "DeleteSIMData", function(ply, invString, itemData, entData)
	if !CheckPly(ply) or !CheckChar(ply) or !invString or !itemData.IsPDA and !itemData.IsSIMCard then return end;

	if itemData.IsPDA and entData.SIMCardSlot != "" then
		if invString then
			local added = BASH:AddItemToInv(ply, invString, "sim_mini", {entData.SIMCardSlot});
			if !added then
				added = BASH:AddItemToInv(ply, "InvMain", "sim_mini", {entData.SIMCardSlot});
				if !added then
					added = BASH:AddItemToInv(ply, "InvSec", "sim_mini", {entData.SIMCardSlot});
					if !added then
						added = BASH:AddItemToInv(ply, "InvAcc", "sim_mini", {entData.SIMCardSlot});
						if !added then
							local traceTab = {};
							traceTab.start = ply:EyePos();
							traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
							traceTab.filter = ply;
							local trace = util.TraceLine(traceTab);
							local itemPos = trace.HitPos;
							itemPos.z = itemPos.z + 2;
							local newItem = ents.Create("bash_item");
							newItem:SetItem("sim_mini", {entData.SIMCardSlot});
							newItem:SetRPOwner(ply);
							newItem:SetPos(itemPos);
							newItem:SetAngles(Angle(0, 0, 0));
							newItem:Spawn();
						end
					end
				end
			end

			BASH:RemovePDAData(entData.MemorySlot);
		end
	elseif itemData.IsSIMCard and entData.ICCID then
		if entData then
			BASH:RemoveSIMCardData(entData.ICCID);
		end
	end
end);

hook.Add("ShutDown", "SaveSIMs", function()
	if BASH.PDAData and BASH.PDAData != {} then
		local pdas = util.TableToJSON(BASH.PDAData, true);
		BASH:WriteToFile("vars/pdas.txt", pdas, true);
		MsgCon(color_purple, "Saved PDA data! Entries: " .. table.Count(BASH.PDAData));
	end

	if BASH.SIMData and BASH.SIMData != {} then
		local sims = util.TableToJSON(BASH.SIMData, true);
		BASH:WriteToFile("vars/sims.txt", sims, true);
		MsgCon(color_purple, "Saved SIM data! Entries: " .. table.Count(BASH.SIMData));
	end

	if BASH.Bounties and BASH.Bounties != {} then
		local bounties = util.TableToJSON(BASH.Bounties, true);
		BASH:WriteToFile("vars/bounties.txt", bounties, true);
		MsgCon(color_purple, "Saved bounty data! Entries: " .. table.Count(BASH.Bounties));
	end


	if BASH.Adverts and BASH.Adverts != {} then
		local adverts = util.TableToJSON(BASH.Adverts, true);
		BASH:WriteToFile("vars/adverts.txt", adverts, true);
		MsgCon(color_purple, "Saved advert data! Entries: " .. table.Count(BASH.Adverts));
	end

	if BASH.Groups and BASH.Groups != {} then
		local groups = util.TableToJSON(BASH.Groups, true);
		BASH:WriteToFile("vars/groups.txt", groups, true);
		MsgCon(color_purple, "Saved group data! Entries: " .. table.Count(BASH.Groups));
	end
end);

hook.Add("OnUnsafeRemove", "UnsafeSIMRemove", function(ent)
	if !ent or !ent:IsValid() then return end;
	if !ent.ItemData.IsPDA and !ent.ItemData.IsSIMCard then return end;

	if ent.ItemData.IsPDA then
		if ent.SIMCardSlot != "" then
			BASH:RemoveSIMCardData(ent.SIMCardSlot);
		end

		BASH:RemovePDAData(ent.MemorySlot);
	elseif ent.ItemData.IsSIMCard then
		BASH:RemoveSIMCardData(ent.ICCID);
	end
end);

local function PeriodicSave()
	if BASH.PDAData and BASH.PDAData != {} then
		local pdas = util.TableToJSON(BASH.PDAData, true);
		BASH:WriteToFile("vars/pdas.txt", pdas, true);
		MsgCon(color_purple, "Saved PDA data! Entries: " .. table.Count(BASH.PDAData));
	end

	if BASH.SIMData and BASH.SIMData != {} then
		local sims = util.TableToJSON(BASH.SIMData, true);
		BASH:WriteToFile("vars/sims.txt", sims, true);
		MsgCon(color_purple, "Saved SIM data! Entries: " .. table.Count(BASH.SIMData));
	end

	if BASH.Bounties and BASH.Bounties != {} then
		local bounties = util.TableToJSON(BASH.Bounties, true);
		BASH:WriteToFile("vars/bounties.txt", bounties, true);
		MsgCon(color_purple, "Saved bounty data! Entries: " .. table.Count(BASH.Bounties));
	end


	if BASH.Adverts and BASH.Adverts != {} then
		local adverts = util.TableToJSON(BASH.Adverts, true);
		BASH:WriteToFile("vars/adverts.txt", adverts, true);
		MsgCon(color_purple, "Saved advert data! Entries: " .. table.Count(BASH.Adverts));
	end

	if BASH.Groups and BASH.Groups != {} then
		local groups = util.TableToJSON(BASH.Groups, true);
		BASH:WriteToFile("vars/groups.txt", groups, true);
		MsgCon(color_purple, "Saved group data! Entries: " .. table.Count(BASH.Groups));
	end
end
hook.Add("PeriodicSave", "PDAPeriodicSave", PeriodicSave);

function BASH:LoadSIMs()
	local sims = "";

	if file.Exists("vars/sims.txt", "DATA") then
		sims = file.Read("vars/sims.txt", "DATA");
	else
		self:CreateFile("vars/sims.txt");
	end

	self.SIMData = util.JSONToTable(sims) or {};
	//  JSON converts strings composed only of numbers into a number. :^(
	for index, data in pairs(self.SIMData) do
		if isnumber(index) then
			self.SIMData[index] = nil;
			self.SIMData[tostring(index)] = data;
		else
			self.SIMData[index] = data;
		end
	end
	MsgCon(color_purple, "Loaded SIM data! Entries: " .. table.Count(self.SIMData));
end

function BASH:LoadPDAs()
	local pdas = "";

	if file.Exists("vars/pdas.txt", "DATA") then
		pdas = file.Read("vars/pdas.txt", "DATA");
	else
		self:CreateFile("vars/pdas.txt");
	end

	self.PDAData = util.JSONToTable(pdas) or {};
	//  JSON converts strings composed only of numbers into a number. :^(
	for index, data in pairs(self.PDAData) do
		if isnumber(index) then
			self.PDAData[index] = nil;
			self.PDAData[tostring(index)] = data;
		else
			self.PDAData[index] = data;
		end
	end
	MsgCon(color_purple, "Loaded PDA data! Entries: " .. table.Count(self.PDAData));
end

function BASH:NewPDAData(id)
	if !self.PDAData or !id then return end;

	id = tostring(id);
	self.PDAData[id] = {};
	self.PDAData[id].GhostMode = false;
	self.PDAData[id].Notes = {};
	self.PDAData[id].MapData = {};

	MsgCon(color_purple, "New PDA registered: " .. id);
end

function BASH:NewSIMCardData(id)
	if !self.SIMData or !id then return end;

	id = tostring(id);
	self.SIMData[id] = {};
	self.SIMData[id].Handle = RandomHandle();
	self.SIMData[id].Status = "Online";
	self.SIMData[id].Title = "";
	self.SIMData[id].Contacts = {};
	self.SIMData[id].Blocked = {};

	MsgCon(color_purple, "New SIM card registered: " .. id);
end

function BASH:RemovePDAData(id)
	if !self.PDAData or !id then return end;

	self.PDAData[id] = nil;

	MsgCon(color_purple, "PDA destroyed: " .. id);
end

function BASH:RemoveSIMCardData(id)
	if !self.SIMData or !id then return end;

	self.SIMData[id] = nil;

	MsgCon(color_purple, "SIM card destroyed: " .. id);
end

function BASH:SpawnTowers()
	local map = game.GetMap();
	if !BASH[map] then return end;

	local mapData = BASH[map];
	if !mapData.Towers then return end;

	for index, pos in pairs(mapData.Towers) do
		local newTower = ents.Create("bash_network_tower");
		newTower:SetPos(pos);
		newTower:Spawn();
		newTower:Activate();
		MsgCon(color_green, "Created network tower at position " .. tostring(pos) .. ".", true);
	end
end

function BASH:CalculateEconomy()
	self.EconomyBalanced = false;
	self.EconomyStats = {};
	local stats = {};

	local getEconStats = self.DB:query("SELECT * FROM BASH_econ;");
	if !getEconStats then
		timer.Simple(5, function()
			self:CalculateEconomy();
		end);

		return;
	end
	getEconStats:start();

	function getEconStats:onSuccess(data)
		stats = data[1] or {};
	end

	// Floating Cash
	local getFloatingCash = self.DB:query("SELECT * FROM BASH_characters;");
	getFloatingCash:start();

	local cash = 0;
	function getFloatingCash:onSuccess(data)
		for index, character in pairs(data) do
			if character.Rubles then
				cash = cash + character.Rubles;
			end
		end
	end

	// Assignment
	timer.Simple(5, function()
		stats["FloatingCash"] = cash;
		BASH.EconomyStats = stats;
		BASH:UpdateEconomy(stats);
	end);
end

function BASH:GetEconomy(ply)
	local getEconStats = self.DB:query("SELECT * FROM BASH_econ;");
	getEconStats:start();

	function getEconStats:onSuccess(data)
		stats = data[1];
		netstream.Start(ply, "BASH_Send_Econ_Return", stats);
	end
end

function BASH:UpdateEconomy(value, field)
	if !self.EconomyStats then
		self:CalculateEconomy();
		return;
	end

	local updateEconomy;
	if field then
		updateEconomy = self.DB:query("UPDATE BASH_econ SET " .. field .. " = " .. tostring(value) .. ";");
	else
		value["ValueIn"] = value["ValueIn"] or 0;
		value["ValueOut"] = value["ValueOut"] or 0;
		value["FloatingCash"] = value["FloatingCash"] or 0;
		value["CashMoved"] = value["CashMoved"] or 0;
		value["CashFired"] = value["CashFired"] or 0;
		updateEconomy = self.DB:query("UPDATE BASH_econ SET ValueIn = " .. tostring(value["ValueIn"]) .. ", ValueOut = " .. tostring(value["ValueOut"]) .. ", FloatingCash = " .. tostring(value["FloatingCash"]) .. ", CashMoved = " .. tostring(value["CashMoved"]) .. ", CashFired = " .. tostring(value["CashFired"]) .. ";");
	end

	if !updateEconomy then return end;
	updateEconomy:start();

	function updateEconomy:onSuccess(data)
		if field then
			BASH.EconomyStats[field] = value;
		end
	end
end

function BASH:GetBounties(ply)
	if self.Bounties then
		if ply then
			netstream.Start(ply, "BASH_Send_Bounties_Return", self.Bounties);
		end
		return;
	end

	local bounties = {};
	if file.Exists("vars/bounties.txt", "DATA") then
		bounties = file.Read("vars/bounties.txt", "DATA");
		bounties = util.JSONToTable(bounties) or {};
	else
		self:CreateFile("vars/bounties.txt");
		bounties = {};
	end

	if ply then
		netstream.Start(ply, "BASH_Send_Bounties_Return", bounties);
		return;
	end

	self.Bounties = bounties;
	MsgCon(color_purple, "Loaded bounty data! Entries: " .. table.Count(self.Bounties));
end

function BASH:GetAdverts(ply)
	if self.Adverts then
		if ply then
			netstream.Start(ply, "BASH_Send_Adverts_Return", self.Adverts);
		end
		return;
	end

	local adverts = {};
	if file.Exists("vars/adverts.txt", "DATA") then
		adverts = file.Read("vars/adverts.txt", "DATA");
		adverts = util.JSONToTable(adverts) or {};
	else
		self:CreateFile("vars/adverts.txt");
		adverts = {};
	end

	if ply then
		netstream.Start(ply, "BASH_Send_Adverts_Return", adverts);
		return;
	end

	self.Adverts = adverts;
	MsgCon(color_purple, "Loaded advert data! Entries: " .. table.Count(self.Adverts));
end

function BASH:GetGroups(ply)
	if self.Groups then
		if ply then
			netstream.Start(ply, "BASH_Send_Groups_Return", self.Groups);
		end
		return;
	end

	local groups = {};
	if file.Exists("vars/groups.txt", "DATA") then
		groups = file.Read("vars/groups.txt", "DATA");
		groups = util.JSONToTable(groups) or {};
	else
		self:CreateFile("vars/adverts.txt");
		groups = {};
	end

	if ply then
		netstream.Start(ply, "BASH_Send_Groups_Return", groups);
		return;
	end

	self.Groups = groups;
	MsgCon(color_purple, "Loaded group data! Entries: " .. table.Count(self.Groups));
end

function BASH:PDABroadcast(text)
	for _, ply in pairs(player.GetAll()) do
		if ply:GetEntry("CharLoaded") and ply:HasPDA() and ply:GetEntry("Connection") > 0 then
			ply:PrintChat(text);
		end
	end
end

netstream.Hook("BASH_Request_Online", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	local tab = {};
	for index, sim in pairs(BASH.ConnectedPDAs) do
		tab[sim] = {};
		tab[sim].Handle = BASH.SIMData[sim].Handle;
		tab[sim].Status = BASH.SIMData[sim].Status;
		tab[sim].Title = BASH.SIMData[sim].Title;
	end

	netstream.Start(ply, "BASH_Request_Online_Return", tab);
end);

netstream.Hook("BASH_Request_Device", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local memory = BASH.PDAData[tostring(data[1])];
	local sim = BASH.SIMData[tostring(data[2])];

	netstream.Start(ply, "BASH_Request_Device_Return", {memory, sim});
end);

netstream.Hook("BASH_Add_PDAPool", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	if !BASH.ConnectedPDAs then
		BASH.ConnectedPDAs = {};
	end

	table.insert(BASH.ConnectedPDAs, data);
end);

netstream.Hook("BASH_Update_GhostMode", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local mem = tostring(data[1]);
	local val = data[2];

	if !BASH.PDAData[mem] then return end;
	BASH.PDAData[mem].GhostMode = val;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[mem]);
end);

netstream.Hook("BASH_Update_Handle", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local sim = tostring(data[1]);
	local handle = data[2];

	for _sim, _data in pairs(BASH.SIMData) do
		if _data.Handle == handle then
			ply:PrintChat("A SIM card with that handle already exists!");
			return;
		end
	end

	if !BASH.SIMData[sim] then return end;
	BASH.SIMData[sim].Handle = handle;
	netstream.Start(ply, "BASH_Update_Device_SIM", BASH.SIMData[sim]);
end);

netstream.Hook("BASH_Update_Status", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local sim = tostring(data[1]);
	local status = data[2];

	if !BASH.SIMData[sim] then return end;
	BASH.SIMData[sim].Status = status;
	netstream.Start(ply, "BASH_Update_Device_SIM", BASH.SIMData[sim]);
end);

netstream.Hook("BASH_Update_Title", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local sim = tostring(data[1]);
	local title = data[2];

	if !BASH.SIMData[sim] then return end;
	BASH.SIMData[sim].Title = title;
	netstream.Start(ply, "BASH_Update_Device_SIM", BASH.SIMData[sim]);
end);

netstream.Hook("BASH_Send_Econ", function(ply, data)
	BASH:GetEconomy(ply);
end);

netstream.Hook("BASH_Send_Bounties", function(ply, data)
	BASH:GetBounties(ply);
end);

netstream.Hook("BASH_Send_Adverts", function(ply, data)
	BASH:GetAdverts(ply);
end);

netstream.Hook("BASH_Send_Groups", function(ply, data)
	BASH:GetGroups(ply);
end);

netstream.Hook("BASH_New_Note", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local mem = data[1];
	local title = data[2];

	if !BASH.PDAData[mem] then return end;
	BASH.PDAData[mem].Notes[title] = "";
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[mem]);
	netstream.Start(ply, "BASH_New_Note_Return");
end);

netstream.Hook("BASH_Edit_Note", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local mem = data[1];
	local title = data[2];
	local newTitle = data[3];

	if !BASH.PDAData[mem] then return end;
	local text = BASH.PDAData[mem].Notes[title];
	BASH.PDAData[mem].Notes[title] = nil;
	BASH.PDAData[mem].Notes[newTitle] = text;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[mem]);
	netstream.Start(ply, "BASH_New_Note_Return");
end);

netstream.Hook("BASH_Update_Note", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local mem = data[1];
	local title = data[2];
	local text = data[3];

	if !BASH.PDAData[mem] then return end;
	BASH.PDAData[mem].Notes[title] = text;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[mem]);
	netstream.Start(ply, "BASH_Update_Note_Return", {title, text});
end);

netstream.Hook("BASH_Delete_Note", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local mem = data[1];
	local title = data[2];

	if !BASH.PDAData[mem] then return end;
	BASH.PDAData[mem].Notes[title] = nil;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[mem]);
	netstream.Start(ply, "BASH_New_Note_Return");
end);

netstream.Hook("BASH_Add_StashData", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local pda = data[1];
	local stash = data[2];
	local stashTable = util.JSONToTable(stash);
	if !pda or !stash or !stashTable then return end;
	if !BASH.PDAData[pda] then return end;

	BASH.PDAData[pda].MapData[stashTable.ID] = stash;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[pda]);
	netstream.Start(ply, "BASH_Update_Map");
end);

netstream.Hook("BASH_Remove_StashData", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local pda = data[1];
	local id = data[2];
	if !pda or !id then return end;
	if !BASH.PDAData[pda] then return end;

	local stashString = BASH.PDAData[pda].MapData[id];
	BASH.PDAData[pda].MapData[id] = nil;
	netstream.Start(ply, "BASH_Update_Device_MEM", BASH.PDAData[pda]);
	netstream.Start(ply, "BASH_Remove_StashData_Return", stashString);
end);
