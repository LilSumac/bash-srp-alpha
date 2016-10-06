local BASH = BASH;

netstream.Hook("BASH_Request_Messages_Return", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;
    
    BASH.ChatData = data;
    local rec = data.Owner;

    if !BASH.MessageNotif then
        BASH.MessageNotif = {};
    end
    if !BASH.PDANotifs then
        BASH.PDANotifs = {};
    end

    if !BASH.PDA.Open then
        LocalPlayer():PrintChat("Your PDA vibrates.");
    end

    if BASH.PDA.CurrentApp != 1 then
        BASH.MessageNotif[rec] = true;
        return;
    end

	BASH:RefreshContacts();
end);

netstream.Hook("BASH_Failed_Chat", function(blocked)
    if blocked then
        Derma_Message("This chat is no longer available.", "Chat Error", "Accept");
    else
        Derma_Message("No SIM data was found attached to that handle!", "Chat Error", "Accept");
    end
end);

netstream.Hook("BASH_Send_Message_Return", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;

    local sender = data[1];
    local rec = data[2];
    local chatID = data[3];
    local message = data[4];
    if !sender or !rec or !chatID or !message then return end;

    if !BASH.MessageNotif then
        BASH.MessageNotif = {};
    end
    if !BASH.PDANotifs then
        BASH.PDANotifs = {};
    end

    if !BASH.PDA.Open then
        LocalPlayer():PrintChat("Your PDA vibrates.");
    end

    if BASH.PDA.CurrentApp != 1 then
        if !BASH.PDANotifs[rec] then
            BASH.PDANotifs[rec] = {};
        end
        BASH.PDANotifs[rec][chatID] = true;
        BASH.MessageNotif[rec] = true;
        return;
    else
        if BASH.PDA.Content.Container.Right and BASH.PDA.Content.Container.Right:IsValid() and BASH.PDA.Content.Container.Right.ContactChatID then
            if BASH.PDA.Content.Container.Right.ContactChatID != chatID then
                if !BASH.PDANotifs[rec] then
                    BASH.PDANotifs[rec] = {};
                end
                BASH.PDANotifs[rec][chatID] = true;
                BASH.MessageNotif[rec] = true;
                return;
            end
        end
    end

    BASH:HandleNewMessage(sender, chatID, message);
end);

netstream.Hook("BASH_Block_Contact_Return", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !BASH.PDA.Open then return end;

    if BASH.PDA.Content.Container and BASH.PDA.Content.Container.Right and BASH.PDA.Content.Container.Right.ChatWrapper and BASH.PDA.Content.Container.Right.ChatWrapper:IsValid() then
        BASH.PDA.Content.Container.Right.ChatWrapper:Remove();
        BASH.PDA.Content.Container.Right.ChatWrapper = nil;
    end

    BASH.PDA.Content.Container:Remove();
    BASH:ContactsApp();
end);

netstream.Hook("BASH_Confirm_Unblock", function(data)
    if !data then return end;

    Derma_Query("This contact is blocked. Do you want to unblock this contact?", "Confirm Unblock", "Cancel", function() end,
                "Unblock", function()
                    netstream.Start("BASH_Unblock_Contact", {BASH.PDA.SIMCard, data});
                end);
end);
