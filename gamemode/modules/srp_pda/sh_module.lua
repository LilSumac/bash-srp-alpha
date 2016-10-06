local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_PDA";
MODULE.Name = "SRP PDA System";
MODULE.Author = "LilSumac";
MODULE.Description = "Items and frameworks for PDA items and the STALKERnet.";
MODULE.Dependencies = {"SRP_CHAT", "SRP_ALERT", "SRP_STASH"};

if CLIENT then
	include("cl_messaging.lua");
	include("cl_pda.lua");
	include("sh_messaging.lua");
	include("sh_pda.lua");
	include("vgui/vgui_pda.lua");
	include("vgui/vgui_apps.lua");
else
	AddCSLuaFile("cl_messaging.lua");
	AddCSLuaFile("cl_pda.lua");
	AddCSLuaFile("sh_messaging.lua");
	AddCSLuaFile("sh_pda.lua");
	AddCSLuaFile("vgui/vgui_pda.lua");
	AddCSLuaFile("vgui/vgui_apps.lua");
	include("sh_messaging.lua");
	include("sh_pda.lua");
	include("sv_messaging.lua");
	include("sv_pda.lua");
end

BASH.Modules[MODULE.ID] = MODULE;

/*  Module Variables  */
BASH.Registry:NewVariable("Connection", 		0, 		true, false);
BASH.Registry:NewVariable("ClosestTower", 		0, 		false, false);
BASH.Registry:NewVariable("LastNetworkPing", 	0, 		false, false);
