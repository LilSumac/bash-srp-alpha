local BASH = BASH;

netstream.Hook("BASH_Repair_Item", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) or !ply:IsTechnician() then return end;
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
    local cond = item.Condition;
    if cond <= 10 then
        ply:PrintChat("This item is beyond repair!");
        return;
    end
    local price = math.floor(itemData.DefaultPrice - ((cond / 100) * itemData.DefaultPrice));
    if price > ply:GetEntry("Rubles") then
        ply:PrintChat("You can't afford to repair this item!");
        return;
    end
    local neededScraps = math.ceil((itemData.MetalYield * 2) * ((100 - cond) / 100));
    local hasItem, total = ply:HasItem("scrap_metal", true);
    if total < neededScraps then
        ply:PrintChat("You don't have enough scrap metal to repair this item!");
        return;
    end
    local neededFabric = math.ceil((itemData.FabricYield * 2) * ((100 - cond) / 100));
    hasItem, total = ply:HasItem("scrap_fabric", true);
    if total < neededFabric then
        ply:PrintChat("You don't have enough scrap fabric to repair this item!");
        return;
    end
    local takenScraps = 0;
    local hasScrap, itemInv, invX, invY, stacks, newStacks, scrapInv;
    while takenScraps < neededScraps do
        hasScrap, itemInv, invX, invY, stacks = ply:HasItem("scrap_metal");
        if !hasScrap then break end;
        scrapInv = ply:GetEntry(itemInv);
        scrapInv = util.JSONToTable(scrapInv);
        newStacks = stacks - (neededScraps - takenScraps);
        if newStacks <= 0 then
            takenScraps = takenScraps + stacks;
            scrapInv.Content[invX][invY] = {};
        else
            takenScraps = takenScraps + (neededScraps - takenScraps);
            scrapInv.Content[invX][invY].Stacks = newStacks;
        end
        scrapInv = util.TableToJSON(scrapInv);
        ply:UpdateEntry(itemInv, scrapInv);
    end
    takenScraps = 0;
    while takenScraps < neededFabric do
        hasScrap, itemInv, invX, invY, stacks = ply:HasItem("scrap_fabric");
        if !hasScrap then break end;
        scrapInv = ply:GetEntry(itemInv);
        scrapInv = util.JSONToTable(scrapInv);
        newStacks = stacks - (neededFabric - takenScraps);
        if newStacks <= 0 then
            takenScraps = takenScraps + stacks;
            scrapInv.Content[invX][invY] = {};
        else
            takenScraps = takenScraps + (neededFabric - takenScraps);
            scrapInv.Content[invX][invY].Stacks = newStacks;
        end
        scrapInv = util.TableToJSON(scrapInv);
        ply:UpdateEntry(itemInv, scrapInv);
    end

    if inv != "Storage" then
        inv = ply:GetEntry(invString);
    else
        inv = ply:GetTable().StorageEnt:GetTable().Inventory;
        noUpdate = true;
    end
    inv = util.JSONToTable(inv);
    inv.Content[x][y].Condition = 100;
    inv = util.TableToJSON(inv);
    if invString != "Storage" and !noUpdate then
        ply:UpdateEntry(invString, inv);
    else
        ply:GetTable().StorageEnt:GetTable().Inventory = inv;
        netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, inv});
    end

	ply:RefreshWeight();
	ply:TakeMoney(price);
	ply:PrintChat(itemData.Name .. " repaired for " .. price .. " rubles, " .. neededScraps .. " metal, and " .. neededFabric .. " fabric!");
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has repaired " .. itemData.Name .. " for " .. price .. " rubles, " .. neededScraps .. " metal, and " .. neededFabric .. " fabric.", true);
end);

netstream.Hook("BASH_Upgrade_Item", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) or !ply:IsTechnician() then return end;
    if !data then return end;

    local inv = data[1];
    local invString = data[1];
    local x = data[2];
    local y = data[3];
    local upgradeIndex = data[4];
    if inv != "Storage" then
        inv = ply:GetEntry(inv);
    else
        inv = ply:GetTable().StorageEnt:GetTable().Inventory;
    end
    inv = util.JSONToTable(inv);
    local item = inv.Content[x][y];
    if !item or !item.ID then return end;
    local itemData = BASH.Items[item.ID];
    if !itemData or !itemData.Upgradeable then return end;
    local upgrade = itemData.Upgrades[upgradeIndex];
    if !upgrade then return end;
    local cond = item.Condition;
    if cond <= 10 then
        ply:PrintChat("This item is too damaged to upgrade!");
        return;
    end
    if upgrade[2] > ply:GetEntry("Rubles") then
        ply:PrintChat("You can't afford to upgrade this item!");
        return;
    end
    local hasItem, total = ply:HasItem("scrap_metal", true);
    if upgrade[3]["metal"] then
        if total < upgrade[3]["metal"] then
            ply:PrintChat("You don't have enough scrap metal to upgrade this item!");
            return;
        end
    end
    hasItem, total = ply:HasItem("scrap_fabric", true);
    if upgrade[3]["fabric"] then
        if total < upgrade[3]["fabric"] then
            ply:PrintChat("You don't have enough scrap fabric to upgrade this item!");
            return;
        end
    end

    if upgrade[4] then
        local newPart, hasPart, partInv, partX, partY, partInvObj;
        for upInd, part in pairs(upgrade[4]) do
            newPart = BASH.Items[part];
            if !newPart then continue end;
            if !ply:HasItem(part) then
                ply:PrintChat("You don't have a required part to upgrade this item! (" .. newPart.Name .. ")");
                return;
            end
        end
        for upInd, part in pairs(upgrade[4]) do
            hasPart, partInv, partX, partY = ply:HasItem(part);
            partInvObj = ply:GetEntry(partInv);
            partInvObj = util.JSONToTable(partInvObj);
            partInvObj.Content[partX][partY] = {};
            partInvObj = util.TableToJSON(partInvObj);
            ply:UpdateEntry(partInv, partInvObj);
        end
    end

    local takenScraps = 0;
    local hasScrap, itemInv, invX, invY, stacks, newStacks, scrapInv;
    if upgrade[3]["metal"] then
        while takenScraps < upgrade[3]["metal"] do
            hasScrap, itemInv, invX, invY, stacks = ply:HasItem("scrap_metal");
            if !hasScrap then break end;
            scrapInv = ply:GetEntry(itemInv);
            scrapInv = util.JSONToTable(scrapInv);
            newStacks = stacks - (upgrade[3]["metal"] - takenScraps);
            if newStacks <= 0 then
                takenScraps = takenScraps + stacks;
                scrapInv.Content[invX][invY] = {};
            else
                takenScraps = takenScraps + (upgrade[3]["metal"] - takenScraps);
                scrapInv.Content[invX][invY].Stacks = newStacks;
            end
            scrapInv = util.TableToJSON(scrapInv);
            ply:UpdateEntry(itemInv, scrapInv);
        end
    end
    if upgrade[3]["fabric"] then
        takenScraps = 0;
        while takenScraps < upgrade[3]["fabric"] do
            hasScrap, itemInv, invX, invY, stacks = ply:HasItem("scrap_fabric");
            if !hasScrap then break end;
            scrapInv = ply:GetEntry(itemInv);
            scrapInv = util.JSONToTable(scrapInv);
            newStacks = stacks - (upgrade[3]["fabric"] - takenScraps);
            if newStacks <= 0 then
                takenScraps = takenScraps + stacks;
                scrapInv.Content[invX][invY] = {};
            else
                takenScraps = takenScraps + (upgrade[3]["fabric"] - takenScraps);
                scrapInv.Content[invX][invY].Stacks = newStacks;
            end
            scrapInv = util.TableToJSON(scrapInv);
            ply:UpdateEntry(itemInv, scrapInv);
        end
    end

    local noUpdate = false;
    if invString != "Storage" then
        inv = ply:GetEntry(invString);
    else
        inv = ply:GetTable().StorageEnt:GetTable().Inventory;
        noUpdate = true;
    end
    inv = util.JSONToTable(inv);
    inv.Content[x][y].ID = upgrade[1];
    inv = util.TableToJSON(inv);
    if invString != "Storage" and !noUpdate then
        ply:UpdateEntry(invString, inv);
    else
        ply:GetTable().StorageEnt:GetTable().Inventory = inv;
        netstream.Start(ply, "BASH_Request_Storage_Return", {ply:GetTable().StorageEnt, inv});
    end

	ply:RefreshWeight();
	ply:TakeMoney(upgrade[2]);

    local costPre = itemData.Name .. " upgraded to " .. BASH.Items[upgrade[1]].Name;
    local costSuf = " for " .. upgrade[2] .. " rubles, " .. (upgrade[3]["metal"] or 0) .. " metal, and " .. (upgrade[3]["fabric"] or 0) .. " fabric.";
    if upgrade[4] then
        costSuf = " for " .. upgrade[2] .. " rubles, " .. (upgrade[3]["metal"] or 0) .. " metal, " .. (upgrade[3]["fabric"] or 0) .. " fabric, ";
        for index, part in pairs(upgrade[4]) do
            local newPart = BASH.Items[part];
            if !newPart then continue end;
            costSuf = costSuf .. ((index == #upgrade[4] and "and ") or "") .. newPart.Name .. ((index == #upgrade[4] and "!") or ", ");
        end
    end
	ply:PrintChat(costPre .. costSuf);
	MsgCon(color_green, ply:GetEntry("Name")  .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has upgraded " .. itemData.Name .. " to " .. BASH.Items[upgrade[1]].Name .. costSuf, true);
end);
