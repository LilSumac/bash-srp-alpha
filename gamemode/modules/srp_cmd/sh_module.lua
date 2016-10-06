local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_CMD";
MODULE.Name = "SRP Command System";
MODULE.Author = "LilSumac";
MODULE.Description = "Simple back-end system for chat and console commands.";
MODULE.Dependencies = {"SRP_CHAT"};

if CLIENT then
	include("cl_concmd.lua");
	include("sh_chatcmd.lua");
elseif SERVER then
	AddCSLuaFile("cl_concmd.lua");
	AddCSLuaFile("sh_chatcmd.lua");
	include("sh_chatcmd.lua");
	include("sv_concmd.lua");

	util.AddNetworkString("BASH_Send_Screencap");
end

BASH.Modules[MODULE.ID] = MODULE;
