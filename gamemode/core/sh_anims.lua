local BASH = BASH;

/*
**  Animation Table
*/
local animTable = {};
animTable["tnb"] = {};
animTable["tnb"]["normal"] = {
    ["seat"] = ACT_HL2MP_SIT,
    ["jump"] = ACT_HL2MP_JUMP_FIST,
    ["idle"] = ACT_HL2MP_IDLE,
    ["walk"] = ACT_HL2MP_WALK,
    ["run"] = ACT_HL2MP_RUN,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH,
        ["walk"] = ACT_HL2MP_WALK_CROUCH
    }
};
animTable["tnb"]["passive"] = {
    ["jump"] = ACT_HL2MP_JUMP_PASSIVE,
    ["idle"] = ACT_HL2MP_IDLE_PASSIVE,
    ["walk"] = ACT_HL2MP_WALK_PASSIVE,
    ["run"] = ACT_HL2MP_RUN_PASSIVE,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH,
        ["walk"] = ACT_HL2MP_WALK_CROUCH
    }
};
animTable["tnb"]["fist"] = {
    ["seat"] = ACT_HL2MP_SIT_FIST,
    ["jump"] = ACT_HL2MP_JUMP_FIST,
    ["idle"] = ACT_HL2MP_IDLE_FIST,
    ["walk"] = ACT_HL2MP_WALK_FIST,
    ["run"] = ACT_HL2MP_RUN_FIST,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH_FIST,
        ["walk"] = ACT_HL2MP_WALK_CROUCH_FIST
    }
};
animTable["tnb"]["ar2"] = {
    ["seat"] = ACT_HL2MP_SIT_AR2,
    ["jump"] = ACT_HL2MP_JUMP_AR2,
    ["idle"] = ACT_HL2MP_IDLE_AR2,
    ["walk"] = ACT_HL2MP_WALK_AR2,
    ["run"] = ACT_HL2MP_RUN_PASSIVE,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH_AR2,
        ["walk"] = ACT_HL2MP_WALK_CROUCH_AR2
    }
};
animTable["tnb"]["rifle"] = animTable["tnb"]["ar2"];
animTable["tnb"]["shotgun"] = animTable["tnb"]["ar2"];
animTable["tnb"]["revolver"] = {
    ["seat"] = ACT_HL2MP_SIT_PISTOL,
    ["jump"] = ACT_HL2MP_JUMP_REVOLVER,
    ["idle"] = ACT_HL2MP_IDLE_REVOLVER,
    ["walk"] = ACT_HL2MP_WALK_REVOLVER,
    ["run"] = ACT_HL2MP_RUN,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH_REVOLVER,
        ["walk"] = ACT_HL2MP_WALK_CROUCH_REVOLVER
    }
};
animTable["tnb"]["pistol"] = animTable["tnb"]["revolver"];
animTable["tnb"]["melee2"] = {
    ["seat"] = ACT_HL2MP_SIT_MELEE,
    ["jump"] = ACT_HL2MP_JUMP_MELEE2,
    ["idle"] = ACT_HL2MP_IDLE_MELEE2,
    ["walk"] = ACT_HL2MP_WALK_MELEE2,
    ["run"] = ACT_HL2MP_RUN_MELEE2,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH_MELEE2,
        ["walk"] = ACT_HL2MP_WALK_CROUCH_MELEE2
    }
};
animTable["tnb"]["gmod_tool"] = animTable["tnb"]["revolver"];
animTable["tnb"]["weapon_physgun"] = {
    ["seat"] = ACT_HL2MP_SIT_PHYSGUN,
    ["jump"] = ACT_HL2MP_JUMP_PHYSGUN,
    ["idle"] = ACT_HL2MP_IDLE_PHYSGUN,
    ["walk"] = ACT_HL2MP_WALK_PHYSGUN,
    ["run"] = ACT_HL2MP_RUN_PHYSGUN,
    ["crouch"] = {
        ["idle"] = ACT_HL2MP_IDLE_CROUCH_PHYSGUN,
        ["walk"] = ACT_HL2MP_WALK_CROUCH_PHYSGUN
    }
};

animTable["misery"] = {};
animTable["misery"]["normal"] = {
    ["seat"] = ACT_BUSY_SIT_CHAIR,
    ["jump"] = ACT_JUMP,
    ["idle"] = ACT_IDLE,
    ["walk"] = ACT_WALK,
    ["run"] = ACT_RUN,
    ["crouch"] = {
        ["idle"] = ACT_COVER_LOW,
        ["walk"] = ACT_WALK_CROUCH
    }
};
animTable["misery"]["passive"] = {
    ["seat"] = ACT_BUSY_SIT_CHAIR,
    ["jump"] = ACT_JUMP,
    ["idle"] = ACT_IDLE_RPG_RELAXED,
    ["walk"] = ACT_WALK_RPG_RELAXED,
    ["run"] = ACT_RUN_RPG_RELAXED,
    ["crouch"] = {
        ["idle"] = ACT_COVER_LOW,
        ["walk"] = ACT_WALK_CROUCH_RPG
    }
};
animTable["misery"]["fist"] = {
    ["seat"] = ACT_BUSY_SIT_CHAIR,
    ["jump"] = ACT_JUMP,
    ["idle"] = ACT_IDLE,
    ["walk"] = ACT_WALK,
    ["run"] = ACT_RUN,
    ["crouch"] = {
        ["idle"] = ACT_COVER_LOW,
        ["walk"] = ACT_WALK_CROUCH
    }
};
animTable["misery"]["ar2"] = {
    ["seat"] = ACT_BUSY_SIT_CHAIR,
    ["jump"] = ACT_JUMP,
    ["idle"] = ACT_IDLE_ANGRY_SMG1,
    ["walk"] = ACT_WALK_AIM_RIFLE_STIMULATED,
    ["run"] = ACT_RUN_AIM_RIFLE_STIMULATED,
    ["crouch"] = {
        ["idle"] = ACT_COVER_LOW,
        ["walk"] = ACT_WALK_CROUCH_AIM_RIFLE
    }
};
animTable["misery"]["rifle"] = animTable["misery"]["ar2"];
animTable["misery"]["shotgun"] = animTable["misery"]["ar2"];
animTable["misery"]["revolver"] = animTable["misery"]["ar2"];
animTable["misery"]["pistol"] = animTable["misery"]["revolver"];
animTable["misery"]["melee2"] = {
    ["seat"] = ACT_BUSY_SIT_CHAIR,
    ["jump"] = ACT_JUMP,
    ["idle"] = ACT_IDLE_ANGRY_MELEE,
    ["walk"] = ACT_WALK,
    ["run"] = ACT_RUN,
    ["crouch"] = {
        ["idle"] = ACT_COVER_LOW,
        ["walk"] = ACT_WALK_CROUCH
    }
};
animTable["misery"]["gmod_tool"] = animTable["misery"]["revolver"];
animTable["misery"]["weapon_physgun"] = animTable["misery"]["ar2"];

local mutantModels = {};
mutantModels["bloodsucker1"] = true;
mutantModels["bloodsucker2"] = true;
mutantModels["boar1"] = true;
mutantModels["chimera1"] = true;
mutantModels["zombie1"] = true;
mutantModels["zombie2"] = true;
mutantModels["dog1"] = true;
mutantModels["dog2"] = true;
mutantModels["pseudogiant1"] = false;
mutantModels["rodent1"] = true;
mutantModels["snork1"] = true;

/*
**	Animation Handling
*/

function BASH:GetModelType(model)
    if !model then return "tnb", false end;
    if string.sub(model, 1, 19) == "models/tnb/stalker/" then return "tnb" end;
    if string.sub(model, 1, 18) == "models/stalkertnb/" then
        local isMutant = false;
        for mutant, canRun in pairs(mutantModels) do
            if string.sub(model, 19) == (mutant .. ".mdl") then isMutant = true break end;
        end

        local modelStr = (isMutant and "misery") or "tnb";
        return modelStr, isMutant;
    elseif string.sub(model, 1, 13) == "models/cakez/" then return "misery", false end;

    return "tnb", false;
end

function BASH:GetMoveType(velocity, crouched)
    local len2d = velocity:Length2D();
    local aType = "idle";

	if crouched then
		if len2d < 0.5 then
			aType = "idle";
		else
			aType = "walk";
		end
	else
		if len2d < 0.5 then
			aType = "idle";
		elseif len2d <= 160 then
			aType = "walk";
		else
			aType = "run";
		end
	end

	return aType;
end

function BASH:HandlePlayerDriving(ply, velocity)
    if ply:InVehicle() then
        local modelStr, isMutant = BASH:GetModelType(ply:GetModel());
        if isMutant then return false end;
        local wep = ply:GetActiveWeapon();
        local wepName = wep:GetClass();
        local holsterType = wep:GetTable().RunHoldType or wep:GetTable().HolsterType;
        local aimType = wep:GetTable().NormalHoldType or wep:GetTable().HoldType;
        local moveType = self:GetMoveType(velocity, ply:Crouching());

        if wep:GetTable().FireMode == "safe" or wep:GetTable().CurrentFireMode == 1 then
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["seat"];
            elseif animTable[modelStr][holsterType] then
                ply.CalcIdeal = animTable[modelStr][holsterType]["seat"];
            end
        else
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["seat"];
            elseif animTable[modelStr][aimType] then
                ply.CalcIdeal = animTable[modelStr][aimType]["seat"];
            end
        end

        return true;
    end

    return false;
end

function BASH:HandlePlayerJumping(ply, velocity)
    if !ply.Jumping and !ply:OnGround() and ply:WaterLevel() <= 2 then
        ply.Jumping = true;
    end

    if ply.Jumping then
        if ply:OnGround() or ply:WaterLevel() > 2 then
            ply.Jumping = false;
            return false;
        end

        local modelStr, isMutant = BASH:GetModelType(ply:GetModel());
        if isMutant then return false end;
        local wep = ply:GetActiveWeapon();
        if !wep or !wep:IsValid() then return false end;
        local wepName = wep:GetClass();
        local holsterType = wep:GetTable().RunHoldType or wep:GetTable().HolsterType;
        local aimType = wep:GetTable().NormalHoldType or wep:GetTable().HoldType;
        if !aimType or aimType == "" then return false end;

        if wep:GetTable().FireMode == "safe" or wep:GetTable().CurrentFireMode == 1 then
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["jump"];
            elseif animTable[modelStr][holsterType] then
                ply.CalcIdeal = animTable[modelStr][holsterType]["jump"];
            end
        else
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["jump"];
            elseif animTable[modelStr][aimType] then
                ply.CalcIdeal = animTable[modelStr][aimType]["jump"];
            end
        end

        return true;
    end

    return false;
end

function BASH:HandlePlayerCrouching(ply, velocity)
    if ply:Crouching() and ply:WaterLevel() <= 0 then
        local modelStr, isMutant = BASH:GetModelType(ply:GetModel());
        if isMutant then return false end;
        local wep = ply:GetActiveWeapon();
        if !wep or !wep:IsValid() then return end;
        local wepName = wep:GetClass();
        local holsterType = wep:GetTable().RunHoldType or wep:GetTable().HolsterType;
        local aimType = wep:GetTable().NormalHoldType or wep:GetTable().HoldType;
        local moveType = self:GetMoveType(velocity, ply:Crouching());
        if isMutant and moveType == "run" and mutantModels[string.sub(ply:GetModel(), 19)] == false then
            moveType = "walk";
        end

        if wep:GetTable().FireMode == "safe" or wep:GetTable().CurrentFireMode == 1 then
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["crouch"][moveType];
            elseif animTable[modelStr][holsterType] then
                ply.CalcIdeal = animTable[modelStr][holsterType]["crouch"][moveType];
            end
        else
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName]["crouch"][moveType];
            elseif animTable[modelStr][aimType] then
                ply.CalcIdeal = animTable[modelStr][aimType]["crouch"][moveType];
            end
        end

        return true;
    end

    return false;
end

function BASH:HandlePlayerSwimming(ply, velocity)
    return false;
end

/*
if CLIENT then
    local function doAnimGUI(ply, cmd, args)
        local frame = vgui.Create("DFrame");
        frame:SetSize(400, 400);
        frame:Center();
        frame:ShowCloseButton(true);
        //frame:MakePopup();

        local list = vgui.Create("DListView", frame);
        list:SetSize(398, 374);
        list:SetPos(1, 25);
        list:SetMultiSelect(false);
        list:AddColumn("ACT_ Enum");

        local index = 1;
        for enum, val in SortedPairs(_G) do
            if string.sub(enum, 1, 4) == "ACT_" then
                list:AddLine(enum);
                local line = list:GetLine(index);
                line.EnumVal = val;
                line.OnMousePressed = function(self, mouse)
                    if mouse == MOUSE_LEFT then
                        LocalPlayer().CalcIdeal = self.EnumVal;
                        netstream.Start("update_anim", self.EnumVal);
                    end
                end
                index = index + 1;
            end
        end
    end
    concommand.Add("anims", doAnimGUI);
elseif SERVER then
    netstream.Hook("update_anim", function(ply, data)
        ply.CalcIdeal = data;
    end);
end
*/

function BASH:CalcMainActivity(ply, velocity)
    ply.CalcIdeal = ACT_HL2MP_IDLE;
    ply.CalcSeqOverride = -1;
    if !CheckPly(ply) or !ply:Alive() then return ply.CalcIdeal, ply.CalcSeqOverride end;

    local wep = ply:GetActiveWeapon();
    if !wep or !wep:IsValid() then
        return ply.CalcIdeal, ply.CalcSeqOverride;
    end

    if !self:HandlePlayerDriving(ply, velocity) and
       !self:HandlePlayerJumping(ply, velocity) and
       !self:HandlePlayerSwimming(ply, velocity) and
       !self:HandlePlayerCrouching(ply, velocity) then
        local modelStr, isMutant = BASH:GetModelType(ply:GetModel());
        local wepName = wep:GetClass();
        local holsterType = wep:GetTable().RunHoldType or wep:GetTable().HolsterType;
        local aimType = wep:GetTable().NormalHoldType or wep:GetTable().HoldType;
        local moveType = self:GetMoveType(velocity, ply:Crouching());
        if isMutant and moveType == "run" and mutantModels[string.sub(ply:GetModel(), 19)] == false then
            moveType = "walk";
        end
        if !holsterType and !aimType and wep:GetClass() == "bash_wep_hands" then return ply.CalcIdeal, ply.CalcSeqOverride end;

        if wep:GetTable().FireMode == "safe" or wep:GetTable().CurrentFireMode == 1 then
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName][moveType];
            elseif animTable[modelStr][holsterType] then
                ply.CalcIdeal = animTable[modelStr][holsterType][moveType];
            end
        else
            if animTable[modelStr][wepName] then
                ply.CalcIdeal = animTable[modelStr][wepName][moveType];
            elseif animTable[modelStr][aimType] then
                ply.CalcIdeal = animTable[modelStr][aimType][moveType];
            end
        end
    end

    return ply.CalcIdeal, ply.CalcSeqOverride;
end

function GM:TranslateActivity(ply, act)
	return act;
end
