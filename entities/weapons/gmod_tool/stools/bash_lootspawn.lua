TOOL.Name = "Loot Spawner";
TOOL.Category = "#!/BASH";
TOOL.ClientConVar["lootdelay"] = "30";

if CLIENT then
    language.Add("tool.bash_lootspawn.name", "Loot Spawner");
    language.Add("tool.bash_lootspawn.desc", "Spawn, edit, and remove loot spawn points.");
    language.Add("tool.bash_lootspawn.0", "Left Click: Create a new loot spawn. Right Click: Remove a loot spawn. Reload: Update a loot spawn's delay.");
end

function TOOL:LeftClick(trace)
    if CLIENT then return true end;
    if !trace.Hit or trace.HitSky then return end;
    if !LocalPlayer():IsStaff() then return end;

    local newLoot = ents.Create("bash_loot");
    local pos = trace.HitPos;
    pos.z = pos.z + 6;
    local id = RandomString(8);
    newLoot:SetPos(pos);
    newLoot:SetAngles(Angle(0, 0, 0));
	newLoot:Spawn();
    newLoot:Activate();
    newLoot:SetDelay(tonumber(self:GetClientNumber("lootdelay")));
    newLoot:SetID(id);

    return true;
end

function TOOL:RightClick(trace)
    if CLIENT then return true end;
    if !trace.Hit or trace.HitSky then return end;
    if trace.Entity:GetClass() != "bash_loot" then return end;
    if !LocalPlayer():IsStaff() then return end;

    trace.Entity:Remove();
    return true;
end

function TOOL:Reload(trace)
    if CLIENT then return true end;
    if !trace.Hit or trace.HitSky then return end;
    if trace.Entity:GetClass() != "bash_loot" then return end;
    if !LocalPlayer():IsStaff() then return end;

    trace.Entity:SetDelay(tonumber(self:GetClientNumber("lootdelay")));
    return true;
end

function TOOL:DrawToolScreen(w, h)
    draw.RoundedBox(0, 0, 0, w, h, color_black);
    draw.SimpleText(self.Name, "BASHFontLarge", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function TOOL.BuildCPanel(control)
    local delayLabel = vgui.Create("DLabel", control);
    delayLabel:SetFont("BASHFontHeavy");
    delayLabel:SetText("The time (in minutes) that loot takes to spawn.");
    delayLabel:SetPos(10, 30);
    delayLabel:SetTextColor(color_black);
    delayLabel:SizeToContents();
    local delay = vgui.Create("Slider", control);
    delay:SetPos(10, 50);
    delay:SetWide(250);
    delay:SetMin(30);
    delay:SetMax(720);
    delay:SetValue(30);
    delay:SetDecimals(0);
    delay:SetConVar("bash_lootspawn_lootdelay");
end

function TOOL:DrawHUD()
    if !LocalPlayer().HighlightLoot and LocalPlayer():IsStaff() then
        LocalPlayer().HighlightLoot = true;
    end
end

function TOOL:Holster()
    if CLIENT then
        LocalPlayer().HighlightLoot = false;
    end
end
