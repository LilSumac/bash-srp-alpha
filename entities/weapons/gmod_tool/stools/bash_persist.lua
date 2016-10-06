TOOL.Name = "Persist";
TOOL.Category = "#!/BASH";

if CLIENT then
    language.Add("tool.bash_persist.name", "Persist");
    language.Add("tool.bash_persist.desc", "Adds props/constraints to the persist whitelist.");
    language.Add("tool.bash_persist.0", "Left Click: Persist a prop. Right Click: Un-persist a prop. Reload: Toggle a prop's persistance.");
end

function TOOL:CanShoot(trace)
    if !trace.Entity or !trace.Entity:IsValid() then return false end;
    return trace.Entity:IsProp() and trace.Entity:GetClass() != "prop_ragdoll";
end

function TOOL:LeftClick(trace)
    if CLIENT then return true end;
    if !LocalPlayer():IsStaff() and !LocalPlayer():HasFlag("e") then return end;
    if !self:CanShoot(trace) then return end;

    trace.Entity:SetPersistent(true);

    return true;
end

function TOOL:RightClick(trace)
    if CLIENT then return true end;
    if !self:CanShoot(trace) then return end;
    if !LocalPlayer():IsStaff() and !LocalPlayer():HasFlag("e") then return end;

    trace.Entity:SetPersistent(false);

    return true;
end

function TOOL:Reload(trace)
    if CLIENT then return true end;
    if !self:CanShoot(trace) then return end;
    if !LocalPlayer():IsStaff() and !LocalPlayer():HasFlag("e") then return end;

    trace.Entity:SetPersistent(!trace.Entity:GetPersistent());

    return true;
end

local materialTick = Material("icon16/tick.png");
local materialCross = Material("icon16/cross.png");
local strange = false;
function TOOL:DrawToolScreen(w, h)
    if !strange then strange = true MsgN("Rendering bug for toolgun bypassed.") end;

    cam.Start2D();
        draw.RoundedBox(0, 0, 0, w, h, color_black);
        draw.SimpleText(self.Name, "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

        local trace = self.Owner:GetEyeTrace();
        local icon;
        if self:CanShoot(trace) then
            icon = (trace.Entity:GetPersistent() and materialTick) or materialCross;
        else
            draw.SimpleText("...", "BASHFontLarge", w / 2, (h / 2) + 14, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
            return;
        end

        draw.NoTexture();
        surface.SetDrawColor(255, 255, 255, 255);
        surface.SetMaterial(icon);
        surface.DrawTexturedRect((w / 2) - 16, (h / 2) + 14, 32, 32);
    cam.End2D();
end
