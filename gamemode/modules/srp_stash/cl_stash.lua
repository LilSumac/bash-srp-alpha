local BASH = BASH;

netstream.Hook("BASH_Send_StashInfo", function(data)
    if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;
    if !data then return end;

    LocalPlayer():PrintChat("New stash created! Check the developer console (~) for the generated stash data string.");
    MsgCon(color_green, data);
end);
