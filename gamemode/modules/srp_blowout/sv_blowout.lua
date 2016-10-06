local BASH = BASH;
local Player = FindMetaTable("Player");
BASH.Blowout = {};
BASH.Blowout.Active = false;
BASH.Blowout.Start = 0;
BASH.Blowout.Length = 108;
BASH.Blowout.LastDamage = 0;
BASH.Blowout.Shaking = false;

local function StartBlowout(ply, cmd, args)
    if !CheckPly(ply) or !CheckChar(ply) then return end;
    if !ply:IsStaff() then
        ply:PrintChat("You can't do that!");
        return;
    end

    if BASH.Blowout.Active then
        ply:PrintChat("A blowout is already in effect!");
        return;
    end

    BASH.Blowout.Start = CurTime();
    BASH.Blowout.Active = true;
    netstream.Start(player.GetAll(), "BASH_Blowout_Start");
    MsgCon(color_red, ply:GetEntry("Name") .. " [" .. ply:SteamID() .. "/" .. ply:GetEntry("BASHID") .. "] has initiated a blowout.", true);
    CommandPrint(ply, ply:GetEntry("Name") .. " has initiated a blowout.");
end
concommand.Add("#!/blowout", StartBlowout);

local function RangedTrace(pos, ang, dist, filt)
    local trace = {};
    trace.start = pos;
    trace.endpos = pos + ang * dist;
    trace.filter = filt;
    return util.TraceLine(trace);
end
function Player:IsCovered()
    local pos = self:GetPos();
    local tr_up = RangedTrace(pos, self:GetUp(), 1200, self);
    local tr_back = RangedTrace(pos, self:GetForward() * -1, 1200, self);
    local tr_right = RangedTrace(pos, self:GetRight(), 1200, self);
    local tr_left = RangedTrace(pos, self:GetRight() * -1, 1200, self);

    return tr_up.Hit and tr_back.Hit and tr_right.Hit and tr_left.Hit;
end

function BASH:StartBlowoutEffects()
    //  Fade In
    local fadeIn = ents.Create("env_fade");
    local vals = {
        duration = 0.2,
        holdtime = 5,
        rendercolor = "220 0 0",
        renderamt = 180
    };
    fadeIn:SetPos(Vector(0, 0, 0));
    for key, val in pairs(vals) do
        fadeIn:SetKeyValue(key, val);
    end
    fadeIn:Spawn();
    fadeIn:Fire("fade", "", 0);
    fadeIn:Fire("kill", "", 5.2);

    //  Fade Out
    local fadeOut = ents.Create("env_fade");
    vals = {
        duration = 4,
        holdtime = 0,
        rendercolor = "220 0 0",
        renderamt = 180,
        spawnflags = 1
    };
    fadeOut:SetPos(Vector(0, 0, 0));
    for key, val in pairs(vals) do
        fadeOut:SetKeyValue(key, val);
    end
    fadeOut:Spawn();
    fadeOut:Fire("fade", "", 5.2);
    fadeOut:Fire("kill", "", 10.2);

    //  Shaking
    local shake = ents.Create("env_shake");
    vals = {
        amplitude = math.random(10, 20),
        duration = 35,
        frequency = math.random(285, 320),
        spawnflags = 1 + 4 + 8 + 16
    };
    shake:SetPos(Vector(0, 0, 0));
    for key, val in pairs(vals) do
        shake:SetKeyValue(key, val);
    end
    shake:Spawn();
    shake:Fire("StartShake", "", 0);
    shake:Fire("kill", "", 36);
end

function BASH:DoBlowoutDamage()
    for _, ply in pairs(player.GetAll()) do
        if CheckPly(ply) and CheckChar(ply) and ply:Alive() and !ply:GetEntry("Observing") then
            if !ply:IsCovered() then
                local rads = ply:GetEntry("Radiation");
                rads = math.Clamp(rads + 10, 0, 100);
                ply:UpdateEntry("Radiation", rads);
            end
        end
    end
end

function BASH:ResetBlowout()
    self.Blowout.Active = false;
    self.Blowout.Start = 0;
    self.Blowout.LastDamage = 0;
    self.Blowout.Shaking = false;

    netstream.Start(player.GetAll(), "BASH_Blowout_End");
end

hook.Add("Think", "BlowoutThink", function()
    if !BASH.Blowout.Active then return end;

    local blowoutTime = CurTime() - BASH.Blowout.Start;
    if blowoutTime > 108 then
        BASH:ResetBlowout();
    elseif blowoutTime > 44 then
        if !BASH.Blowout.Shaking then
            BASH:StartBlowoutEffects();
            BASH.Blowout.Shaking = true;
        end

        if CurTime() - BASH.Blowout.LastDamage > 1 then
            BASH:DoBlowoutDamage();
            BASH.Blowout.LastDamage = CurTime();
        end
    end
end);
