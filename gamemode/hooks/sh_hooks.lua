local BASH = BASH;

gameevent.Listen("player_connect");
hook.Add("player_connect", "bash_player_connect", function(data)
	if tobool(data.bot) then return end;
	local name = data.name;
	local steamID = data.networkid;
	local ip = data.address;
	Broadcast(name .. " has connected.");
	MsgCon(color_blue, name .. " [" .. steamID .. " / " .. ip .. "] has connected.", true);
end);

gameevent.Listen("player_disconnect");
hook.Add("player_disconnect", "bash_player_disconnect", function(data)
	if tobool(data.bot) then return end;
	local name = data.name;
	local steamID = data.networkid;
	local reason = data.reason;
	local text = name .. " [" .. steamID .. "] has disconnected. (" .. reason .. ")";

	MsgCon(color_blue, text, true);
end);

/*
function BASH:PlayerConnect(name, ip)
	if CLIENT then
		LocalPlayer():PrintChat(name .. " has connected.");
	elseif SERVER then
		MsgCon(color_blue, name .. " [" .. ip .. "] has connected.", true);
	end
end
*/

hook.Add("OnFlagsChanged", "ChangeFlagTools", function(ply, flags)
	if string.find(flags, "t") or ply:IsStaff() then
		ply:Give("gmod_tool");
	elseif ply:GetWeapon("gmod_tool") then
		ply:StripWeapon("gmod_tool");
	end

    if string.find(flags, "u") or ply:IsStaff() then
		ply:UpdateEntry("MaxProps", 99999);
	elseif string.find(flags, "y") then
		ply:UpdateEntry("MaxProps", 50);
	else
		ply:UpdateEntry("MaxProps", 20);
	end

	if string.find(flags, "d") then
		ply:UpdateEntry("Rank", "Director");
	elseif string.find(flags, "a") then
		ply:UpdateEntry("Rank", "Admin");
	elseif string.find(flags, "q") then
		ply:UpdateEntry("Rank", "Trial Admin");
	elseif string.find(flags, "e") then
		ply:UpdateEntry("Rank", "Event Coord.");
	elseif string.find(flags, "g") then
		ply:UpdateEntry("Rank", "Volunteer");
	else
		ply:UpdateEntry("Rank", "Player");
	end
end);

//	PAC3 Stuff
hook.Add("PrePACEditorOpen", "RestrictPACFlags", function(ply)
    if !ply:IsStaff() and !ply:HasFlag("f") then
		ply:PrintChat("You can't do that!");
        return false;
    end
end);

function BASH:PhysgunPickup(ply, ent)
	if ply:IsStaff() and (ent:IsPlayer() or ent:IsItem() or ent:IsVehicle()) then
		if ent:IsPlayer() then
			ent:SetNotSolid(true);
			ent:SetMoveType(MOVETYPE_NOCLIP);
		end
		return true;
	end
	if ent:GetClass() == "bash_stockpile" and ply:IsStaff() then return true end;

	if ent:IsItem() then
		return ply:GetPos():Distance(ent:GetPos()) < 90;
	end

	if ent:IsProp() and ent.OwnerID and ent.OwnerID != ply:SteamID() and !ply:IsStaff() then return false end;

	if ent:IsDoor() then return false end;
	if ent:IsProp() then return true end;
end

function BASH:PhysgunDrop(ply, ent)
	if ply:IsStaff() and ent:IsPlayer() then
		ent:SetNotSolid(false);
		ent:SetMoveType(MOVETYPE_WALK);
	end
end

function BASH:PlayerNoClip(ply, state)
	return false;
end

function BASH:CanTool(ply, trace, tool)
	if tool == "remover" and trace.Entity:IsValid() and trace.Entity:IsDoor() then
		return false;
	end
	if tool == "remover" and trace.Entity.Owner and trace.Entity.Owner:IsValid() and trace.Entity.OwnerID != ply:SteamID() and !ply:IsStaff() then
		return false;
	end

	return true;
end

function BASH:CanProperty(ply, property, ent)
	if property == "bash_lootspawn" then
		return ply:IsStaff();
	end

	return true;
end

function BASH:CanDrive(ply, ent)
	return false;
end

function BASH:EntityRemoved(ent)
	if !ent or !ent:IsValid() then return end;
	if !ent.Owner or !CheckPly(ent.Owner) then return end;
	if !ent:IsProp() then return end;
	if ent:GetTable().IsDeathRagdoll then return end;

	local props = ent.Owner:GetEntry("Props");
	if !props then return end;
	ent.Owner:UpdateEntry("Props", props - 1);
end
