local BASH = BASH;
local QUIRK = {};
QUIRK.ID = "morehealth";
QUIRK.Name = "Iron Skin";
QUIRK.Description = "[Health] +MAX HEALTH | -HEALTH REGEN";
QUIRK.QuirkType = "health";
QUIRK.MaxHealth = 25;
QUIRK.HealthRegen = -2;
BASH:ProcessQuirk(QUIRK);
