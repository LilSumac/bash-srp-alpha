local BASH = BASH;
local Player = FindMetaTable("Player");

/*
**  Utility Functions
*/

function Player:Initialize()
	if !CheckPly(self) then return end;

	self:SetTeam(TEAM_SPECTATOR);
	self:StripAmmo();
	self:StripWeapons();
	self:Spectate(OBS_MODE_ROAMING);
	self:SetMoveType(MOVETYPE_NOCLIP);
	self:Freeze(true);

	local map = game.GetMap();
	if BASH[map] and BASH[map].CamPos and BASH[map].CamAng then
		self:SetPos(BASH[map].CamPos);
		self:SetEyeAngles(BASH[map].CamAng);
	end

	self.Initialized = true;
end

function Player:LoadCharacter(charID)
	if !CheckPly(self) then return end;
	if CLIENT then return end;

	if self:Alive() then
		self:StripWeapons();
		self:StripAmmo();
	end

	local data;
	for ind, char in pairs(self.CharData) do
		if char.CharID == charID then
			data = char;
		end
	end
	if !data then return end;

	self:UpdateEntry("CharLoaded", true);
	for var, val in pairs(data) do
		local varData = BASH.Registry.Variables[var];
		if varData then
			if isstring(varData.Default) then
				self:UpdateEntry(var, val);
			elseif isnumber(varData.Default) then
				self:UpdateEntry(var, tonumber(val));
			end
		end
	end

	local suit, suitCond = ParseDouble(data.Suit);
	if suit != "" and suitCond then
		local suitData = BASH.Items[suit];
		self:SetModel(suitData.PlayerModel);
	else
		self:SetModel(data.Model);
	end

	self:RefreshWeight();
	self:Spawn();

	netstream.Start(ply, "BASH_Convo", {});

	hook.Call("OnLoadCharacter", BASH, self);

	MsgCon(color_purple, self:Name() .. " [" .. self:SteamID() .. " / " .. self:GetEntry("BASHID") .. "] has spawned with the character " .. data.Name .. " [" .. data.CharID .. "].", true);
end

function Player:TakeMoney(amount)
	local cash = self:GetEntry("Rubles");
	local newCash = math.Clamp(cash - amount, 0, 999999999);
	self:UpdateEntry("Rubles", newCash);
end

function Player:GiveMoney(amount)
	local cash = self:GetEntry("Rubles");
	local newCash = math.Clamp(cash + amount, 0, 999999999);
	self:UpdateEntry("Rubles", newCash);
end

function Player:NoClip(clip)
	self:UpdateEntry("Observing", clip);
	self:SetNoDraw(clip);
	self:SetNotSolid(clip);

	if self:GetActiveWeapon() and self:GetActiveWeapon():IsValid() then
		self:GetActiveWeapon():SetNoDraw(clip);
	end

	if clip then
		self:SetMoveType(MOVETYPE_NOCLIP);
		self:GodEnable();
	else
		self:SetMoveType(MOVETYPE_WALK);
		self:GodDisable();
	end
end

function Player:ReformatWeapons()
	local slots = {};
	local buffer = {};
	local newWeps = {};
	local index = 1;
	local buffIndex = 1;
	for slot, _ in pairs(EQUIP_PARTS) do slots[index] = slot index = index + 1 end;

	local suit = self:GetEntry("Suit");
	suit, _ = ParseDouble(suit);
	if suit != "" then
		local suitData = BASH.Items[suit];
		for _, slot in pairs(suitData.EquipSlots) do
			slots[index] = slot;
			index = index + 1;
		end
	end

	local accessory = self:GetEntry("Acc");
	local acc, cond = ParseDouble(accessory);
	if acc != "" then
		local accData = BASH.Items[acc];
		for _, slot in pairs(accData.EquipSlots) do
			slots[index] = slot;
			index = index + 1;
		end
	end
	table.sort(slots, function(a, b) return EQUIP_PARTS[a] < EQUIP_PARTS[b] end);

	local weps = self:GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	for ind, slot in pairs(slots) do
		local curWep = weps[ind];

		if !curWep or !curWep.ID then
			newWeps[ind] = {};
		else
			local wepData = BASH.Items[curWep.ID];
			if wepData then
				if wepData.SlotType != slot then
					newWeps[ind] = {};
					buffer[buffIndex] = curWep;
					buffIndex = buffIndex + 1;
				else
					newWeps[ind] = curWep;
				end
			else
				newWeps[ind] = {};
			end
		end
	end

	for _, wep in pairs(newWeps) do
		if !wep.ID then
			for ind, buffWep in pairs(buffer) do
				local wepData = BASH.Items[buffWep.ID];
				if wepData then
					if wepData.SlotType == slots[index] then
						newWeps[index] = buffWep;
						buffer[ind] = {};
						break;
					end
				end
			end
		end
	end

	for index, buffWep in pairs(buffer) do
		if buffWep.ID then
			local wepData = BASH.Items[buffWep.ID];
			local wepEnt = self:GetWeapon(wepData.WeaponEntity);
			if wepEnt and wepEnt:IsValid() then
				buffWep.Ammo = wepEnt:Clip1();
				self:StripWeapon(wepData.WeaponEntity);
			end

			local added = BASH:AddItemToInv(self, "InvMain", buffWep.ID, {buffWep.Condition, buffWep.Ammo}, true, true);
			if !added then
				added = BASH:AddItemToInv(self, "InvSec", buffWep.ID, {buffWep.Condition, buffWep.Ammo}, true, true);
				if !added then
					added = BASH:AddItemToInv(self, "InvAcc", buffWep.ID, {buffWep.Condition, buffWep.Ammo}, true, true);
					if !added then
						local traceTab = {};
						traceTab.start = self:EyePos();
						traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
						traceTab.filter = self;
						local trace = util.TraceLine(traceTab);
						local itemPos = trace.HitPos;
						itemPos.z = itemPos.z + 2;
						local newItem = ents.Create("bash_item");
						newItem:SetItem(buffWep.ID, {buffWep.Condition, buffWep.Ammo});
						newItem:SetRPOwner(self);
						newItem:SetPos(itemPos);
						newItem:SetAngles(Angle(0, 0, 0));
						newItem:Spawn();
						newItem:Activate();
					end
				end
			end
		end
	end

	newWeps = util.TableToJSON(newWeps);
	self:UpdateEntry("Weapons", newWeps);
end

/*
**  Inventory Functions
*/

function Player:PickupItem(ent)
	if !CheckPly(self) or !CheckChar(self) then return end;
	if !ent then return end;
	if ent:CheckForTransfer(self) then
		self:PrintChat("Possible item transfer detected: Event logged.");
		MsgCon(color_red, "Possible item transfer detected from " .. self:Name() .. ": " .. self:GetEntry("Name") .. " tried to pick up an object [" .. ent:GetTable().ItemID .. "] dropped by " .. ent:GetTable().OwnerName .. "!", true);
		return;
	else
		local owner = ent:GetTable().OwnerName or "noone";
		local ownerID = ent:GetTable().OwnerSteamID or "no ID";
		MsgCon(color_blue, "[TRANSFER CHECK] " .. self:Name() .. " (" .. self:GetEntry("Name") .. "/" .. self:SteamID() .. ") is picking up an item (" .. ent:GetTable().ItemID .. ") that belonged to " .. owner .. " (" .. ownerID .. ").", true);
	end

	local entData = ent:GetTable();
	local itemData = entData.ItemData;
	local itemID = itemData.ID;
	local args = {};

	local itemCond, itemInv, itemAttach, itemStacks;
	if itemData.IsSuit then
		args[1] = entData.Condition;
		args[2] = entData.Inventory;
	elseif itemData.IsAccessory then
		args[1] = entData.Inventory;
	elseif itemData.IsWeapon then
		args[1] = entData.Condition;
		args[2] = entData.Ammo;
		args[3] = entData.Attachments;
	elseif itemData.IsWritable then
		args[1] = entData.Writing;
	elseif itemData.IsConditional then
		args[1] = entData.Condition;
	elseif itemData.IsStackable then
		args[1] = entData.Stacks;
	elseif !itemData.NoProperties then
		args = hook.Call("GetItemProperties", BASH, itemData, entData) or {};
	end

	local added = BASH:AddItemToInv(self, "InvMain", itemID, args);
	if added then
		hook.Call("OnItemPickup", BASH, self, entData);
		self:RefreshWeight();
		ent.IsSafeRemoved = true;
		ent:Remove();
		return;
	end

	added = BASH:AddItemToInv(self, "InvSec", itemID, args);
	if added then
		hook.Call("OnItemPickup", BASH, self, entData);
		self:RefreshWeight();
		ent.IsSafeRemoved = true;
		ent:Remove();
		return;
	end

	added = BASH:AddItemToInv(self, "InvAcc", itemID, args);
	if added then
		hook.Call("OnItemPickup", BASH, self, entData);
		self:RefreshWeight();
		ent.IsSafeRemoved = true;
		ent:Remove();
		return;
	end

	self:PrintChat("Your inventory is full!");
end

function Player:DropItem(data)
	if !data then return end;

	local fromInv = data.FromInv;
	local x = data.X;
	local y = data.Y;
	local id = data.ID;
	local entData = data.EntData;
	local stacks = data.Stacks;

	local itemData = BASH.Items[id];
	if !itemData then return end;

	local dropInv, dropInvString, noUpdate;
	if fromInv == INV_MAIN then
		dropInv = self:GetEntry("InvMain");
		dropInvString = "InvMain";
	elseif fromInv == INV_SEC then
		dropInv = self:GetEntry("InvSec");
		dropInvString = "InvSec";
	elseif fromInv == INV_ACC then
		dropInv = self:GetEntry("InvAcc");
		dropInvString = "InvAcc";
	elseif fromInv == INV_STORE then
		dropInv = self:GetTable().StorageEnt:GetTable().Inventory;
		dropInvString = "InvStore";
		noUpdate = true;
	end
	if !dropInv then return end;
	dropInv = util.JSONToTable(dropInv);
	if itemData.IsStackable and entData.Stacks - stacks != 0 then
		dropInv.Content[x][y].Stacks = entData.Stacks - stacks;
	else
		dropInv.Content[x][y] = {};
	end
	dropInv = util.TableToJSON(dropInv);
	if dropInvString and !noUpdate then
		self:UpdateEntry(dropInvString, dropInv);
	elseif dropInvString == "InvStore" then
		self:GetTable().StorageEnt:GetTable().Inventory = dropInv;
	end

	local traceTab = {};
	traceTab.start = self:EyePos();
	traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
	traceTab.filter = self;
	local trace = util.TraceLine(traceTab);

	local itemArgs = {};
	if itemData.IsSuit then
		itemArgs[1] = entData.Condition;
		itemArgs[2] = util.TableToJSON(entData.Inventory);		// To prevent strange JSON-string-inside-table error...?
	elseif itemData.IsAccessory then
		itemArgs[1] = util.TableToJSON(entData.Inventory);		// To prevent strange JSON-string-inside-table error...?
	elseif itemData.IsWeapon then
		itemArgs[1] = entData.Condition;
		itemArgs[2] = entData.Ammo;
		itemArgs[3] = util.TableToJSON(entData.Attachments);
	elseif itemData.IsAttachment then
		itemArgs[1] = entData.CustomColor;
	elseif itemData.IsWritable then
		itemArgs[1] = entData.Writing;
	elseif itemData.IsConditional then
		itemArgs[1] = entData.Condition;
	elseif itemData.IsStackable then
		itemArgs[1] = stacks or entData.Stacks;
	elseif !itemData.NoProperties then
		itemArgs = hook.Call("GetItemProperties", BASH, itemData, entData) or {};
	end

	local itemPos = trace.HitPos;
	itemPos.z = itemPos.z + 2;
	local newItem = ents.Create("bash_item");
	newItem:SetItem(id, itemArgs);
	newItem:SetRPOwner(self);
	newItem:SetPos(itemPos);
	newItem:SetAngles(Angle(0, 0, 0));
	newItem:Spawn();
	newItem:Activate();

	hook.Call("OnItemDrop", BASH, self, data);

	if fromInv != INV_STORE then
		self:RefreshWeight();
	else
		netstream.Start(self, "BASH_Request_Storage_Return", {self:GetTable().StorageEnt, dropInv});
	end
end

function Player:ScrapItem(data)
	if !CheckPly(self) or !CheckChar(self) then return end;
	if !data then return end;

	local fromInv = data.FromInv;
	local x = data.X;
	local y = data.Y;
	local id = data.ID;
	local entData = data.EntData;

	local itemData = BASH.Items[id];
	if !itemData then return end;

	local dropInv, dropInvString, noUpdate;
	if fromInv == INV_MAIN then
		dropInv = self:GetEntry("InvMain");
		dropInvString = "InvMain";
	elseif fromInv == INV_SEC then
		dropInv = self:GetEntry("InvSec");
		dropInvString = "InvSec";
	elseif fromInv == INV_ACC then
		dropInv = self:GetEntry("InvAcc");
		dropInvString = "InvAcc";
	elseif fromInv == INV_STORE then
		dropInv = self:GetTable().StorageEnt:GetTable().Inventory;
		dropInvString = "InvStore";
		noUpdate = true;
	end
	if !dropInv then return end;

	local updatedStore;
	dropInv = util.JSONToTable(dropInv);
	dropInv.Content[x][y] = {};
	dropInv = util.TableToJSON(dropInv);
	if dropInvString and !noUpdate then
		self:UpdateEntry(dropInvString, dropInv);
	elseif dropInvString == "InvStore" then
		self:GetTable().StorageEnt:GetTable().Inventory = dropInv;
		updatedStore = false;
	end

	hook.Call("OnScrapItem", BASH, self, dropInvString, itemData, entData);

	local fabrics = math.random(0, itemData.FabricYield) * entData.Stacks;
	local metals = math.random(0, itemData.MetalYield) * entData.Stacks;

	if fabrics > 0 then
		updatedStore = true;
		local added = BASH:AddItemToInv(self, dropInvString, "scrap_fabric", {fabrics});
		if !added then
			added = BASH:AddItemToInv(self, "InvMain", "scrap_fabric", {fabrics});
			if !added then
				added = BASH:AddItemToInv(self, "InvSec", "scrap_fabric", {fabrics});
				if !added then
					added = BASH:AddItemToInv(self, "InvAcc", "scrap_fabric", {fabrics});
					if !added then
						local traceTab = {};
						traceTab.start = self:EyePos();
						traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
						traceTab.filter = self;
						local trace = util.TraceLine(traceTab);
						local itemPos = trace.HitPos;
						itemPos.z = itemPos.z + 2;
						local newItem = ents.Create("bash_item");
						newItem:SetItem("scrap_fabric", {fabrics});
						newItem:SetRPOwner(self);
						newItem:SetPos(itemPos);
						newItem:SetAngles(Angle(0, 0, 0));
						newItem:Spawn();
						newItem:Activate();
					end
				end
			end
		end
	end

	if metals > 0 then
		updatedStore = true;
		local added = BASH:AddItemToInv(self, dropInvString, "scrap_metal", {metals});
		if !added then
			added = BASH:AddItemToInv(self, "InvMain", "scrap_metal", {metals});
			if !added then
				added = BASH:AddItemToInv(self, "InvSec", "scrap_metal", {metals});
				if !added then
					added = BASH:AddItemToInv(self, "InvAcc", "scrap_metal", {metals});
					if !added then
						local traceTab = {};
						traceTab.start = self:EyePos();
						traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
						traceTab.filter = self;
						local trace = util.TraceLine(traceTab);
						local itemPos = trace.HitPos;
						itemPos.z = itemPos.z + 2;
						local newItem = ents.Create("bash_item");
						newItem:SetItem("scrap_metal", {metals});
						newItem:SetRPOwner(self);
						newItem:SetPos(itemPos);
						newItem:SetAngles(Angle(0, 0, 0));
						newItem:Spawn();
						newItem:Activate();
					end
				end
			end
		end
	end

	if fromInv != INV_STORE then
		self:RefreshWeight();
	elseif !updatedStore and fromInv == INV_STORE then
		netstream.Start(self, "BASH_Request_Storage_Return", {self:GetTable().StorageEnt, dropInv});
	end
end

function Player:DivideItem(data)
	if !CheckPly(self) or !CheckChar(self) then return end;
	if !data then return end;

	local fromInv = data.FromInv;
	local x = data.X;
	local y = data.Y;
	local id = data.ID;
	local entData = data.EntData;
	local splitNum = data.SplitNum;

	local itemData = BASH.Items[id];
	if !itemData then return end;

	local splitInv, splitInvString, noUpdate;
	if fromInv == INV_MAIN then
		splitInv = self:GetEntry("InvMain");
		splitInvString = "InvMain";
	elseif fromInv == INV_SEC then
		splitInv = self:GetEntry("InvSec");
		splitInvString = "InvSec";
	elseif fromInv == INV_ACC then
		splitInv = self:GetEntry("InvAcc");
		splitInvString = "InvAcc";
	elseif fromInv == INV_STORE then
		splitInv = self:GetTable().StorageEnt:GetTable().Inventory;
		splitInvString = "InvStore";
		noUpdate = true;
	end
	if !splitInv then return end;

	splitInv = util.JSONToTable(splitInv);
	splitInv.Content[x][y].Stacks = splitInv.Content[x][y].Stacks - splitNum;
	splitInv = util.TableToJSON(splitInv);
	if splitInvString and !noUpdate then
		self:UpdateEntry(splitInvString, splitInv);
	elseif splitInvString == "InvStore" then
		self:GetTable().StorageEnt:GetTable().Inventory = splitInv;
	end

	local added = BASH:AddItemToInv(self, splitInvString, id, {splitNum}, true, true);
	if !added then
		added = BASH:AddItemToInv(self, "InvMain", id, {splitNum}, true, true);
		if !added then
			added = BASH:AddItemToInv(self, "InvSec", id, {splitNum}, true, true);
			if !added then
				added = BASH:AddItemToInv(self, "InvAcc", id, {splitNum}, true, true);
				if !added then
					local traceTab = {};
					traceTab.start = self:EyePos();
					traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
					traceTab.filter = self;
					local trace = util.TraceLine(traceTab);
					local itemPos = trace.HitPos;
					itemPos.z = itemPos.z + 2;
					local newItem = ents.Create("bash_item");
					newItem:SetItem(id, {splitNum});
					newItem:SetRPOwner(self);
					newItem:SetPos(itemPos);
					newItem:SetAngles(Angle(0, 0, 0));
					newItem:Spawn();
					newItem:Activate();
				end
			end
		end
	end

	if fromInv != INV_STORE then
		self:RefreshWeight();
	end
end

function Player:UpdateWriting(data, newString)
	if !CheckPly(self) or !CheckChar(self) then return end;
	if !data then return end;

	local fromInv = data.FromInv;
	local x = data.X;
	local y = data.Y;
	local id = data.ID;
	local entData = data.EntData;
	local splitNum = data.SplitNum;

	local updateInv, updateInvString, noUpdate;
	if fromInv == INV_MAIN then
		updateInv = self:GetEntry("InvMain");
		updateInvString = "InvMain";
	elseif fromInv == INV_SEC then
		updateInv = self:GetEntry("InvSec");
		updateInvString = "InvSec";
	elseif fromInv == INV_ACC then
		updateInv = self:GetEntry("InvAcc");
		updateInvString = "InvAcc";
	elseif fromInv == INV_STORE then
		updateInv = self:GetTable().StorageEnt:GetTable().Inventory;
		updateInvString = "InvStore";
		noUpdate = true;
	end
	if !updateInv then return end;

	updateInv = util.JSONToTable(updateInv);
	updateInv.Content[x][y].Writing = newString;
	updateInv.Content[x][y].Author = self:SteamID();
	updateInv = util.TableToJSON(updateInv);
	if updateInvString and !noUpdate then
		self:UpdateEntry(updateInvString, updateInv);
	elseif updateInvString == "InvStore" then
		self:GetTable().StorageEnt:GetTable().Inventory = updateInv;
	end
end

function Player:WearItem(itemType, data, ent)
	if !data or !data.ID then return end;

	local itemData = BASH.Items[data.ID];
	if !itemData then return end;
	if itemData.SteamIDs and !itemData.SteamIDs[self:SteamID()] then
		self:PrintChat("You are not authorized to wear this!");
		return;
	end

	local newItemString = data.ID .. ((data.Condition and (";" .. data.Condition)) or "");

	if itemType == "Suit" then
		self:UpdateEntry("InvSec", data.Inventory);
		local newSuitModel = itemData.PlayerModel;
		self:SetModel(newSuitModel);
	elseif itemType == "Acc" then
		self:UpdateEntry("InvAcc", data.Inventory);
	end

	self:UpdateEntry(itemType, newItemString);

	if data.X and data.Y and data.FromInv then
		local removeInv, removeInvString, noUpdate;
		if data.FromInv == INV_MAIN then
			removeInv = self:GetEntry("InvMain");
			removeInvString = "InvMain";
		elseif data.FromInv == INV_SEC then
			removeInv = self:GetEntry("InvSec");
			removeInvString = "InvSec";
		elseif data.FromInv == INV_ACC then
			removeInv = self:GetEntry("InvAcc");
			removeInvString = "InvAcc";
		elseif data.FromInv == INV_STORE then
			removeInv = self:GetTable().StorageEnt:GetTable().Inventory;
			removeInvString = "InvStore";
			noUpdate = true;
		end
		if !removeInv then return end;
		removeInv = util.JSONToTable(removeInv);
		removeInv.Content[data.X][data.Y] = {};
		removeInv = util.TableToJSON(removeInv);
		if removeInvString and !noUpdate then
			self:UpdateEntry(removeInvString, removeInv);
		elseif removeInvString == "InvStore" then
			self:GetTable().StorageEnt:GetTable().Inventory = removeInv;
			netstream.Start(self, "BASH_Request_Storage_Return", {self:GetTable().StorageEnt, removeInv});
		end
	end

	hook.Call("OnWearItem", BASH, self);
	self:ReformatWeapons();
	self:RefreshWeight();
	netstream.Start(self, "BASH_Wear_Item_Return", itemType);

	if ent and ent:IsValid() then
		ent:Remove();
	end
end

function Player:RemoveSuit(dropSuit)
	local suit, condition = ParseDouble(self:GetEntry("Suit"));
	local inv = self:GetEntry("InvSec");
	local args = {};
	args[1] = tonumber(condition);
	args[2] = inv;

	if dropSuit then
		local invSec = {};
		invSec.Name = "";
		invSec.Content = {};
		invSec = util.TableToJSON(invSec);
		self:UpdateEntry("Suit", "");
		self:UpdateEntry("InvSec", invSec);
		self:SetModel(self:GetEntry("Model"));

		local traceTab = {};
		traceTab.start = self:EyePos();
		traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
		traceTab.filter = self;
		local trace = util.TraceLine(traceTab);
		local itemPos = trace.HitPos;
		itemPos.z = itemPos.z + 2;
		local newItem = ents.Create("bash_item");
		newItem:SetItem(suit, args);
		newItem:SetRPOwner(self);
		newItem:SetPos(itemPos);
		newItem:SetAngles(Angle(0, 0, 0));
		newItem:Spawn();
		newItem:Activate();

		hook.Call("OnRemoveSuit", BASH, self);
		self:ReformatWeapons();
		self:RefreshWeight();
		netstream.Start(self, "BASH_Remove_Item_Return", "Suit");
		return;
	end

	local added = BASH:AddItemToInv(self, "InvMain", suit, args, true);

	if added then
		local invSec = {};
		invSec.Name = "";
		invSec.Content = {};
		invSec = util.TableToJSON(invSec);
		self:UpdateEntry("Suit", "");
		self:UpdateEntry("InvSec", invSec);
		self:SetModel(self:GetEntry("Model"));

		hook.Call("OnRemoveSuit", BASH, self);
		self:ReformatWeapons();
		netstream.Start(self, "BASH_Remove_Item_Return", "Suit");
		return;
	end

	added = BASH:AddItemToInv(self, "InvAcc", suit, args, true);

	if added then
		local invSec = {};
		invSec.Name = "";
		invSec.Content = {};
		invSec = util.TableToJSON(invSec);
		self:UpdateEntry("Suit", "");
		self:UpdateEntry("InvSec", invSec);
		self:SetModel(self:GetEntry("Model"));

		hook.Call("OnRemoveSuit", BASH, self);
		self:ReformatWeapons();
		netstream.Start(self, "BASH_Remove_Item_Return", "Suit");
		return;
	end

	self:PrintChat("You have no room to remove your suit!");
end

function Player:RemoveAcc(dropAcc)
	local acc = self:GetEntry("Acc");
	local inv = self:GetEntry("InvAcc");
	local args = {};
	args[1] = inv;

	if dropAcc then
		local invAcc = {};
		invAcc.Name = "";
		invAcc.Content = {};
		invAcc = util.TableToJSON(invAcc);
		self:UpdateEntry("Acc", "");
		self:UpdateEntry("InvAcc", invAcc);

		local traceTab = {};
		traceTab.start = self:EyePos();
		traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
		traceTab.filter = self;
		local trace = util.TraceLine(traceTab);
		local itemPos = trace.HitPos;
		itemPos.z = itemPos.z + 2;

		local newItem = ents.Create("bash_item");
		newItem:SetItem(acc, args);
		newItem:SetRPOwner(self);
		newItem:SetPos(itemPos);
		newItem:SetAngles(Angle(0, 0, 0));
		newItem:Spawn();
		newItem:Activate();

		hook.Call("OnRemoveAcc", BASH, self);
		self:ReformatWeapons();
		self:RefreshWeight();
		netstream.Start(self, "BASH_Remove_Item_Return", "Acc");
		return;
	end

	local added = BASH:AddItemToInv(self, "InvMain", acc, args, true);

	if added then
		local invAcc = {};
		invAcc.Name = "";
		invAcc.Content = {};
		invAcc = util.TableToJSON(invAcc);
		self:UpdateEntry("Acc", "");
		self:UpdateEntry("InvAcc", invAcc);

		hook.Call("OnRemoveAcc", BASH, self);
		self:ReformatWeapons();
		netstream.Start(self, "BASH_Remove_Item_Return", "Acc");
		return;
	end

	added = BASH:AddItemToInv(self, "InvSec", acc, args, true);

	if added then
		local invAcc = {};
		invAcc.Name = "";
		invAcc.Content = {};
		invAcc = util.TableToJSON(invAcc);
		self:UpdateEntry("Acc", "");
		self:UpdateEntry("InvAcc", invAcc);

		hook.Call("OnRemoveAcc", BASH, self);
		self:ReformatWeapons();
		netstream.Start(self, "BASH_Remove_Item_Return", "Acc");
		return;
	end

	self:PrintChat("You have no room to remove your accessory!");
end

netstream.Hook("BASH_Load_Character", function(ply, data)
	ply:LoadCharacter(data);
end);

netstream.Hook("BASH_Wear_Suit", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	if IsEntity(data) then
		if data:CheckForTransfer(ply) then
			ply:PrintChat("Possible item transfer detected: Event logged.");
			MsgCon(color_red, "Possible item transfer detected from " .. ply:Name() .. ": " .. ply:GetEntry("Name") .. " tried to pick up an object [" .. data:GetTable().ItemID .. "] dropped by " .. data:GetTable().OwnerName .. "!", true);
			return;
		end

		local entData = data:GetTable();
		local suitData = {};
		suitData.Inventory = entData.Inventory;
		suitData.Condition = entData.Condition;
		suitData.ID = entData.ItemID;

		ply:WearItem("Suit", suitData, data);
	elseif istable(data) then
		local args = data[1];
		if istable(args.Inventory) then
			args.Inventory = util.TableToJSON(args.Inventory);
		end
		args.FromInv = data[2];
		args.X = data[3];
		args.Y = data[4];

		ply:WearItem("Suit", args);
	end
end);

netstream.Hook("BASH_Wear_Acc", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	if IsEntity(data) then
		if data:CheckForTransfer(ply) then
			ply:PrintChat("Possible item transfer detected: Event logged.");
			MsgCon(color_red, "Possible item transfer detected from " .. ply:Name() .. ": " .. ply:GetEntry("Name") .. " tried to pick up an object [" .. data:GetTable().ItemID .. "] dropped by " .. data:GetTable().OwnerName .. "!", true);
			return;
		end

		local entData = data:GetTable();
		local accData = {};
		accData.Inventory = entData.Inventory;
		accData.Condition = entData.Condition;
		accData.ID = entData.ItemID;

		ply:WearItem("Acc", accData, data);
	elseif istable(data) then
		local args = data[1];
		if istable(args.Inventory) then
			args.Inventory = util.TableToJSON(args.Inventory);
		end
		args.FromInv = data[2];
		args.X = data[3];
		args.Y = data[4];

		ply:WearItem("Acc", args);
	end
end);

netstream.Hook("BASH_Remove_Suit", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if ply:GetEntry("Suit") == "" then return end;

	ply:RemoveSuit(data);
end);

netstream.Hook("BASH_Remove_Acc", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if ply:GetEntry("Acc") == "" then return end;

	ply:RemoveAcc(data);
end);

netstream.Hook("BASH_Scrap_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	ply:ScrapItem(data);
end);

netstream.Hook("BASH_Divide_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local args = data[1];
	args.SplitNum = data[2];
	ply:DivideItem(args);
end);

netstream.Hook("BASH_Request_Writing", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local writingID = data.Writing;
	netstream.Start(ply, "BASH_Return_Writing", {data, BASH.WritingData[writingID]});
end);

netstream.Hook("BASH_Update_Writing", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local writingID = data[1];
	local writingString = data[2];
	BASH.WritingData[writingID] = string.gsub(writingString, '\n', '');
end);

netstream.Hook("BASH_Equip_Weapon", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local wep = data[1];
	local ammo = data[2];

	//ply:ConCommand("give " .. wep);
	ply:Give(wep);
	local wepEnt = ply:GetWeapon(wep);
	wepEnt:SetClip1(ammo);

	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "] has equipped a '" .. wep .. "'.", true);
end);

netstream.Hook("BASH_Remove_Weapon", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local wep = data[1];
	ply:StripWeapon(wep);
end);

netstream.Hook("BASH_Select_Weapon", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local wep = data;
	if !ply:GetWeapon(wep):IsValid() then return end;
	ply:SelectWeapon(wep);
	//ply:ConCommand("use " .. wep);

	if ply:GetWeapon(wep):GetTable().IsBASHWeapon and !ply:GetWeapon(wep):GetTable().IsMelee then
		ply:GetWeapon(wep):BASHInit();
	end
end);

netstream.Hook("BASH_Claim_Money", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	if IsEntity(data) then
		if data:CheckForTransfer(ply) then
			ply:PrintChat("Possible item transfer detected: Event logged.");
			MsgCon(color_red, "Possible item transfer detected from " .. ply:Name() .. ": " .. ply:GetEntry("Name") .. " tried to pick up an object [" .. data:GetTable().ItemID .. "] dropped by " .. data:GetTable().OwnerName .. "!", true);
			return;
		end

		local money = data:GetTable().Stacks;
		ply:GiveMoney(money);
		data:Remove();
		BASH:UpdateEconomy(BASH.EconomyStats["CashMoved"] + money, "CashMoved");
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has picked up " .. money .. " rubles.", true);
	elseif isnumber(data) then
		ply:GiveMoney(data);
		BASH:UpdateEconomy(BASH.EconomyStats["CashMoved"] + data, "CashMoved");
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has claimed " .. data .. " rubles from their inventory.", true);
	end
end);

netstream.Hook("BASH_Claim_Money_Storage", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;
	if !ply:GetTable().StorageEnt then return end;

	local invX = data[1];
	local invY = data[2];
	if !invX or !invY then return end;
	local inv = ply:GetTable().StorageEnt:GetTable().Inventory;
	if !inv then return end;
	inv = util.JSONToTable(inv);
	local money = inv.Content[invX][invY].Stacks;
	inv.Content[invX][invY] = {};
	inv = util.TableToJSON(inv);
	ply:GetTable().StorageEnt:GetTable().Inventory = inv;
	ply:GiveMoney(money);
	BASH:UpdateEconomy(BASH.EconomyStats["CashMoved"] + money, "CashMoved");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has claimed " .. money .. " rubles from storage.", true);
end);

netstream.Hook("BASH_Consume_Item", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local var = data[1];
	local effect = data[2];
	local item = data[3];
	local inv = data[4];
	local itemX = data[5];
	local itemY = data[6];
	if !var or !effect then return end;

	if istable(var) and istable(effect) then
		for index, curVar in pairs(var) do
			if curVar == "Health" then
				local health = ply:Health();
				ply:SetHealth(math.Clamp(health + effect[index], 0, 100));
				if ply:Health() < 0 then
					ply:Kill();
				end
			elseif curVar == "IsHungry" or curVar == "IsThirsty" then
				local variable = ply:GetEntry(curVar);
				ply:UpdateEntry(curVar, math.Clamp(variable + effect[index], 0, 1));
				if var == "IsHungry" then
					ply:UpdateEntry("LastAte", os.time());
				elseif var == "IsThirsty" then
					ply:UpdateEntry("LastDrank", os.time());
				end
			else
				if BASH.Registry.Variables[curVar] then
					local preVar = ply:GetEntry(curVar);
					ply:UpdateEntry(curVar, math.Clamp(preVar + effect[index], 0, 100));
				end
			end
		end
	end

	if var == "Health" then
		local health = ply:Health();
		ply:SetHealth(math.Clamp(health + effect, 0, 100));
		if ply:Health() < 0 then
			ply:Kill();
		end
	elseif var == "IsHungry" or var == "IsThirsty" then
		local variable = ply:GetEntry(var);
		ply:UpdateEntry(var, math.Clamp(variable + effect, 0, 1));
		if var == "IsHungry" then
			ply:UpdateEntry("LastAte", os.time());
		elseif var == "IsThirsty" then
			ply:UpdateEntry("LastDrank", os.time());
		end
	else
		if BASH.Registry.Variables[var] then
			local preVar = ply:GetEntry(var);
			ply:UpdateEntry(var, math.Clamp(preVar + effect, 0, 100));
		end
	end

	if isentity(item) then
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "] has consumed a(n) " .. item:GetTable().ItemData.Name .. ".");
		ply:PrintChat(item:GetTable().ItemData.ConsumeMessage);

		if item:GetTable().ItemData.IsStackable then
			local stacks = item:GetTable().Stacks;
			if stacks > 1 then
				item:GetTable().Stacks = stacks - 1;
			else
				item:Remove();
			end
		else
			item:Remove();
		end
	elseif isstring(item) and inv and itemX and itemY then
		local itemData = BASH.Items[item];
		if !itemData then return end;
		local removeInv, removeInvString, noUpdate;
		if inv == INV_MAIN then
			removeInv = ply:GetEntry("InvMain");
			removeInvString = "InvMain";
		elseif inv == INV_SEC then
			removeInv = ply:GetEntry("InvSec");
			removeInvString = "InvSec";
		elseif inv == INV_ACC then
			removeInv = ply:GetEntry("InvAcc");
			removeInvString = "InvAcc";
		elseif inv == INV_STORE then
			removeInv = ply:GetTable().StorageEnt:GetTable().Inventory;
			removeInvString = "InvStore";
			noUpdate = true;
		end
		if !removeInv then return end;
		removeInv = util.JSONToTable(removeInv);
		if itemData.IsStackable then
			local stacks = removeInv.Content[itemX][itemY].Stacks;
			if stacks > 1 then
				removeInv.Content[itemX][itemY].Stacks = stacks - 1;
			else
				removeInv.Content[itemX][itemY] = {};
			end
		else
			removeInv.Content[itemX][itemY] = {};
		end
		removeInv = util.TableToJSON(removeInv);
		if removeInvString and !noUpdate then
			ply:UpdateEntry(removeInvString, removeInv);
		elseif removeInvString == "InvStore" then
			ply:GetTable().StorageEnt:GetTable().Inventory = removeInv;
			netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, removeInv});
		end
		ply:PrintChat(itemData.ConsumeMessage);
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "] has consumed a(n) " .. itemData.Name .. ".");
	end
end);

netstream.Hook("BASH_Unload_Weapon", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local inv = data[1];
    local invString = data[1];
    local x = data[2];
    local y = data[3];
    local noUpdate = false;
    if inv != "Storage" then
        inv = ply:GetEntry(inv);
    else
        inv = ply:GetTable().StorageEnt:GetTable().Inventory;
        noUpdate = true;
    end
    inv = util.JSONToTable(inv);
    local item = inv.Content[x][y];
    if !item or !item.ID then return end;
    local itemData = BASH.Items[item.ID];
    if !itemData.IsWeapon then return end;

	local ammo = inv.Content[x][y].Ammo;

	inv.Content[x][y].Ammo = 0;
    inv = util.TableToJSON(inv);
    if invString != "Storage" and !noUpdate then
        ply:UpdateEntry(invString, inv);
    else
        ply:GetTable().StorageEnt:GetTable().Inventory = inv;
        netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, inv});
    end

	local invs = {"InvMain", "InvSec", "InvAcc"};
	local added;
	for ind, inv in pairs(invs) do
		added = BASH:AddItemToInv(ply, inv, "ammo_" .. itemData.AmmoType, {ammo}, false, false);
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
			newItem:SetItem("ammo_" .. itemData.AmmoType, {ammo});
			newItem:SetRPOwner(ply);
			newItem:SetPos(itemPos);
			newItem:SetAngles(Angle(0, 0, 0));
			newItem:Spawn();
			newItem:Activate();
		end
	end

	ply:RefreshWeight();
end);

netstream.Hook("BASH_Remove_Attachment", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local inv = data[1];
    local invString = data[1];
    local x = data[2];
    local y = data[3];
	local slot = data[4];
	local att = data[5];
	local col = data[6];
    local noUpdate = false;
    if inv != "Storage" then
        inv = ply:GetEntry(inv);
    else
        inv = ply:GetTable().StorageEnt:GetTable().Inventory;
        noUpdate = true;
    end
    inv = util.JSONToTable(inv);
    local item = inv.Content[x][y];
    if !item or !item.ID then return end;
    local itemData = BASH.Items[item.ID];
    if !itemData.IsWeapon then return end;

	inv.Content[x][y].Attachments[slot] = nil;
    inv = util.TableToJSON(inv);
    if invString != "Storage" and !noUpdate then
        ply:UpdateEntry(invString, inv);
    else
        ply:GetTable().StorageEnt:GetTable().Inventory = inv;
        netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, inv});
    end

	local itemData;
	for id, item in pairs(BASH.Items) do
		if item.IsAttachment and item.AttachmentEnt == att then
			itemData = item;
		end
	end
	if !itemData then return end;
	if itemData.Hidden then return end;

	local invs = {"InvMain", "InvSec", "InvAcc"};
	local added;
	for ind, inv in pairs(invs) do
		added = BASH:AddItemToInv(ply, inv, itemData.ID, {(col or itemData.DefaultColor)}, false, false);
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
			newItem:SetItem(itemData.ID, {(col or itemData.DefaultColor)});
			newItem:SetRPOwner(ply);
			newItem:SetPos(itemPos);
			newItem:SetAngles(Angle(0, 0, 0));
			newItem:Spawn();
			newItem:Activate();
		end
	end

	ply:RefreshWeight();
end);
