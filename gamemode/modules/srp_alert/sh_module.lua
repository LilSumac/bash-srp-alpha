local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_ALERT";
MODULE.Name = "SRP Alert System";
MODULE.Author = "LilSumac";
MODULE.Description = "Position-based pings for adminstrative and IC purposes.";

if CLIENT then
	include("cl_alert.lua");
else
	AddCSLuaFile("cl_alert.lua");
	include("sv_alert.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
