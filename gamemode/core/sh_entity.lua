local BASH = BASH;
local Entity = FindMetaTable("Entity");

local prop_types = {
    ["prop_physics"] = true,
    ["prop_physics_multiplayer"] = true,
    ["prop_physics_override"] = true,
    ["prop_ragdoll"] = true
};
function Entity:IsProp()
    if self and self:IsValid() then
        local class = self:GetClass();
        return prop_types[class];
    end

    return false;
end

local door_types = {
    ["func_door"] = true,
    ["func_door_rotating"] = true,
    ["prop_door_rotating"] = true
};
function Entity:IsDoor()
    if self and self:IsValid() then
        local class = self:GetClass();
        return door_types[class];
    end

    return false;
end

function Entity:IsItem()
    if self and self:IsValid() then
        if self:GetClass() == "bash_item" then
            return true;
        end
    end

    return false;
end

function Entity:IsBASHItem()
    if self and self:IsValid() then
        if string.find(self:GetClass(), "bash_", 1, true) then
            return true;
        end
    end

    return false;
end
