local BASH = BASH;
local QUIRK = {};
QUIRK.ID = "lesshealth";
QUIRK.Name = "Delicate Frame";
QUIRK.Description = "[Health] -MAX HEALTH | +HEALTH REGEN";
QUIRK.QuirkType = "health";
QUIRK.MaxHealth = -20;
QUIRK.HealthRegen = 2;
BASH:ProcessQuirk(QUIRK);
