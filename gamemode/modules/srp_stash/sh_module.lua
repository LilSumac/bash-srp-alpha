local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_STASH";
MODULE.Name = "SRP Stash System";
MODULE.Author = "LilSumac";
MODULE.Description = "Implements the ability to stash inventory items and recover them at a later time.";
MODULE.Dependencies = {"SRP_CMD", "SRP_PDA"};

if CLIENT then
    include("cl_stash.lua");
    include("sh_stash_cmd.lua");
else
    AddCSLuaFile("cl_stash.lua");
    AddCSLuaFile("sh_stash_cmd.lua");
    include("sh_stash_cmd.lua");
    include("sv_stash.lua");
    include("sv_stash_cmd.lua");
end

BASH.Modules[MODULE.ID] = MODULE;
