local BASH = BASH;
local Player = FindMetaTable("Player");

hook.Add("OnItemProcess", "PDAItemProcess", function(item)
	if !item.IsPDA and !item.IsSIMCard then return end;

	local tab = {};
	if item.IsPDA then
		tab.IsPDA = true;
		tab.SIMCardDefault = item.SIMCardDefault or true;
	elseif item.IsSIMCard then
		tab.IsSIMCard = true;
	end
	return tab;
end);

function Player:HasPDA()
	local pdas = {
		"pda_stalker",
		"pda_military"
	};

	for _, pda in pairs(pdas) do
		if self:HasItem(pda) then return true end;
	end

	return false;
end

function Player:RemoveSIMCard(data)
	if !CheckPly(self) or !CheckChar(self) then return end;
	if !data then return end;

	local fromInv = data.FromInv;
	local x = data.X;
	local y = data.Y;
	local id = data.ID;
	local entData = data.EntData;

	local itemData = BASH.Items[id];
	if !itemData then return end;

	local removeInv, removeInvString, noUpdate;
	if fromInv == INV_MAIN then
		removeInv = self:GetEntry("InvMain");
		removeInvString = "InvMain";
	elseif fromInv == INV_SEC then
		removeInv = self:GetEntry("InvSec");
		removeInvString = "InvSec";
	elseif fromInv == INV_ACC then
		removeInv = self:GetEntry("InvAcc");
		removeInvString = "InvAcc";
	elseif fromInv == INV_STORE then
		removeInv = self:GetTable().StorageEnt:GetTable().Inventory;
		removeInvString = "InvStore";
		noUpdate = true;
	end
	if !removeInv then return end;

	removeInv = util.JSONToTable(removeInv);
	removeInv.Content[x][y].SIMCardSlot = "";
	if removeInvString and !noUpdate then
		self:UpdateEntry(removeInvString, util.TableToJSON(removeInv));
	elseif removeInvString == "InvStore" then
		self:GetTable().StorageEnt:GetTable().Inventory = removeInv;
	end

	local added = BASH:AddItemToInv(self, removeInvString, "sim_mini", {entData.SIMCardSlot}, true, true);
	if !added then
		added = BASH:AddItemToInv(self, "InvMain", "sim_mini", {entData.SIMCardSlot}, true, true);
		if !added then
			added = BASH:AddItemToInv(self, "InvSec", "sim_mini", {entData.SIMCardSlot}, true, true);
			if !added then
				added = BASH:AddItemToInv(self, "InvAcc", "sim_mini", {entData.SIMCardSlot}, true, true);
				if !added then
					local traceTab = {};
					traceTab.start = self:EyePos();
					traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
					traceTab.filter = self;
					local trace = util.TraceLine(traceTab);
					local itemPos = trace.HitPos;
					itemPos.z = itemPos.z + 2;
					local newItem = ents.Create("bash_item");
					newItem:SetItem("sim_mini", {splitNum});
					newItem:SetRPOwner(self);
					newItem:SetPos(itemPos);
					newItem:SetAngles(Angle(0, 0, 0));
					newItem:Spawn();
				end
			end
		end
	end
end

netstream.Hook("BASH_Remove_SIMCard", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	ply:RemoveSIMCard(data[1]);
end);
