local BASH = BASH;
local Player = FindMetaTable("Player");

hook.Add("OnInit", "LoadChats", function()
    BASH.ChatBrain = {};

	local chat = "";
	local chatID = "";
	local files, _ = file.Find("vars/chats/*.txt", "DATA");
	for index, fileName in pairs(files) do
		chatID = string.sub(fileName, 1, string.len(fileName) - 4);
		chat = file.Read("vars/chats/" .. fileName, "DATA");
		chat = util.JSONToTable(chat);

		BASH.ChatBrain[chatID] = chat;
	end

	MsgCon(color_purple, "Loaded chat data! Entries: " .. table.Count(BASH.ChatBrain));
end);

hook.Add("ShutDown", "SaveChats", function()
    for id, chat in pairs(BASH.ChatBrain) do
		BASH:WriteToFile("vars/chats/" .. id .. ".txt", util.TableToJSON(chat, true), true);
	end

	MsgCon(color_purple, "Saved chat data! Entries: " .. table.Count(BASH.ChatBrain));
end);

local function PeriodicSave()
	for id, chat in pairs(BASH.ChatBrain) do
		BASH:WriteToFile("vars/chats/" .. id .. ".txt", util.TableToJSON(chat, true), true);
	end

	MsgCon(color_purple, "Saved chat data! Entries: " .. table.Count(BASH.ChatBrain));
end
hook.Add("PeriodicSave", "ChatsPeriodicSave", PeriodicSave);

function BASH:GetMessageData(sim)
    local simData = BASH.SIMData[sim];
    if !simData then return end;
    local newData = {};
    newData.Owner = sim;
    for contactSIM, chatID in pairs(simData.Contacts) do
        local contactData = BASH.SIMData[contactSIM];
        local chatData = BASH.ChatBrain[chatID];
        if contactData and chatData and !simData.Blocked[contactSIM] then
            newData[contactSIM] = {};
            newData[contactSIM].Handle = contactData.Handle;
            newData[contactSIM].ChatID = chatID;
            newData[contactSIM].Chat = chatData.Chat;
        end
    end
    return newData;
end

function BASH:GetSIMByHandle(handle)
    for sim, data in pairs(self.SIMData) do
        if data.Handle == handle then
            return sim;
        end
    end
end

netstream.Hook("BASH_Request_Messages", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local sim = data;
    local newData = BASH:GetMessageData(sim);

    netstream.Start(ply, "BASH_Request_Messages_Return", newData);
end);

netstream.Hook("BASH_New_Message", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local sim = data[1];
    local handle = data[2];
    if !sim or !handle then return end;
    local simData = BASH.SIMData[sim];
    local contactSIM = BASH:GetSIMByHandle(handle);
    local contactData = BASH.SIMData[contactSIM];
    if !contactSIM or (contactData and contactData.Blocked[sim]) then
        netstream.Start(ply, "BASH_Failed_Chat");
        return;
    end
    if simData.Blocked[contactSIM] then
        netstream.Start(ply, "BASH_Confirm_Unblock", contactSIM);
        return;
    end

    local simData = BASH.SIMData[sim];
    local chatID = RandomString(12);
    BASH.SIMData[sim].Contacts[contactSIM] = chatID;
    BASH.SIMData[contactSIM].Contacts[sim] = chatID;
    BASH.ChatBrain[chatID] = {};
    BASH.ChatBrain[chatID].Participants = {sim, contactSIM};
    BASH.ChatBrain[chatID].Chat = {};
    BASH.ChatBrain[chatID].Chat[1] = {};
    BASH.ChatBrain[chatID].Chat[1].Sender = sim;
    BASH.ChatBrain[chatID].Chat[1].Message = simData.Handle .. " has started a chat.";

    local newData = BASH:GetMessageData(sim);
    netstream.Start(ply, "BASH_Request_Messages_Return", newData);

    local contact = BASH:GetSIMOwner(contactSIM);
    if contact and CheckPly(contact) and CheckChar(contact) and ply != contact then
        newData = BASH:GetMessageData(contactSIM);
        netstream.Start(contact, "BASH_Request_Messages_Return", newData);
    end
end);

netstream.Hook("BASH_Send_Message", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local senderSIM = data[1];
    local recSIM = data[2];
    local chatID = data[3];
    local message = data[4];
    if !senderSIM or !recSIM or !chatID or !message then return end;

    local recData = BASH.SIMData[recSIM];
    if recData and recData.Blocked[senderSIM] then
        netstream.Start(ply, "BASH_Failed_Chat", true);
        return;
    end

    local index = #BASH.ChatBrain[chatID].Chat + 1;
    BASH.ChatBrain[chatID].Chat[index] = {};
    BASH.ChatBrain[chatID].Chat[index].Sender = senderSIM;
    BASH.ChatBrain[chatID].Chat[index].Message = message;

    netstream.Start(ply, "BASH_Send_Message_Return", {senderSIM, recSIM, chatID, message});

    local contact = BASH:GetSIMOwner(recSIM);
    if contact and CheckPly(contact) and CheckChar(contact) and ply != contact then
        netstream.Start(contact, "BASH_Send_Message_Return", {senderSIM, recSIM, chatID, message});
    end
end);

netstream.Hook("BASH_Block_Contact", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local blocker = data[1];
    local blocked = data[2];
    if !blocker or !blocked then return end;

    if !BASH.SIMData[blocker] then return end;
    BASH.SIMData[blocker].Blocked[blocked] = true;

    netstream.Start(ply, "BASH_Block_Contact_Return");
end);

netstream.Hook("BASH_Unblock_Contact", function(ply, data)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !data then return end;

    local unblocker = data[1];
    local unblocked = data[2];
    if !unblocker or !unblocked then return end;

    if !BASH.SIMData[unblocker] then return end;
    BASH.SIMData[unblocker].Blocked[unblocked] = nil;

    netstream.Start(ply, "BASH_Block_Contact_Return");
end);
