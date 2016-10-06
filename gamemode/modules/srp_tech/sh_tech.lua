local BASH = BASH;
local Player = FindMetaTable("Player");

function Player:IsTechnician()
	return self:HasFlag("h") or self:HasFlag("j") or self:HasFlag("k") or self:HasFlag("m");
end
