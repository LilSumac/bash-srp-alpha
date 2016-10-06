local BASH = BASH;
local Player = FindMetaTable("Player");

hook.Add("OnItemProcess", "ArtifactItemProcess", function(item)
	local tab = {};
	if item.IsSuit then
		tab.ArtifactSlots = item.ArtifactSlots or 2;
	elseif item.IsAccessory then
		tab.ArtifactSlots = item.ArtifactSlots or 0;
	elseif item.IsArtifact then
		tab.IsArtifact = true;
		tab.ArmorBoost = item.ArmorBoost or 0;
		tab.BurnResist = item.BurnResist or 0;
		tab.AcidResist = item.AcidResist or 0;
		tab.ElectroResist = item.ElectroResist or 0;
		tab.ColdResist = item.ColdResist or 0;
		tab.EnergyBoost = item.EnergyBoost or 0;
		tab.RadsPerMin = item.RadsPerMin or 0;
		tab.LootHidden = true;
	end
	return tab;
end);

hook.Add("OnWearItem", "ArtifactReformatOnWear", function(ply)
	ply:ReformatArtifacts();
end);

hook.Add("OnRemoveSuit", "ArtifactReformatOnRemoveSuit", function(ply)
	ply:ReformatArtifacts();
end);

hook.Add("OnRemoveAcc", "ArtifactReformatOnRemoveAcc", function(ply)
	ply:ReformatArtifacts();
end);

function Player:ReformatArtifacts()
	local newArts = {};
	newArts[1] = {};
	local suit, _ = ParseDouble(self:GetEntry("Suit"));
	if suit != "" then
		local suitData = BASH.Items[suit];
		for ind = 1, suitData.ArtifactSlots do
			newArts[ind] = {};
		end
	end

	local index = table.Count(newArts) + 1;
	local acc, _ = ParseDouble(self:GetEntry("Acc"));
	if acc != "" then
		local accData = BASH.Items[acc];
		for ind = 1, accData.ArtifactSlots do
			newArts[index] = {};
			index = index + 1;
		end
	end

	local arts = self:GetEntry("Artifacts");
	arts = util.JSONToTable(arts);
	local buffer = arts;
	for index, slot in pairs(newArts) do
		local curArt = arts[index];
		if !curArt then break end;

		if curArt.ID then
			newArts[index] = curArt;
			buffer[index] = nil;
		end
	end

	for index, slot in pairs(newArts) do
		if !slot.ID then
			for ind, buffArt in pairs(buffer) do
				newArts[index] = buffArt;
				buffer[ind] = nil;
				break;
			end
		end
	end

	for index, buffArt in pairs(buffer) do
		if buffArt.ID then
			local added = BASH:AddItemToInv(self, "InvMain", buffArt.ID, {buffArt.Purity, buffArt.NameOverride}, true, true);
			if !added then
				added = BASH:AddItemToInv(self, "InvSec", buffArt.ID, {buffArt.Purity, buffArt.NameOverride}, true, true);
				if !added then
					added = BASH:AddItemToInv(self, "InvAcc", buffArt.ID, {buffArt.Purity, buffArt.NameOverride}, true, true);
					if !added then
						local traceTab = {};
						traceTab.start = self:EyePos();
						traceTab.endpos = traceTab.start + self:GetAimVector() * 90;
						traceTab.filter = self;
						local trace = util.TraceLine(traceTab);
						local itemPos = trace.HitPos;
						itemPos.z = itemPos.z + 2;
						local newItem = ents.Create("bash_item");
						newItem:SetItem(buffArt.ID, {buffArt.Purity, buffArt.NameOverride});
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

	newArts = util.TableToJSON(newArts);
	self:UpdateEntry("Artifacts", newArts);
end

function Player:HasDetector()
	return self:HasItem("art_compass") or self:HasItem("detector_veles") or self:HasItem("detector_bear") or self:HasItem("detector_echo");
end

function Player:GetBestDetector()
	if self:HasItem("art_compass") then
		return "art_compass";
	elseif self:HasItem("detector_veles") then
		return "detector_veles";
	elseif self:HasItem("detector_bear") then
		return "detector_bear";
	elseif self:HasItem("detector_echo") then
		return "detector_echo";
	end
end
