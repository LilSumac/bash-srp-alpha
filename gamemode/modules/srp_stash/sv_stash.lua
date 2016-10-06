local BASH = BASH;

hook.Add("OnInit", "LoadStash", function()
	BASH:LoadStashes();
end);

hook.Add("ShutDown", "SaveStashes", function()
	local stashes = util.TableToJSON(BASH.StashData, true);
	BASH:WriteToFile("vars/stashes/" .. game.GetMap() .. ".txt", stashes, true);

	MsgCon(color_purple, "Saved stash data! Entries: " .. table.Count(BASH.StashData));
end);

function BASH:LoadStashes()
	local stashes = "";

	if file.Exists("vars/stashes/" .. game.GetMap() .. ".txt", "DATA") then
		stashes = file.Read("vars/stashes/" .. game.GetMap() .. ".txt", "DATA");
	else
		self:CreateFile("vars/stashes/" .. game.GetMap() .. ".txt");
	end

	self.StashData = util.JSONToTable(stashes) or {};
	MsgCon(color_purple, "Loaded stash data! Entries: " .. table.Count(self.StashData));
end

local function PeriodicSave()
	local stash = util.TableToJSON(BASH.StashData, true);
	BASH:WriteToFile("vars/stashes/" .. game.GetMap() .. ".txt", stash, true);

	MsgCon(color_purple, "Saved stash data! Entries: " .. table.Count(BASH.StashData));
end
hook.Add("PeriodicSave", "StashPeriodicSave", PeriodicSave);
