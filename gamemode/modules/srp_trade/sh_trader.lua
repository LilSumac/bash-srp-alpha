local BASH = BASH;
local Player = FindMetaTable("Player");

function Player:IsTrader()
    return self:HasFlag("i") or self:HasFlag("o") or self:HasFlag("p") or self:HasFlag("l") or self:IsSumac();
end
