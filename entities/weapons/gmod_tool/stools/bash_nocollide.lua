TOOL.Name = "Adv. No Collide";
TOOL.Category = "#!/BASH";
TOOL.ClientConVar["removeshadow"] = "0";

if CLIENT then
    language.Add("tool.bash_nocollide.name", "Adv. No Collide");
    language.Add("tool.bash_nocollide.desc", "No Collide entities with the world.");
    language.Add("tool.bash_nocollide.0", "Left Click: No Collide with everything, including the world.\nRight Click: Enable all collisions.\nReload: No Collide with everything except the world.");
end

local Entity = FindMetaTable("Entity");
function Entity:SetCollisions(collide)
    local phys = self:GetPhysicsObject();
    if !phys or !phys:IsValid() then return end;
    local physCount = self:GetPhysicsObjectCount();

    if collide then
        self:SetCollisionGroup(COLLISION_GROUP_NONE);
    else
        self:SetCollisionGroup(COLLISION_GROUP_WORLD);
    end
    if physCount == 1 then
        phys:EnableCollisions(collide);
    elseif physCount > 1 then
        local curObj;
        for index = 0, physCount - 1 do
            curObj = self:GetPhysicsObjectNum(index);
            if curObj and curObj:IsValid() then
                curObj:EnableCollisions(collide);
            end
        end
    end
end

function TOOL:LeftClick(trace)
    if CLIENT then return true end;

    local ent = trace.Entity;
    if !ent or !ent:IsValid() or ent:IsPlayer() then return end;

    ent:SetCollisions(false);
    local removeShadow = tobool(self:GetClientNumber("removeshadow"));
    ent:DrawShadow(!removeShadow);

    return true;
end

function TOOL:RightClick(trace)
    if CLIENT then return true end;

    local ent = trace.Entity;
    if !ent or !ent:IsValid() or ent:IsPlayer() then return end;

    ent:SetCollisions(true);
    ent:DrawShadow(true);

    return true;
end

function TOOL:Reload(trace)
    if CLIENT then return true end;

    local ent = trace.Entity;
    if !ent or !ent:IsValid() or ent:IsPlayer() then return end;

    local phys = ent:GetPhysicsObject();
    if !phys or !phys:IsValid() then return end;
    local physCount = ent:GetPhysicsObjectCount();
    ent:SetCollisionGroup(COLLISION_GROUP_WORLD);
    if physCount == 1 then
        phys:EnableCollisions(true);
    elseif physCount > 1 then
        local curObj;
        for index = 0, physCount - 1 do
            curObj = ent:GetPhysicsObjectNum(index);
            if curObj and curObj:IsValid() then
                curObj:EnableCollisions(true);
            end
        end
    end

    local removeShadow = tobool(self:GetClientNumber("removeshadow"));
    ent:DrawShadow(!removeShadow);

    return true;
end

function TOOL:DrawToolScreen(w, h)
    draw.RoundedBox(0, 0, 0, w, h, color_black);
    draw.SimpleText(self.Name, "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function TOOL.BuildCPanel(control)
    local removeShadow = vgui.Create("DCheckBoxLabel", control)
    removeShadow:SetPos(10, 30);
    removeShadow:SetText("Disable Entity Shadow");
    removeShadow:SetValue(0);
    removeShadow:SetConVar("bash_nocollide_removeshadow");
    removeShadow:SizeToContents();
end
