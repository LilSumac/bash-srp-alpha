local BASH = BASH;
local QUIRK = {};
QUIRK.ID = "lessweight";
QUIRK.Name = "Light Packer";
QUIRK.Description = "[Weight] -MAX WEIGHT | +MAX STAMINA";
QUIRK.QuirkType = "weight";
QUIRK.NormalMaxStamina = 10;
QUIRK.HungryMaxStamina = 10;
QUIRK.MaxWeight = -20;
BASH:ProcessQuirk(QUIRK);
