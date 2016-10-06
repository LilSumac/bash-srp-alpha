local BASH = BASH;

hook.Add("OnInit", "LoadStashes", function()
	BASH:LoadStockpiles();
end);

hook.Add("InitPostEntity", "CreateStorage", function()
	local map = game.GetMap();
	if !file.Exists("vars/stockpiles/" .. map .. ".txt", "DATA") then return end;
	local stockpiles = file.Read("vars/stockpiles/" .. map .. ".txt", "DATA");
	stockpiles = util.JSONToTable(stockpiles);
	for index, stock in pairs(stockpiles) do
		if !stock.Pos or !stock.Angles then continue end;
		local newStorage = ents.Create("bash_stockpile");
		newStorage:SetPos(stock.Pos);
		newStorage:SetAngles(stock.Angles);
		newStorage:Spawn();
		newStorage:Activate();
        local physObj = newStorage:GetPhysicsObject();
        physObj:EnableMotion(false);

		MsgCon(color_green, "Created stockpile at position " .. tostring(stock.Pos) .. ".", true);
	end
end);

hook.Add("ShutDown", "SaveStashes", function()
    local stockpiles = ents.FindByClass("bash_stockpile");
	if !stockpiles then return end;
	local save = {};
	local index = 1;
	for _, stock in pairs(stockpiles) do
		save[index] = {};
		save[index].Pos = stock:GetPos();
		save[index].Angles = stock:GetAngles();
		index = index + 1;
	end

	save = util.TableToJSON(save, true);
	BASH:WriteToFile("vars/stockpiles/" .. game.GetMap() .. ".txt", save, true);
    MsgCon(color_purple, "Saved stockpile entities! Entries: " .. tostring(index - 1));

    local save2;
    for ind, faction in pairs(BASH.Factions) do
        if faction.HasStockpile then
            save2 = util.TableToJSON(BASH.Stockpiles[faction.ID], true);
            BASH:WriteToFile("vars/stockpiles/" .. faction.ID .. ".txt", save2, true);
            MsgCon(color_purple, "Saved faction stockpile '" .. faction.ID .. "'!");
        end
    end
end);

function BASH:LoadStockpiles()
	local stock = "";
    self.Stockpiles = {};
    for index, faction in pairs(self.Factions) do
        if faction.HasStockpile then
            if file.Exists("vars/stockpiles/" .. faction.ID .. ".txt", "DATA") then
        		stock = file.Read("vars/stockpiles/" .. faction.ID .. ".txt", "DATA");
        	else
        		self:CreateDirectory("vars/stockpiles");
        		self:CreateFile("vars/stockpiles/" .. faction.ID .. ".txt");
        		stock = "[]";
        	end

            stock = util.JSONToTable(stock) or {};

			for id, item in pairs(self.Items) do
				if !stock[id] then
					stock[id] = 0;
				end
			end

            self.Stockpiles[faction.ID] = stock;
            MsgCon(color_purple, "Loaded stockpile for faction '" .. faction.ID .. "'!");
        end
    end
end


netstream.Hook("BASH_Request_Stockpile", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

    local ent = data[1];
	local faction = data[2];
    if !BASH.Stockpiles[faction] then return end;
	ent:SetNWBool("InUse", true);
	ent:GetTable().User = ply;
	netstream.Start(ply, "BASH_Request_Stockpile_Return", {ent, BASH.Stockpiles[faction]});
end);

netstream.Hook("BASH_Close_Stockpile", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	data:SetNWBool("InUse", false);
	data:GetTable().User = nil;
end);

netstream.Hook("BASH_Withdraw_Stockpile", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !ply:HasFlag("s") then
		LocalPlayer():PrintChat("You're not allowed to withdraw from the stockpile!");
		return;
	end
	if !data then return end;

	local itemID = data[1];
	local num = data[2];
	local ent = data[3];
	if !itemID or !num or !ent then return end;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;

	local itemArgs = {};
	if itemData.IsSuit then
		itemArgs[1] = 100;
		local inv = {};
		inv.Name = itemData.Inventory;
		inv.Content = {};
		local invData = BASH.Inventories[itemData.Inventory];
		if invData then
			for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
		end
		itemArgs[2] = util.TableToJSON(inv);
	elseif itemData.IsAccessory then
		local inv = {};
		inv.Name = itemData.Inventory;
		inv.Content = {};
		local invData = BASH.Inventories[itemData.Inventory];
		if invData then
			for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
		end
		itemArgs[1] = util.TableToJSON(inv);
	elseif itemData.IsWeapon then
		itemArgs[1] = 100;
		itemArgs[2] = 0;
	elseif itemData.IsWritable then
		itemArgs[1] = RandomString(24);
		BASH:NewWritingData(itemArgs[1]);
	elseif itemData.IsConditional then
		itemArgs[1] = 100;
	elseif itemData.IsStackable then
		itemArgs[1] = num;
	elseif !itemData.NoProperties then
		itemArgs = hook.Call("GetItemProperties", BASH, itemData) or {};
	end

	local invs = {"InvMain", "InvSec", "InvAcc"};
	local added;
	for ind, inv in pairs(invs) do
		added = BASH:AddItemToInv(ply, inv, itemID, itemArgs, false, true);
		if added then break end;
		if !added and ind == 3 then
			local traceTab = {};
			traceTab.start = ply:EyePos();
			traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
			traceTab.filter = ply;
			local trace = util.TraceLine(traceTab);
			local itemPos = trace.HitPos;
			itemPos.z = itemPos.z + 2;
			local newItem = ents.Create("bash_item");
			newItem:SetItem(itemID, itemArgs);
			newItem:SetRPOwner(ply);
			newItem:SetPos(itemPos);
			newItem:SetAngles(Angle(0, 0, 0));
			newItem:Spawn();
			newItem:Activate();
		end
	end

	local faction = ply:GetEntry("Faction");
	local factionData = BASH.Factions[faction];
	BASH.Stockpiles[faction][itemID] = BASH.Stockpiles[faction][itemID] - num;
	ply:PrintChat(itemData.Name .. " withdrawn!");
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has withdrawn " .. num .. " " .. itemData.Name .. " from the " .. factionData.Name .. " stockpile.", true);
	netstream.Start(ply, "BASH_Request_Stockpile_Return", {ent, BASH.Stockpiles[faction]});
end);

netstream.Hook("BASH_Deposit_Stockpile", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !ply:HasFlag("s") and !ply:HasFlag("x") then return end;
	if !data then return end;

	local itemID = data[1];
	local num = data[2];
	local ent = data[3];
	if !itemID or !num then return end;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;
	local amountSold = 1;
	local cond = 1;
	if itemData.IsStackable then
		local hasItem, inv, x, y, stacks, invObj, newStacks;
		amountSold = 0;
		while amountSold < num do
			hasItem, inv, x, y, stacks = ply:HasItem(itemID);
			if !hasItem then break end;
			invObj = ply:GetEntry(inv);
			invObj = util.JSONToTable(invObj);
			newStacks = stacks - (num - amountSold);
			if newStacks <= 0 then
				amountSold = amountSold + stacks;
				invObj.Content[x][y] = {};
			else
				amountSold = amountSold + (num - amountSold);
				invObj.Content[x][y].Stacks = newStacks;
			end
			invObj = util.TableToJSON(invObj);
			ply:UpdateEntry(inv, invObj);
		end
	else
		local hasItem, inv, x, y, stacks = ply:HasItem(itemID);
		if !hasItem then return end;
		local invObj = ply:GetEntry(inv);
		invObj = util.JSONToTable(invObj);
		if itemData.IsConditional and invObj.Content[x][y].Condition != 100 then
			ply:PrintChat("You can't store conditional items that are not in perfect condition!");
			return;
		end
		invObj.Content[x][y] = {};
		invObj = util.TableToJSON(invObj);
		ply:UpdateEntry(inv, invObj);
	end

	local faction = ply:GetEntry("Faction");
	local factionData = BASH.Factions[faction];
	if !factionData then return end;
	BASH.Stockpiles[faction][itemID] = BASH.Stockpiles[faction][itemID] + amountSold;
	ply:RefreshWeight();
	ply:PrintChat(amountSold .. " " .. itemData.Name .. " deposited!");
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has deposited " .. amountSold .. " " .. itemData.Name .. " to the " .. factionData.Name .. " stockpile.", true);
	netstream.Start(ply, "BASH_Request_Stockpile_Return", {ent, BASH.Stockpiles[faction]});
end);
