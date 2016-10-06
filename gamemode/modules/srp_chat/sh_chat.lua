local BASH = BASH;

//	Feat. Shitty Color Pallete
local color_ooc = Color(255, 255, 255);
local color_looc = Color(219, 219, 219);
local color_say = Color(100, 150, 200);
local color_act = Color(138, 185, 209);
local color_emp = Color(225, 230, 250);
local color_rad = Color(230, 230, 230);
local color_pda = Color(121, 189, 143);
local color_lev = Color(103, 215, 140);
local color_ev = Color(18, 176, 71);
local color_broad = Color(150, 0, 0);
local color_mind = Color(218, 167, 0);
local color_ad = Color(204, 102, 0);
local color_pm = Color(153, 51, 255);
CHAT_TYPES = {
	OOC =		{ID = 1, Command = {"//"}, Filters = {1, 2}, Range = 0, Font = "BASHFontHeavy", TextColor = color_ooc, ICLog = false, Desc = "Global OOC"},
	LOOC =		{ID = 2, Command = {".//", "[["}, Filters = {1, 2, 3}, Range = 375, Font = "BASHFontHeavy", TextColor = color_looc, ICLog = true, Desc = "Local OOC"},
	SAY =		{ID = 3, Filters = {1, 3}, Range = 250, Font = "BASHFontLight", TextColor = color_say, ICLog = true},
	WHISP =		{ID = 4, Command = {"/w", "/whis", "/whisper"}, AddSpace = true, Filters = {1, 3}, Range = 50, Font = "BASHFontSmall", TextColor = color_emp, ICLog = true, Desc = "Whisper"},
	YELL =		{ID = 5, Command = {"/y", "/yell"}, AddSpace = true, Filters = {1, 3}, Range = 750, Font = "BASHFontYell", TextColor = color_emp, ICLog = true, Desc = "Yell"},
	ME =		{ID = 6, Command = {"/me"}, AddSpace = true, Filters = {1, 3}, Range = 375, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Character Action"},
	MES =		{ID = 7, Command = {"/mes", "/me's"}, AddSpace = true, Filters = {1, 3}, Range = 375, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Character Action with 's"},
	LME =		{ID = 8, Command = {"/lme"}, AddSpace = true, Filters = {1, 3}, Range = 750, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Long Range Character Action"},
	LMES =		{ID = 9, Command = {"/lmes", "/lme's"}, AddSpace = true, Filters = {1, 3}, Range = 750, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Long Range Character Action with 's"},
	IT =		{ID = 10, Command = {"/it"}, AddSpace = true, Filters = {1, 3}, Range = 375, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Independent Action"},
	LIT =		{ID = 11, Command = {"/lit"}, AddSpace = true, Filters = {1, 3}, Range = 750, Font = "BASHFontHeavy", TextColor = color_act, ICLog = true, Desc = "Long Range Independent Action"},
	RADIO =		{ID = 12, Command = {"/r", "/rad", "/radio"}, AddSpace = true, Filters = {1, 3, 4}, Font = "BASHFontLight", TextColor = color_rad, ICLog = true, ServerFormat = true, Desc = "Radio Speaking"},
	RWHISP =	{ID = 13, Command = {"/rw", "/rwhisp", "/radiow"}, AddSpace = true, Filters = {1, 3, 4}, Font = "BASHFontSmall", TextColor = color_rad, ICLog = true, ServerFormat = true, Desc = "Radio Whispering"},
	RYELL =		{ID = 14, Command = {"/ry", "/ryell", "/radioy"}, AddSpace = true, Filters = {1, 3, 4}, Font = "BASHFontHeavy", TextColor = color_rad, ICLog = true, ServerFormat = true, Desc = "Radio Yelling"},
	LEVENT =	{ID = 15, Command = {"/lev", "/levent"}, AddSpace = true, Filters = {1, 3}, Font = "BASHFontHeavy", TextColor = color_lev, ICLog = true, ServerFormat = true, Desc = "Local Event"},
	EVENT =		{ID = 16, Command = {"/ev", "/event"}, AddSpace = true, Filters = {1, 3}, Font = "BASHFontHeavy", TextColor = color_ev, ICLog = true, ServerFormat = true, Desc = "Global Event"},
	BROAD =		{ID = 17, Command = {"/broad", "/broadcast"}, AddSpace = true, Filters = {1, 3}, Font = "BASHFontYell", TextColor = color_broad, ICLog = false, ServerFormat = true, Desc = "Global OOC Broadcast"},
	CONC =		{ID = 18, Command = {"/conc", "/mind"}, AddSpace = true, Filters = {1, 3}, Font = "BASHFontHeavy", TextColor = color_mind, ICLog = true, ServerFormat = true, Desc = "Personal Conciousness"},
	PM =		{ID = 19, Filters = {1, 2, 5}, Font = "BASHFontHeavy", TextColor = color_pm, ICLog = false},
	ADMIN =		{ID = 20, Command = {"/a", "/ad", "/admin"}, AddSpace = true, Filters = {1, 2, 6}, Font = "BASHFontHeavy", TextColor = color_ad, ICLog = false, ServerFormat = true, Desc = "Admin OOC"},
	CMD =		{ID = 21, Filters = {7}, Font = "BASHFontHeavy", TextColor = Color(0, 100, 150, 255), ICLog = false},
	UTIL =		{ID = 22, Filters = {1, 2, 3}, Font = "BASHFontHeavy", TextColor = Color(180, 180, 180, 255), ICLog = false}
};
function CHAT_TYPES.OOC.Format(ply, text)
	local consoleText = "[OOC] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. "): " .. text;
	text = "[OOC] " .. ply:GetEntry("Name") .. ": " .. text;
	return text, consoleText;
end
function CHAT_TYPES.LOOC.Format(ply, text)
	local consoleText = "[LOOC] " .. ply:GetEntry("Name") .. " (" .. ply:Name() .. "): " .. text;
	text = "[LOOC] " .. ply:GetEntry("Name") .. ": " .. text;
	return text, text;
end
function CHAT_TYPES.SAY.Format(ply, text)
	text = ply:GetEntry("Name") .. ' says, "' .. text .. '"';
	return text, text;
end
function CHAT_TYPES.WHISP.Format(ply, text)
	text = ply:GetEntry("Name") .. ' whispers, "' .. text .. '"';
	return text, text;
end
function CHAT_TYPES.YELL.Format(ply, text)
	text = ply:GetEntry("Name") .. ' yells, "' .. text .. '"';
	return text, text;
end
function CHAT_TYPES.ME.Format(ply, text)
	text = "**" .. ply:GetEntry("Name") .. " " .. text .. "**";
	return text, text;
end
function CHAT_TYPES.MES.Format(ply, text)
	text = "**" .. ply:GetEntry("Name") .. "'s " .. text .. "**";
	return text, text;
end
CHAT_TYPES.LME.Format = CHAT_TYPES.ME.Format;
CHAT_TYPES.LMES.Format = CHAT_TYPES.MES.Format;
function CHAT_TYPES.IT.Format(ply, text)
	local consoleText = "(" .. ply:GetEntry("Name") .. " [" .. ply:Name() .. "] has used /it.)\n**" .. text .. "**";
	text = "**" .. text .. "**";
	return text, consoleText;
end
function CHAT_TYPES.LIT.Format(ply, text)
	local consoleText = "(" .. ply:GetEntry("Name") .. " [" .. ply:Name() .. "] has used /lit.)\n**" .. text .. "**";
	text = "**" .. text .. "**";
	return text, consoleText;
end
