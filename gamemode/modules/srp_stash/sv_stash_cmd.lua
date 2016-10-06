local BASH = BASH;

local function CreateStash(ply, cmd, args)
	if !ply:GetEntry("CharLoaded") then return end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);
	local target = trace.Entity;

	if !target or !target:IsValid() or !target.ItemData.Inventory then
		ply:PrintChat("You need to be looking at an inventory item to make a stash!");
		return;
	end

	if target:CheckForTransfer(ply) then
		ply:PrintChat("Possible item transfer detected: Event logged.");
		MsgCon(color_red, "Possible item transfer detected from " .. ply:Name() .. ": " .. ply:GetEntry("Name") .. " tried to pick up an object [" .. target:GetTable().ItemID .. "] dropped by " .. target:GetTable().OwnerName .. "!", true);
		return;
	end

	local password = args[1];
	if !password or string.len(password) < 4 then
		ply:PrintChat("You need to give your stash a password that's at least 4 characters long!");
		return;
	end

	local data = {};
	data.Password = password;
	data.Item = target.ItemID;
	data.Inventory = util.TableToJSON(util.JSONToTable(target.Inventory));
    data.Condition = target.Condition;

	local id = RandomString(16);
	local stashString = {};
	stashString.ID = id;
	stashString.Pos = target:GetPos();
	stashString.Password = password;
	stashString = util.TableToJSON(stashString);
	netstream.Start(ply, "BASH_Send_StashInfo", stashString);

	BASH.StashData[id] = {};
	BASH.StashData[id].Pos = target:GetPos();
	BASH.StashData[id].Data = data;

	MsgCon(color_purple, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has created a stash: " .. id);
	target:Remove();
end
concommand.Add("#!/createstash", CreateStash);

local function UncoverStash(ply, cmd, args)
    if !ply:GetEntry("CharLoaded") then return end;

    local password = args[1];
	if !password then
		ply:PrintChat("You need to supply a password that's at least 4 characters long!");
		return;
	end

    local playerPos = ply:GetPos();
    for id, stash in pairs(BASH.StashData) do
        if playerPos:Distance(stash.Pos) < 90 then
            if password == stash.Data.Password then
                local item = stash.Data.Item;
                local itemData = BASH.Items[item];
                if !itemData then return end;

                local args = {};
                if itemData.IsSuit then
                    args[1] = stash.Data.Condition;
                    args[2] = stash.Data.Inventory;
                elseif itemData.IsAccessory then
                    args[1] = stash.Data.Inventory;
                end

                local newEnt = ents.Create("bash_item");
                newEnt:SetItem(item, args);
                newEnt:SetPos(stash.Pos);
                newEnt:SetAngles(Angle(0, 0, 0));
                newEnt:Spawn();

				BASH.StashData[id] = nil;
                MsgCon(color_purple, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has uncovered a stash: " .. id);
                return;
            end
        end
    end

    ply:PrintChat("No stash found in this area with that password.");
end
concommand.Add("#!/uncoverstash", UncoverStash);
