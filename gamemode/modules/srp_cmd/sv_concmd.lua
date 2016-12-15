local BASH = BASH;

local function NoClip(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or
		(!ply:IsStaff() and !ply:HasFlag("c") and !ply:HasFlag("e") and !ply:IsTrader())
	then return end;

	ply:NoClip(!ply:GetEntry("Observing"));
end
concommand.Add("#!/noclip", NoClip);

local function GiveMoney(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") then return end;

	local amount = tonumber(args[1]);
	if !amount then
		ply:PrintChat("You must enter a number of rubles to give!");
		return;
	end

	amount = math.Round(amount);
	if ply:GetEntry("Rubles") < amount then
		ply:PrintChat("You don't have that much to give!");
		return;
	elseif amount < 0 then
		ply:PrintChat("You can't give negative cash!");
		return;
	end

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 150;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);

	if trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetEntry("CharLoaded") then
		ply:TakeMoney(amount);
		trace.Entity:GiveMoney(amount);

		ply:PrintChat("You gave " .. trace.Entity:GetEntry("Name") .. " " .. amount .. " rubles!");
		trace.Entity:PrintChat(ply:GetEntry("Name") .. " gave you " .. amount .. " rubles!");

		BASH:UpdateEconomy(BASH.EconomyStats["CashMoved"] + amount, "CashMoved");
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] gave " .. trace.Entity:GetEntry("Name") .. " [" .. trace.Entity:Name() .. "/" .. trace.Entity:SteamID() .. "] " .. amount .. " rubles.", true);
	else
		ply:PrintChat("You must be looking at a valid player to give money!");
		return;
	end
end
concommand.Add("#!/givemoney", GiveMoney);

local function CreateBounty(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to submit bounties! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local tab = {};
	local bountyTarget = args[1];
	local bountyPrice = tonumber(args[2] or 1000);
	local bountyDesc = args[3];
	local bountyOwner = args[4];
	bountyPrice = math.Round(bountyPrice);

	if !bountyTarget or bountyTarget == "" then
		ply:PrintChat("You must enter a target name for the bounty!");
		return;
	end

	if !bountyPrice or bountyPrice < 0 then
		ply:PrintChat("You must enter a proper price for the bounty!");
		return;
	end

	if !bountyDesc or bountyDesc == "" then
		ply:PrintChat("You must enter a description for the bounty!");
		return;
	end

	if !bountyOwner or bountyOwner == "" then
		ply:PrintChat("You must submit an owner for the bounty!");
		return;
	end

	local bountyID = RandomString(8);
	tab.Target = bountyTarget;
	tab.Price = bountyPrice;
	tab.Desc = bountyDesc;
	tab.Owner = bountyOwner;
	tab.Status = "OPEN";

	BASH.Bounties[bountyID] = tab;
	ply:PrintChat("New bounty submitted. ID: " .. bountyID .. " [ID required for editing/deletion!]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] submitted bounty " .. bountyID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has submitted a new bounty: " .. bountyID);
	BASH:PDABroadcast("A new bounty has been posted! (" .. bountyID .. ")");
end
concommand.Add("#!/createbounty", CreateBounty);

local function RemoveBounty(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to remove bounties! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local bountyID = args[1];
	if !bountyID or string.len(bountyID) != 8 then
		ply:PrintChat("No valid bounty ID entered!");
		return;
	end

	if !BASH.Bounties[bountyID] then
		ply:PrintChat("No bounty with that ID found!");
		return;
	end

	BASH.Bounties[bountyID] = nil;
	ply:PrintChat("Bounty removed. ID: " .. bountyID);
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] removed bounty " .. bountyID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has removed a bounty: " .. bountyID);
	BASH:PDABroadcast("A bounty has been removed! (" .. bountyID .. ")");
end
concommand.Add("#!/removebounty", RemoveBounty);

local function EditBounty(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to edit bounties! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local bountyID = args[1];
	if !bountyID or string.len(bountyID) != 8 then
		ply:PrintChat("No valid bounty ID entered!");
		return;
	end

	if !BASH.Bounties[bountyID] then
		ply:PrintChat("No bounty with that ID found!");
		return;
	end

	netstream.Start(ply, "BASH_Edit_Bounty", {bountyID, BASH.Bounties[bountyID]});
end
concommand.Add("#!/editbounty", EditBounty);
netstream.Hook("BASH_Update_Bounty", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local bountyID = data[1];
	local desc = data[2];
	local price = data[3];
	local status = data[4];
	if !bountyID then return end;
	if !desc then
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has stopped editing the bounty '" .. bountyID .. "'.", true);
		return;
	end

	BASH.Bounties[bountyID].Desc = desc;
	BASH.Bounties[bountyID].Price = price;
	BASH.Bounties[bountyID].Status = status;

	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has edited the bounty '" .. bountyID .. "'.", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited a bounty: " .. bountyID);
	BASH:PDABroadcast("A bounty has been edited! (" .. bountyID .. ")");
end);

local function CreateGroup(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to submit groups! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local tab = {};
	local groupName = args[1];
	local groupDesc = args[2];
	local groupLeader = args[3];
	local groupHiring = args[4] or "OPEN";
	local groupR = tonumber(args[5] or 255);
	local groupG = tonumber(args[6] or 255);
	local groupB = tonumber(args[7] or 255);
	local groupColor = Color(groupR, groupG, groupB);

	if !groupName or groupName == "" then
		ply:PrintChat("You must enter a name for the group!");
		return;
	end

	if !groupDesc or groupDesc == "" then
		ply:PrintChat("You must enter a description for the group!");
		return;
	end

	if !groupLeader or groupLeader == "" then
		ply:PrintChat("You must enter a name for the leader of the group!");
		return;
	end

	local groupID = RandomString(8);
	tab.Name = groupName;
	tab.Desc = groupDesc;
	tab.Leader = groupLeader;
	tab.Hiring = groupHiring;
	tab.Color = groupColor;

	BASH.Groups[groupID] = tab;
	ply:PrintChat("New group submitted. ID: " .. groupID .. " [ID required for editing/deletion!]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] submitted group " .. groupID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has submitted a new group: " .. groupID);
	BASH:PDABroadcast("A new group has been posted! (" .. groupID .. ")");
end
concommand.Add("#!/creategroup", CreateGroup);

local function RemoveGroup(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to remove groups! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local groupID = args[1];
	if !groupID or string.len(groupID) != 8 then
		ply:PrintChat("No valid group ID entered!");
		return;
	end

	if !BASH.Groups[groupID] then
		ply:PrintChat("No bounty with that ID found!");
		return;
	end

	BASH.Groups[groupID] = nil;
	ply:PrintChat("Group removed. ID: " .. groupID);
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] removed group " .. groupID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has removed a group: " .. groupID);
	BASH:PDABroadcast("A group has been removed! (" .. groupID .. ")");
end
concommand.Add("#!/removegroup", RemoveGroup);

local function EditGroup(ply, cmd, args)
	if !ply then return end;
	if !ply:HasFlag("w") and !ply:IsStaff() then
		ply:PrintChat("You're not allowed to edit groups! Contact a sysadmin.");
		return;
	end;
	if !ply:GetEntry("CharLoaded") then return end;

	local groupID = args[1];
	if !groupID or string.len(groupID) != 8 then
		ply:PrintChat("No valid group ID entered!");
		return;
	end

	if !BASH.Groups[groupID] then
		ply:PrintChat("No group with that ID found!");
		return;
	end

	netstream.Start(ply, "BASH_Edit_Group", {groupID, BASH.Groups[groupID]});
end
concommand.Add("#!/editgroup", EditGroup);
netstream.Hook("BASH_Update_Group", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local groupID = data[1];
	local desc = data[2];
	local leader = data[3];
	local status = data[4];
	if !groupID then return end;
	if !desc then
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has stopped editing the group '" .. groupID .. "'.", true);
		return;
	end

	BASH.Groups[groupID].Desc = desc;
	BASH.Groups[groupID].Leader = leader;
	BASH.Groups[groupID].Hiring = status;

	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has edited the group '" .. groupID .. "'.", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited a group: " .. groupID);
	BASH:PDABroadcast("A group has been edited! (" .. groupID .. ")");
end);

local function CreateAdvert(ply, cmd, args)
	if !ply then return end;
	if ply:HasFlag("z") then
		ply:PrintChat("You've been blacklisted from making PDA adverts.");
		return;
	end
	if !ply:HasPDA() then
		ply:PrintChat("You must have a PDA to create an advert!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local tab = {};
	local advertTitle = args[1];
	local advertDesc = args[2];
	local advertOwner = args[3];

	if !advertTitle or advertTitle == "" then
		ply:PrintChat("You must enter a proper title for the advert!");
		return;
	end

	if !advertDesc or advertDesc == "" then
		ply:PrintChat("You must enter a description for the advert!");
		return;
	end

	if !advertOwner or advertOwner == "" then
		ply:PrintChat("You must submit an owner for the advert!");
		return;
	end

	local advertID = RandomString(8);
	tab.Title = advertTitle;
	tab.Desc = advertDesc;
	tab.Owner = advertOwner;
	tab.OwnerID = ply:SteamID();

	BASH.Adverts[advertID] = tab;
	ply:PrintChat("New advert submitted. ID: " .. advertID .. " [ID required for editing/deletion!]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] submitted advert " .. advertID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has submitted a new advert: " .. advertID);
	BASH:PDABroadcast("A new advert has been posted! (" .. advertID .. ")");
end
concommand.Add("#!/createadvert", CreateAdvert);

local function RemoveAdvert(ply, cmd, args)
	if !ply then return end;
	if ply:HasFlag("z") then
		ply:PrintChat("You've been blacklisted from removing PDA adverts.");
		return;
	end
	if !ply:HasPDA() then
		ply:PrintChat("You must have a PDA to remove an advert!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local advertID = args[1];
	if !advertID or string.len(advertID) != 8 then
		ply:PrintChat("No valid advert ID entered!");
		return;
	end

	if !BASH.Adverts[advertID] then
		ply:PrintChat("No advert with that ID found!");
		return;
	end

	if BASH.Adverts[advertID].OwnerID != ply:SteamID() and !ply:IsStaff() then
		ply:PrintChat("You are not allowed to remove adverts that are not yours!");
		return;
	end

	BASH.Adverts[advertID] = nil;
	ply:PrintChat("Advert removed. ID: " .. advertID);
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] removed advert " .. advertID .. ".", true);
	CommandPrint(ply:GetEntry("Name") .. " has removed an advert: " .. advertID);
	BASH:PDABroadcast("An advert has been removed! (" .. advertID .. ")");
end
concommand.Add("#!/removeadvert", RemoveAdvert);

local function EditAdvert(ply, cmd, args)
	if !ply then return end;
	if ply:HasFlag("z") then
		ply:PrintChat("You've been blacklisted from editing PDA adverts.");
		return;
	end
	if !ply:HasPDA() then
		ply:PrintChat("You must have a PDA to edit an advert!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local advertID = args[1];
	if !advertID or string.len(advertID) != 8 then
		ply:PrintChat("No valid advert ID entered!");
		return;
	end

	if !BASH.Adverts[advertID] then
		ply:PrintChat("No advert with that ID found!");
		return;
	end

	if BASH.Adverts[advertID].OwnerID != ply:SteamID() and !ply:IsStaff() then
		ply:PrintChat("You are not allowed to edit adverts that are not yours!");
		return;
	end

	netstream.Start(ply, "BASH_Edit_Advert", {advertID, BASH.Adverts[advertID]});
end
concommand.Add("#!/editadvert", EditAdvert);
netstream.Hook("BASH_Update_Advert", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local advertID = data[1];
	local title = data[2];
	local desc = data[3];
	local owner = data[4];
	if !advertID then return end;
	if !title then
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has stopped editing the advert '" .. advertID .. "'.", true);
		return;
	end

	BASH.Adverts[advertID].Title = title;
	BASH.Adverts[advertID].Desc = desc;
	BASH.Adverts[advertID].Owner = owner;

	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has edited the advert '" .. advertID .. "'.", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited an advert: " .. advertID);
	BASH:PDABroadcast("An advert has been edited! (" .. advertID .. ")");
end);

local function Slay(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	target:Kill();
	Broadcast(ply:GetEntry("Name") .. " has slain " .. target:GetEntry("Name") .. ".");
	CommandPrint(ply:GetEntry("Name") .. " has slain " .. target:GetEntry("Name") .. ".");
end
concommand.Add("#!/slay", Slay);

local function GrantMoney(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local amount = tonumber(args[2]);

	if !amount then
		ply:PrintChat("You must enter a number of rubles to grant!");
		return;
	end

	amount = math.Round(amount);

	if amount < 0 then
		ply:PrintChat("You can't grant negative cash!");
		return;
	end

	target:GiveMoney(amount);
	ply:PrintChat("You granted " .. target:GetEntry("Name") .. " " .. amount .. " rubles!");
	target:PrintChat(ply:GetEntry("Name") .. " granted you " .. amount .. " rubles!");

	BASH:UpdateEconomy(BASH.EconomyStats["ValueIn"] + amount, "ValueIn");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] granted " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] " .. amount .. " rubles.", true);
	CommandPrint(ply:GetEntry("Name") .. " has granted " .. target:GetEntry("Name") .. " " .. amount .. " rubles.");
end
concommand.Add("#!/grantmoney", GrantMoney);

local function DrainMoney(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local amount = tonumber(args[2]);

	if !amount then
		ply:PrintChat("You must enter a number of rubles to drain!");
		return;
	end

	amount = math.Round(amount);

	if amount < 0 then
		ply:PrintChat("You can't drain negative cash!");
		return;
	end

	target:TakeMoney(amount);
	ply:PrintChat("You drained " .. target:GetEntry("Name") .. " of " .. amount .. " rubles!");
	target:PrintChat(ply:GetEntry("Name") .. " drained you of " .. amount .. " rubles!");

	BASH:UpdateEconomy(BASH.EconomyStats["ValueOut"] + amount, "ValueOut");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] drained " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] of " .. amount .. " rubles.", true);
	CommandPrint(ply:GetEntry("Name") .. " has drained " .. target:GetEntry("Name") .. " of " .. amount .. " rubles.");
end
concommand.Add("#!/drainmoney", DrainMoney);

local function Kick(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local message = "";

	if args[2] then
		for index = 2, #args do
			if message != "" then
				message = message .. " ";
			end

			message = message .. args[index];
		end
	end

	if message == "" then
		message = "Kicked by an administrator.";
	end

	Broadcast(ply:GetEntry("Name") .. " kicked " .. target:GetEntry("Name") .. ". [" .. message .. "]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] kicked " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "]. [" .. message .. "]", true);
	target.ForceDisconnect = true;
	target:Kick(message);
end
concommand.Add("#!/kick", Kick);

local function EditCharFlags(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	netstream.Start(ply, "BASH_Edit_CharFlags", target);
end
concommand.Add("#!/editcharflags", EditCharFlags);
netstream.Hook("BASH_Edit_CharFlags_Return", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = data[1];
	local flags = data[2];
	if flags == "" then flags = " " end;
	if !target or !CheckPly(target) or !CheckChar(target) then return end;

	target:UpdateEntry("CharFlags", flags);
	ply:PrintChat("You edited character flags for " .. target:GetEntry("Name") .. ".");
	target:PrintChat("Your character flags were edited by " .. ply:GetEntry("Name") .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] edited character flags (" .. flags .. ") for " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited character flags for " .. target:GetEntry("Name") .. ".");

	timer.Simple(0.1, function()
		hook.Call("OnFlagsChanged", BASH, target, flags);
	end);
end);

local function EditPlayerFlags(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	netstream.Start(ply, "BASH_Edit_PlyFlags", target);
end
concommand.Add("#!/editplayerflags", EditPlayerFlags);
netstream.Hook("BASH_Edit_PlyFlags_Return", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = data[1];
	local flags = data[2];
	if flags == "" then flags = " " end;
	if !target or !CheckPly(target) or !CheckChar(target) then return end;

	target:UpdateEntry("PlayerFlags", flags);
	ply:PrintChat("You edited player flags for " .. target:GetEntry("Name") .. ".");
	target:PrintChat("Your player flags were edited by " .. ply:GetEntry("Name") .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] edited player flags (" .. flags .. ") for " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited character flags for " .. target:GetEntry("Name") .. ".");

	timer.Simple(0.1, function()
		hook.Call("OnFlagsChanged", nil, target, flags);
	end);
end);

local function EditWhitelists(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	netstream.Start(ply, "BASH_Edit_Whitelists", target);
end
concommand.Add("#!/editwhitelists", EditWhitelists);
netstream.Hook("BASH_Edit_Whitelists_Return", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local target = data[1];
	local whitelists = data[2];
	if whitelists == "" then return end;
	if !target or !CheckPly(target) or !CheckChar(target) then return end;

	target:UpdateEntry("Whitelists", whitelists);
	ply:PrintChat("You edited whitelists for " .. target:GetEntry("Name") .. ".");
	target:PrintChat("Your whitelists were edited by " .. ply:GetEntry("Name") .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] edited whitelists for " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited whitelists for " .. target:GetEntry("Name") .. ".");
end);

local function TimedKill(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local time = tonumber(args[2]);
	if !time then
		ply:PrintChat("You must enter a time length for the PK!");
		return;
	end
	if time < 0 then
		ply:PrintChat("Time length must be greater than zero! 0: Perma - >0: Ban in minutes");
		return;
	end

	if time == 0 then
		target:UpdateEntry("PKTime", 0);
	else
		target:UpdateEntry("PKTime", os.time() + (time * 60));
	end
	target:UpdateEntry("IsPKed", true);
	target:SQLUpdate();
	target:Initialize();

	local message = "";
	if time > 0 then
		message = " for " .. time .. " minutes.";
	else
		message = " permanently.";
	end

	ply:PrintChat("You killed '" .. target:GetEntry("Name") .. "'" .. message);
	Broadcast(ply:GetEntry("Name") .. " has killed " .. target:GetEntry("Name") .. message);
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] killed " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "]" .. message, true);
	CommandPrint(ply:GetEntry("Name") .. " has killed " .. target:GetEntry("Name") .. message);
end
concommand.Add("#!/timedkill", TimedKill)

local function Mute(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	if !BASH.MutedPlayers then
		BASH.MutedPlayers = {};
	end

	BASH.MutedPlayers[target:SteamID()] = true;

	ply:PrintChat("You muted '" .. target:GetEntry("Name") .. "'.");
	target:PrintChat("You were muted by '" .. ply:GetEntry("Name") .. "'.")
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has muted " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has muted " .. target:GetEntry("Name") .. ".");
end
concommand.Add("#!/mute", Mute);

local function UnMute(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	if !BASH.MutedPlayers then
		BASH.MutedPlayers = {};
	end

	BASH.MutedPlayers[target:SteamID()] = nil;

	ply:PrintChat("You unmuted '" .. target:GetEntry("Name") .. "'.");
	target:PrintChat("You were unmuted by '" .. ply:GetEntry("Name") .. "'.")
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has unmuted " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has unmuted " .. target:GetEntry("Name") .. ".");
end
concommand.Add("#!/unmute", UnMute);

local function Bring(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	ply.LastBrought = target;
	target.LastPos = target:GetPos();

	local pos = ply:GetPos();
	target:SetPos(pos);

	ply:PrintChat("You brought " .. target:GetEntry("Name") .. ".");
	target:PrintChat("You were brought to " .. ply:GetEntry("Name") .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] brought " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has brought " .. target:GetEntry("Name") .. ".");
end
concommand.Add("#!/bring", Bring);

local function ReturnLast(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	if !ply.LastBrought then
		ply:PrintChat("You haven't brought anyone to return!");
		return;
	end

	local target = ply.LastBrought;
	if !CheckPly(target) or !CheckChar(target) or !target.LastPos then
		ply:PrintChat("Your target doesn't have a position to return to!");
		return;
	end

	target:SetPos(target.LastPos);
	ply.LastBrought = nil;

	ply:PrintChat("You returned " .. target:GetEntry("Name") .. " to their original position.");
	target:PrintChat("You were returned to your original position by " .. ply:GetEntry("Name") .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] returned " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] to their original position.", true);
	CommandPrint(ply:GetEntry("Name") .. " has returned " .. target:GetEntry("Name") .. ".");
end
concommand.Add("#!/returnlast", ReturnLast);

local function OOCDelay(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local amount = args[1];
	if !amount or !tonumber(amount) then
		ply:PrintChat("You must enter a number for the OOC delay!");
		return;
	end

	amount = math.Round(tonumber(amount));
	if amount < 0 then
		ply:PrintChat("You can't have a negative OOC delay!");
		return;
	end

	BASH.OOCDelay = amount;
	Broadcast(ply:GetEntry("Name") .. " set the OOC delay to " .. amount .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] set the OOC delay to " .. amount .. ".", true);
end
concommand.Add("#!/setoocdelay", OOCDelay);

local function Ban(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local length = args[2];
	if !length or !tonumber(length) then
		ply:PrintChat("You must enter a number for the ban length!");
		return;
	end

	length = math.Round(tonumber(length));
	if length < 0 then
		ply:PrintChat("You can't have a negative ban length!");
		return;
	end

	local suffix = "";
	if length == 0 then
		suffix = "permanently"
	else
		suffix = "for " .. length .. " minutes";
	end

	local message = "";
	if args[3] then
		for index = 3, #args do
			if message != "" then
				message = message .. " ";
			end

			message = message .. args[index];
		end
	end

	if message == "" then
		message = "Banned by an administrator.";
	end

	Broadcast(ply:GetEntry("Name") .. " banned " .. target:GetEntry("Name") .. " " .. suffix .. ". [" .. message .. "]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] banned " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] " .. suffix .. ". [" .. message .. "]", true);
	BASH:BanPlayer(ply, target, length * 60, message);
end
concommand.Add("#!/ban", Ban);

local function BanID(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local banID = args[1];
	if !banID or banID == "" then
		ply:PrintChat("Enter a SteamID to ban!");
		return;
	end

	local length = args[2];
	if !length or !tonumber(length) then
		ply:PrintChat("You must enter a number for the ban length!");
		return;
	end

	length = math.Round(tonumber(length));
	if length < 0 then
		ply:PrintChat("You can't have a negative ban length!");
		return;
	end

	local suffix = "";
	if length == 0 then
		suffix = "permanently"
	else
		suffix = "for " .. length .. " minutes";
	end

	local message = "";
	if args[3] then
		for index = 3, #args do
			if message != "" then
				message = message .. " ";
			end

			message = message .. args[index];
		end
	end

	if message == "" then
		message = "Banned by an administrator.";
	end

	Broadcast(ply:GetEntry("Name") .. " banned " .. banID .. " " .. suffix .. ". [" .. message .. "]");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] banned " .. banID .. " " .. suffix .. ". [" .. message .. "]", true);
	BASH:BanPlayer(ply, banID, length * 60, message);
end
concommand.Add("#!/banid", BanID);

local function Youtube(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local youtubeid = args[1];
	if !youtubeid or youtubeid == "" then
		ply:PrintChat("You need to supply a Youtube ID to play!");
		return;
	end

	netstream.Start(player.GetAll(), "BASH_Play_Youtube", youtubeid);

	Broadcast(ply:GetEntry("Name") .. " played Youtube video " .. youtubeid .. ".");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] played Youtube video " .. youtubeid .. ".", true);
end
concommand.Add("#!/youtube", Youtube);

local function KillYoutube(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	netstream.Start(player.GetAll(), "BASH_Kill_Youtube");

	Broadcast(ply:GetEntry("Name") .. " killed the current Youtube video.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] killed the current Youtube video.", true);
end
concommand.Add("#!/killyoutube", KillYoutube);

local function SetModel(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local path = args[2];
	if !path or path == "" then
		ply:PrintChat("No model path supplied!");
		return;
	end

	local suit, cond = target:GetEntry("Suit");
	if suit == "" then
		target:SetModel(path);
	end
	target:UpdateEntry("Model", path);

	ply:PrintChat("You set " .. target:GetEntry("Name") .. "'s model to " .. path .. ".");
	target:PrintChat("Your model was set to " .. path .. " by " .. ply:GetEntry("Name") .. ".");
	CommandPrint(ply:GetEntry("Name") .. " has set the model for " .. target:GetEntry("Name") .. " to " .. path .. ".");
	BASH:WriteToLog(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] set " .. target:GetEntry("Name") .. "'s [" .. target:Name() .. "/" .. target:SteamID() .. "] model to " .. path .. ".", LOG_ALL);
end
concommand.Add("#!/setmodel", SetModel);

local function SetSpawn(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;
	if !ply:Alive() then return end;

	local newSpawn = ply:GetPos();
	BASH["spawn_loner"] = newSpawn;
	ply:PrintChat("Default spawn point override set.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] overrode the default spawn point.", true);
	CommandPrint(ply:GetEntry("Name") .. " overrode the default spawn point.");
end
concommand.Add("#!/setspawn", SetSpawn);

local function RemoveSpawn(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local faction;
	if args[1] and args[1] != "" then
		faction = args[1];
	end

	if faction then
		if BASH["spawn_" .. faction] then
			BASH["spawn_" .. faction] = nil;
			ply:PrintChat("'" .. faction .. "' spawn point override removed.");
			MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] removed the '" .. faction .. "' spawn point override.", true);
			CommandPrint(ply:GetEntry("Name") .. " removed the '" .. faction .. "' spawn point override.");
		else
			ply:PrintChat("No '" .. faction .. "' spawn point override found.");
		end
	else
		if BASH["spawn_loner"] then
			BASH["spawn_loner"] = nil;
			ply:PrintChat("Default spawn point override removed.");
			MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] removed the default spawn point override.", true);
			CommandPrint(ply:GetEntry("Name") .. " removed the default spawn point override.");
		else
			ply:PrintChat("No default spawn point override found.");
		end
	end
end
concommand.Add("#!/removespawn", RemoveSpawn);

local function FactionSpawn(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;
	if !ply:Alive() then return end;

	local faction = args[1];
	if !faction or faction == "" then
		ply:PrintChat("You need to supply a faction spawn to override!");
		return;
	end

	local newSpawn = ply:GetPos();
	BASH["spawn_" .. faction] = newSpawn;
	ply:PrintChat("'" .. faction .. "' spawn point override set.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] overrode the " .. faction .. " spawn point.", true);
	CommandPrint(ply:GetEntry("Name") .. " overrode the " .. faction .. " spawn point.");
end
concommand.Add("#!/factionspawn", FactionSpawn);

local function CreateItem(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then return end;
	if !ply:GetEntry("CharLoaded") then return end;
	if !args[1] then return end;

	local itemID = args[1];
	local arg1 = args[2];
	local arg2 = args[3];
	local arg3 = args[4];
	local itemData = BASH.Items[itemID];

	if !itemData then return end;

	local itemArgs = {};
	if itemData.IsSuit then
		itemArgs[1] = math.Clamp(tonumber(arg1 or 100), 0, 100) or 100;
		local inv = {};
		inv.Name = itemData.Inventory;
		inv.Content = {};
		local invData = BASH.Inventories[itemData.Inventory];
		if invData then
			for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
		end
		itemArgs[2] = util.TableToJSON(inv);
	elseif itemData.IsAccessory then
		if arg1 then
			itemArgs[1] = arg1;
		else
			local inv = {};
			inv.Name = itemData.Inventory;
			inv.Content = {};
			local invData = BASH.Inventories[itemData.Inventory];
			if invData then
				for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
			end
			itemArgs[1] = util.TableToJSON(inv);
		end
	elseif itemData.IsWeapon then
		itemArgs[1] = math.Clamp(tonumber(arg1 or 100), 0, 100) or 100;
		itemArgs[2] = math.Clamp(tonumber(arg2 or 0), 0, 999) or 0;
		itemArgs[3] = util.TableToJSON({});
	elseif itemData.IsAttachment then
		itemArgs[1] = arg1 or itemData.DefaultColor;
	elseif itemData.IsWritable then
		itemArgs[1] = arg1 or RandomString(24);
		BASH:NewWritingData(itemArgs[1]);
	elseif itemData.IsConditional then
		itemArgs[1] = math.Clamp(tonumber(arg1 or 100), 0, 100) or 100;
	elseif itemData.IsStackable then
		itemArgs[1] = math.Clamp(tonumber(arg1 or itemData.DefaultStacks), 0, itemData.MaxStacks);
	elseif !itemData.NoProperties then
		itemArgs = hook.Call("GetItemProperties", BASH, itemData) or {};
	end

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);
	local itemPos = trace.HitPos;
	itemPos.z = itemPos.z + 2;

	local newEnt = ents.Create("bash_item");
	newEnt:SetItem(itemID, itemArgs);
	newEnt:SetPos(itemPos);
	newEnt:SetAngles(Angle(0, 0, 0));
	newEnt:Spawn();
	newEnt:Activate();

	MsgCon(color_purple, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has spawned an item: " .. itemID);
	CommandPrint(ply:GetEntry("Name") .. " has spawned an item: " .. itemID);
	BASH:UpdateEconomy(BASH.EconomyStats["ValueIn"] + itemData.DefaultPrice, "ValueIn");
end
concommand.Add("#!/createitem", CreateItem);

local function CreateStorage(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then return end;
	if !ply:GetEntry("CharLoaded") then return end;
	if !args[1] then return end;

	local invID = args[1];
	local invData = BASH.Inventories[invID];
	if !invData then return end;
	local modelOverride = args[2];

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);
	local itemPos = trace.HitPos;
	itemPos.z = itemPos.z + 2;

	local newEnt = ents.Create("bash_storage");
	newEnt:CreateInventory(invID, modelOverride);
	newEnt:SetRPOwner(ply:GetEntry("BASHID"));
	newEnt:SetPos(itemPos);
	newEnt:SetAngles(Angle(0, 0, 0));
	newEnt:Spawn();
	newEnt:Activate();

	MsgCon(color_purple, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has spawned a storage entity: " .. invID);
	CommandPrint(ply:GetEntry("Name") .. " has spawned a storage entity: " .. invID);
end
concommand.Add("#!/createstorage", CreateStorage);

local function History(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;
	if !ply:Alive() then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end
	if CheckPly(target.HistoryEditor) and CheckChar(target.HistoryEditor) then
		ply:PrintChat("Character '" .. args[1] .. "' is already having their history edited!");
		return;
	end

	local hist = "";
	BASH:CreateDirectory("vars/history/");
	if file.Exists("vars/history/" .. target:GetEntry("CharID") .. ".txt", "DATA") then
		hist = file.Read("vars/history/" .. target:GetEntry("CharID") .. ".txt", "DATA");
	else
		hist = "[Default Template]\n\n* Significant Events [w/ dates]:\n\n\n* Notable Acquaintances [friends, family, etc.]:\n\n\n* Space Description:\n\n\n* Desires:\n\n\n* Weaknesses:\n\n\n* Fears:\n";
		BASH:CreateFile("vars/history/" .. target:GetEntry("CharID") .. ".txt");
		BASH:WriteToFile("vars/history/" .. target:GetEntry("CharID") .. ".txt", hist, true);
	end

	target.HistoryEditor = ply;
	netstream.Start(ply, "BASH_Send_History", {target:GetEntry("CharID"), hist});
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has opened the history of " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
end
concommand.Add("#!/history", History);
netstream.Hook("BASH_Update_History", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;
	if !data then return end;

	local charID = data[1];
	local hist = data[2];
	if !charID then return end;

	local target = player.GetByInfo("CharID", charID);
	if !target then return end;
	target.HistoryEditor = nil;
	if !hist then
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has closed the history of " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
		return;
	end

	BASH:CreateDirectory("vars/history/");
	BASH:CreateFile("vars/history/" .. target:GetEntry("CharID") .. ".txt");
	BASH:WriteToFile("vars/history/" .. target:GetEntry("CharID") .. ".txt", hist, true);
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has edited the history of " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].", true);
	CommandPrint(ply:GetEntry("Name") .. " has edited the history for " .. target:GetEntry("Name") .. ".");
end);

local function GrantLoot(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() and !ply:IsTrader() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;
	if !ply:Alive() then return end;

	local lastGrant = ply:GetEntry("LastLootGrant");
	if os.time() - lastGrant < 86400 and !ply:IsStaff() then
		ply:PrintChat("You've already claimed your mission loot recently! Please wait another " .. math.ceil((86400 - (os.time() - lastGrant)) / 60) .. " minutes.");
		return;
	end

	ply:UpdateEntry("LastLootGrant", os.time());
	local invs = {"InvMain", "InvSec", "InvAcc"};
	local items = {};
	local drawing = math.random(8, 12);
	local added;
	for index = 1, drawing do
		local item, args = BASH:GetRandomItem(2);
		for ind, inv in pairs(invs) do
			added = BASH:AddItemToInv(ply, inv, item, args, false, true);
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
				newItem:SetItem(item, args);
				newItem:SetRPOwner(ply);
				newItem:SetPos(itemPos);
				newItem:SetAngles(Angle(0, 0, 0));
				newItem:Spawn();
				newItem:Activate();
			end
		end
	end

	local args = {math.random(500, 4000)};
	for ind, inv in pairs(invs) do
		added = BASH:AddItemToInv(ply, inv, "money", args, false, true);
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
			newItem:SetItem("money", args);
			newItem:SetRPOwner(ply);
			newItem:SetPos(itemPos);
			newItem:SetAngles(Angle(0, 0, 0));
			newItem:Spawn();
			newItem:Activate();
		end
	end

	ply:PrintChat("You've claimed your mission loot! Remember, you must use ALL of these items as loot for a mission/job. Failing to do so will result in removal of trader flags and further punishment.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has claimed their mission loot.", true);
	CommandPrint(ply:GetEntry("Name") .. " has claimed their mission loot.");
end
concommand.Add("#!/grantloot", GrantLoot);

local function BundleMoney(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local money = tonumber(args[1]);
	if !money or money < 1 then
		ply:PrintChat("You must enter a valid number!");
		return;
	end

	local invs = {"InvMain", "InvSec", "InvAcc"};
	local added;
	for ind, inv in pairs(invs) do
		added = BASH:AddItemToInv(ply, inv, "money", {money}, false, true);
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
			newItem:SetItem("money", {money});
			newItem:SetRPOwner(ply);
			newItem:SetPos(itemPos);
			newItem:SetAngles(Angle(0, 0, 0));
			newItem:Spawn();
			newItem:Activate();
		end
	end

	ply:TakeMoney(money);
	ply:PrintChat("You've bundled " .. money .. " rubles.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has bundled " .. money .. "rubles.", true);
end
concommand.Add("#!/bundlemoney", BundleMoney);

local function DropMoney(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local money = tonumber(args[1]);
	if !money or money < 1 then
		ply:PrintChat("You must enter a valid number!");
		return;
	end

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);
	local itemPos = trace.HitPos;
	itemPos.z = itemPos.z + 2;
	local newItem = ents.Create("bash_item");
	newItem:SetItem("money", {money});
	newItem:SetRPOwner(ply);
	newItem:SetPos(itemPos);
	newItem:SetAngles(Angle(0, 0, 0));
	newItem:Spawn();
	newItem:Activate();

	ply:TakeMoney(money);
	ply:PrintChat("You've dropped " .. money .. " rubles.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has dropped " .. money .. "rubles.", true);
end
concommand.Add("#!/dropmoney", DropMoney);

local function ToggleConv(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 150;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);

	if trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetEntry("CharLoaded") then
		if !ply.Convo then
			ply.Convo = {};
		end

		local name = trace.Entity:GetEntry("Name");
		local id = trace.Entity:GetEntry("CharID");
		if ply.Convo[id] then
			ply.Convo[id] = nil;
			ply:PrintChat("Removed " .. name .. " from your conversation.");
		else
			ply.Convo[id] = true;
			ply:PrintChat("Added " .. name .. " to your conversation.");
		end

		netstream.Start(ply, "BASH_Convo", ply.Convo);
	else
		ply:PrintChat("You must be looking at a valid player to toggle them in your conversation!");
		return;
	end
end
concommand.Add("#!/toggleconv", ToggleConv);

local function ResetConv(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	ply.Convo = {};
	ply:PrintChat("Your conversation has been reset.");
	netstream.Start(ply, "BASH_Convo", {});
end
concommand.Add("#!/resetconv", ResetConv);

local function SetPassword(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local pass = args[1];
	if !pass then pass = "" end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 150;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);

	if trace.Entity:IsValid() and trace.Entity:GetClass() == "bash_storage" then
		trace.Entity:SetPassword(pass);
		if pass != "" then
			ply:PrintChat("Storage password set to " .. pass .. "!");
			MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has set a storage entity's (" .. trace.Entity.InventoryID .. ") password to " .. pass .. "!", true);
		else
			ply:PrintChat("Storage password cleared!");
			MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has cleared a storage entity's (" .. trace.Entity.InventoryID .. ") password!", true);
		end
	end
end
concommand.Add("#!/setpassword", SetPassword);

local function PMCharacter(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end
	if target == ply then
		ply:PrintChat("That's you, silly!");
		return;
	end

	if !args[2] or args[2] == "" then
		ply:PrintChat("You must enter a message to send!");
		return;
	end

	local toMessage = "[OOC-PM] TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	for index = 2, #args do
		toMessage = toMessage .. " " .. args[index];
	end

	local consoleMessage = "[OOC-PM] FROM " .. ply:GetEntry("Name") .. " (" .. target:Name() .. ") TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	local fromMessage = "[OOC-PM] FROM " .. ply:GetEntry("Name") .. " (" .. target:Name() .. "):";
	for index = 2, #args do
		consoleMessage = consoleMessage .. " " .. args[index];
		fromMessage = fromMessage .. " " .. args[index];
	end

	MsgCon(color_white, consoleMessage);
	netstream.Start(ply, "BASH_Return_Chat", {ply, toMessage, toMessage, CHAT_TYPES.PM.ID});
	netstream.Start(target, "BASH_Return_Chat", {ply, fromMessage, fromMessage, CHAT_TYPES.PM.ID});
end
concommand.Add("#!/pmc", PMCharacter);

local function PMPlayer(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	for _, _ply in pairs(player.GetAll()) do
		if _ply:GetEntry("CharLoaded") and string.find(_ply:Name(), target) then
			target = _ply;
			break;
		end
	end
	if isstring(target) then
		ply:PrintChat("Player '" .. args[1] .. "' not found.");
		return;
	end
	if target == ply then
		ply:PrintChat("That's you, silly!");
		return;
	end

	if !args[2] or args[2] == "" then
		ply:PrintChat("You must enter a message to send!");
		return;
	end

	local toMessage = "[OOC-PM] TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	for index = 2, #args do
		toMessage = toMessage .. " " .. args[index];
	end

	local consoleMessage = "[OOC-PM] FROM " .. ply:GetEntry("Name") .. " (" .. target:Name() .. ") TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	local fromMessage = "[OOC-PM] FROM " .. ply:GetEntry("Name") .. " (" .. target:Name() .. "):";
	for index = 2, #args do
		consoleMessage = consoleMessage .. " " .. args[index];
		fromMessage = fromMessage .. " " .. args[index];
	end

	MsgCon(color_white, consoleMessage);
	netstream.Start(ply, "BASH_Return_Chat", {ply, toMessage, toMessage, CHAT_TYPES.PM.ID});
	netstream.Start(target, "BASH_Return_Chat", {ply, fromMessage, fromMessage, CHAT_TYPES.PM.ID});
end
concommand.Add("#!/pmp", PMPlayer);

local function ConcMessage(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end
	if target == ply then
		ply:PrintChat("That's you, silly!");
		return;
	end

	if !args[2] or args[2] == "" then
		ply:PrintChat("You must enter a message to send!");
		return;
	end

	local toMessage = "[Conscience] TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	for index = 2, #args do
		toMessage = toMessage .. " " .. args[index];
	end

	local consoleMessage = "[Conscience] FROM " .. ply:GetEntry("Name") .. " (" .. target:Name() .. ") TO " .. target:GetEntry("Name") .. " (" .. target:Name() .. "):";
	local fromMessage = "[Conscience] ";
	for index = 2, #args do
		consoleMessage = consoleMessage .. " " .. args[index];
		fromMessage = fromMessage .. " " .. args[index];
	end

	MsgCon(color_white, consoleMessage);
	netstream.Start(ply, "BASH_Return_Chat", {ply, toMessage, toMessage, CHAT_TYPES.CONC.ID});
	netstream.Start(target, "BASH_Return_Chat", {ply, fromMessage, fromMessage, CHAT_TYPES.CONC.ID});
end
concommand.Add("#!/conc", ConcMessage);

local function PropDesc(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") or !ply:Alive() then return end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 150;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);

	if trace.Entity:IsValid() and trace.Entity:IsProp() then
		if trace.Entity:GetTable().OwnerID != ply:SteamID() then
			ply:PrintChat("You can't set the description for a prop you don't own!");
			return;
		end

		local desc = "";
		for index = 1, #args do
			if desc != "" then
				desc = desc .. " ";
			end

			desc = desc .. args[index];
		end

		trace.Entity:SetNWString("Description", desc);
		ply:PrintChat("Description for this prop set.");
	else
		ply:PrintChat("You must be looking at a prop to set its description!");
		return;
	end
end
concommand.Add("#!/propdesc", PropDesc);

local function SpawnStockpile(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;
	if !ply:Alive() then return end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 90;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);
	local itemPos = trace.HitPos;
	itemPos.z = itemPos.z + 6;

	local newEnt = ents.Create("bash_stockpile");
	newEnt:SetPos(itemPos);
	newEnt:SetAngles(Angle(0, 0, 0));
	newEnt:Spawn();
	newEnt:Activate();

	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has spawned a stockpile.", true);
	CommandPrint(ply:GetEntry("Name") .. " has spawned a stockpile!");
end
concommand.Add("#!/stockpile", SpawnStockpile);

local function AdminESP(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end
	if !ply:GetEntry("CharLoaded") then return end;

	local espOn = ply:GetEntry("AdminESP");
	ply:UpdateEntry("AdminESP", !espOn);
	local message = "on.";
	if espOn then
		message = "off.";
	end

	ply:PrintChat("Admin ESP turned " .. message);
end
concommand.Add("#!/esp", AdminESP);

local function PreRestart(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	MsgCon(color_red, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "] has initiated a pre-restart.");
	Broadcast(ply:GetEntry("Name") .. " has initiated a pre-restart. Kicking will start in ten seconds.");
	local delay = 10;

	for _, _ply in pairs(player.GetAll()) do
		if !ply != NULL and _ply:IsValid() and CheckPly(_ply) then
			timer.Simple(delay, function()
				_ply:Kick("Server restarting, please wait before rejoining");
			end);

			delay = delay + 0.5;
		end
	end
end
concommand.Add("#!/prerestart", PreRestart);

local function SetFaction(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local faction = args[2];
	if !faction or faction == "" then
		ply:PrintChat("You must enter a faction ID to set!");
		return;
	end

	if !BASH.Factions[faction] then
		ply:PrintChat("No faction with this ID found!");
		return;
	end

	target:UpdateEntry("Faction", faction);
	ply:PrintChat("You set " .. target:GetEntry("Name") .. "'s faction to '" .. faction .. "'.");
	target:PrintChat(ply:GetEntry("Name") .. " set your faction to '" .. faction .. "'.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has changed the faction of " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] to '" .. faction .. "'.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has changed the faction of " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] to '" .. faction .. "'.");
end
concommand.Add("#!/setfaction", SetFaction);

local function Language(ply, cmd, args, argStr)
	if !ply then return end;
	local lang = args[1];
	if string.len(lang) != 3 or !BASH.Quirks[lang] then
		ply:PrintChat("Invalid language ID!");
		return;
	end
	if !ply:HasQuirk(lang) then
		ply:PrintChat("You don't know this language!");
		return;
	end;

	local validCommands = {[3] = true, [4] = true, [5] = true, [12] = true, [13] = true, [14] = true}
	local command = args[2];
	local commandID, commandData;
	for _, cmd in pairs(CHAT_TYPES) do
		if cmd.Command then
			for _, keyword in pairs(cmd.Command) do
				if command == string.sub(keyword, 2) then
					commandID = cmd.ID;
					commandData = cmd;
					break;
				end
			end
		end
	end
	if !commandID or !commandData then
		commandID = 3;
		commandData = CHAT_TYPES.SAY;
	end
	if !validCommands[commandID] then
		ply:PrintChat("You may only speak, whisper, yell, and use the radio with the /lang command!");
		return;
	end

	local messageTab = string.Explode(" ", argStr);
	local message = "[" .. string.upper(lang) .. "] ";
	local jumbled = "[???] ";
	local console, jumbConsole = "", "";
	local start = (commandID == 3 and 2) or 3;
	if messageTab[start] then
		for index = start, #messageTab do
			message = message .. messageTab[index] .. " ";
		end
	else
		ply:PrintChat("You need to enter something to say!");
		return;
	end
	message = string.sub(message, 1, string.len(message) - 1);
	local char, rand = "", "";
	for index = 7, string.len(message) do
		if message[index] == " " then
			char = " ";
		else
			while rand == "" or tonumber(rand) do
				rand = table.Random(CHARACTERS);
			end
			char = rand;
		end
		jumbled = jumbled .. char;
		rand = "";
	end

	if commandData.Format then
		message, console = commandData.Format(ply, message);
		jumbled, jumbConsole = commandData.Format(ply, jumbled);
	end

	if commandData.Range then
		local recipients, jumbRecipients = {}, {};
		local nearby = ents.FindInSphere(ply:GetPos(), commandData.Range);
		for _, newPly in pairs(nearby) do
			if CheckPly(newPly) and CheckChar(newPly) then
				if newPly:HasQuirk(lang) then
					table.insert(recipients, newPly);
				else
					table.insert(jumbRecipients, newPly);
				end
			end
		end

		MsgCon(color_white, console, true);
		netstream.Start(recipients, "BASH_Return_Chat", {ply, message, console, commandID});
		netstream.Start(jumbRecipients, "BASH_Return_Chat", {ply, jumbled, jumbConsole, commandID});
	else
		commandData.Run(ply, message, lang, jumbled);
		return;
	end
end
concommand.Add("#!/lang", Language);

local function Roll(ply, cmd, args)
	if !CheckPly(ply) or !CheckChar(ply) or !ply:Alive() then return end;

	local maxRoll = tonumber(args[1] or 100);
	if maxRoll < 1 then
		ply:PrintChat("You can't roll for less than one!");
		return;
	end
	if maxRoll > 100000 then
		ply:PrintChat("You can't roll for more than 100,000!");
		return;
	end

	math.randomseed(SysTime());
	local roll = math.random(maxRoll + 1) - 1;
	local recipients = {};
	local ents = ents.FindInSphere(ply:GetPos(), 375);
	for index, ent in pairs(ents) do
		if CheckPly(ent) and CheckChar(ent) and !table.HasValue(recipients, ent) then
			table.insert(recipients, ent);
		end
	end

	local text = "**" .. ply:GetEntry("Name") .. " has rolled for " .. roll .. " out of " .. maxRoll .. ".**";
	MsgCon(color_white, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "] has rolled for " .. roll .. " out of " .. maxRoll .. ".", true);
	netstream.Start(recipients, "BASH_Return_Chat", {ply, text, text, 3});
end
concommand.Add("#!/roll", Roll);

local function GetScreencap(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	ply:PrintChat("Requesting a screencap of " .. target:GetEntry("Name") .. "'s screen.");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has requested a screencap of " .. target:GetEntry("Name") .. "'s [" .. target:Name() .. "/" .. target:SteamID() .. "] screen.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has requested a screencap of " .. target:GetEntry("Name") .. "'s [" .. target:Name() .. "/" .. target:SteamID() .. "] screen.");
	netstream.Start(target, "BASH_Request_Screencap");
end
concommand.Add("#!/screengrab", GetScreencap);

local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

function dec(data)
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

/*
net.Receive("BASH_Send_Screencap", function(len, ply)
	local screenSize = net.ReadInt(32);
	local screen = net.ReadData(screenSize);

	BASH:CreateDirectory("screencaps");
	local purgedName = string.Replace(ply:Name(), " ", "");
	local capID = RandomString(8);
	local fileName = BASH:GetSafeFilename("screencaps/" .. purgedName .. "-" .. capID);
	local screenCap = file.Open(fileName, "wb", "DATA");
	screenCap:Write(screen);
	screenCap:Close();
	MsgCon(color_green, "Screencap of " .. ply:GetEntry("Name") .. "'s [" .. ply:Name() .. "/" .. ply:SteamID() .. "] screen has been saved to the file '" .. fileName .. "'! Be sure to rename it to a .jpeg file before viewing.");
	CommandPrint("Screencap of " .. ply:GetEntry("Name") .. "'s [" .. ply:Name() .. "/" .. ply:SteamID() .. "] screen has been saved to the file '" .. fileName .. "'!");
end)
*/

net.Receive("BASH_Send_Screencap", function(len, ply)
	local steamID = ply:SteamID();
	local screenPart = net.ReadString();
	local isEnd = net.ReadBool();
	if !BASH.CacheScreens then BASH.CacheScreens = {} end;
	if !BASH.CacheScreens[steamID] then
		BASH.CacheScreens[steamID] = screenPart;
	else
		BASH.CacheScreens[steamID] = BASH.CacheScreens[steamID] .. screenPart;
	end
	if !isEnd then return end;

	BASH:CreateDirectory("screencaps");
	local purgedName = string.Replace(ply:Name(), " ", "");
	local capID = RandomString(8);
	local fileName = BASH:GetSafeFilename("screencaps/" .. purgedName .. "-" .. capID);
	local screenCap = file.Open(fileName, "wb", "DATA");
	screenCap:Write(dec(BASH.CacheScreens[steamID]));
	screenCap:Close();
	MsgCon(color_green, "Screencap of " .. ply:GetEntry("Name") .. "'s [" .. ply:Name() .. "/" .. ply:SteamID() .. "] screen has been saved to the file '" .. fileName .. "'! Be sure to rename it to a .jpeg file before viewing.");
	CommandPrint("Screencap of " .. ply:GetEntry("Name") .. "'s [" .. ply:Name() .. "/" .. ply:SteamID() .. "] screen has been saved to the file '" .. fileName .. "'!");
	BASH.CacheScreens[steamID] = nil;
end)

local function GetCharInfo(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	local info = "CHARACTER INFO: " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "]\n";
	info = info .. "Description: " .. target:GetEntry("Description") .. "\n";
	info = info .. "Base Model: " .. target:GetEntry("Model") .. "\n";
	info = info .. "Gender: " .. target:GetEntry("Gender") .. "\n";
	info = info .. "Faction: " .. target:GetEntry("Faction") .. "\n";
	info = info .. "Player Flags: " .. target:GetEntry("PlayerFlags") .. "\n";
	info = info .. "Character Flags: " .. target:GetEntry("CharFlags") .. "\n";
	info = info .. "Rubles: " .. target:GetEntry("Rubles") .. "\n";

	local suit, suitCond = ParseDouble(target:GetEntry("Suit"));
	if suit then
		info = info .. "Suit: " .. suit .. "\n";
	end
	if suitCond then
		info = info .. "Suit Condition: " .. suitCond .. "\n";
	end
	local acc = target:GetEntry("Acc");
	local accHasInv = true;
	if acc then
		info = info .. "Accessory: " .. acc .. "\n";
		local accData = BASH.Items[acc];
		if accData then
			if accData.NoInventory then accHasInv = false end;
		end
	end

	local weapons = target:GetEntry("Weapons");
	weapons = util.JSONToTable(weapons);
	info = info .. "Weapons:\n";
	local wepTable;
	for index, wep in pairs(weapons) do
		if wep.ID then
			wepTable = BASH.Items[wep.ID]
			if !wepTable then continue end;

			info = info .. "\t" .. wepTable.Name .. "\n";
			if wep.Condition then
				info = info .. "\t\tCondition: " .. wep.Condition .. "\n";
			end
			if wep.Ammo then
				info = info .. "\t\tAmmo: " .. wep.Ammo .. "\n";
			end
			if wep.Attachments then
				info = info .. "\t\tAttachments:\n";
				for ind, att in pairs(wep.Attachments) do
					local attData = BASH:FindAttByID((istable(att) and att.ent) or att);
					if !attData then continue end;
					info = info .. "\t\t\t" .. attData.Name .. "\n";
				end
			end
		end
	end

	local clothing = target:GetEntry("Clothing");
	clothing = util.JSONToTable(clothing);
	info = info .. "Clothing:\n";
	local articleData;
	for index, article in pairs(clothing) do
		articleData = BASH.Items[article];
		if !articleData then continue end;
		info = info .. "\t" .. articleData.Name .. "\n";
	end

	local arts = target:GetEntry("Artifacts");
	arts = util.JSONToTable(arts);
	info = info .. "Artifacts:\n";
	local artData;
	for index, art in pairs(arts) do
		local artData = BASH.Items[art];
		if !artData then continue end;
		info = info .. "\t" .. artData.Name .. "\n";
		if art.Purity then
			info = info .. "\t\tPurity: " .. art.Purity .. "\n";
		end
		if art.NameOverride then
			info = info .. "\t\tName Override: " .. art.NameOverride .. "\n";
		end
	end

	info = info .. "Inventory Items:\n";
	local invs = {"InvMain", "InvSec", "InvAcc"};
	local curInv, curItem, itemData;
	for _, inv in pairs(invs) do
		curInv = target:GetEntry(inv);
		curInv = util.JSONToTable(curInv);
		if inv == "InvAcc" and !accHasInv then continue end;

		for invX = 1, #curInv.Content do
			for invY = 1, #curInv.Content[1] do
				curItem = curInv.Content[invX][invY];
				if curItem.ID then
					itemData = BASH.Items[curItem.ID];
					if itemData then
						info = info .. "\t" .. itemData.Name .. "\n";
						if itemData.IsStackable and curItem.Stacks then
							info = info .. "\t\tStacks: " .. curItem.Stacks .. "\n";
						end
					end
				end
			end
		end
	end

	ply:PrintChat(target:GetEntry("Name") .. "'s info has been printed to console!");
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has requested character info about " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "].");
	netstream.Start(ply, "BASH_Request_Charinfo", info);
end
concommand.Add("#!/getcharinfo", GetCharInfo);

local function PhysgunBan(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	target:StripWeapon("weapon_physgun");
	BASH.PhysgunBlacklist[target:SteamID()] = true;
	ply:PrintChat(target:GetEntry("Name") .. " has been banned from using the physgun!");
	target:PrintChat("You've been banned from using the physgun by " .. ply:GetEntry("Name") .. "!");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has banned " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] from using the physgun.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has banned " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] from using the physgun.");
end
concommand.Add("#!/physgunban", PhysgunBan);

local function PhysgunBanID(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local banID = args[1];
	if !banID or banID == "" then
		ply:PrintChat("Enter a SteamID to ban from physgun access!");
		return;
	end

	local target = player.GetBySteamID(banID);
	if CheckPly(target) and CheckChar(target) then
		target:StripWeapon("weapon_physgun");
		target:PrintChat("You've been banned from using the physgun by " .. ply:GetEntry("Name") .. "!");
	end

	BASH.PhysgunBlacklist[banID] = true;
	ply:PrintChat(banID .. " has been banned from using the physgun!");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has banned " .. banID .. " from using the physgun.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has banned " .. banID .. " from using the physgun.");
end
concommand.Add("#!/physgunbanid", PhysgunBanID);

local function PhysgunUnban(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local target = args[1];
	if !target or target == "" then
		ply:PrintChat("Enter a character name to target!");
		return;
	end

	target = player.GetByInfo("Name", target);
	if !target then
		ply:PrintChat("Character '" .. args[1] .. "' not found.");
		return;
	end

	target:Give("weapon_physgun");
	BASH.PhysgunBlacklist[target:SteamID()] = nil;
	ply:PrintChat(target:GetEntry("Name") .. " has been granted physgun access!");
	target:PrintChat("You've been granted physgun access by " .. ply:GetEntry("Name") .. "!");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has granted " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] physgun access.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has granted " .. target:GetEntry("Name") .. " [" .. target:Name() .. "/" .. target:SteamID() .. "] physgun access.");
end
concommand.Add("#!/physgununban", PhysgunUnban);

local function PhysgunUnbanID(ply, cmd, args)
	if !ply then return end;
	if !ply:IsStaff() then
		ply:PrintChat("You can't do that!");
		return;
	end

	local banID = args[1];
	if !banID or banID == "" then
		ply:PrintChat("Enter a SteamID to grant physgun access!");
		return;
	end

	local target = player.GetBySteamID(banID);
	if CheckPly(target) and CheckChar(target) then
		target:Give("weapon_physgun");
		target:PrintChat("You've been granted physgun access by " .. ply:GetEntry("Name") .. "!");
	end

	BASH.PhysgunBlacklist[banID] = nil;
	ply:PrintChat(banID .. " has been granted physgun access!");
	MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has granted " .. banID .. " physgun access.", true);
	CommandPrint(ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has granted " .. banID .. " physgun access.");
end
concommand.Add("#!/physgununbanid", PhysgunUnbanID);

local function PatDown(ply, cmd, args)
	if !ply then return end;
	if !ply:GetEntry("CharLoaded") then return end;

	local traceTab = {};
	traceTab.start = ply:EyePos();
	traceTab.endpos = traceTab.start + ply:GetAimVector() * 150;
	traceTab.filter = ply;
	local trace = util.TraceLine(traceTab);

	if trace.Entity:IsValid() and trace.Entity:IsPlayer() and trace.Entity:GetEntry("CharLoaded") then
		if !ply.LastPatDown then
			ply.LastPatDown = 0;
		end
		if CurTime() - ply.LastPatDown < 10 then
			ply:PrintChat("Please wait a moment before requesting another a pat-down.");
			return;
		end

		ply:PrintChat("You've requested to pat-down " .. trace.Entity:GetEntry("Name") .. ".");
		ply.LastPatDown = CurTime();
		netstream.Start(trace.Entity, "BASH_Request_PatDown", ply);
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] is requesting to pat-down " .. trace.Entity:GetEntry("Name") .. " [" .. trace.Entity:Name() .. "/" .. trace.Entity:SteamID() .. "].", true);
	else
		ply:PrintChat("You must be looking at a valid player to pat down!");
		return;
	end
end
concommand.Add("#!/patdown", PatDown);
netstream.Hook("BASH_PatDown_Response", function(ply, data)
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	local response = data[1];
	local patter = data[2];
	if !CheckPly(patter) or !CheckChar(patter) then return end;

	if response then
		local patdown = "Items on " .. ply:GetEntry("Name") .. ":\n";

		local suit, suitCond = ParseDouble(ply:GetEntry("Suit"));
		local suitData = BASH.Items[suit];
		if suitData then
			patdown = patdown .. "Suit: " .. suitData.Name .. "\n";
		end
		if suitCond then
			patdown = patdown .. "\t" .. suitCond .. "%\n";
		end
		local acc = ply:GetEntry("Acc");
		local accData = BASH.Items[acc];
		local accHasInv = true;
		if accData then
			patdown = patdown .. "Accessory: " .. accData.Name .. "\n";
			if accData.NoInventory then accHasInv = false end;
		end

		local clothing = ply:GetEntry("Clothing");
		clothing = util.JSONToTable(clothing);
		patdown = patdown .. "Clothing:\n";
		local articleData;
		for index, article in pairs(clothing) do
			articleData = BASH.Items[article];
			if !articleData then continue end;
			patdown = patdown .. "\t" .. articleData.Name .. "\n";
		end

		patdown = patdown .. "Weapons:\n";
		local weps = ply:GetEntry("Weapons");
		weps = util.JSONToTable(weps);
		local wepData;
		for _, wep in pairs(weps) do
			if wep.ID then
				wepData = BASH.Items[wep.ID];
				if wepData then
					patdown = patdown .. "\t" .. wepData.Name .. "\n";
					patdown = patdown .. "\t\t" .. wep.Condition .. "%\n";
				end
			end
		end

		local arts = ply:GetEntry("Artifacts");
		arts = util.JSONToTable(arts);
		patdown = patdown .. "Artifacts:\n";
		local artData;
		for index, art in pairs(arts) do
			local artData = BASH.Items[art];
			if !artData then continue end;
			patdown = patdown .. "\t" .. artData.Name .. "\n";
		end

		patdown = patdown .. "Items:\n";
		local invs = {"InvMain", "InvSec", "InvAcc"};
		local curInv, curItem, itemData;
		for _, inv in pairs(invs) do
			curInv = ply:GetEntry(inv);
			curInv = util.JSONToTable(curInv);
			if inv == "InvAcc" and !accHasInv then continue end;

			for invX = 1, #curInv.Content do
				for invY = 1, #curInv.Content[1] do
					curItem = curInv.Content[invX][invY];
					if curItem.ID then
						itemData = BASH.Items[curItem.ID];
						if itemData then
							patdown = patdown .. "\t" .. itemData.Name .. "\n";
							if itemData.IsStackable and curItem.Stacks then
								patdown = patdown .. "\t\tStacks: " .. curItem.Stacks .. "\n";
							end
						end
					end
				end
			end
		end

		patter:PrintChat("You've successfully patted " .. ply:GetEntry("Name") .. " down! Check your developer console (~) for their items.");
		ply:PrintChat("You've been patted down by " .. patter:GetEntry("Name") .. ".");
		netstream.Start(patter, "BASH_Send_PatDown", patdown);
	else
		patter:PrintChat(ply:GetEntry("Name") .. " has denied your request for a pat-down!");
		MsgCon(color_green, ply:GetEntry("Name") .. " [" .. ply:Name() .. "/" .. ply:SteamID() .. "] has denied a pat-down request from " .. patter:GetEntry("Name") .. " [" .. patter:Name() .. "/" .. patter:SteamID() .. "].", true);
	end
end);

/*
local function FixMemoryCrash(ply, cmd, args)
	local db = BASH.DB;
	local getAllData = db:query("SELECT CharID, Name, InvMain, InvSec, InvAcc FROM BASH_characters;");
	getAllData:start();

	function getAllData:onSuccess(data)
		local existantPDAs = {};
		local existantSIMs = {};
		local dupedPDAs = {};
		local dupedSIMs = {};

		local updateChar = false;
		for index, char in pairs(data) do
			MsgCon(color_green, "Fixing empty PDA data for: " .. char.Name);

			local invMain = util.JSONToTable(char.InvMain);
			for invX = 1, #invMain.Content do
				for invY = 1, #invMain.Content[1] do
					local curItem = invMain.Content[invX][invY];
					if !curItem.ID then continue end;

					if curItem.ID == "pda_stalker" then
						PrintTable(curItem);

						if curItem.MemorySlot and curItem.MemorySlot != "" then
							if !existantPDAs[curItem.MemorySlot] then
								existantPDAs[curItem.MemorySlot] = true;
							else
								dupedPDAs[curItem.MemorySlot] = true;
								invMain.Content[invX][invY] = {};
								updateChar = true;
							end

							if !BASH.PDAData[curItem.MemorySlot] then
								BASH:NewPDAData(curItem.MemorySlot);
							end
						end

						if curItem.SIMCardSlot and curItem.SIMCardSlot != "" then
							if !existantSIMs[curItem.SIMCardSlot] then
								existantSIMs[curItem.SIMCardSlot] = true;
							else
								dupedSIMs[curItem.SIMCardSlot] = true;
								invMain.Content[invX][invY] = {};
								updateChar = true;
							end

							if !BASH.SIMData[curItem.SIMCardSlot] then
								BASH:NewSIMCardData(curItem.SIMCardSlot);
							end
						end
					elseif curItem.ID == "sim_mini" then
						PrintTable(curItem);

						if !existantSIMs[curItem.ICCID] then
							existantSIMs[curItem.ICCID] = true;
						else
							dupedSIMs[curItem.ICCID] = true;
							invMain.Content[invX][invY] = {};
							updateChar = true;
						end

						if curItem.ICCID and curItem.ICCID != "" then
							if !BASH.SIMData[curItem.ICCID] then
								BASH:NewSIMCardData(curItem.ICCID);
							end
						end
					end
				end
			end

			local invSec = util.JSONToTable(char.InvSec);
			if invSec.Content then
				for invX = 1, #invSec.Content do
					for invY = 1, #invSec.Content[1] do
						local curItem = invSec.Content[invX][invY];
						if !curItem.ID then continue end;

						if curItem.ID == "pda_stalker" then
							PrintTable(curItem);

							if curItem.MemorySlot and curItem.MemorySlot != "" then
								if !existantPDAs[curItem.MemorySlot] then
									existantPDAs[curItem.MemorySlot] = true;
								else
									dupedPDAs[curItem.MemorySlot] = true;
									invSec.Content[invX][invY] = {};
									updateChar = true;
								end

								if !BASH.PDAData[curItem.MemorySlot] then
									BASH:NewPDAData(curItem.MemorySlot);
								end
							end

							if curItem.SIMCardSlot and curItem.SIMCardSlot != "" then
								if !existantSIMs[curItem.SIMCardSlot] then
									existantSIMs[curItem.SIMCardSlot] = true;
								else
									dupedSIMs[curItem.SIMCardSlot] = true;
									invSec.Content[invX][invY] = {};
									updateChar = true;
								end

								if !BASH.SIMData[curItem.SIMCardSlot] then
									BASH:NewSIMCardData(curItem.SIMCardSlot);
								end
							end
						elseif curItem.ID == "sim_mini" then
							PrintTable(curItem);

							if !existantSIMs[curItem.ICCID] then
								existantSIMs[curItem.ICCID] = true;
							else
								dupedSIMs[curItem.ICCID] = true;
								invSec.Content[invX][invY] = {};
								updateChar = true;
							end

							if curItem.ICCID and curItem.ICCID != "" then
								if !BASH.SIMData[curItem.ICCID] then
									BASH:NewSIMCardData(curItem.ICCID);
								end
							end
						end
					end
				end
			end

			local invAcc = util.JSONToTable(char.InvAcc);
			if invAcc.Content then
				for invX = 1, #invAcc.Content do
					for invY = 1, #invAcc.Content[1] do
						local curItem = invAcc.Content[invX][invY];
						if !curItem.ID then continue end;

						if curItem.ID == "pda_stalker" then
							PrintTable(curItem);

							if curItem.MemorySlot and curItem.MemorySlot != "" then
								if !existantPDAs[curItem.MemorySlot] then
									existantPDAs[curItem.MemorySlot] = true;
								else
									dupedPDAs[curItem.MemorySlot] = true;
									invAcc.Content[invX][invY] = {};
									updateChar = true;
								end

								if !BASH.PDAData[curItem.MemorySlot] then
									BASH:NewPDAData(curItem.MemorySlot);
								end
							end

							if curItem.SIMCardSlot and curItem.SIMCardSlot != "" then
								if !existantSIMs[curItem.SIMCardSlot] then
									existantSIMs[curItem.SIMCardSlot] = true;
								else
									dupedSIMs[curItem.SIMCardSlot] = true;
									invAcc.Content[invX][invY] = {};
									updateChar = true;
								end

								if !BASH.SIMData[curItem.SIMCardSlot] then
									BASH:NewSIMCardData(curItem.SIMCardSlot);
								end
							end
						elseif curItem.ID == "sim_mini" then
							PrintTable(curItem);

							if !existantSIMs[curItem.ICCID] then
								existantSIMs[curItem.ICCID] = true;
							else
								dupedSIMs[curItem.ICCID] = true;
								invAcc.Content[invX][invY] = {};
								updateChar = true;
							end

							if curItem.ICCID and curItem.ICCID != "" then
								if !BASH.SIMData[curItem.ICCID] then
									BASH:NewSIMCardData(curItem.ICCID);
								end
							end
						end
					end
				end
			end

			if updateChar then
				invMain = util.TableToJSON(invMain);
				invSec = util.TableToJSON(invSec);
				invAcc = util.TableToJSON(invAcc);

				local updateDupes = db:query("UPDATE BASH_characters SET InvMain = \'" .. invMain .. "\', InvSec = \'" .. invSec .. "\', InvAcc = \'" .. invAcc .. "\' WHERE CharID = \'" .. char.CharID .. "\';");
				updateDupes:start();

				function updateDupes:onSuccess(data)
					MsgCon(color_green, "Updated duped items for: " .. char.Name);
				end

				function updateDupes:onError(err, sql)
					MsgCon(color_red, "ERROR!");
					MsgCon(color_red, err);
				end
			end

			updateChar = false;
		end

		MsgN("Duped PDAs:");
		PrintTable(dupedPDAs);
		MsgN("");
		MsgN("Duped SIMs:");
		PrintTable(dupedSIMs);
	end

	function getAllData:onError(err, sql)
		MsgCon(color_red, "ERROR!");
		MsgCon(color_red, err);
		MsgCon(color_red, sql);
	end
end
concommand.Add("fixmemcrash", FixMemoryCrash);
*/
