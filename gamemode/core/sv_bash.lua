local BASH = BASH;

DeriveGamemode("sandbox");
concommand.Remove("gm_save");

resource.AddWorkshop("185609021");	//	atmos
resource.AddWorkshop("646315827");	//	rp_stalker_redux
resource.AddWorkshop("646312597");	//	Map Props
resource.AddWorkshop("653510090");	//	Main Content 1
resource.AddWorkshop("653664623");	//	Main Content 2
resource.AddWorkshop("653667813");	//	Main Content 3
resource.AddWorkshop("653679694");	//	Main Content 4
resource.AddWorkshop("653686928");	//	Weapon Content 1
resource.AddWorkshop("653693452");	//	Weapon Content 2
resource.AddWorkshop("653696705");	//	Weapon Content 3
resource.AddWorkshop("653699404");	//	Weapon Content 4
resource.AddWorkshop("653702990");	//	Weapon Content 5
resource.AddWorkshop("653705504");	//	Weapon Content 6
resource.AddWorkshop("653706893");	//	Weapon Content 7

function BASH:Init()
	hook.Call("OnInit", self);
	self:LoadWriting();
	MsgCon(color_green, "Successfully initialized server-side. Init time: " .. math.Round(SysTime() - self.StartTime, 5) .. " seconds.", true);
	MsgCon(color_green, "***** SERVER STARTUP *****", true);

	self:SQLInit();
end

hook.Add("InitPostEntity", "CreateEntities", function()
	BASH:LoadPersist();
	BASH:LoadLoot();

	local map = game.GetMap();
	if !file.Exists("vars/storage/" .. map .. ".txt", "DATA") then return end;
	local storage = file.Read("vars/storage/" .. map .. ".txt", "DATA");
	storage = util.JSONToTable(storage);
	for index, closet in pairs(storage) do
		if !closet.ID or !closet.Pos or !closet.Angles or !closet.Owner or !closet.Password or !closet.Inventory then continue end;
		local newStorage = ents.Create("bash_storage");
		newStorage:CreateInventory(closet.ID, closet.ModelOverride);
		newStorage.Inventory = closet.Inventory;
		newStorage:SetRPOwner(closet.Owner);
		newStorage:SetPos(closet.Pos);
		newStorage:SetPassword(closet.Password);
		newStorage:SetAngles(closet.Angles);
		newStorage:Spawn();
		newStorage:Activate();
		local physObj = newStorage:GetPhysicsObject();
        physObj:EnableMotion(false);

		MsgCon(color_green, "Created passworded storage (" .. closet.ID .. ") at position " .. tostring(closet.Pos) .. ".", true);
	end
end);

hook.Add("OnInit", "LoadPhysBlacklist", function()
	MsgCon(color_green, "Loading physgun blacklist...");

	local blacklist = "";
	if file.Exists("vars/physblacklist.txt", "DATA") then
		blacklist = file.Read("vars/physblacklist.txt", "DATA");
	else
		BASH:CreateFile("vars/physblacklist.txt");
		blacklist = "[]";
	end

	blacklist = util.JSONToTable(blacklist);
	BASH.PhysgunBlacklist = blacklist;
	MsgCon(color_green, "Loaded physgun blacklist! Entries: " .. table.Count(BASH.PhysgunBlacklist));
end);

function BASH:LoadPersist()
	MsgCon(color_green, "Loading map persist file...");

	local file = file.Read("persist/" .. game.GetMap() .. "_.txt");
	if !file then
		MsgCon(color_green, "No map persist file found.");
		return;
	end

	local tab = util.JSONToTable(file);
	if !tab then return end;
	if !tab.Entities then return end;
	if !tab.Constraints then return end;

	local ents, consts = duplicator.Paste(nil, tab.Entities, tab.Constraints);
	for _, ent in pairs(ents) do
		ent:SetPersistent(true);
	end

	MsgCon(color_green, "Map persist file loaded. Entities: " .. table.Count(tab.Entities) .. " - Constraints: " .. table.Count(tab.Constraints));
end

function BASH:LoadLoot()
	local map = game.GetMap();
	local loot = "";

	if file.Exists("vars/loot/" .. map .. ".txt", "DATA") then
		loot = file.Read("vars/loot/" .. map .. ".txt", "DATA");
	else
		self:CreateDirectory("vars/loot");
		self:CreateFile("vars/loot/" .. map .. ".txt");
		loot = "[]";
	end

	loot = util.JSONToTable(loot) or {};
	self.Loot = loot;
	self.LootEnts = {};
	for id, lootData in pairs(self.Loot) do
		self.LootEnts[id] = ents.Create("bash_loot");
		self.LootEnts[id]:SetPos(lootData.Pos);
		self.LootEnts[id]:SetID(id);
		self.LootEnts[id]:SetDelay(lootData.Delay);
	end
end
hook.Add("OnUnsafeRemove", "UnsafeLootRemove", function(ent)
	if !ent or !ent:IsValid() then return end;
	if !ent.IsLoot then return end;

	BASH:RemoveWritingData(ent.Writing);
end);

function BASH:LoadWriting()
	local writing = "";

	if file.Exists("vars/writing.txt", "DATA") then
		writing = file.Read("vars/writing.txt", "DATA");
	else
		self:CreateFile("vars/writing.txt");
	end

	self.WritingData = util.JSONToTable(writing) or {};
	MsgCon(color_purple, "Loaded writing data! Entries: " .. table.Count(self.WritingData));
end


function BASH:NewWritingData(id)
	if !self.WritingData or !id then return end;

	self.WritingData[id] = "";
	MsgCon(color_purple, "New writing registered: " .. id);
end

function BASH:RemoveWritingData(id)
	if !self.WritingData or !id then return end;

	self.WritingData[id] = nil;

	MsgCon(color_purple, "Writing destroyed: " .. id);
end
hook.Add("OnUnsafeRemove", "UnsafeWritingRemove", function(ent)
	if !ent or !ent:IsValid() then return end;
	if !ent.ItemData.IsWritable then return end;

	BASH:RemoveWritingData(ent.Writing);
end);

function BASH:SaveWriting()
	if !self.WritingData or self.WritingData == {} then return end;
	local writing = util.TableToJSON(self.WritingData, true);
	self:WriteToFile("vars/writing.txt", writing, true);

	MsgCon(color_purple, "Saved writing data! Entries: " .. table.Count(self.WritingData));
end
hook.Add("ShutDown", "SaveWriting", function()
	BASH:SaveWriting();
end);

local function PeriodicSave()
    MsgCon(color_blue, "Saving all variable data...");

	local writing = util.TableToJSON(BASH.WritingData, true);
	BASH:WriteToFile("vars/writing.txt", writing, true);
	MsgCon(color_purple, "Saved writing data! Entries: " .. table.Count(BASH.WritingData));

	local closets = ents.FindByClass("bash_storage");
	if !closets then return end;
	local save = {};
	local index = 1;
	for _, closet in pairs(closets) do
		if closet.Password and closet.Password != "" then
			save[index] = {};
			save[index].ID = closet.InventoryID;
			save[index].Model = closet.ModelOverride;
			save[index].Pos = closet:GetPos();
			save[index].Angles = closet:GetAngles();
			save[index].Inventory = closet.Inventory;
			save[index].Owner = closet.Owner;
			save[index].Password = closet.Password;
			index = index + 1;
		end
	end

	save = util.TableToJSON(save, true);
	BASH:WriteToFile("vars/storage/" .. game.GetMap() .. ".txt", save, true);
	MsgCon(color_purple, "Saved passworded storage! Entries: " .. tostring(index - 1));

	local loots = ents.FindByClass("bash_loot");
	if !loots then return end;
	index = 1;
	save = {};
	for _, loot in pairs(loots) do
		local id = loot.LootID;
		save[id] = {};
		save[id].Pos = loot:GetPos();
		save[id].Delay = loot.Delay;
		index = index + 1;
	end

	save = util.TableToJSON(save, true);
	BASH:WriteToFile("vars/loot/" .. game.GetMap() .. ".txt", save, true);
	MsgCon(color_purple, "Saved loot spawns! Entries: " .. tostring(index - 1));

	local blacklist = util.TableToJSON(BASH.PhysgunBlacklist, true);
	BASH:WriteToFile("vars/physblacklist.txt", blacklist, true);
	MsgCon(color_purple, "Saved physgun blacklist! Entries: " .. table.Count(BASH.PhysgunBlacklist));

	hook.Call("PeriodicSave", BASH);

    MsgCon(color_blue, "Completed variable data save.");
end
timer.Create("PeriodicSave", 300, 0, PeriodicSave);

hook.Add("ShutDown", "SavePasswordedStorage", function()
	local closets = ents.FindByClass("bash_storage");
	if !closets then return end;
	local save = {};
	local index = 1;
	for _, closet in pairs(closets) do
		if closet.Password and closet.Password != "" then
			save[index] = {};
			save[index].ID = closet.InventoryID;
			save[index].Model = closet.ModelOverride;
			save[index].Pos = closet:GetPos();
			save[index].Angles = closet:GetAngles();
			save[index].Inventory = closet.Inventory;
			save[index].Owner = closet.Owner;
			save[index].Password = closet.Password;
			index = index + 1;
		end
	end

	save = util.TableToJSON(save, true);
	BASH:WriteToFile("vars/storage/" .. game.GetMap() .. ".txt", save, true);
	MsgCon(color_purple, "Saved passworded storage! Entries: " .. tostring(index - 1));
end);

hook.Add("ShutDown", "SaveLoot", function()
	local loots = ents.FindByClass("bash_loot");
	if !loots then return end;
	local index = 1;
	local save = {};
	for _, loot in pairs(loots) do
		local id = loot.LootID;
		save[id] = {};
		save[id].Pos = loot:GetPos();
		save[id].Delay = loot.Delay;
		index = index + 1;
	end

	save = util.TableToJSON(save, true);
	BASH:WriteToFile("vars/loot/" .. game.GetMap() .. ".txt", save, true);
	MsgCon(color_purple, "Saved loot spawns! Entries: " .. tostring(index - 1));
end);

hook.Add("ShutDown", "SavePhysgunBlacklist", function()
	if !BASH.PhysgunBlacklist or BASH.PhysgunBlacklist == {} then return end;
	local blacklist = util.TableToJSON(BASH.PhysgunBlacklist or {}, true);
	BASH:WriteToFile("vars/physblacklist.txt", blacklist, true);

	MsgCon(color_purple, "Saved physgun blacklist! Entries: " .. table.Count(BASH.PhysgunBlacklist));
end);
