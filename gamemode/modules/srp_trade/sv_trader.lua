local BASH = BASH;

hook.Add("OnInit", "LoadStock", function()
	BASH:LoadStock();
end);

function BASH:LoadStock()
	local stock = {};

	if file.Exists("vars/stock.txt", "DATA") then
		stock = file.Read("vars/stock.txt", "DATA");
		stock = util.JSONToTable(stock) or {};

		for id, item in pairs(self.Items) do
			if !stock[id] then
				stock[id] = item.DefaultStock;
			end
		end
	else
		self:CreateDirectory("vars/");
		self:CreateFile("vars/stock.txt");

		for id, item in pairs(self.Items) do
			if !item.Hidden and item.DefaultStock then
				stock[id] = item.DefaultStock;
			end
		end
	end

	self.TraderStock = stock;
	MsgCon(color_purple, "Loaded trader stock data! Entries: " .. table.Count(self.TraderStock));
end

hook.Add("ShutDown", "SaveStock", function()
	for id, item in pairs(BASH.Items) do
		if !BASH.TraderStock[id] then
			BASH.TraderStock[id] = item.DefaultStock;
		end
	end
	local stock = util.TableToJSON(BASH.TraderStock, true);
	BASH:WriteToFile("vars/stock.txt", stock, true);

	MsgCon(color_purple, "Saved trader stock data! Entries: " .. table.Count(BASH.TraderStock));
end);

local function PeriodicSave()
	local stock = util.TableToJSON(BASH.TraderStock, true);
	BASH:WriteToFile("vars/stock.txt", stock, true);

	MsgCon(color_purple, "Saved trader stock data! Entries: " .. table.Count(BASH.TraderStock));
end
hook.Add("PeriodicSave", "TraderPeriodicSave", PeriodicSave);

netstream.Hook("BASH_Send_Stock", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !ply:IsTrader() then return end;

	netstream.Start(ply, "BASH_Return_Stock", BASH.TraderStock);
end);

netstream.Hook("BASH_Buy_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !ply:IsTrader() and !ply:HasFlag("I") then return end;
	if !data then return end;

	local itemID = data[1];
	local num = data[2];
	if !itemID or !num then return end;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;
	if ply:HasFlag("I") and !itemData.IsConsumable then return end;

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
		itemArgs[3] = util.TableToJSON({});
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

	BASH.TraderStock[itemID] = BASH.TraderStock[itemID] - num;
	local rubles = math.floor(itemData.DefaultPrice * (num / itemData.DefaultStacks));
	ply:TakeMoney(rubles);
	ply:PrintChat(itemData.Name .. " purchased!");
	BASH:UpdateEconomy(BASH.EconomyStats.ValueIn + (itemData.DefaultPrice * num), "ValueIn");
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has bought " .. num .. " " .. itemData.Name .. " from the marketplace for " .. rubles .. " rubles.", true);
	netstream.Start(ply, "BASH_Return_Stock", BASH.TraderStock);
end);

netstream.Hook("BASH_Sell_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !ply:IsTrader() and !ply:HasFlag("I") then return end;
	if !data then return end;

	local itemID = data[1];
	local num = data[2];
	if !itemID or !num then return end;
	local itemData = BASH.Items[itemID];
	if !itemData then return end;
	if ply:HasFlag("I") and !itemData.IsConsumable then return end;

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
		cond = (invObj.Content[x][y].Condition or 100) / 100;
		invObj.Content[x][y] = {};
		invObj = util.TableToJSON(invObj);
		ply:UpdateEntry(inv, invObj);
	end

	local rubles = math.floor(((itemData.DefaultPrice / 2) * cond) * (amountSold / itemData.DefaultStacks));
	BASH.TraderStock[itemID] = BASH.TraderStock[itemID] + amountSold;
	ply:RefreshWeight();
	ply:GiveMoney(rubles);
	ply:PrintChat(amountSold .. " " .. itemData.Name .. " sold for " .. rubles .. " ru!");
	BASH:UpdateEconomy(BASH.EconomyStats.ValueOut + (((itemData.DefaultPrice / 2) * cond) * amountSold), "ValueOut");
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has sold " .. amountSold .. " " .. itemData.Name .. " to the marketplace for " .. rubles .. " rubles.", true);
	netstream.Start(ply, "BASH_Return_Stock", BASH.TraderStock);
end);
