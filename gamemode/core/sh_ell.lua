local BASH = BASH;

if CLIENT then
	include("sh_util.lua");
	include("sh_glob.lua");
	include("cl_bash.lua");
else
	AddCSLuaFile("sh_util.lua");
	AddCSLuaFile("sh_glob.lua");
	AddCSLuaFile("cl_bash.lua");
	include("sh_util.lua");
	include("sh_glob.lua");
	include("sv_bash.lua");
end

BASH:ProcessFile("external/sh_pon.lua");
BASH:ProcessFile("external/sh_netstream2.lua");
BASH:ProcessFile("core/cl_util.lua");
BASH:ProcessFile("core/sh_anims.lua");
BASH:ProcessFile("core/sh_inventory.lua");
BASH:ProcessFile("core/sh_player.lua");
BASH:ProcessFile("core/sh_entity.lua");
BASH:ProcessFile("core/sh_registry.lua");
BASH:ProcessFile("core/sv_inventory.lua");
BASH:ProcessFile("core/sv_player.lua");
BASH:ProcessFile("core/sv_sql.lua");
MsgCon(color_green, "Processed core files.");
BASH:ProcessDirectory("config", false);
BASH:ProcessDirectory("hooks", false);
BASH:ProcessDirectory("vgui", false);
BASH:ProcessDirectory("maps", false);
BASH:ProcessModules();
BASH:ProcessDirectory("items", false);
BASH:ProcessDirectory("inventories", false);
BASH:ProcessDirectory("factions", false);
BASH:ProcessDirectory("quirks", false);

BASH:Init();
