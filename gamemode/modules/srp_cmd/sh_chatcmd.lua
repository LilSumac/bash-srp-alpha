local BASH = BASH;
BASH.PlayerCMD = {};
BASH.AdminCMD = {};

function BASH:AddChatCMD(keywords, callback, description, adminOnly)
	if !self.ChatCMD then
		self.ChatCMD = {};
		self.ChatCMDFormatted = {};
	end

	local index = #self.ChatCMDFormatted + 1;
	self.ChatCMDFormatted[index] = {};
	self.ChatCMDFormatted[index].Keywords = keywords;
	self.ChatCMDFormatted[index].Desc = description or "";
	self.ChatCMDFormatted[index].AdminOnly = adminOnly or false;

	for _, word in pairs(keywords) do
		self.ChatCMD[word] = {};
		self.ChatCMD[word].Func = callback;
		self.ChatCMD[word].Desc = description or "";
	end
end

local BASH = BASH;

/*
**	LANGUAGE COMMANDS
*/
local function English(ply, text)
	ply:ConCommand("#!/lang eng " .. text);
end
BASH:AddChatCMD({"/eng"}, English)

local function French(ply, text)
	ply:ConCommand("#!/lang fre " .. text);
end
BASH:AddChatCMD({"/fre"}, French)

local function German(ply, text)
	ply:ConCommand("#!/lang ger " .. text);
end
BASH:AddChatCMD({"/ger"}, German)

local function Italian(ply, text)
	ply:ConCommand("#!/lang ita " .. text);
end
BASH:AddChatCMD({"/ita"}, Italian)

local function Polish(ply, text)
	ply:ConCommand("#!/lang pol " .. text);
end
BASH:AddChatCMD({"/pol"}, Polish)

local function Spanish(ply, text)
	ply:ConCommand("#!/lang spa " .. text);
end
BASH:AddChatCMD({"/spa"}, Spanish)

/*
**	PLAYER COMMANDS
*/
local function GiveMoney(ply, text)
	ply:ConCommand("#!/givemoney " .. text);
end
BASH:AddChatCMD({"/giverubles", "/givemoney", "/pay"}, GiveMoney, "<amount> - Gives the <amount> of money to the player you're looking at (within range).");

local function BundleMoney(ply, text)
	ply:ConCommand("#!/bundlemoney " .. text);
end
BASH:AddChatCMD({"/bundlemoney", "/bundlerubles", "/bundle"}, BundleMoney, "<amount> - Turns <amount> ruble(s) into a physical item and adds it to your inventory.");

local function DropMoney(ply, text)
	ply:ConCommand("#!/dropmoney " .. text);
end
BASH:AddChatCMD({"/dropmoney", "/droprubles"}, DropMoney, "<rubles> - Turns <amount> ruble(s) into a physical item and drops it in front of you.");

local function Roll(ply, text)
	ply:ConCommand("#!/roll " .. text);
end
BASH:AddChatCMD({"/roll"}, Roll, "<maxRoll> - Rolls for a random number from 1 to <maxRoll>.");

local function PatDown(ply, text)
	ply:ConCommand("#!/patdown " .. text);
end
BASH:AddChatCMD({"/patdown", "/search"}, PatDown, "<no args> - Sends a pat-down request to the person you're looking at.");

local function ToggleConv(ply, text)
	ply:ConCommand("#!/toggleconv " .. text);
end
BASH:AddChatCMD({"/toggleconv", "/toggleconvo"}, ToggleConv, "<no args> - Toggles whether the character you're currently looking at is part of your conversation.");

local function ResetConv(ply, text)
	ply:ConCommand("#!/resetconv " .. text);
end
BASH:AddChatCMD({"/resetconv", "/resetconvo"}, ResetConv, "<no args> - Clears all characters from your conversation.");

local function PMCharacter(ply, text)
	ply:ConCommand("#!/pmc " .. text);
end
BASH:AddChatCMD({"/pm", "/pmc", "/pmchar", "/pmcharacter"}, PMCharacter, "<target>, <message> - Sends an OOC private message to the character with the name <target>.");

local function PMPlayer(ply, text)
	ply:ConCommand("#!/pmp " .. text);
end
BASH:AddChatCMD({"/pmp", "/pmply", "/pmplayer"}, PMPlayer, "<target>, <message> - Sends an OOC private message to the player with the Steam name <target>.");

local function PropDesc(ply, text)
	ply:ConCommand("#!/propdesc " .. text);
end
BASH:AddChatCMD({"/setdesc", "/propdesc", "/desc"}, PropDesc, "<desc> - Sets the description for the prop you're currently looking at.");

local function AddBounty(ply, text)
	ply:ConCommand("#!/createbounty " .. text);
end
BASH:AddChatCMD({"/addbounty", "/createbounty", "/bounty"}, AddBounty, "<target>, <price>, <description>, <owner> - Adds a bounty on the <target> for <price> with <description> owned by <owner>.");

local function RemoveBounty(ply, text)
	ply:ConCommand("#!/removebounty " .. text);
end
BASH:AddChatCMD({"/deletebounty", "/removebounty"}, RemoveBounty, "<bountyID> - Deletes the bounty connected to <bountyID>.");

local function EditBounty(ply, text)
	ply:ConCommand("#!/editbounty " .. text);
end
BASH:AddChatCMD({"/editbounty"}, EditBounty, "<bountyID> - Edits the bounty connected to <bountyID>.")

local function AddGroup(ply, text)
	ply:ConCommand("#!/creategroup " .. text);
end
BASH:AddChatCMD({"/addgroup", "/creategroup"}, AddGroup, "<name>, <description>, <leader>, <hiring>, <red>, <green>, <blue> - Adds a group with the given <name>, <description>, <leader>, <hiring> status, and <red> <green> <blue> color.");

local function RemoveGroup(ply, text)
	ply:ConCommand("#!/removegroup " .. text);
end
BASH:AddChatCMD({"/deletegroup", "/removegroup"}, RemoveGroup, "<groupID> - Deletes the group connected to <groupID>.");

local function EditGroup(ply, text)
	ply:ConCommand("#!/editgroup " .. text);
end
BASH:AddChatCMD({"/editGroup"}, EditGroup, "<groupID> - Edits the group connected to <groupID>.")

local function AddAdvert(ply, text)
	ply:ConCommand("#!/createadvert " .. text);
end
BASH:AddChatCMD({"/addadvert", "/createadvert", "/advert"}, AddAdvert, "<title>, <description>, <owner> - Creates a PDA advert with <title> and <description> owned by <owner>.");

local function RemoveAdvert(ply, text)
	ply:ConCommand("#!/removeadvert " .. text);
end
BASH:AddChatCMD({"/deleteadvert", "/removeadvert"}, RemoveAdvert, "<advertID> - Deletes the advert connected to <advertID>.");

local function EditAdvert(ply, text)
	ply:ConCommand("#!/editadvert " .. text);
end
BASH:AddChatCMD({"/editadvert"}, EditAdvert, "<advertID> - Edits the advert connected to <advertID>.")

local function GrantLoot(ply, text)
	ply:ConCommand("#!/grantloot " .. text);
end
BASH:AddChatCMD({"/getloot", "/grantloot"}, GrantLoot, "<no args> - Claims loot for making missions on traders and coordinators. This command has a 48-hour timer.");

local function OpenPAC(ply, text)
	ply:ConCommand("pac_editor");
end
BASH:AddChatCMD({"/openpac", "/pac"}, OpenPAC, "<no args> - Opens the PAC editor.");

local function Noclip(ply, text)
	ply:ConCommand("#!/noclip");
end
BASH:AddChatCMD({"/noclip", "/observe", "/observer"}, Noclip, "<no args> - Enables/Disables noclip mode.");

/*
**	ADMIN COMMANDS
*/
local function AdminESP(ply, text)
	ply:ConCommand("#!/esp " .. text);
end
BASH:AddChatCMD({"/esp"}, AdminESP, "<no args> - Toggles the admin ESP.", true);

local function CreateItem(ply, text)
	ply:ConCommand("#!/createitem " .. text);
end
BASH:AddChatCMD({"/createitem", "/spawnitem"}, CreateItem, "<itemID>, <itemArgs (optional)> - Creates a brand new item with <itemID> and <itemArgs>.", true);

local function CreateStorage(ply, text)
	ply:ConCommand("#!/createstorage " .. text);
end
BASH:AddChatCMD({"/createstorage", "/spawnstorage"}, CreateStorage, "<invID>, <modelPath (optional)> - Creates a storage container with the given <invID> and <modelPath>.", true);

local function SetPassword(ply, text)
	ply:ConCommand("#!/setpassword " .. text);
end
BASH:AddChatCMD({"/setpassword", "/setstoragepassword"}, SetPassword, "<password> - Sets the password for the storage object you're currently looking at.", true);

local function Stockpile(ply, text)
	ply:ConCommand("#!/stockpile " .. text);
end
BASH:AddChatCMD({"/spawnstockpile", "/stockpile"}, Stockpile, "<no args> - Spawns a stockpile where you're currently looking.", true);

local function Grant(ply, text)
	ply:ConCommand("#!/grantmoney " .. text);
end
BASH:AddChatCMD({"/grant", "/grantrubles", "/grantmoney"}, Grant, "<target>, <amount> - Grants <target> with <amount> of money.", true);

local function Drain(ply, text)
	ply:ConCommand("#!/drainmoney " .. text);
end
BASH:AddChatCMD({"/drain", "/drainrubles", "/drainmoney"}, Drain, "<target>, <amount> - Drains <target> of <amount> money.", true);

local function SetModel(ply, text)
	ply:ConCommand("#!/setmodel " .. text);
end
BASH:AddChatCMD({"/setmodel", "/changemodel"}, SetModel, "<target>, <path> - Sets <target>'s model to <path>.", true);

local function SetFaction(ply, text)
	ply:ConCommand("#!/setfaction " .. text);
end
BASH:AddChatCMD({"/setfaction"}, SetFaction,  "<target>, <factionID> - Sets <target>'s faction to <factionID>.", true)

local function Mute(ply, text)
	ply:ConCommand("#!/mute " .. text);
end
BASH:AddChatCMD({"/mute"}, Mute, "<target> - Mutes <target> in global OOC.", true);

local function UnMute(ply, text)
	ply:ConCommand("#!/unmute " .. text);
end
BASH:AddChatCMD({"/unmute"}, UnMute, "<target> - Unmutes <target> in global OOC.", true);

local function Bring(ply, text)
	ply:ConCommand("#!/bring " .. text);
end
BASH:AddChatCMD({"/bring"}, Bring, "<target> - Brings <target> to your current location.", true);

local function ReturnLast(ply, text)
	ply:ConCommand("#!/returnlast " .. text);
end
BASH:AddChatCMD({"/return", "/returnlast"}, ReturnLast, "<no args> - Returns the last person you brought to their original location.", true);

local function Slay(ply, text)
	ply:ConCommand("#!/slay " .. text);
end
BASH:AddChatCMD({"/slay"}, Slay, "<target> - Kills <target>.", true);

local function TimedKill(ply, text)
	ply:ConCommand("#!/timedkill " .. text);
end
BASH:AddChatCMD({"/timedkill"}, TimedKill, "<target>, <time> - Kills <target> for <time> minutes (or permanently).", true);

local function Kick(ply, text)
	ply:ConCommand("#!/kick " .. text);
end
BASH:AddChatCMD({"/kick"}, Kick, "<target>, <reason> - Kicks <target> from the game with given <reason> (optional).", true);

local function Ban(ply, text)
	ply:ConCommand("#!/ban " .. text);
end
BASH:AddChatCMD({"/ban"}, Ban, "<target>, <minutes>, <reason> - Bans <target> from the server for <minutes> with given <reason>.", true);

local function BanID(ply, text)
	ply:ConCommand("#!/banid " .. text);
end
BASH:AddChatCMD({"/banid"}, BanID, "<steamID>, <minutes>, <reason> - Bans <steamID> from the server for <minutes> with given <reason>.", true);

local function SetSpawn(ply, text)
	ply:ConCommand("#!/setspawn " .. text);
end
BASH:AddChatCMD({"/setspawn"}, SetSpawn, "<no args> - Sets the default spawn point override to your current location.", true);

local function FactionSpawn(ply, text)
	ply:ConCommand("#!/factionspawn " .. text);
end
BASH:AddChatCMD({"/factionspawn"}, FactionSpawn, "<faction> - Sets the <faction> spawn to your current location.", true);

local function RemoveSpawn(ply, text)
	ply:ConCommand("#!/removespawn " .. text);
end
BASH:AddChatCMD({"/removespawn"}, RemoveSpawn, "<no args> - Removes the overridden default spawn point.", true);

local function OOCDelay(ply, text)
	ply:ConCommand("#!/setoocdelay " .. text);
end
BASH:AddChatCMD({"/oocdelay", "/setoocdelay"}, OOCDelay, "<delay> - Sets the OOC delay to <delay> seconds.", true);

local function EditCharFlags(ply, text)
	ply:ConCommand("#!/editcharflags " .. text);
end
BASH:AddChatCMD({"/editcharflags", "/editcharacterflags"}, EditCharFlags, "<target> - Edits character flags for <target>.", true);

local function EditPlayerFlags(ply, text)
	ply:ConCommand("#!/editplayerflags " .. text);
end
BASH:AddChatCMD({"/editplyflags", "/editplayerflags"}, EditPlayerFlags, "<target> - Edits character flags for <target>.", true);

local function EditWhitelists(ply, text)
	ply:ConCommand("#!/editwhitelists " .. text);
end
BASH:AddChatCMD({"/editwhitelists"}, EditWhitelists, "<target> - Edits whitelists for <target>.", true);

local function History(ply, text)
	ply:ConCommand("#!/history " .. text);
end
BASH:AddChatCMD({"/history", "/edithistory"}, History, "<target> - Opens the history for <target>.", true);

local function ConcMsg(ply, text)
	ply:ConCommand("#!/conc " .. text);
end
BASH:AddChatCMD({"/mind", "/conc"}, ConcMsg, "<target>, <message> - Sends <message> to be displayed to the <target> as their conscience.", true);

local function Youtube(ply, text)
	ply:ConCommand("#!/youtube " .. text);
end
BASH:AddChatCMD({"/youtube"}, Youtube, "<youtubeid> - Plays the audio of a Youtube video with <youtubeid> for all connected players.", true);

local function KillYoutube(ply, text)
	ply:ConCommand("#!/killyoutube " .. text);
end
BASH:AddChatCMD({"/killyoutube"}, KillYoutube, "<no args> - Stops the currently playing Youtube video.", true);

local function GetCharInfo(ply, text)
	ply:ConCommand("#!/getcharinfo " .. text);
end
BASH:AddChatCMD({"/charinfo", "/getcharinfo"}, GetCharInfo, "<target> - Prints out extensive information about <target> in your console.", true);

local function PhysgunBan(ply, text)
	ply:ConCommand("#!/physgunban " .. text);
end
BASH:AddChatCMD({"/physban", "/physgunban"}, PhysgunBan, "<target> - Bans <target> from using the physgun.", true);

local function PhysgunBanID(ply, text)
	ply:ConCommand("#!/physgunbanid " .. text);
end
BASH:AddChatCMD({"/physbanid", "/physgunbanid"}, PhysgunBanID, "<steamid> - Bans <steamid> from using the physgun.", true);

local function PhysgunUnban(ply, text)
	ply:ConCommand("#!/physgununban " .. text);
end
BASH:AddChatCMD({"/physunban", "/physgununban"}, PhysgunUnban, "<target> - Grants <target> access to the physgun.", true);

local function PhysgunUnbanID(ply, text)
	ply:ConCommand("#!/physgununbanid " .. text);
end
BASH:AddChatCMD({"/physunbanid", "/physgununbanid"}, PhysgunUnbanID, "<steamid> - Grants <steamid> access to the physgun.", true);
