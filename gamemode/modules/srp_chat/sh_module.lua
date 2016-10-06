local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_CHAT";
MODULE.Name = "SRP Chat System";
MODULE.Author = "LilSumac";
MODULE.Description = "Chat GUI and back-end system with STALKER-themed features.";

if CLIENT then
	include("cl_chat.lua");
	include("sh_chat.lua");
else
	AddCSLuaFile("cl_chat.lua");
	AddCSLuaFile("sh_chat.lua");
	include("sh_chat.lua");
	include("sv_chat.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
