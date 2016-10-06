if CLIENT then
    SWEP.PrintName = "Hands";
    SWEP.ViewModelFlip = true;
elseif SERVER then
    AddCSLuaFile("shared.lua");
end

SWEP.Base = "bash_wep_base_melee";
SWEP.Category = "BASH Weapons";
SWEP.Spawnable = false;
SWEP.AdminSpawnable = false;

SWEP.Primary.Damage = 0;
SWEP.Primary.Ammo = "";
SWEP.Primary.Cone = 0;
SWEP.Primary.Recoil = 0;
SWEP.Primary.Delay = 0.15;
SWEP.Primary.Automatic = false;

SWEP.WorldModel = "";
SWEP.ViewModel = "models/weapons/c_arms.mdl";
SWEP.HoldType = "fist";
SWEP.HolsterType = "normal";
SWEP.UseHands = true;
SWEP.RunSightPos = Vector(0, 0, 0);
SWEP.RunSightAng = Angle(-14, 0, 0);
SWEP.WallSightPos = Vector(0, 0, 0);
SWEP.WallSightAng = Angle(0, 0, 0);
SWEP.SafeSightPos = Vector(0, 0, -8);
SWEP.SafeSightAng = Angle(0, 0, 0);

function SWEP:Initialize()
    self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
    self:SetHoldType(self.HolsterType);
    self.IsRunning = false;
    self.IsNearWall = false;

    self.FireModes = {
        {HUD = "Holstered", Auto = false},
        {HUD = "Raised", Auto = false}
    };
    self.HitSounds = {
		Sound("npc/vort/foot_hit.wav"),
		Sound("weapons/crossbow/hitbod1.wav"),
		Sound("weapons/crossbow/hitbod2.wav")
	};

	self.SwingSounds = {
		Sound("npc/vort/claw_swing1.wav"),
		Sound("npc/vort/claw_swing2.wav")
	};
end

function SWEP:PrimaryAttack()
    if self.IsRunning then return end;

    if self.Owner:KeyDown(IN_USE) then
        self:CycleFiremode();
        self.Weapon:SetNextPrimaryFire(CurTime() + 0.25);
        return;
    end

    if self.CurrentFireMode == 1 then return end;

    self.Weapon:SetNextPrimaryFire(CurTime() + 0.8);
	self.Weapon:EmitSound(self.SwingSounds[math.random(1, #self.SwingSounds)]);
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER);
	self.Owner:SetAnimation(PLAYER_ATTACK1);
	self.NextPrimaryAttack = CurTime() + 1;

    local trace = {};
	trace.start = self.Owner:EyePos();
	trace.endpos = trace.start + self.Owner:GetAimVector() * 60;
	trace.filter = self.Owner;
	local tr = util.TraceLine(trace);
	if tr.Hit or (tr.Entity and tr.Entity:IsValid()) then
		self:EmitSound(self.HitSounds[math.random(1, #self.HitSounds)])

		if tr.Entity:IsPlayer() then
			tr.Entity:SetHealth(tr.Entity:Health() - math.random(1, 2));
			local eyeang = Angle(2 * math.Rand(-8, 8), 2 * math.Rand(-8, 8), 0);
			tr.Entity:ViewPunch(eyeang);
		end
	end
end

SWEP.LastPickUp = 0;
function SWEP:SecondaryAttack()
    if CLIENT then return end;
    if !IsFirstTimePredicted() then return end;
    if !self:CanPrimaryAttack() then return end;
    if CurTime() - self.LastPickUp < 1 then return end;

    local ent = self.Owner:GetTable().HandPickUpSent;
    if ent and ent:IsValid() then
		ent:Remove();
        self.Owner:GetTable().HandPickUpSent = nil;
	else
		local trace = {};
		trace.start = self.Owner:EyePos();
		trace.endpos = trace.start + self.Owner:GetAimVector() * 60;
		trace.filter = self.Owner;
		local tr = util.TraceLine(trace);
		if tr.Entity and tr.Entity:IsValid() then
            self.Owner:GetTable().HandPickUpSent = ents.Create("bash_pickup");
        	self.Owner:GetTable().HandPickUpSent:SetPos(tr.Entity:GetPos());
        	self.Owner:GetTable().HandPickUpSent:SetModel("models/props_junk/popcan01a.mdl");
        	self.Owner:GetTable().HandPickUpSent:SetPlayer(self.Owner);
        	self.Owner:GetTable().HandPickUpSent:SetTarget(tr.Entity);
        	self.Owner:GetTable().HandPickUpSent:Spawn();
        	self.Owner:GetTable().HandPickUpTarget = tr.Entity;
        	constraint.Weld(self.Owner:GetTable().HandPickUpSent, tr.Entity, 0, tr.PhysicsBone, 9999);
		end
	end

    self.LastPickUp = CurTime();
end

function SWEP:Reload() end;
