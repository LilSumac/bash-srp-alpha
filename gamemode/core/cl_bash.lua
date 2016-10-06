local BASH = BASH;

DeriveGamemode("sandbox");

//	Some client config settings.
CreateClientConVar("bash_show_hud", 1, true, false);
CreateClientConVar("bash_play_youtube", 1, true, false);
CreateClientConVar("bash_log_enabled", 1, true, false);

//	Default BASH fonts.
surface.CreateFont("BASHFontIntro", {
	size = 16,
	weight = 500,
	font = "Courier Prime",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontLight", {
	size = 14,
	weight = 500,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontFlavor", {
	size = 14,
	weight = 500,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false,
	italic = true
});

surface.CreateFont("BASHFontYell", {
	size = 18,
	weight = 700,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontHeavy", {
	size = 14,
	weight = 700,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontSmall", {
	size = 12,
	weight = 500,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontLarge", {
	size = 24,
	weight = 700,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontApp", {
	size = 36,
	weight = 500,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false
});

surface.CreateFont("BASHFontLargeItalic", {
	size = 24,
	weight = 700,
	font = "DevaVu Sans Mono",
	antialias = true,
	additive = false,
	italic = true
});

//	Who the fuck broke this shit?
TEXT_ALIGN_TOP = 4;
TEXT_ALIGN_BOTTOM = 3;

function BASH:Init()
	//	Initialization process.
	hook.Call("OnInit", self);
	MsgCon(color_green, "Successfully initialized client-side. Init time: " .. math.Round(SysTime() - self.StartTime, 5) .. " seconds.", true);
	self.Initialized = true;

	/*
	if !steamworks.IsSubscribed(353475860) then
		self:NewBlip("WARNING! You are not subscribed to the necessary base BASH content! Click here to pull up the addon!",
			function()
				gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=353475860");
			end);
	end
	*/


	//	Enable map-specific error filtering.
	if game.GetMap() == "rp_stalker" or game.GetMap() == "rp_stalker_redux" then
		RunConsoleCommand("con_filter_enable", "1");
		RunConsoleCommand("con_filter_text_out", "steam_");
	end
end

//	Remove annoying default GMod features.
timer.Destroy("HintSystem_OpeningMenu");
timer.Destroy("HintSystem_Annoy1");
timer.Destroy("HintSystem_Annoy2");
concommand.Remove("gm_save");
concommand.Remove("act");
