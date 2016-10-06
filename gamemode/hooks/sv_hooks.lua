local BASH = BASH;

hook.Add("ShutDown", "SaveChars", function()
	local delay = 0.001;
	local players = player.GetAll();
	for _, ply in pairs(players) do
		if ply:GetEntry("CharLoaded") then
			ply:SQLUpdate();
		end
	end

	MsgCon(color_green, "***** SERVER SHUTDOWN *****", true);
end);

function BASH:PlayerAuthed(ply, steamID, uniqueID)
	if ply:IsBot() then return end;

	ply:SuppressHint("HintSystem_OpeningMenu");
	ply:SuppressHint("HintSystem_Annoy1");
	ply:SuppressHint("HintSystem_Annoy2");

	/*
	timer.Simple(1, function()
		ply:SQLInit();
	end);
	*/
end

function BASH:PlayerDisconnected(ply)
	if ply:IsBot() then return end;
	if !ply.SQLInitDone then return end;
	if !ply.InitDone then return end;
	if !CheckPly(ply) then return end;

	local weps = ply:GetEntry("Weapons");
	if weps then							// Some weird disconnect bug?
		weps = util.JSONToTable(weps) or {};
		for index, wep in pairs(weps) do
			if wep.ID and wep.ID != "" then
				local wepData = self.Items[wep.ID];
				local wepEnt = ply:GetWeapon(wepData.WeaponEntity);
				if wepData and wepEnt:IsValid() then
					wep.Ammo = wepEnt:Clip1();
				end
			end
		end
		weps = util.TableToJSON(weps);
		ply:UpdateEntry("Weapons", weps);
	end

	if ply:GetTable().Ragdoll and ply:GetTable().Ragdoll:IsValid() then
		ply:GetTable().Ragdoll:Remove();
		ply:GetTable().Ragdoll = nil;
	end

	ply.Disconnecting = true;
	ply:SQLUpdate();
end

function BASH:PlayerSpawn(ply)
	if !ply.Initialized then
		ply:Initialize();
		return;
	end

	ply:GodDisable();
	ply:SetTeam(1);
	ply:UnSpectate();
	ply:UnLock();
	ply:SetCanZoom(false);
	ply:StripWeapons();
	ply:StripAmmo();

	local faction = ply:GetEntry("Faction");
	local map = game.GetMap();
	if self["spawn_" .. faction] then
		ply:SetPos(self["spawn_" .. faction]);
	elseif self[map].Spawns[faction] then
		ply:SetPos(self[map].Spawns[faction]);
	end

	ply:Give("bash_wep_hands");
	if !self.PhysgunBlacklist[ply:SteamID()] then
		ply:Give("weapon_physgun");
	end
	if ply:HasFlag("t") or ply:IsStaff() then
		ply:Give("gmod_tool");
	end

	local flags = ply:GetEntry("CharFlags") .. ply:GetEntry("PlayerFlags");
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
	elseif string.find(flags, "g") then
		ply:UpdateEntry("Rank", "Volunteer");
	else
		ply:UpdateEntry("Rank", "Player");
	end

	ply:ReformatWeapons();
	local weps = ply:GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	local delay = 0.1;
	for index, wep in pairs(weps) do
		if wep.ID and wep.ID != "" then
			local wepData = self.Items[wep.ID];
			if wepData then
				timer.Simple(delay, function()
					ply:Give(wepData.WeaponEntity);
					local wepEnt = ply:GetWeapon(wepData.WeaponEntity);
					wepEnt:SetClip1(wep.Ammo);
				end);
				delay = delay + 0.001;
			end
		end
	end

	ply:UpdateEntry("Radiation", 0);

	local predicted = ply:CalculateQuirkEffects();
	ply:UpdateEntry("MaxHealth", predicted.MaxHealth);
	ply:SetHealth(predicted.MaxHealth);
	ply:UpdateEntry("HealthRegen", predicted.HealthRegen);
	ply:UpdateEntry("MaxWeight", predicted.MaxWeight);

	ply:SetWalkSpeed(140);
	ply:SetCrouchedWalkSpeed(50);
	netstream.Start(ply, "BASH_Reset_Stamina");

	if ply:GetTable().Ragdoll and ply:GetTable().Ragdoll:IsValid() then
		ply:GetTable().Ragdoll:Remove();
		ply:GetTable().Ragdoll = nil;
	end

	if faction == "mutant" then
		local model = string.sub(ply:GetModel(), 19);
		if string.sub(model, 1, 11) == "bloodsucker" then
			ply:SetWalkSpeed(100);
			ply:SetCrouchedWalkSpeed(50);
			ply:SetRunSpeed(150);
		elseif string.sub(model, 1, 4) == "boar" then
			ply:SetWalkSpeed(100);
			ply:SetCrouchedWalkSpeed(75);
			ply:SetRunSpeed(175);
		elseif string.sub(model, 1, 6) == "zombie" then
			ply:SetWalkSpeed(75);
			ply:SetCrouchedWalkSpeed(50);
			ply:SetRunSpeed(175);
		elseif string.sub(model, 1, 3) == "dog" then
			ply:SetWalkSpeed(100);
			ply:SetCrouchedWalkSpeed(50);
		elseif string.sub(model, 1, 11) == "pseudogiant" then
			ply:SetWalkSpeed(100);
			ply:SetRunSpeed(100);
		elseif string.sub(model, 1, 6) == "rodent" then
			ply:SetWalkSpeed(100);
			ply:SetRunSpeed(175);
		elseif string.sub(model, 1, 5) == "snork" then
			ply:SetWalkSpeed(140);
			ply:SetRunSpeed(260);
		end
	end

	//ply:SetupHands();
end

/*
function BASH:PlayerSetHandsModel(ply, ent)
	local simplemodel = player_manager.TranslateToPlayerModelName(ply:GetModel());
	local info = player_manager.TranslatePlayerHands(simplemodel);
	if info then
		ent:SetModel(info.model);
		ent:SetSkin(info.skin);
		ent:SetBodyGroups(info.body);
	end
end
*/

function BASH:Think()
	for _, ply in pairs(player.GetAll()) do
		if CheckPly(ply) and CheckChar(ply) then
			if ply:Alive() then
				if ply:GetEntry("Faction") != "mutant" then
					if ply:GetEntry("Weight") > ply:GetEntry("MaxWeight") and ply:GetWalkSpeed() != 0 then
						ply:SetWalkSpeed(1);
						ply:SetRunSpeed(1);
					elseif ply:GetEntry("Weight") <= ply:GetEntry("MaxWeight") and ply:GetWalkSpeed() != 140 then
						ply:SetWalkSpeed(140);
						ply:SetRunSpeed(260);
					end

					local stamina = ply:GetEntry("Stamina");
					if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 60 and ply:IsOnGround() and !ply:InVehicle() and !ply:GetEntry("Observing") then
						if stamina >= 10 then
							if ply:GetRunSpeed() != 320 then
								ply:SetRunSpeed(260);
							end
						else
							ply:SetRunSpeed(ply:GetWalkSpeed());
						end
					end
				end

				local maxHP = ply:GetEntry("MaxHealth");
				if ply:Health() > maxHP then
					ply:SetHealth(maxHP);
				end

				ply.LastHealthRegen = ply.LastHealthRegen or CurTime();
				if CurTime() - ply.LastHealthRegen > 20 then
					local health = ply:Health();
					local maxHealth = ply:GetEntry("MaxHealth");
					local healthRegen = ply:GetEntry("HealthRegen");
					health = math.Clamp(health + healthRegen, 0, maxHealth);
					ply:SetHealth(health);
					ply.LastHealthRegen = CurTime();
				end

				local drunk = ply:GetEntry("DrunkMul");
				if drunk > 0 then
					if !ply.LastSober then
						ply.LastSober = 0;
					end

					if CurTime() - ply.LastSober > 60 then
						ply:UpdateEntry("DrunkMul", math.Clamp(drunk - 10, 0, 100));
						ply.LastSober = CurTime();
					end
				end

				local wep = ply:GetActiveWeapon();
				if ply:GetTable().HandPickUpSent and ply:GetTable().HandPickUpSent:IsValid() and wep:GetClass() != "bash_wep_hands" then
					ply:GetTable().HandPickUpSent:Remove();
					ply:GetTable().HandPickUpSent = nil;
				end
			else
				if ply:GetTable().HandPickUpSent and ply:GetTable().HandPickUpSent:IsValid() then
					ply:GetTable().HandPickUpSent:Remove();
					ply:GetTable().HandPickUpSent = nil;
				end
			end
		end
	end
end

function BASH:PlayerShouldTakeDamage(victim, attacker)
	if attacker:IsProp() then return false end;
	if attacker:IsItem() then return false end;
	if attacker:IsDoor() then return false end;

	return true;
end

function BASH:EntityTakeDamage(target, dmg)
	if CheckPly(target) and CheckChar(target) then
		target.LastHealthRegen = CurTime();
	end
end

function BASH:ScalePlayerDamage(ply, hitgroup, dmg)
	if CheckPly(ply) and CheckChar(ply) then
		local attacker = dmg:GetAttacker();
		if attacker:IsPlayer() and attacker:GetActiveWeapon() and attacker:GetActiveWeapon().IsBASHWeapon and attacker:GetActiveWeapon().OOCFireMode == "strp" then return end;

		local dampener = 0;
		local suit, cond = ParseDouble(ply:GetEntry("Suit"));
		if suit != "" then
			local suitData = self.Items[suit];
			if hitgroup == HITGROUP_HEAD then
				dampener = dampener + (suitData.HelmetArmor * (cond / 100));
			else
				dampener = dampener + (suitData.BodyArmor * (cond / 100));
			end
		end
		local acc = ply:GetEntry("Acc");
		if acc != "" then
			local accData = self.Items[acc];
			if hitgroup == HITGROUP_HEAD then
				dampener = dampener + accData.HelmetArmor;
			else
				dampener = dampener + accData.BodyArmor;
			end
		end
		local arts = ply:GetEntry("Artifacts");
		arts = util.JSONToTable(arts);
		for index, art in pairs(arts) do
			if art and art.ID then
				local artData = self.Items[art.ID];
				if hitgroup != HITGROUP_HEAD then
					dampener = dampener + (artData.ArmorBoost * (art.Purity / 100));
				end
			end
		end

		local damage = dmg:GetDamage();
		damage = damage - (math.Clamp(dampener / damage, 0, 1) * (damage / 1.25));
		dmg:SetDamage(math.Clamp(damage, 0, 999999));
	end
end

function BASH:GetFallDamage(ply, speed)
	return speed / 10;
end

function BASH:AllowPlayerPickup(ply, ent)
	return false;
end

function BASH:OnPhysgunFreeze(weapon, phys, ent, ply)
	if !ent:IsProp() then return false end;
	if ent:GetTable().OwnerID != ply:SteamID() and !ply:IsStaff() then return false end;

	phys:EnableMotion(false);
	ply:AddFrozenPhysicsObject(ent, phys);
	return true;
end

function BASH:DoPlayerDeath(ply, attacker, dmg)
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	local weps = ply:GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	for index, wep in pairs(weps) do
		if wep and wep.ID then
			local wepData = self.Items[wep.ID];
			local wepEnt = ply:GetWeapon(wepData.WeaponEntity);
			weps[index].Ammo = 0;
			weps[index].Condition = math.Round(weps[index].Condition * 0.75, 1);
		end
	end

	weps = util.TableToJSON(weps);
	ply:UpdateEntry("Weapons", weps);

	local suit, cond = ParseDouble(ply:GetEntry("Suit"));
	if suit != "" then
		cond = math.Round(cond * 0.75, 1);
		ply:UpdateEntry("Suit", suit .. ";" .. cond);
	end

	local ragdoll = ents.Create("prop_ragdoll");
	ragdoll:SetPos(ply:GetPos());
	ragdoll:SetAngles(ply:GetAngles());
	ragdoll:SetModel(ply:GetModel());
	ragdoll:SetOwner(ply);
	ragdoll:Spawn();
	ragdoll.IsDeathRagdoll = true;

	local objects = ragdoll:GetPhysicsObjectCount();
	local vel = ply:GetVelocity();

	for index = 1, objects do
		local bone = ragdoll:GetPhysicsObjectNum(index);
		if bone and bone:IsValid() then
			local bonepos, boneang = ply:GetBonePosition(ragdoll:TranslatePhysBoneToBone(index));
			if bonepos and boneang then
				bone:SetPos(bonepos);
			end
			bone:AddVelocity(vel);
		end
	end

	ply:Spectate(OBS_MODE_CHASE);
	ply:SpectateEntity(ragdoll);
	ply:GetTable().Ragdoll = ragdoll;
end

function BASH:PlayerSpawnSENT(ply, class)
	return ply:IsStaff();
end

function BASH:PlayerSpawnEffect(ply, model)
	return ply:IsStaff();
end

function BASH:PlayerSpawnNPC(ply, npc, weapon)
	return ply:IsStaff() or ply:HasFlag("n");
end

function BASH:PlayerSpawnVehicle(ply, model, name, tab)
	return ply:IsStaff() or ply:HasFlag("v");
end

function BASH:PlayerGiveSWEP(ply, class, info)
	return ply:IsStaff();
end

local badProps = {
	["models/props_canal/bridge_pillar02.mdl"] = true,
	["models/props_canal/canal_bridge01.mdl"] = true,
	["models/props_canal/canal_bridge02.mdl"] = true,
	["models/props_canal/canal_bridge02.mdl"] = true,
	["models/props_canal/canal_bridge03b.mdl"] = true,
	["models/props_canal/canal_bridge04.mdl"] = true,
	["models/props_c17/oildrum001_explosive.mdl"] = true,
	["models/Cranes/crane_frame.mdl"] = true,
	["models/Gibs/helicopter_brokenpiece_06_body.mdl"] = true,
	["models/Gibs/helicopter_brokenpiece_05_tailfan.mdl"] = true,
	["models/Gibs/helicopter_brokenpiece_04_cockpit.mdl"] = true,
	["models/props_combine/combine_intmonitor001.mdl"] = true,
	["models/props_combine/combine_interface001.mdl"] = true,
	["models/props_combine/combine_monitorbay.mdl"] = true,
	["models/props_combine/CombineThumper001a.mdl"] = true,
	["models/props_combine/CombineThumper002.mdl"] = true,
	["models/props_combine/combinetower001.mdl"] = true,
	["models/props_combine/health_charger001.mdl"] = true,
	["models/props_combine/suit_charger001.mdl"] = true,
	["models/Combine_Helicopter.mdl"] = true,
	["models/Combine_dropship.mdl"] = true,
	["models/combine_apc.mdl"] = true,
	["models/props_combine/combine_train02a.mdl"] = true,
	["models/props_combine/combine_train02b.mdl"] = true,
	["models/props_combine/CombineTrain01a.mdl"] = true,
	["models/props_trainstation/train005.mdl"] = true
};
function BASH:PlayerSpawnProp(ply, model)
	if !CheckPly(ply) or !CheckChar(ply) then return false end;
	if !ply:Alive() then return false end;

	if badProps[model] and !ply:IsStaff() then
		ply:PrintChat("This prop has been blacklisted! Ask a staff member to spawn it.");
		return false;
	end

	if !ply.LastSpawn then
		ply.LastSpawn = 0;
	end

	if CurTime() - ply.LastSpawn < 3 then
		if !AdvDupe or !AdvDupe[ply] or !AdvDupe[ply].Pasting then
			ply:PrintChat("Please wait a moment before spawning another prop.");
			return false;
		end
	end

	if ply:GetEntry("Props") >= ply:GetEntry("MaxProps") then
		ply:PrintChat("You've spawned your max amount of props! (" .. ply:GetEntry("MaxProps") .. ")");
		return false;
	end

	return true;
end

function BASH:PlayerSpawnRagdoll(ply, model)
	if ply:IsStaff() or ply:HasFlag("r") then
		if !ply.LastSpawn then
			ply.LastSpawn = 0;
		end

		if CurTime() - ply.LastSpawn < 3 then
			if !AdvDupe or !AdvDupe[ply] or !AdvDupe[ply].Pasting then
				ply:PrintChat("Please wait a moment before spawning another prop.");
				return false;
			end
		end

		if ply:GetEntry("Props") >= ply:GetEntry("MaxProps") then
			ply:PrintChat("You've spawned your max amount of props! (" .. ply:GetEntry("MaxProps") .. ")");
			return false;
		end

		return true;
	end

	return false;
end

function BASH:PlayerSpawnedSENT(ply, ent)
	if !ent or !ent:IsValid() then return end;
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	MsgCon(color_green, "[SENT] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. ") spawned SENT: " .. ent:GetClass(), true);
end

function BASH:PlayerSpawnedProp(ply, model, ent)
	if !ent or !ent:IsValid() then return end;
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	if (!ply:HasFlag("u") and !ply:IsStaff()) and ent:GetPhysicsObject():GetMass() > 600 then
		ply:PrintChat("That prop is too big!");
		ent:Remove();
		return;
	end

	local props = ply:GetEntry("Props");
	ply:UpdateEntry("Props", props + 1);

	ent.Owner = ply;
	ent.OwnerID = ply:SteamID();
	ent:SetNWString("UseString", "Spawned by " .. ply:GetEntry("Name") .. " (" .. ply:SteamID() .. ")");
	ply.LastSpawn = CurTime();

	MsgCon(color_green, "[PROP] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. ") spawned prop: " .. model, true);
end

function BASH:PlayerSpawnedRagdoll(ply, model, ent)
	if !ent or !ent:IsValid() then return end;
	if !CheckPly(ply) or !CheckChar(ply) then return end;

	if !ply:IsStaff() and !ply:HasFlag("u") and ent:GetPhysicsObject():GetMass() > 400 then
		ply:PrintChat("That prop is too big!");
		return;
	end

	local props = ply:GetEntry("Props");
	ply:UpdateEntry("Props", props + 1);

	ent.Owner = ply;
	ent.OwnerID = ply:SteamID();
	ent:SetNWString("UseString", "Spawned by " .. ply:GetEntry("Name") .. " (" .. ply:SteamID() .. ")");
	ply.LastSpawn = CurTime();

	MsgCon(color_green, "[RAGDOLL] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. ") spawned ragdoll: " .. model, true);
end

function BASH:PlayerSwitchFlashlight(ply, enabled)
	return ply:HasItem("flashlight");
end

//	PAC3 Stuff
hook.Add("PrePACConfigApply", "RestrictPAC", function(ply, outfit)
    if !ply:IsStaff() and !ply:HasFlag("f") then
        return false, "";
    end
end)

netstream.Hook("BASH_Check_Crash", function(ply, data)
	if !CheckPly(ply) then return end;
	if !data then return end;
	if data != "cleared" then return end;
	netstream.Start(ply, "BASH_Check_Crash_Return", data);
end);
