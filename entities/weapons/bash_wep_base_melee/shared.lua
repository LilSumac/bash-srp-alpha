if CLIENT then
    SWEP.CSMuzzleFlashes = false;
    SWEP.DrawAmmo = false;
    SWEP.DrawCrosshair = false;
    SWEP.DrawWeaponInfoBox = false;
    SWEP.PrintName = "BASE MELEE";
    SWEP.Slot = 2;
    SWEP.SlotPos = 0;
    SWEP.ViewModelFOV = 60;
    SWEP.ViewModelFlip = false;
elseif SERVER then
    AddCSLuaFile("shared.lua");
end

SWEP.Category = "BASH Weapons";
SWEP.Author = "LilSumac";
SWEP.IsBASHWeapon = true;
SWEP.IsMelee = true;
SWEP.Spawnable = false;
SWEP.AdminSpawnable = false;
SWEP.AutoSwitchTo = false;
SWEP.AutoSwitchFrom = false;

SWEP.Primary.Damage = 35;
SWEP.Primary.ClipSize = -1;
SWEP.Primary.Delay = 1;
SWEP.Primary.DefaultClip = 1;
SWEP.Primary.Automatic = false;
SWEP.Primary.Ammo = "none";
SWEP.Secondary.ClipSize = -1;
SWEP.Secondary.DefaultClip = -1;
SWEP.Secondary.Damage = 0;
SWEP.Secondary.Automatic = false;
SWEP.Secondary.Ammo = "none";
SWEP.MissSound = Sound("");
SWEP.WallSound = Sound("");

SWEP.ViewModel = "";
SWEP.WorldModel = "";
SWEP.HoldType = "melee2";
SWEP.HolsterType = "normal";
SWEP.RunSightPos = Vector(0, 0, 0);
SWEP.RunSightAng = Angle(0, 0, 0);
SWEP.WallSightPos = Vector(0, 0, 0);
SWEP.WallSightAng = Angle(0, 0, 0);
SWEP.SafeSightPos = Vector(0, 0, 0);
SWEP.SafeSightAng = Angle(0, 0, 0);

SWEP.IsRunning = false;
SWEP.IsNearWall = false;
SWEP.FireModes = {
    {HUD = "Holstered", Auto = false},
    {HUD = "Raised", Auto = false}
};
SWEP.CurrentFireMode = 1;
SWEP.ShotsFired = 0;

function SWEP:Initialize()
	self:SetHoldType(self.HolsterType);
    self.IsRunning = false;
    self.IsNearWall = false;
    self.ShotsFired = 0;
end

function SWEP:Think()
    if self.Owner:KeyDown(IN_SPEED) and self.Owner:KeyDown(IN_FORWARD) and !self.Owner:KeyDown(IN_DUCK) and self.Owner:IsOnGround() then
        self.IsRunning = true;
    elseif self.IsRunning then
        self.IsRunning = false;
    end

    if self.IsRunning or self.IsNearWall then
        self:SetHoldType(self.HolsterType);
    elseif !self.IsRunning and !self.IsNearWall then
        if self.CurrentFireMode == 1 then
            self:SetHoldType(self.HolsterType);
        else
            self:SetHoldType(self.HoldType);
        end
    end
end

function SWEP:PrimaryAttack()
    if self.Owner:KeyDown(IN_USE) then
        if IsFirstTimePredicted() then
            self:CycleFiremode();
        end
        self.Weapon:SetNextPrimaryFire(CurTime() + 0.25);
        return;
    end

    if self.CurrentFireMode == 1 then return end;
    if !self:CanPrimaryAttack() then return end;

	local tr = {};
	tr.start = self.Owner:GetShootPos();
	tr.endpos = self.Owner:GetShootPos() + (self.Owner:GetAimVector() * 95);
	tr.filter = self.Owner;
	tr.mask = MASK_SHOT;
	local trace = util.TraceLine(tr);

	self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay);
	self.Owner:SetAnimation(PLAYER_ATTACK1);

	if trace.Hit then
		if trace.Entity:IsPlayer() or string.find(trace.Entity:GetClass(), "npc") or string.find(trace.Entity:GetClass(), "prop_ragdoll") then
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER);
			bullet = {};
			bullet.Num    = 1;
			bullet.Src    = self.Owner:GetShootPos();
			bullet.Dir    = self.Owner:GetAimVector();
			bullet.Spread = Vector(0, 0, 0);
			bullet.Tracer = 0;
			bullet.Force  = 1;
			bullet.Damage = self.Primary.Damage;
			self.Owner:FireBullets(bullet);
		else
			self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER);
			bullet = {};
			bullet.Num    = 1;
			bullet.Src    = self.Owner:GetShootPos();
			bullet.Dir    = self.Owner:GetAimVector();
			bullet.Spread = Vector(0, 0, 0);
			bullet.Tracer = 0;
			bullet.Force  = 1;
			bullet.Damage = self.Primary.Damage;
			self.Owner:FireBullets(bullet);
			self.Weapon:EmitSound(self.WallSound);
			util.Decal("ManhackCut", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal);
		end
        self.ShotsFired = self.ShotsFired + 1;
	else
		self.Weapon:EmitSound(self.MissSound, 100, math.random(90, 120));
		self.Weapon:SendWeaponAnim(ACT_VM_MISSCENTER);
	end

	self.Owner:ViewPunch(Angle(4, 10, 0));
end

function SWEP:CanPrimaryAttack()
    if self.IsRunning or self.IsNearWall or self.Owner:GetEntry("Observing") then return false end;
    return true;
end

function SWEP:SecondaryAttack()
	return false;
end

function SWEP:Reload()
	return false;
end

function SWEP:CycleFiremode()
    if self.CurrentFireMode + 1 > #self.FireModes then
        self.CurrentFireMode = 1;
        self:SetHoldType(self.HolsterType);
    else
        self.CurrentFireMode = self.CurrentFireMode + 1;
        self:SetHoldType(self.HoldType);
    end

    if SERVER then
        netstream.Start(self.Owner, "BASH_Send_Firemode_Melee", self.CurrentFireMode);
    end
end

/*
**  Viewmodel Magic Starts Here!
**  Most credit goes to rebel1324.
*/
local function int(delta, from, to)
    local intType = type(from);
    if intType == "Angle" then
        from = util_NormalizeAngles(from);
        to = util_NormalizeAngles(to);
    end

    local out = from + (to - from) * delta;
    return out;
end

local sin, cos = math.sin, math.cos;
local clamp = math.Clamp;
local bRunning = false;
local bWall = false;
local bSafe = false;
local SetPos = Vector();
local SetAng = Angle();
local WantedPos = Vector();
local WantedAng = Angle();
local curStep = 0;
local bobPos = Vector();
local swayPos = Vector();
local restPos = Vector();
local Right = Angle();
local Up = Angle();
local Forward = Angle();
local swayLimit = 5;
SWEP.DisableBob = false;     // For aligning weapon ironsights!
SWEP.aimAngle = Angle();
SWEP.oldAimAngle = Angle();
SWEP.aimDiff = Angle();
function SWEP:GetViewModelPosition(pos, ang)
    bRunning = self.IsRunning;
    bWall = self.IsNearWall;
    bSafe = self.CurrentFireMode == 1;

    if self.DisableBob then
        Right = ang:Right();
        Up = ang:Up();
        Forward = ang:Forward();

        if bSafe then
            WantedPos = self.SafeSightPos;
            WantedAng = self.SafeSightAng;
        elseif bWall then
            WantedPos = self.WallSightPos;
            WantedAng = self.WallSightAng;
        elseif bRunning then
            WantedPos = self.RunSightPos;
            WantedAng = self.RunSightAng;
        else
            return pos, ang
        end

        ang = ang * 1;
        ang:RotateAroundAxis(Right, WantedAng.x);
        ang:RotateAroundAxis(Up, WantedAng.y);
        ang:RotateAroundAxis(Forward, WantedAng.z);

        pos = pos + WantedPos.x * Right;
        pos = pos + WantedPos.y * Forward;
        pos = pos + WantedPos.z * Up;

        return pos, ang;
    end

    local vel = clamp(self.Owner:GetVelocity():Length2D() / self.Owner:GetWalkSpeed(), 0, 1);
    local rest = 1 - clamp(self.Owner:GetVelocity():Length2D() / 20, 0, 1);
    curStep = curStep + (vel / math.pi) * (FrameTime() * 10);

    self.aimAngle = self.Owner:EyeAngles();
    self.aimDiff = self.aimAngle - self.oldAimAngle;
    for i = 1, 3 do
        if (360 - math.abs(self.aimDiff[i]) < 180) then
            if (self.aimDiff[i] < 0) then
                self.aimDiff[i] = self.aimDiff[i] + 360;
            else
                self.aimDiff[i] = self.aimDiff[i] - 360;
            end
        end
    end

    self.oldAimAngle = self.aimAngle;

    bobPos[1] = -sin(curStep / ((bRunning and 1.5) or 2)) * vel / 2;
    bobPos[2] = sin(curStep / 4) * vel * 1.5;
    bobPos[3] = sin(curStep) / ((bRunning and 1) or 1.5) * vel / 2;

    restPos[3] = sin(CurTime()) / 4;
    restPos[1] = cos(CurTime()) / 8;

    swayPos[1] = clamp(int(0.1, swayPos[1], -self.aimDiff[2]), -swayLimit, swayLimit);
    swayPos[3] = clamp(int(0.1, swayPos[3], self.aimDiff[1]), -swayLimit, swayLimit);

    for i = 1, 3 do
        self.aimDiff[i] = clamp(self.aimDiff[i], -swayLimit, swayLimit);
    end

    //  REST = Standing still.
    //  BOB = Moving & running.
    //  SWAY = Looking around.
    //  View Priority = Safe >> Near Wall >> Sprinting >> Passive!
    SetPos = (((bSafe and self.SafeSightPos) or (bWall and self.WallSightPos) or (bRunning and self.RunSightPos)) or (restPos * rest)) + (bobPos * (bRunning and 10 or 1));
    SetAng = (bSafe and self.SafeSightAng) or (bWall and self.WallSightAng) or (bRunning and self.RunSightAng) or (self.aimDiff);

    WantedPos = LerpVector(0.05, WantedPos, SetPos);
    WantedAng = LerpAngle(0.1, WantedAng, SetAng);

    Right = ang:Right();
    Up = ang:Up();
    Forward = ang:Forward();

    ang = ang * 1;
    ang:RotateAroundAxis(Right, WantedAng.x);
    ang:RotateAroundAxis(Up, WantedAng.y);
    ang:RotateAroundAxis(Forward, WantedAng.z);

    pos = pos + WantedPos.x * Right;
    pos = pos + WantedPos.y * Forward;
    pos = pos + WantedPos.z * Up;

    return pos, ang;
end

/*
**  Viewmodel Magic Ends Here!
*/

function SWEP:OnRemove()
    return true;
end

function SWEP:Holster()
    if self.ShotsFired > 0 then
        local weps = self.Owner:GetEntry("Weapons");
        weps = util.JSONToTable(weps);
        for index, wep in pairs(weps) do
            if wep.ID then
                local wepData = BASH.Items[wep.ID];
                if wepData.WeaponEntity == self:GetClass() then
        			wep.Condition = math.Clamp(wep.Condition - ((self.ShotsFired / wepData.Durability) * 100), 0, 100);
                end
            end
        end
    end

	return true;
end

if CLIENT then
    netstream.Hook("BASH_Send_Firemode_Melee", function(data)
        local wep = LocalPlayer():GetActiveWeapon();

        if wep.IsBASHWeapon and wep.IsMelee then
            wep.CurrentFireMode = data;
            LocalPlayer():EmitSound("bash-srp/weapons/ic_firemode.wav");
        end
    end);
    hook.Add("HUDPaint", "WeaponHUDMelee", function()
        local wep = LocalPlayer():GetActiveWeapon();

        if wep.IsBASHWeapon and wep.IsMelee then
            draw.SimpleText("Firemode [USE + FIRE]: " .. wep.FireModes[wep.CurrentFireMode].HUD, "CW_HUD16", ScrW() / 2, ScrH() - 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
        end
		if wep.PrintName == "Hands" then
			draw.SimpleText("Left Click: Punch (Raised) - Right Click: Pick Up/Drop (Holstered)", "CW_HUD16", ScrW() / 2, ScrH() - 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
		end
    end);
end
