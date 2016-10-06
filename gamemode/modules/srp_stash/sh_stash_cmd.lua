local BASH = BASH;

local function CreateStashChat(ply, text)
	ply:ConCommand("#!/createstash " .. text);
end
BASH:AddChatCMD({"/stash", "/createstash"}, CreateStashChat, "<password> - Creates a stash out of whatever item your character is currently looking at with the password <password>.");

local function UncoverStashChat(ply, text)
	ply:ConCommand("#!/uncoverstash " .. text);
end
BASH:AddChatCMD({"/uncover", "/uncoverstash", "/recover", "/recoverstash"}, UncoverStashChat, "<password> - Uncovers any stashes in the surrounding area with the password <password>.");
