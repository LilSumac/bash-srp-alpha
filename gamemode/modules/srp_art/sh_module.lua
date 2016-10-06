local BASH = BASH;
local MODULE = {};
MODULE.ID = "SRP_ART";
MODULE.Name = "SRP Artifact System";
MODULE.Author = "LilSumac";
MODULE.Description = "STALKER artifact entities with purity values and positive/negative effects.";

if CLIENT then
	include("cl_artifact.lua");
	include("sh_artifact.lua");
else
	AddCSLuaFile("cl_artifact.lua");
	AddCSLuaFile("sh_artifact.lua");
	include("sh_artifact.lua");
	include("sv_artifact.lua");
end

BASH.Modules[MODULE.ID] = MODULE;

/*  Module Variable  */
INV_ART = 123;
