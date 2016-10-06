local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_TECH";
MODULE.Name = "SRP Technician System";
MODULE.Author = "LilSumac";
MODULE.Description = "Repair/Upgrade GUI and back-end systems for technician characters."

if CLIENT then
	include("sh_tech.lua");
else
	AddCSLuaFile("sh_tech.lua");
	include("sh_tech.lua");
	include("sv_tech.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
