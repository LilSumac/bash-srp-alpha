local BASH = BASH;
local string = string;

/*
**	MsgCon
**	Console logging utility function.
**		color: Color of the text.
**		text: Text to log.
**		log: Whether or not to log the text.
*/
function MsgCon(color, text, log)
	MsgC(color, text .. '\n');

	if log then
		BASH:WriteToLog(text, LOG_ALL)
	end
end

/*
**	MsgErr
**	Error logging utility function.
**		text: Error text to log.
*/
function MsgErr(text)
	MsgC(color_red, text .. '\n');

	local date = os.date("%Y-%m-%d", os.time());
	local time = os.date("%X", os.time());
	BASH:WriteToFile("errors/" .. date .. ".txt", "[" .. time .. "]: " .. text);
end

/*
**	Broadcast
**	Prints a message to every player's chat.
**		text: Text to print.
*/
function Broadcast(text)
	for _, ply in pairs(player.GetAll()) do
		if ply:GetEntry("CharLoaded") then
			ply:PrintChat(text);
		end
	end
end

/*
**	CommandPrint
**	Sends command information to all staff.
**		text: Text to send.
*/
function CommandPrint(text)
	local recipients = {};
	for _, _ply in pairs(player.GetAll()) do
		if CheckPly(_ply) and CheckChar(_ply) then
			if _ply:IsStaff() then
				table.insert(recipients, _ply);
			end
		end
	end

	local text = "[CMD] " .. text;
	netstream.Start(recipients, "BASH_Return_Chat", {"", text, text, CHAT_TYPES.CMD.ID});
end

/*
**	CheckPly
**	Checks whether an entity is a valid player.
**		ply: Entity to check.
**	returns: boolean
*/
function CheckPly(ply)
	return ply and ply:IsValid() and ply:IsPlayer();
end

/*
**	CheckChar
**	Checks whether an entity is a valid player with a valid
**	character loaded.
**		ply: Entity to check.
**	returns: boolean
*/
function CheckChar(ply)
	return CheckPly(ply) and ply.PlyData and ply.CharData and ply:GetEntry("CharLoaded") and ply:GetEntry("CharID");
end

/*
**	IsEmpty
**	Table utility function to check if a table is empty.
**		color: Color of the text.
**		text: Text to log.
**		log: Whether or not to log the text.
*/
function IsEmpty(tab)
	return !(tab and table.Count(tab) > 0);
end

/*
**	ChokeString
**	Truncates a string to a certain length, appending '...' to the end.
**		text: Text to truncate.
**		max: Max length to allow.
*/
function ChokeString(text, max)
	if !text then return end;

	local length = string.len(text);

	if length > max then
		text = string.sub(text, 1, max) .. "...";
	end

	return text;
end

function RandomString(length)
	local randomString = "";

	for index = 1, length, 1 do
		randomString = randomString .. CHARACTERS[math.random(1, #CHARACTERS)];
	end

	return randomString;
end

function RandomHandle(length)
	local randomHandle = "";

	for index = 1, length or 8 do
		randomHandle = randomHandle .. tostring(math.random(0, 9));
	end

	return randomHandle;
end

function ParseDouble(str)
	local strExplode = string.Explode(';', str);
	return strExplode[1], strExplode[2];
end

function SecondsToTime(secs, daytime)
	local hours = math.floor(secs / 3600);
	local minutes = math.floor((secs - (hours * 3600)) / 60);
	local seconds = secs - (hours * 3600) - (minutes * 60);

	if hours < 10 then hours = "0" .. tostring(hours) end;
	if minutes < 10 then minutes = "0" .. tostring(minutes) end;
	if seconds < 10 then seconds = "0" .. tostring(seconds) end;
	if daytime then
		hours = hours % 24;
	end
	return hours .. ":" .. minutes .. ":" .. seconds;
end

function player.GetBySteamID(steamID)
	for _, ply in pairs(player.GetAll()) do
		if ply:SteamID() == steamID then
			return ply;
		end
	end
end

function player.GetByInfo(info, value, exact)
	local players = player.GetAll();
	for _, ply in pairs(players) do
		if exact then
			if ply:GetEntry(info) == value then
				return ply;
			end
		else
			if string.find(ply:GetEntry(info), value) then
				return ply;
			end
		end
	end
end

function player.GetChars()
	local tab = {};
	local players = player.GetAll();
	for _, ply in pairs(players) do
		if CheckPly(ply) and CheckChar(ply) then
			table.insert(tab, ply);
		end
	end
	return tab;
end

function player.GetRegistered()
	local tab = {};
	local players = player.GetAll();
	for _, ply in pairs(players) do
		if CheckPly(ply) and ply.InitDone then
			table.insert(tab, ply);
		end
	end
	return tab;
end

function BASH:ProcessFile(name, print)
	local fileName = self.FolderName .. "/gamemode/" .. name;
	local filePrefix = string.sub(string.GetFileFromFilename(name), 1, string.find(string.GetFileFromFilename(name), '_', 1));

	if table.HasValue(PREFIXES_CLIENT, filePrefix) then
		if CLIENT then include(fileName)
		else AddCSLuaFile(fileName) end;
	elseif table.HasValue(PREFIXES_SHARED, filePrefix) then
		if CLIENT then include(fileName)
		else AddCSLuaFile(fileName) include(fileName) end;
	elseif table.HasValue(PREFIXES_SERVER, filePrefix) then
		if SERVER then include(fileName) end;
	end

	if SERVER and print then
		MsgCon(color_green, "Processed file '" .. name .. "'.");
	end
end

function BASH:ProcessDirectory(directory, print)
	MsgCon(color_green, "Processing directory '" .. directory .. "'...");

	local gameDir = self.FolderName .. "/gamemode/" .. directory .. "/*";
	local files, dirs = file.Find(gameDir, "LUA", nameasc);
	for _, file in pairs(files) do
		file = directory .. "/" .. file;
		self:ProcessFile(file, print);
	end

	if dirs then
		for _, dir in pairs(dirs) do
			dir = directory .. "/" .. dir;
			self:ProcessDirectory(dir, print);
		end
	end
end

function BASH:ProcessModules()
	if !self.Modules then
		self.Modules = {};
	end

	MsgCon(color_green, "Mounting modules...");

	local moduleDir = self.FolderName .. "/gamemode/modules/*";
	local _, mods = file.Find(moduleDir, "LUA", nameasc);
	for _, mod in pairs(mods) do
		local modFiles, _ = file.Find(self.FolderName .. "/gamemode/modules/" .. mod .. "/*", "LUA", nameasc);

		if table.HasValue(modFiles, "sh_module.lua") then
			local fileName = self.FolderName .. "/gamemode/modules/" .. mod .. "/sh_module.lua";
			if CLIENT then include(fileName)
			else AddCSLuaFile(fileName) include(fileName) end;

			MsgCon(color_green, "Mounted module '" .. mod .. "'.");
		else
			MsgErr("Module '" .. mod .. "' does not have a sh_module.lua file!");
		end
	end

	self:CheckDependencies();
end

function BASH:CheckDependencies()
    MsgCon(color_green, "Checking dependencies...");
	local throw = false;

    for id, module in pairs(self.Modules) do
		if module.Dependencies then
	        for _, dep in pairs(module.Dependencies) do
	            if !self.Modules[dep] then
	                MsgErr("Module '" .. module.ID .. "' is missing a dependent module: '" .. dep .. "'!");
					throw = true;
	            end
	        end
		end
    end

	if throw then
		MsgErr("Dependency errors were found! Please check the log and remedy these immediately.");
	else
		MsgCon(color_green, "No dependency errors!");
	end
end

function BASH:ProcessItem(item)
	local id = item.ID or self:RandomString(16);
	local tab = hook.Call("OnItemProcess", nil, item) or {};
	tab.Actions = {};

	tab.ID = id;
	tab.Name = item.Name or "Unknown Item";
	tab.Description = item.Description or "An unknown item.";
	tab.FlavorText = item.FlavorText or "Where'd this come from?";
	tab.WorldModel = item.WorldModel or Model("models/props_junk/garbage_bag001a.mdl");
	tab.ModelScale = item.ModelScale or 1;
	tab.ModelColor = item.ModelColor or Color(255, 255, 255);
	tab.Tier = item.Tier or 1;
	tab.Weight = item.Weight or 0;
	tab.Hidden = item.Hidden or false;
	tab.LootHidden = tab.LootHidden or item.LootHidden or false;
	tab.DefaultStock = item.DefaultStock or 0;
	tab.DefaultPrice = item.DefaultPrice or 0;
	tab.IsStackable = item.IsStackable or false;
	tab.DefaultStacks = item.DefaultStacks or 1;
	tab.MaxStacks = item.MaxStacks or 1;
	tab.IsConditional = item.IsConditional or false;
	tab.FabricYield = item.FabricYield or 0;
	tab.MetalYield = item.MetalYield or 0;
	tab.ItemSize = item.ItemSize or SIZE_MIN;
	tab.NoProperties = item.NoProperties or false;

	tab.Actions["Pick Up"] = function(ply, ent)
		if SERVER then return end;
		if !ent or !ent:IsValid() then return end;

		netstream.Start("BASH_Pickup_Item", ent);
	end

	if item.IsWeapon then
		tab.IsWeapon = true;
		tab.IsConditional = true;
		tab.DefaultPrice = tab.DefaultPrice * 0.75;	//	Shitty tweak. Let's see how this goes.
		tab.Durability = item.Durability or 100;
		tab.SlotType = item.SlotType or "Primary";
		tab.WeaponEntity = item.WeaponEntity or "";
		tab.AmmoType = item.AmmoType or "none";
		tab.Upgradeable = item.Upgradeable or false;
		tab.Upgrades = item.Upgrades or {};
		tab.Attachments = item.Attachments or {};
		tab.IncludedAttachments = item.IncludedAttachments or {};
		tab.LootHidden = (item.LootHidden == false and true) or false;

		/*
		Upgrade Example
		{*Weapon item to upgrade to*, *Rubles required*, *Metal scrap required*, *Weapon part entities required (if any)*}

		item.Upgrades = {
			{"wep_ak74_silenced", 1000, 2, {"ak_silencer"}},
			{"wep_ak74_assault", 2500, 4}
		};
		*/
	elseif item.IsAttachment then
		tab.IsAttachment = true;
		tab.AttachmentSlot = item.AttachmentSlot or "Sight";
		tab.AttachmentEnt = item.AttachmentEnt or "md_kobra";
		tab.DefaultColor = item.DefaultColor or Color(255, 75, 75);		// Default sight color;
		tab.RequiresTech = item.RequiresTech or false;
	elseif item.IsSuit then
		tab.IsSuit = true;
		tab.IsConditional = true;
		tab.PlayerModel = item.PlayerModel or Model("models/stalkertnb/bandit1.mdl");
		tab.NightVision = item.NightVision or false;
		tab.Respiration = item.Respiration or false;
		tab.BodyArmor = item.BodyArmor or 0;
		tab.HelmetArmor = item.HelmetArmor or 0;
		tab.RadiationResist = item.RadiationResist or 0;
		tab.BurnResist = item.BurnResist or 0;
		tab.AcidResist = item.AcidResist or 0;
		tab.ElectroResist = item.ElectroResist or 0;
		tab.ColdResist = item.ColdResist or 0;
		tab.Durability = item.Durability or 0;
		tab.NoInventory = item.NoInventory or false;
		tab.Inventory = item.Inventory or "";
		tab.StorageSize = item.StorageSize or STORAGE_SMALL;
		tab.EquipSlots = item.EquipSlots or {};
		tab.NoClothing = item.NoClothing or false;
		tab.Upgradeable = item.Upgradeable or false;
		tab.Upgrades = item.Upgrades or {};
		if tab.DefaultStock == 0 and tab.Tier > 1 then
			tab.LootHidden = true;
		else
			tab.LootHidden = false;
		end
		tab.Actions["Wear"] = function(ply, ent)
			if !ent or !ent:IsValid() then return end;

			if ply:GetEntry("Suit") != "" then
				self:CreateNotif("You're already wearing a suit!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			elseif tab.NoClothing and ply:HasClothing() then
				self:CreateNotif("You must remove your excess clothing to wear this suit!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			else
				netstream.Start("BASH_Wear_Suit", ent);
			end
		end

		/*
		Upgrade Example
		{*Suit item to upgrade to*, *Rubles required*, *Fabric scrap required*, *Suit part entities required (if any)*}

		item.Upgrades = {
			{"trenchcoat_black_reinforced", 1000, 8, {"gasmask"}}
		};
		*/
	elseif item.IsAccessory then
		tab.IsAccessory = true;
		tab.BodyArmor = item.BodyArmor or 0;
		tab.HelmetArmor = item.HelmetArmor or 0;
		tab.Respiration = item.Respiration or false;
		tab.RadiationResist = item.RadiationResist or 0;
		tab.BurnResist = item.BurnResist or 0;
		tab.AcidResist = item.AcidResist or 0;
		tab.ElectroResist = item.ElectroResist or 0;
		tab.ColdResist = item.ColdResist or 0;
		tab.NoInventory = item.NoInventory or false;
		tab.Inventory = item.Inventory or "";
		tab.StorageSize = item.StorageSize or STORAGE_SMALL;
		tab.EquipSlots = item.EquipSlots or {};
		tab.BodyPos = item.BodyPos or "Head";
		tab.NoClothing = item.NoClothing or false;
		tab.Actions["Wear"] = function(ply, ent)
			if !ent or !ent:IsValid() then return end;

			if LocalPlayer():GetEntry("Acc") != "" then
				self:CreateNotif("You're already wearing an accessory!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			elseif tab.NoClothing and ply:HasClothing(tab.BodyPos) then
				self:CreateNotif("You must remove your '" .. tab.BodyPos .. "' article to wear this accessory!", "BASHFontHeavy", NOTIF_TOP_CENT, 4);
				return;
			else
				netstream.Start("BASH_Wear_Acc", ent);
			end
		end
	elseif item.IsClothing then
		tab.IsClothing = true;
		tab.BodyPos = item.BodyPos or "Torso";
		tab.NoProperties = true;
	elseif item.IsWritable then
		tab.IsWritable = true;
		tab.Actions["Read"] = function(ply, ent)
			if !ent or !ent:IsValid() then return end;

			self:CloseInventory();
			netstream.Start("BASH_Request_Writing", ent);
		end
	elseif item.IsConsumable then
		tab.IsConsumable = true;
		tab.ConsumeString = item.ConsumeString or "Consume";
		tab.ConsumeVariable = item.ConsumeVariable or "Health";
		tab.ConsumeEffect = item.ConsumeEffect or 0;
		tab.ConsumeMessage = item.ConsumeMessage or "You've consumed an item.";
		tab.ConsumeIcon = item.ConsumeIcon or "icon16/pill.png";
		tab.NoProperties = true;
		tab.Actions[tab.ConsumeString] = function(ply, ent)
			if !ent or !ent:IsValid() then return end;

			netstream.Start("BASH_Consume_Item", {tab.ConsumeVariable, tab.ConsumeEffect, ent})
		end
	elseif item.IsScrap then
		tab.NoProperties = true;
	end

	tab.Actions["Examine"] = function(ply, ent)
		ply:PrintChat(tab.Description);
	end

	if item.Actions then
		for text, func in pairs(item.Actions) do
			tab.Actions[text] = func;
		end
	end

	if !self.Items then
		self.Items = {};
	end

	self.Items[id] = tab;

	if SERVER then
		MsgCon(color_purple, "Processing item '" .. tab.Name .. "'.");
	end
end

function BASH:ProcessFaction(faction)
	local tab = {};
	tab.ID = faction.ID or self:RandomString(8);
	tab.Name = faction.Name or "Unknown Faction";
	tab.Description = faction.Description or "An unknown faction.";
	tab.Color = faction.Color or color_white;
	tab.TextColor = faction.TextColor or color_black;
	tab.MaleModels = faction.MaleModels or {};
	tab.FemaleModels = faction.FemaleModels or tab.MaleModels;
	tab.Default = faction.Default or false;
	tab.MaxCharacters = faction.MaxCharacters or 8;
	tab.HasStockpile = faction.HasStockpile or false;

	if !self.Factions then
		self.Factions = {};
	end

	self.Factions[tab.ID] = tab;

	if SERVER then
		MsgCon(color_purple, "Processing faction '" .. tab.Name .. "'.");
	end
end

function BASH:ProcessQuirk(quirk)
	local tab = {};
	tab.ID = quirk.ID or self:RandomString(8);
	tab.Name = quirk.Name or "Unknown Quirk";
	tab.Description = quirk.Description or "";
	tab.QuirkType = quirk.QuirkType or self:RandomString(16);
	tab.MaxHealth = quirk.MaxHealth or 0;
	tab.HealthRegen = quirk.HealthRegen or 0;
	tab.MaxWeight = quirk.MaxWeight or 0;
	tab.NormalMaxStamina = quirk.NormalMaxStamina or 0;
	tab.NormalStaminaRegen = quirk.NormalStaminaRegen or 0;
	tab.HungryMaxStamina = quirk.HungryMaxStamina or 0;
	tab.ThirstyStaminaRegen = quirk.ThirstyStaminaRegen or 0;
	tab.HungerLength = quirk.HungerLength or 0;
	tab.ThirstLength = quirk.ThirstLength or 0;

	if !self.Quirks then
		self.Quirks = {};
	end

	self.Quirks[tab.ID] = tab;

	if SERVER then
		MsgCon(color_purple, "Processing quirk '" .. tab.Name .. "'.");
	end
end

function BASH:ProcessInventory(inv)
	local tab = {};
	tab.Name = inv.Name or "Inventory";
	tab.ID = inv.ID or RandomString(16);
	tab.SizeX = inv.SizeX or 2;
	tab.SizeY = inv.SizeY or 2;
	tab.Model = inv.Model;

	if !self.Inventories then
		self.Inventories = {};
	end

	self.Inventories[tab.ID] = tab;

	if SERVER then
		MsgCon(color_purple, "Processing inventory '" .. tab.Name .. "'.");
	end
end

function BASH:InventoryIsEmpty(tab)
	for invX = 1, #tab do
		for invY = 1, #tab[1] do
			if tab[invX][invY].ID then
				return false;
			end
		end
	end

	return true;
end

function BASH:GetRandomItem(tier)
	local items = {};
	local index = 1;
	for id, item in pairs(BASH.Items) do
		if item.Tier <= tier and !item.LootHidden and !item.IsSuit and !item.IsClothing then
			items[index] = id;
			index = index + 1;
		end
	end

	local randomItem = table.Random(items);
	local itemArgs = {};
	local itemData = self.Items[randomItem];
	if itemData.IsSuit then
		itemArgs[1] = math.random(25, 100);
		local inv = {};
		inv.Name = itemData.Inventory;
		inv.Content = {};
		local invData = BASH.Inventories[itemData.Inventory];
		if invData then
			for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
		end
		itemArgs[2] = util.TableToJSON(inv);
	elseif itemData.IsAccessory then
		local inv = {};
		inv.Name = itemData.Inventory;
		inv.Content = {};
		local invData = BASH.Inventories[itemData.Inventory];
		if invData then
			for invX = 1, invData.SizeX do inv.Content[invX] = {} for invY = 1, invData.SizeY do inv.Content[invX][invY] = {} end end;
		end
		itemArgs[1] = util.TableToJSON(inv);
	elseif itemData.IsWeapon then
		itemArgs[1] = math.random(25, 75);
		itemArgs[2] = math.random(10);
	elseif itemData.IsWritable then
		itemArgs[1] = RandomString(24);
		BASH:NewWritingData(itemArgs[1]);
	elseif itemData.IsConditional then
		itemArgs[1] = math.random(25, 100);
	elseif itemData.IsStackable then
		if itemData.DefaultStacks != 1 then
			itemArgs[1] = math.random(itemData.DefaultStacks);
		else
			itemArgs[1] = math.random(itemData.MaxStacks);
		end
	elseif !itemData.NoProperties then
		itemArgs = hook.Call("GetItemProperties", BASH, itemData) or {};
	end

	return randomItem, itemArgs;
end

function BASH:FindAttByID(id)
	for itemID, item in pairs(self.Items) do
		if item.IsAttachment and item.AttachmentEnt == id then
			return item;
		end
	end
end

function BASH:CreateFile(name)
	if file.Exists(name, "DATA") then return end;
	file.Write(name, "");
end

function BASH:CreateDirectory(name)
	if file.Exists(name, "DATA") then return end;
	file.CreateDir(name);
end

function BASH:GetSafeFilename(name)
	return string.gsub(string.gsub(string.gsub(name, "%.[^%.]*$", ""), "[^\32-\126]", ""), "[^%w-_/]", "") .. ".txt";
end

function BASH:WriteToFile(name, text, overwrite)
	name = self:GetSafeFilename(name);
	local dir = string.GetPathFromFilename(name);

	self:CreateDirectory(dir);
	self:CreateFile(name);

	local mode;
	if overwrite then
		mode = 'w';
	else
		mode = 'a';
	end

	local logFile = file.Open(name, mode, "DATA");
	if !logFile then
		MsgErr("Couldn't write/append to file '" .. name .. "'!");
		return;
	end

	if overwrite then
		logFile:Write(text);
	else
		logFile:Write((logFile:Size() > 0 and "\n" or "") .. text);
	end
	logFile:Close();
end

function BASH:WriteToLog(text, logType)
	if !self:LoggingEnabled() then return end;

	local time = os.date("%X");
	self:WriteToFile(self:GetLoggingFile(logType), "[" .. time .. "]: " .. text);
end

function BASH:GetLoggingFile(logType)
	if CLIENT then
		local fileName = "bash/";

		if logType == LOG_ALL then
			fileName = fileName .. "all/";
		elseif logType == LOG_IC then
			fileName = fileName .. "ic/";
		end

		fileName = fileName .. os.date("%Y-%m-%d", os.time());

		return fileName;
	else
		local fileName = "logs/";

		if logType == LOG_ALL then
			fileName = fileName .. "all/";
		elseif logType == LOG_IC then
			fileName = fileName .. "ic/";
		end

		fileName = fileName .. os.date("%Y-%m-%d", os.time());

		return fileName;
	end
end

function BASH:LoggingEnabled()
	if CLIENT then
		return tobool(GetConVarNumber("bash_log_enabled"));
	end

	return true;
end
