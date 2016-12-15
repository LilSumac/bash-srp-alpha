local BASH = BASH;
local Player = FindMetaTable("Player");

if !mysqloo then
	require("mysqloo");
end

function BASH:SQLInit()
	self.DB = mysqloo.connect(self.SQLHost, self.SQLUsername, self.SQLPassword, self.SQLDatabase, self.SQLPort);

	function self.DB:onConnected()
		MsgCon(color_green, "Connected to MySQL database successfully!");
		MsgCon(color_green, "MySQLOO Version: " .. mysqloo.VERSION);
		MsgCon(color_green, "MySQL Server Version: " .. mysqloo.MYSQL_INFO);
	end

	function self.DB:onConnectionFailed(error)
		MsgErr("Could not connect to database! Check your sv_config.lua file.");
		MsgErr(error);
	end

	self.DB:connect();

	if !sql.TableExists("BASH_characters_local") then
		sql.Query("CREATE TABLE BASH_characters_local(`BASHID` TINYTEXT NOT NULL, `CharID` TINYTEXT NOT NULL, `LastNotif` INT(10) NOT NULL, `IsHungry` TINYINT(4) NOT NULL, `LastAte` INT(10) NOT NULL, `NextHungerNotif` INT(10) NOT NULL, `IsThirsty` TINYINT(4) NOT NULL, `LastDrank` INT(10) NOT NULL, `NextThirstNotif` INT(10) NOT NULL, `BloodType` TINYTEXT NOT NULL, `LastLootGrant` INT(10) NOT NULL);");
		MsgCon(color_green, "Created local database!");
	else
		MsgCon(color_green, "Connected to local database!");
	end
end

local function CheckDB()
	if BASH.DB then
		local data = BASH.DB:status()

		if data != mysqloo.DATABASE_CONNECTED and data != mysqloo.DATABASE_CONNECTING then
			MsgCon(color_red, "Found disconnected database. Reconnecting...");
			BASH.DB:delete();
			BASH:SQLInit();
			hook.Call("DBReconnect", BASH);
		end
	end
end
timer.Create("CheckDB", 10, 0, CheckDB);

function Player:SQLInit()
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;
	local name = db:escape(self:Name());
	local steamID = self:SteamID();
	local getEntryData = db:query("SELECT * FROM BASH_players WHERE SteamID = '" .. steamID .. "';");
	getEntryData:start();

	function getEntryData:onSuccess(data)
		if IsEmpty(data) then
			local bashID = RandomString(16);
			ply:UpdateEntry({"BASHID", "PassedQuiz"}, {bashID, false});

			local updateEntryData = db:query("INSERT INTO BASH_players(Name, SteamID, BASHID, PassedQuiz, PlayerFlags, Whitelists) VALUES('" .. name .."', '" .. steamID .. "', '" .. bashID .. "', 0, '', 'loner;');");
			updateEntryData:start();

			function updateEntryData:onSuccess(data)
				MsgCon(color_purple, "Created row for new player " .. name .. " [" .. steamID .. "].", true);

				local newData = {
					["Name"] = name,
					["BASHID"] = bashID,
					["SteamID"] = steamID,
					["PassedQuiz"] = 0,
					["PlayerFlags"] = '',
					["Whitelists"] = "loner;"
				};

				ply.PlyData = newData;
				ply.CharData = {};
				ply.SQLInitDone = true;
				ply:CheckForBan();
			end
		else
			MsgCon(color_purple, "Row exists for player " .. name .. " [" .. steamID .. "].", true);
			ply.PlyData = data[1];
			local bashID = ply.PlyData.BASHID;
			local getCharData = db:query("SELECT * FROM BASH_characters WHERE BASHID = '" .. bashID .. "';");
			getCharData:start();

			function getCharData:onSuccess(data)
				for index, character in pairs(data) do
					if character.PKTime == 0 or (character.PKTime != -1 and character.PKTime > os.time()) then
						character.IsPKed = true;
					else
						character.IsPKed = false;
					end
				end

				ply.CharData = data;

				local updateLocalCharData = sql.Query("SELECT * FROM BASH_characters_local WHERE BASHID = '" .. bashID .. "';");
				if istable(updateLocalCharData) then
					table.Merge(ply.CharData, updateLocalCharData);
				end

				ply.SQLInitDone = true;
				ply:CheckForBan();
			end
		end
	end

	function getEntryData:onError(error, sql)
		MsgErr("Failed to get entry data!");
		MsgErr(error);
		MsgErr(sql);
	end
end
netstream.Hook("BASH_Dank_Fix", function(ply, data)
	if !ply or !ply:IsValid() then return end;
	ply:SQLInit();
end);

function Player:CheckForBan()
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;
	local name = db:escape(self:Name());
	local steamID = self:SteamID();
	local bashID = self.PlyData.BASHID;
	local getBans = db:query("SELECT * FROM BASH_bans WHERE Banned_SteamID = '" .. steamID .. "' OR Banned_BASHID = '" .. bashID .. "';");
	getBans:start();

	function getBans:onSuccess(data)
		if IsEmpty(data) then
			MsgCon(color_purple, "No bans found for " .. name .. " [" .. steamID .. "].");
			netstream.Start(ply, "BASH_Init_Data", {ply.PlyData, ply.CharData});
			ply:Register();
		else
			local reason, name, steamID, length, time, msg;
			for index, ban in pairs(data) do
				reason = ban.Banned_Reason;
				name = ban.Banner_Name;
				steamID = ban.Banner_SteamID;
				length = tonumber(ban.Ban_Length);
				time = tonumber(ban.Ban_Time);

				if length == 0 then
					msg = "permanently";
				else
					msg = "for " .. tostring((time - os.time()) / 60) .. " more minutes";
				end
				if length == 0 or time > os.time() then
					ply.ForceDisconnect = true;
					ply:Kick("Banned by " .. name .. " [" .. steamID .. "] " .. msg .. ": " .. reason .. ".");
					return;
				end
			end

			MsgCon(color_purple, "All bans cleared for " .. name .. " [" .. steamID .. "].");
			netstream.Start(ply, "BASH_Init_Data", {ply.PlyData, ply.CharData});
			ply:Register();
		end
	end
end

function Player:SQLUpdate()
	if !CheckPly(self) then return end;
	if !self.PlyData then return end;
	if !self.InitDone then return end;

	local db = BASH.DB;
	local ply = self;
	local var;

	local name = db:escape(self:Name());
	local steamID = self:SteamID();
	local bashID = self:GetEntry("BASHID");
	local plyFlags = db:escape(self:GetEntry("PlayerFlags") or " ");
	local passedQuiz = tonumber(self:GetEntry("PassedQuiz"));
	local whitelists = self:GetEntry("Whitelists");
	local updateQuery = "UPDATE BASH_players SET Name = '" .. name .. "', SteamID = '" .. steamID .. "', BASHID = '" .. bashID .. "', PassedQuiz = " .. passedQuiz .. ", PlayerFlags = '" .. plyFlags .. "', Whitelists = '" .. whitelists .. "' WHERE SteamID = '" .. steamID .. "';";

	local updatePlayerData = db:query(updateQuery);
	updatePlayerData:start();

	function updatePlayerData:onSuccess(data)
		ply:GetPlayerData();
		MsgCon(color_purple, "Updated player data for " .. name .. " [" .. steamID .. "].");
		netstream.Start(ply, "BASH_Ply_Data", ply.PlyData);
	end

	if !self:GetEntry("CharLoaded") then return end;

	local charID = self:GetEntry("CharID");
	local name = db:escape(self:GetEntry("Name"));
	local desc = db:escape(self:GetEntry("Description"));
	local model = self:GetEntry("Model");
	local faction = self:GetEntry("Faction");
	local pkTime = self:GetEntry("PKTime");
	local quirks = self:GetEntry("Quirks");
	local charFlags = db:escape(self:GetEntry("CharFlags") or " ");
	local rubles = self:GetEntry("Rubles");
	local invMain = self:GetEntry("InvMain");
	local invSec = self:GetEntry("InvSec");
	local invAcc = self:GetEntry("InvAcc");
	local suit = self:GetEntry("Suit");
	local acc = self:GetEntry("Acc");
	local clothing = self:GetEntry("Clothing");
	local weps = self:GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	for index, wep in pairs(weps) do
		if wep.ID then
			local wepData = BASH.Items[wep.ID];
			local wepEnt = self:GetWeapon(wepData.WeaponEntity);
			if wepEnt and wepEnt:IsValid() and wepEnt:GetTable().IsBASHWeapon and !wepEnt:GetTable().IsMelee then
				wep.Ammo = wepEnt:Clip1();
				if wepEnt:GetTable().ShotsFired and wepEnt:GetTable().ShotsFired > 0 then
					wep.Condition = wep.Condition - ((wepEnt:GetTable().ShotsFired / wepData.Durability) * 100);
				end
			end
		end
	end
	weps = util.TableToJSON(weps);
	local arts = self:GetEntry("Artifacts");
	updateQuery = "UPDATE BASH_characters SET Name = '" .. name .. "', Description = '" .. desc .. "', Model = '" .. model .. "', Faction = '" .. faction .. "', PKTime = " .. pkTime .. ", Quirks = '" .. quirks .. "', CharFlags = '" .. charFlags .. "', Rubles = " .. rubles .. ", InvMain = '" .. invMain .. "', InvSec = '" .. invSec .. "', InvAcc = '" .. invAcc .. "', Suit = '" .. suit .. "', Acc = '" .. acc .. "', Clothing = '" .. clothing .. "', Weapons = '" .. weps .. "', Artifacts = '" .. arts .. "' WHERE BASHID = '" .. bashID .. "' AND CharID = '" .. charID .. "';";

	local updateCharacterData = db:query(updateQuery);
	updateCharacterData:start();

	local lastNotif = self:GetEntry("LastNotif");
	local isHungry = self:GetEntry("IsHungry");
	local lastAte = self:GetEntry("LastAte");
	local nextHunger = self:GetEntry("NextHungerNotif");
	local isThirsty = self:GetEntry("IsThirsty");
	local lastDrank = self:GetEntry("LastDrank");
	local nextThirst = self:GetEntry("NextThirstNotif");
	local bloodType = self:GetEntry("BloodType");
	local lastLootGrant = self:GetEntry("LastLootGrant");
	updateQuery = "UPDATE BASH_characters_local SET LastNotif = " .. lastNotif .. ", IsHungry = " .. isHungry .. ", LastAte = " .. lastAte .. ", NextHungerNotif = " .. nextHunger .. ", IsThirsty = " .. isThirsty .. ", LastDrank = " .. lastDrank .. ", NextThirstNotif = " .. nextThirst .. ", BloodType = '" .. bloodType .. "', LastLootGrant = " .. lastLootGrant .. " WHERE BASHID = '" .. bashID .. "' AND CharID = '" .. charID .. "';";
	sql.Query(updateQuery);

	function updateCharacterData:onSuccess(data)
		ply:GetCharacterData();
		MsgCon(color_purple, "Updated character data for " .. name .. " [" .. steamID .. "].");

		if ply.Disconnecting then
			ply:UnRegister();
		end
	end
end

function Player:GetPlayerData()
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;
	local bashID = self:GetEntry("BASHID");
	local getPlyData = db:query("SELECT * FROM BASH_players WHERE BASHID = '" .. bashID .. "';");
	getPlyData:start();

	function getPlyData:onSuccess(data)
		ply.PlyData = data[1];
		netstream.Start(ply, "BASH_Ply_Data", ply.PlyData);
	end
end

function Player:GetCharacterData(loadChar)
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;
	local name = db:escape(self:Name());
	local steamID = self:SteamID();
	local bashID = self:GetEntry("BASHID");
	local getCharData = db:query("SELECT * FROM BASH_characters WHERE BASHID = '" .. bashID .. "';");
	getCharData:start();

	function getCharData:onSuccess(data)
		ply.CharData = data;

		for index, character in pairs(data) do
			if character.PKTime == 0 or (character.PKTime != -1 and character.PKTime > os.time()) then
				character.IsPKed = true;
			else
				character.IsPKed = false;
			end
		end

		local getLocalCharData = sql.Query("SELECT * FROM BASH_characters_local WHERE BASHID = '" .. bashID .. "';");
		if istable(getLocalCharData) then
			table.Merge(ply.CharData, getLocalCharData);
		end

		netstream.Start(ply, "BASH_Char_Data", ply.CharData);
	end
end

local function PeriodicSave()
    local delay = 0;
    MsgCon(color_blue, "Saving all characters...");

    for _, ply in pairs(player.GetAll()) do
        if !ply:IsBot() and ply:GetEntry("CharLoaded") then
            timer.Simple(delay, function()
                    ply:SQLUpdate();
            end);

            delay = delay + 0.5;
        end
    end

    timer.Simple(delay, function()
    	MsgCon(color_blue, "Completed character save.");
    end);
end
timer.Create("CharacterSave", 300, 0, PeriodicSave);

function Player:CreateCharacter(data)
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;

	if !data.Name or !data.Description or !data.Gender or !data.Model or !data.Faction then
		netstream.Start(self, "BASH_Create_Character_Failure");
		return;
	end
	if !data.CharID then
		data.CharID = RandomString(16);
	end

	local bashID = self:GetEntry("BASHID");
	local charID = data.CharID;
	local name = db:escape(data.Name);
	local desc = db:escape(data.Description);
	local gender = data.Gender;
	local model = data.Model;
	local faction = data.Faction;
	local quirks = util.TableToJSON(data.Quirks) or "";
	local invMain = {};
	local rubles;
	if table.HasValue(data.Quirks, "morespace") then
		invMain.Name = "inv_clothing_more";
		invMain.Content = {};
		for invX = 1, 3 do invMain.Content[invX] = {} for invY = 1, 3 do invMain.Content[invX][invY] = {} end end;
		rubles = math.random(500, 3000);
	elseif table.HasValue(data.Quirks, "lessspace") then
		invMain.Name = "inv_clothing_less";
		invMain.Content = {};
		for invX = 1, 3 do invMain.Content[invX] = {} for invY = 1, 2 do invMain.Content[invX][invY] = {} end end;
		rubles = math.random(2500, 4500);
	else
		invMain.Name = "inv_clothing";
		invMain.Content = {};
		for invX = 1, 4 do invMain.Content[invX] = {} for invY = 1, 2 do invMain.Content[invX][invY] = {} end end;
		rubles = math.random(1750, 4000);
	end

	local invX, invY = 1, 1;
	while invMain.Content[invX][invY].ID do
		invX = invX + 1;
		if !invMain.Content[invX] then
			invX = 1;
			invY = invY + 1;
		end
	end
	local items = {};
	local suits = {"anorak_black", "anorak_brown", "anorak_camo", "anorak_dusty", "anorak_red", "trenchcoat_black", "trenchcoat_brown", "trenchcoat_brush", "trenchcoat_dusty", "trenchcoat_green"};
	if math.random(10) < 5 then
		local suit = suits[math.random(#suits)];
		local suitData = BASH.Items[suit];
		local suitInv = {};
		suitInv.Name = suitData.Inventory;
		suitInv.Content = {};
		local suitInvData = BASH.Inventories[suitData.Inventory];
		if suitInvData then
			for invX = 1, suitInvData.SizeX do suitInv.Content[invX] = {} for invY = 1, suitInvData.SizeY do suitInv.Content[invX][invY] = {} end end;
		end
		invMain.Content[invX][invY] = {
			ID = suit,
			Condition = math.random(75, 100),
			Inventory = suitInv
		};
		while invMain.Content[invX][invY].ID do
			invX = invX + 1;
			if !invMain.Content[invX] then
				invX = 1;
				invY = invY + 1;
			end
		end
	else
		rubles = rubles + 500;
	end

	local weps = {"wep_ak47", "wep_ak54", "wep_gsh18", "wep_m9", "wep_m1911", "wep_makarov", "wep_mp5", "wep_ots02", "wep_serbu", "wep_tt30"};
	if math.random(10) < 3 then
		local wep = weps[math.random(#weps)];
		local wepData = BASH.Items[wep];
		invMain.Content[invX][invY] = {
			ID = wep,
			Condition = math.random(50, 75),
			Ammo = 0,
			Attachments = {}
		};
		while invMain.Content[invX][invY].ID do
			invX = invX + 1;
			if !invMain.Content[invX] then
				invX = 1;
				invY = invY + 1;
			end
		end
		local ammoData = BASH.Items["ammo_" .. wepData.AmmoType];
		invMain.Content[invX][invY] = {
			ID = "ammo_" .. wepData.AmmoType,
			Stacks = math.random(ammoData.DefaultStacks)
		};
		while invMain.Content[invX][invY].ID do
			invX = invX + 1;
			if !invMain.Content[invX] then
				invX = 1;
				invY = invY + 1;
			end
		end
	else
		rubles = rubles + 250;
	end

	invMain.Content[invX][invY] = {
		ID = "medkit",
		Stacks = math.random(3);
	};

	while invMain.Content[invX][invY].ID do
		invX = invX + 1;
		if !invMain.Content[invX] then
			invX = 1;
			invY = invY + 1;
		end
	end

	invMain.Content[invX][invY] = {
		ID = "bandages",
		Stacks = math.random(5);
	};

	while invMain.Content[invX][invY].ID do
		invX = invX + 1;
		if !invMain.Content[invX] then
			invX = 1;
			invY = invY + 1;
		end
	end

	invMain.Content[invX][invY] = {
		ID = "tourists_delight",
		Stacks = math.random(2);
	};

	invMain = util.TableToJSON(invMain);
	local invSec = {};
	invSec.Name = "";
	invSec.Content = {};
	invSec = util.TableToJSON(invSec);
	local invAcc = {};
	invAcc.Name = "";
	invAcc.Content = {};
	invAcc = util.TableToJSON(invAcc);
	local clothing = {};
	for index, bodyPart in pairs(BODY_PARTS) do clothing[bodyPart] = "" end;
	clothing = util.TableToJSON(clothing);
	local equipment = {};
	for index = 1, 3 do equipment[index] = {} end;
	equipment = util.TableToJSON(equipment);
	local arts = {};
	arts[1] = {};
	arts = util.TableToJSON(arts);

	local createCharacter = db:query("INSERT INTO BASH_characters(BASHID, CharID, Name, Model, Description, Faction, Gender, Quirks, PKTime, CharFlags, Rubles, InvMain, InvSec, InvAcc, Suit, Acc, Clothing, Weapons, Artifacts) VALUES('" .. bashID .. "', '" .. charID .. "', '" .. name .. "', '" .. model .. "', '" .. desc .. "', '" .. faction .. "', '" .. gender .. "', '" .. quirks .. "', -1, '', " .. rubles .. ", '" .. invMain .. "', '" .. invSec .. "', '" .. invAcc .. "', '', '', '" .. clothing .. "', '" .. equipment .. "', '" .. arts .. "');");
	createCharacter:start();

	local bloodType = table.Random({"O+", "O-", "A+", "A-", "B+", "B-", "AB+", "AB-"});
	sql.Query("INSERT INTO BASH_characters_local(BASHID, CharID, LastNotif, IsHungry, LastAte, NextHungerNotif, IsThirsty, LastDrank, NextThirstNotif, BloodType, LastLootGrant) VALUES('" .. bashID .. "', '" .. charID .. "', " .. os.time() .. ", 0, " .. os.time() .. ", " .. os.time() .. ", 0, " .. os.time() .. ", " .. os.time() .. ", '" .. bloodType .. "', 0);");

	function createCharacter:onSuccess(data)
		MsgCon(color_purple, ply:Name() .. " [" .. ply:SteamID() .. " / " .. bashID .. "] has created the character " .. name .. ".", true);

		ply:GetCharacterData();

		timer.Simple(0.5, function()
			netstream.Start(ply, "BASH_Create_Character_Return", charID);
		end);

		BASH:UpdateEconomy("FloatingCash", BASH.EconomyStats["FloatingCash"] + rubles);
	end

	function createCharacter:onError(error, sql)
		MsgErr("Error creating character " .. name .. " for player " .. ply:Name() .. "!");
		MsgErr(error);
		MsgErr(sql);

		netstream.Start(ply, "BASH_Create_Character_Failure");
	end
end

function Player:DeleteCharacter(_charID)
	if !CheckPly(self) then return end;

	local db = BASH.DB;
	local ply = self;

	local charData;
	for ind, char in pairs(self.CharData) do
		if char.CharID == _charID then
			charData = char;
		end
	end
	if !charData then return end;

	local name = db:escape(self:Name());
	local steamID = self:SteamID();
	local bashID = self:GetEntry("BASHID");
	local charName = charData.Name;
	local charID = charData.CharID;
	local cash = charData.Rubles;
	local deleteChar = db:query("DELETE FROM BASH_characters WHERE BASHID = '" .. bashID .. "' AND CharID = '" .. charID .. "';");
	deleteChar:start();
	sql.Query("DELETE FROM BASH_characters_local WHERE BASHID = '" .. bashID .. "' AND CharID = '" .. charID .. "';");

	function deleteChar:onSuccess(data)
		MsgCon(color_purple, ply:Name() .. " [" .. steamID .. " / " .. bashID .. "] has deleted the character " .. charName .. " [" .. charID .. "].", true);
		ply:GetCharacterData();
		BASH:UpdateEconomy("FloatingCash", BASH.EconomyStats["FloatingCash"] - cash);

		if ply:GetEntry("CharLoaded") and ply:GetEntry("CharID") == charID then
			ply:Initialize();
			ply:Register();
			ply:UpdateEntry("CharLoaded", false);
		end
	end
end

function BASH:BanPlayer(banner, banned, length, reason)
	if !banner or !banned or !length then return end;

	local name = self.DB:escape((!isstring(banned) and banned:Name()) or "BANNED-ID");
	local steamID = (!isstring(banned) and banned:SteamID()) or banned;
	local bashID = (!isstring(banned) and banned:GetEntry("BASHID")) or "BANNED-ID";
	local safeReason = self.DB:escape(reason);
	local bannerName = (banner == "Server" and banner) or self.DB:escape(banner:Name());
	local bannerID = (banner == "Server" and "SERVER") or banner:SteamID();
	local time = os.time() + length;

	local newBan = self.DB:query("INSERT INTO BASH_bans(Banned_Name, Banned_SteamID, Banned_BASHID, Banned_Reason, Banner_Name, Banner_SteamID, Ban_Length, Ban_Time) VALUES('" .. name .. "', '" .. steamID .. "', '" .. bashID .. "', '" .. safeReason .. "', '" .. bannerName .. "', '" .. bannerID .. "', " .. tostring(length) .. ", " .. tostring(time) .. ");");
	newBan:start();

	function newBan:onSuccess(data)
		MsgCon(color_green, bannerName .. " has banned " .. name .. " successfully.");
	end

	function newBan:onError(error, sql)
		MsgErr("Error banning player " .. name .. "!");
		MsgErr(error);
		MsgErr(sql);
	end

	if !isstring(banned) then
		banned.ForceDisconnect = true;
		banned:Kick(reason);
	end
end

netstream.Hook("BASH_Create_Character", function(ply, data)
	ply:CreateCharacter(data);
end);

netstream.Hook("BASH_Delete_Character", function(ply, data)
	ply:DeleteCharacter(data);
end);

netstream.Hook("BASH_Post_Quiz", function(ply, data)
	local passedQuiz = data;

	if passedQuiz then
		ply:UpdateEntry("PassedQuiz", 1);
		ply:SQLUpdate();

		netstream.Start(ply, "BASH_Post_Quiz_Return");
	else
		ply:Kick("Quiz failed, try again later!");
	end
end);
