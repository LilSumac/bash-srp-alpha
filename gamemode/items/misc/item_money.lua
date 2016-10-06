local BASH = BASH;
local ITEM = {};
ITEM.ID =				"money";
ITEM.Name =				"Money";
ITEM.Description =		"Cold hard cash.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/props_lab/box01a.mdl");
ITEM.Hidden =			true;
ITEM.LootHidden =       true;
ITEM.IsStackable =		true;
ITEM.MaxStacks =		999999999;
ITEM.NoProperties =     true;
ITEM.Actions =          {};
ITEM.Actions["Claim"] = function(ply, ent)
    if !ent or !ent:IsValid() then return end;

    netstream.Start("BASH_Claim_Money", ent);
end
BASH:ProcessItem(ITEM);
