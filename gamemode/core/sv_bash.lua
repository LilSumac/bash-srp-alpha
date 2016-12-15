local BASH = BASH;

DeriveGamemode("sandbox");
concommand.Remove("gm_save");

//	Add all necessary workshop content. Uncomment if you don't
//	want this.
/*
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
*/

/*
**	BASH.Init
**	Initial function called once all files have been processed.
*/
function BASH:Init()
	hook.Call("OnInit", self);
	self:LoadWriting();
	MsgCon(color_green, "Successfully initialized server-side. Init time: " .. math.Round(SysTime() - self.StartTime, 5) .. " seconds.", true);
	MsgCon(color_green, "***** SERVER STARTUP *****", true);

	self:SQLInit();
end

/*
**	InitPostEntity -> CreateEntities
**	Loads any persistant storage entities from the last server
**	shutdown.
*/
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

/*
**	OnInit -> LoadPhysBlacklist
**	Loads all blacklisted physgun entries.
*/
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
	BASH.PhysgunBlacklist = blacklist or {};
	MsgCon(color_green, "Loaded physgun blacklist! Entries: " .. table.Count(BASH.PhysgunBlacklist));
end);

/*
**	BASH.LoadPersist.
**	Loads any persistant entites from the last server shutdown.
*/
function BASH:LoadPersist()
	MsgCon(color_green, "Loading map persist file...");

	local file = file.Read("persist/" .. game.GetMap() .. "_.txt");
	if !file then
		MsgCon(color_green, "No map persist file found.");
		return;
	end

	local tab = util.JSONToTable(file) or {};
	if !tab then return end;
	if !tab.Entities then return end;
	if !tab.Constraints then return end;

	local ents, consts = duplicator.Paste(nil, tab.Entities, tab.Constraints);
	for _, ent in pairs(ents) do
		ent:SetPersistent(true);
	end

	MsgCon(color_green, "Map persist file loaded. Entities: " .. table.Count(tab.Entities) .. " - Constraints: " .. table.Count(tab.Constraints));
end

/*
**	BASH.LoadLoot
**	Loads any persistant loot entites from the last server shutdown.
*/
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

/*
**	BASH.LoadWriting
**	Loads any persistant writing data saved on the server.
*/
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

/*
**	BASH.NewWritingData
**	Creates a new entry under a given unique ID.
**		id: Unique ID to create the entry under.
*/
function BASH:NewWritingData(id)
	if !self.WritingData or !id then return end;

	self.WritingData[id] = "";
	MsgCon(color_purple, "New writing registered: " .. id);
end

/*
**	BASH.RemoveWritingData
**	Deletes a writing entry saved under the given ID.
**		id: ID of the entry to delete.
*/
function BASH:RemoveWritingData(id)
	if !self.WritingData or !id then return end;

	self.WritingData[id] = nil;
	MsgCon(color_purple, "Writing destroyed: " .. id);
end

/*
**	OnUnsafeRemove -> UnsafeWritingRemove
**	A hook called when an item is removed unsafely. If the item
**	has writing data attached to it, delete said data.
**		ent: Entity being removed.
*/
hook.Add("OnUnsafeRemove", "UnsafeWritingRemove", function(ent)
	if !ent or !ent:IsValid() then return end;
	if !ent.ItemData.IsWritable then return end;

	BASH:RemoveWritingData(ent.Writing);
end);

/*
**	BASH.SaveWriting
**	Saves all writing data from a table server-side to a file with a
**	JSON string.
*/
function BASH:SaveWriting()
	if !self.WritingData or self.WritingData == {} then return end;
				
	local writing = util.TableToJSON(self.WritingData or {}, true);
	self:WriteToFile("vars/writing.txt", writing, true);
	MsgCon(color_purple, "Saved writing data! Entries: " .. table.Count(self.WritingData));
end

/*
**	ShutDown -> SaveWriting
**	Saves writing on server shutdown.
*/
hook.Add("ShutDown", "SaveWriting", function()
	BASH:SaveWriting();
end);

/*
**	PeriodicSave
**	Saves all variable data every 5 minutes.
*/
local function PeriodicSave()
    MsgCon(color_blue, "Saving all variable data...");

	local writing = util.TableToJSON(BASH.WritingData or {}, true);
	BASH:WriteToFile("vars/writing.txt", writing, true);
	MsgCon(color_purple, "Saved writing data! Entries: " .. table.Count(BASH.WritingData or {}));

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

	local blacklist = util.TableToJSON(BASH.PhysgunBlacklist or {}, true);
	BASH:WriteToFile("vars/physblacklist.txt", blacklist, true);
	MsgCon(color_purple, "Saved physgun blacklist! Entries: " .. table.Count(blacklist));

	hook.Call("PeriodicSave", BASH);

    MsgCon(color_blue, "Completed variable data save.");
end
timer.Create("PeriodicSave", 300, 0, PeriodicSave);

/*
**	ShutDown -> SavePasswordedStorage
**	A hook called upon server shutdown that saves all persistant
**	storage entities.
*/
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

/*
**	ShutDown -> SaveLoot
**	A hook called upon server shutdown that saves all loot entities.
*/
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

/*
**	ShutDown -> SavePhysgunBlacklist
**	A hook called upon server shutdown that saves the physgun
**	blacklist.
*/
hook.Add("ShutDown", "SavePhysgunBlacklist", function()
	if !BASH.PhysgunBlacklist or BASH.PhysgunBlacklist == {} then return end;
					
	local blacklist = util.TableToJSON(BASH.PhysgunBlacklist or {}, true);
	BASH:WriteToFile("vars/physblacklist.txt", blacklist, true);
	MsgCon(color_purple, "Saved physgun blacklist! Entries: " .. table.Count(blacklist));
end);
