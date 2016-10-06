local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_HUD";
MODULE.Name = "SRP HUD";
MODULE.Author = "LilSumac";
MODULE.Description = "Simple STALKER-themed STALKER HUD features.";

if CLIENT then
	include("cl_hud.lua");
else
	AddCSLuaFile("cl_hud.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
