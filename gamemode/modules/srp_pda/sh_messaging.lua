local BASH = BASH;
local Player = FindMetaTable("Player");

function Player:GetPDAs()
	local pdas = {};
	local index = 1;
	local curInv = self:GetEntry("InvMain");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID  then
				local itemData = BASH.Items[curItem.ID];
				if itemData.IsPDA then
					pdas[index] = curItem;
					index = index + 1;
				end
			end
		end
	end

	curInv = self:GetEntry("InvSec");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID  then
				local itemData = BASH.Items[curItem.ID];
				if itemData.IsPDA then
					pdas[index] = curItem;
					index = index + 1;
				end
			end
		end
	end

	curInv = self:GetEntry("InvAcc");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID  then
				local itemData = BASH.Items[curItem.ID];
				if itemData.IsPDA then
					pdas[index] = curItem;
					index = index + 1;
				end
			end
		end
	end

	return pdas;
end

function BASH:GetSIMOwner(sim)
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:HasPDA() then
            local pdas = ply:GetPDAs();
			for index, pda in pairs(pdas) do
                if pda.SIMCardSlot == sim then
                    return ply;
                end;
            end
		end
	end
end
