local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_TRADE";
MODULE.Name = "SRP Trader System";
MODULE.Author = "LilSumac";
MODULE.Description = "Marketplace GUI and back-end systems for trader characters."

if CLIENT then
	include("cl_trader.lua");
	include("sh_trader.lua");
else
	AddCSLuaFile("cl_trader.lua");
	AddCSLuaFile("sh_trader.lua");
	include("sh_trader.lua");
	include("sv_trader.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
