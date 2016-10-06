local BASH = BASH;

local function AddArtifactProperties(itemData, args, ent)
	if !itemData.IsArtifact then return end;

	if ent and ent:IsValid() then
		ent:GetTable().Purity = args[1];
		ent:GetTable().NameOverride = args[2];
		return true;
	else
		local newItemTab = {};
		if itemData.IsArtifact then
			newItemTab.Purity = args[1];
			newItemTab.NameOverride = args[2];
		end
		return newItemTab;
	end
end
hook.Add("AddItemProperties", "AddArtifactProperties", AddArtifactProperties);

local function GetArtifactProperties(itemData, entData)
	if !itemData.IsArtifact then return end;

	local args = {};
	if itemData.IsArtifact then
		if entData then
			args[1] = entData.Purity;
			args[2] = entData.NameOverride;
		else
			local rarity = itemData.Tier;
			args[1] = (((rarity) / 5) * math.random(((rarity) / 5) * 60, 100));
			args[2] = "";
		end
	end
	return args;
end
hook.Add("GetItemProperties", "GetArtifactProperties", GetArtifactProperties);

hook.Add("PlayerSpawn", "ArtifactReformatOnSpawn", function(ply)
	if !ply.Initialized then return end;

	ply:ReformatArtifacts();
end);

hook.Add("Think", "ArtifactHandleRads", function()
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) and ply:Alive() then
			if !ply.LastArtThink then
				ply.LastArtThink = 0
			end
			if CurTime() - ply.LastArtThink > 10 then
				if ply:GetEntry("Radiation") >= 50 then
					local ratio = (ply:GetEntry("Radiation") - 50) / 50;
					ply:SetHealth(ply:Health() - (ratio * 8));
					if ply:Health() <= 0 then
						ply:Kill();
					end
				end
				ply.LastArtThink = CurTime();
			end
		end
	end
end);
