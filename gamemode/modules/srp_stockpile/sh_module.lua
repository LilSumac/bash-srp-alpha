local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_STOCKPILE";
MODULE.Name = "SRP Stockpile System";
MODULE.Author = "LilSumac";
MODULE.Description = "Adds stockpile entities for faction leaders to use.";

if CLIENT then
    include("cl_stockpile.lua");
else
    AddCSLuaFile("cl_stockpile.lua");
    include("sv_stockpile.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
