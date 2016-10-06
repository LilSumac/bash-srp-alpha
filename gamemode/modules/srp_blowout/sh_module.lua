local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_BLOWOUT";
MODULE.Name = "SRP Blowout System";
MODULE.Author = "LilSumac";
MODULE.Description = "Adds admin-created blowouts for server events.";

if CLIENT then
	include("cl_blowout.lua");
else
	AddCSLuaFile("cl_blowout.lua");
	include("sv_blowout.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
