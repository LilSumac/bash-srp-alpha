local BASH = BASH;

/* For suits:
** (id, condition, inventory)
**
** For accessories:
** (id, inventory)
**
** For weapons:
** (id, condition, ammo, attachments)
**
** For attachments:
** (id, color)
**
** For writable items:
** (id, writingID)
**
** For conditional items:
** (id, condition)
**
** For stackable items:
** (id, stack)
*/
function BASH:AddItemToInv(ply, inv, id, args, noWeight, newSpot)
	if !CheckPly(ply) or !CheckChar(ply) then return false end;

	local curInv;
	if inv == "InvStore" then
		curInv = ply:GetTable().StorageEnt:GetTable().Inventory;
	else
		curInv = ply:GetEntry(inv);
	end
	curInv = util.JSONToTable(curInv);

	local itemData = self.Items[id];
	if !itemData then return false end;

	if inv == "InvSec" then
		local suit, _ = ParseDouble(ply:GetEntry("Suit"));
		local suitData = BASH.Items[suit];
		if suitData then
			if itemData.NoInventory then
				return false;
			elseif itemData.ItemSize >= suitData.StorageSize then
				return false;
			end
		end
	elseif inv == "InvAcc" then
		local acc = ply:GetEntry("Acc");
		local accData = BASH.Items[acc];
		if accData then
			if accData.NoInventory then
				return false;
			elseif itemData.ItemSize >= accData.StorageSize then
				return false;
			end
		end
	end
	
	local newItemTab = {};
	if itemData.IsSuit then
		newItemTab.Condition = args[1];
		newItemTab.Inventory = util.JSONToTable(args[2]);		// To prevent strange JSON-string-inside-table error...?
	elseif itemData.IsAccessory then
		newItemTab.Inventory = util.JSONToTable(args[1]);		// To prevent strange JSON-string-inside-table error...?
	elseif itemData.IsWeapon then
		newItemTab.Condition = args[1];
		newItemTab.Ammo = args[2];
		newItemTab.Attachments = util.JSONToTable(args[3] or "");
	elseif itemData.IsAttachment then
		newItemTab.CustomColor = args[1];
	elseif itemData.IsWritable then
		newItemTab.Writing = args[1];
		newItemTab.Author = args[2];
	elseif itemData.IsConditional then
		newItemTab.Condition = args[1];
	elseif itemData.IsStackable then
		newItemTab.Stacks = args[1];
		if newItemTab.Stacks <= 0 then return end;
	elseif !itemData.NoProperties then
		newItemTab = hook.Call("AddItemProperties", self, itemData, args);
	end
	newItemTab.ID = itemData.ID;

	local x, y, newStacks, remainingStacks = self:NextInvSpot(ply, inv, id, newItemTab.Stacks, newSpot);
	if !x or !y then return false end;
	newItemTab.Stacks = newStacks;

	if remainingStacks > 0 then
		args[1] = remainingStacks;
		self:AddItemToInv(ply, inv, id, args);
	end

	curInv.Content[x][y] = newItemTab;

	if !noWeight and inv != "InvStore" then
		local curWeight = ply:GetEntry("Weight");
		local itemWeight = itemData.Weight * (newItemTab.Stacks or 1);
		local invWeight = 0;
		if newItemTab.Inventory and newItemTab.Inventory != "" and newItemTab.Inventory != "[]" then
			local itemInvTab = newItemTab.Inventory;
			for invX = 1, #itemInvTab.Content do
				for invY = 1, #itemInvTab.Content[1] do
					invWeight = invWeight + self:GetMultiInvWeight(itemInvTab.Content[invX][invY]);
				end
			end
		end
		ply:UpdateEntry("Weight", curWeight + itemWeight + invWeight);
	end

	local newInv = util.TableToJSON(curInv);
	if inv == "InvStore" then
		ply:GetTable().StorageEnt:GetTable().Inventory = newInv;
		netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, newInv});
	else
		ply:UpdateEntry(inv, newInv);
	end

	return true;
end

function BASH:NextInvSpot(ply, inv, itemID, amount, needNewSpot)
	local curInv;
	if inv == "InvStore" then
		curInv = ply:GetTable().StorageEnt:GetTable().Inventory;
	else
		curInv = ply:GetEntry(inv);
	end
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;
	if !curInv[1] then return end;
	local itemData = self.Items[itemID];
	if !itemData then return end;

	if itemData.IsStackable and !needNewSpot then
		for invY = 1, #curInv[1] do
			for invX = 1, #curInv do
				local curItem = curInv[invX][invY];

				if curItem.ID and curItem.ID == itemID then
					local curRemainingStack = itemData.MaxStacks - curItem.Stacks;
					if curRemainingStack > 0 then
						if amount <= curRemainingStack then
							return invX, invY, amount + curItem.Stacks, 0;
						else
							local remainingStacks = amount - curRemainingStack;
							return invX, invY, itemData.MaxStacks, remainingStacks;
						end
					end
				end
			end
		end
	end

	for invY = 1, #curInv[1] do
		for invX = 1, #curInv do
			local curItem = curInv[invX][invY];

			if !curItem.ID then
				return invX, invY, amount or 1, 0;
			end
		end
	end
end

netstream.Hook("BASH_Pickup_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	ply:PickupItem(data);
end);

netstream.Hook("BASH_Drop_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local args = data[1];
	args.Stacks = data[2] or args.EntData.Stacks;
	ply:DropItem(args);
end);

netstream.Hook("BASH_Request_Storage", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local ent = data[1];
	ent:SetNWBool("InUse", true);
	ent:GetTable().User = ply;
	ply:GetTable().StorageEnt = ent;
	netstream.Start(ply, "BASH_Request_Storage_Return", {ent, ent:GetTable().Inventory});
end);

netstream.Hook("BASH_Update_Storage", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local ent = data[1];
	local inv = data[2];
	local closed = data[3];
	ent:GetTable().Inventory = inv;

	if closed then
		ent:SetNWBool("InUse", false);
		ent:GetTable().User = nil;
		ply:GetTable().StorageEnt = nil;
	end
end);
