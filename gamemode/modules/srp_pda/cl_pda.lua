local BASH = BASH;

hook.Add("Think", "RemovePDAOnDeath", function()
	if LocalPlayer():GetEntry("CharLoaded") then
		if LocalPlayer():Alive() then
			if LocalPlayer():HasPDA() then
				if CurTime() - LocalPlayer():GetEntry("LastNetworkPing") > 1 then
					local inRange = {};
					local index = 1;
					for id, tower in pairs(ents.FindByClass("bash_network_tower")) do
						if LocalPlayer():GetPos():Distance(tower:GetPos()) <= 5000 then
							inRange[index] = tower;
							index = index + 1;
						end
					end

					if #inRange == 0 then
						LocalPlayer():UpdateEntry("Connection", 0);
						LocalPlayer():UpdateEntry("ClosestTower", 0);

						if BASH.PDA.Open and !ply.ForceClosed then
							ply.ForceClosed = true;
							BASH:ClosePDA();
						elseif !BASH.PDA.Open then
							ply.ForceClosed = true;
						end
					else
						ply.ForceClosed = false;
						for ind, tower in pairs(inRange) do
							if tower != LocalPlayer():GetEntry("ClosestTower") then
								if LocalPlayer():GetEntry("ClosestTower") == 0 or LocalPlayer():GetEntry("ClosestTower") == NULL then
									LocalPlayer():UpdateEntry("ClosestTower", tower);
								else
									if LocalPlayer():GetPos():Distance(LocalPlayer():GetEntry("ClosestTower"):GetPos()) > LocalPlayer():GetPos():Distance(tower:GetPos()) then
										LocalPlayer():UpdateEntry("ClosestTower", tower);
									end
								end
							end
						end
					end

					LocalPlayer():UpdateEntry("LastNetworkPing", CurTime());
				end
			end
		else
			if BASH.PDA.Open then
				BASH:ClosePDA();
			end
		end
	end
end);

hook.Add("AddRightClickOptions", "AddPDAOptions", function(panel, options)
	if panel.ItemData.IsPDA then
		options:AddOption("Open PDA", function()
				BASH:CloseInventory();
				BASH:CreatePDA(panel.EntData.MemorySlot, panel.EntData.SIMCardSlot);
			end):SetImage("icon16/transmit_blue.png");

		if panel.EntData.SIMCardSlot != "" then
			options:AddOption("Remove SIM Card", function()
					local data = {
						FromInv = panel.Inv,
						X = panel.InvX,
						Y = panel.InvY,
						ID = panel.ItemData.ID,
						EntData = panel.EntData
					};
					netstream.Start("BASH_Remove_SIMCard", {data});
				end):SetImage("icon16/vcard_delete.png");
		end
	end
end);

hook.Add("DoInventoryDrop", "HandlePDADrop", function(fromItem, fromItemData, toItem, toItemData)
	if !fromItemData or !toItemData then return end;
	if (!fromItemData.IsPDA and !fromItemData.IsSIMCard and !toItemData.IsPDA and !toItemData.IsSIMCard) then return end;

	if toItem.ID and toItemData.IsPDA and fromItemData.IsSIMCard then
		if toItem.SIMCardSlot != "" then
			LocalPlayer():PrintChat("There's already a SIM card in this PDA!");
			return fromItem, toItem;
		end

		toItem.SIMCardSlot = fromItem.ICCID;
		return {}, toItem;
	elseif toItem.ID and toItemData.IsSIMCard and fromItemData.IsPDA then
		if fromItem.SIMCardSlot != "" then
			LocalPlayer():PrintChat("There's already a SIM card in this PDA!");
			return fromItem, toItem;
		end

		fromItem.SIMCardSlot = toItem.ICCID;
		return {}, fromItem;
	end
end);

netstream.Hook("BASH_Update_Device_MEM", function(data)
	if !data then return end;
	BASH.PDA.MemoryData = data;
end);

netstream.Hook("BASH_Update_Device_SIM", function(data)
	if !data then return end;
	BASH.PDA.SIMData = data;
end);

netstream.Hook("BASH_Send_Econ_Return", function(data)
	if !data then return end;
	BASH.EconomyStats = data;
end);

netstream.Hook("BASH_New_Note_Return", function(data)
	if !BASH.PDA.Open then return end;
	BASH:NotesApp();
end);

netstream.Hook("BASH_Update_Note_Return", function(data)
	if !BASH.PDA.Open then return end;
	if !data then return end;

	BASH.PDA.Content.Container.Right.Title = data[1];
	BASH.PDA.Content.Container.Right.NoteData = data[2];
	BASH:RefreshNote();
end);

netstream.Hook("BASH_Update_Map", function(data)
	if !BASH.PDA.Open then return end;
	BASH:MapApp();
end);

netstream.Hook("BASH_Remove_StashData_Return", function(data)
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;

	LocalPlayer():PrintChat("Stash data removed! Check the developer console (~) for the generated stash data string.");
    MsgCon(color_green, data);

	if !BASH.PDA.Open then return end;
	BASH:MapApp();
end);
