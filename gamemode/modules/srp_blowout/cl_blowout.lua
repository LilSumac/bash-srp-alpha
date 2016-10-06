local BASH = BASH;
BASH.Blowout = {};
BASH.Blowout.Active = false;
BASH.Blowout.Start = 0;
BASH.Blowout.Time = 108;
BASH.Blowout.Warning = false;
BASH.Blowout.Sound = false;

hook.Add("Think", "BlowoutThinkClient", function()
    if !BASH.Blowout.Active then return end;

    local blowoutTime = CurTime() - BASH.Blowout.Start;
    if blowoutTime > 44 then
        if !BASH.Blowout.Sound then
            surface.PlaySound("paradoxrp/AmbientNoises/Background/Blowout/blowout.wav");
            BASH.Blowout.Sound = true;
            BASH.Blowout.Warning = false;
        end
    elseif blowoutTime > 20 then
        if !BASH.Blowout.Warning then
            surface.PlaySound("paradoxrp/AmbientNoises/Background/Blowout/armagedets.wav");
            BASH.Blowout.Warning = true;
        end
    end
end);

hook.Add("HUDPaint", "BlowoutDrawWarning", function()
    if BASH.Blowout.Warning then
        draw.SimpleText("WARNING! A blowout is imminent! Find substantial cover immediately!", "BASHFontApp", SCRW / 2, 5, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
    elseif BASH.Blowout.Sound then
        draw.SimpleText("A blowout is in progress! Stay in cover!", "BASHFontApp", SCRW / 2, 5, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
    end
end);

netstream.Hook("BASH_Blowout_Start", function(data)
    BASH.Blowout.Active = true;
    BASH.Blowout.Start = CurTime();
end);

netstream.Hook("BASH_Blowout_End", function(data)
    BASH.Blowout.Active = false;
    BASH.Blowout.Start = 0;
    BASH.Blowout.Warning = false;
    BASH.Blowout.Sound = false;
end);
