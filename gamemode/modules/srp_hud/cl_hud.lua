local BASH = BASH;
local deathCurtain = Color(0, 0, 0, 0);
local deathText = Color(255, 255, 255, 0);
local deathSub = Color(255, 255, 255, 0);
local deathInst = Color(255, 255, 255, 0);
local pkScroll = -20;
local smoothApproach = 0;
local hudImages = {
	HEALTH = surface.GetTextureID("bash-srp/hud/health"),
	AMMO = surface.GetTextureID("bash-srp/hud/ammo"),
	STATUS = surface.GetTextureID("bash-srp/hud/status"),
	STATUS_STANDING = surface.GetTextureID("bash-srp/hud/status_standing"),
	STATUS_WALKING = surface.GetTextureID("bash-srp/hud/status_walking"),
	STATUS_CROUCHING = surface.GetTextureID("bash-srp/hud/status_crouching"),
	STATUS_RUNNING = surface.GetTextureID("bash-srp/hud/status_running")
};


function BASH:HUDPaint()
	if self:GUIOpen() then return end;
	if !LocalPlayer():GetEntry("CharLoaded") then return end;

	if !LocalPlayer():Alive() then
		self:DrawDeath();
		return;
	elseif LocalPlayer():GetEntry("IsPKed") then
		self:DrawPK();
		return;
	end

	if deathCurtain.a > 0 then
		deathCurtain = Color(0, 0, 0, 0);
		deathText = Color(255, 255, 255, 0);
		deathSub = Color(255, 255, 255, 0);
		deathInst = Color(255, 255, 255, 0);
	end

	self:ColorModify();
	self:DrawElements();
	self:DrawActionMenu();
	self:DrawStatuses();
	self:DrawHoverInfo();
	self:DrawWeaponSelect();

	if LocalPlayer():KeyDown(IN_USE) then
		self:DrawPropString();
	end

	if LocalPlayer():HasDetector() then
		self:DrawAnomalies();
	end

	if LocalPlayer():IsStaff() and LocalPlayer():GetEntry("AdminESP") then
		self:DrawESP();
	end

	if LocalPlayer().HighlightLoot then
		self:DrawLootBirth();
	end
end

local ranges = {};
ranges["detector_echo"] = 300;
ranges["detector_bear"] = 500;
ranges["detector_veles"] = 1000;
ranges["art_compass"] = 1500;
local indicator = surface.GetTextureID("effects/select_ring");
function BASH:DrawAnomalies()
	local range = ranges[LocalPlayer():GetBestDetector()];
	local anoms = ents.FindByClass("anom_*");
	local scale, pos, col;
	surface.SetTexture(indicator);
	for index, anom in pairs(anoms) do
		if anom:GetPos():Distance(LocalPlayer():GetPos()) > range then continue end;
		scale = 1 - math.Clamp(anom:GetPos():Distance(LocalPlayer():GetPos()) / range, 0, 1);
		pos = anom:GetPos():ToScreen();
		pos.x = math.Clamp(pos.x, 25, SCRW - 25);
		pos.y = math.Clamp(pos.y, 25, SCRH - 25);
		col = Color(210, 105, 30, scale * 255);
		surface.SetDrawColor(col);
		surface.DrawTexturedRect(pos.x - 25, pos.y - 25, 50, 50);
		draw.SimpleText("!", "BASHFontLarge", pos.x, pos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		//draw.RoundedBox(0, pos.x - 10, pos.y - 10, 20, 20, col);
	end
	local arts = ents.FindByClass("bash_item");
	for index, item in pairs(arts) do
		if !item:GetTable().ItemData.IsArtifact then continue end;
		if item:GetPos():Distance(LocalPlayer():GetPos()) > 300 then continue end;
		scale = 1 - math.Clamp(item:GetPos():Distance(LocalPlayer():GetPos()) / 300, 0, 1);
		pos = item:GetPos():ToScreen();
		pos.x = math.Clamp(pos.x, 25, SCRW - 25);
		pos.y = math.Clamp(pos.y, 25, SCRH - 25);
		col = Color(210, 105, 30, scale * 255);
		surface.SetDrawColor(col);
		surface.DrawTexturedRect(pos.x - 25, pos.y - 25, 50, 50);
		draw.SimpleText("!", "BASHFontLarge", pos.x, pos.y, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
end

function BASH:DrawESP()
	local screenPos, x, y, dist, fact, size, alpha, col;
	for _, ply in pairs(player.GetAll()) do
		if ply != LocalPlayer() and ply:GetEntry("CharLoaded") then
			screenPos = ply:GetPos():ToScreen();
			x, y = math.Clamp(screenPos.x, 5, SCRW - 5), math.Clamp(screenPos.y, 5, SCRH - 5);
			dist = LocalPlayer():GetPos():Distance(ply:GetPos());
			fact = 1 - math.Clamp(dist / 1024, 0, 1);
			size = math.max(10, 32 * fact);
			alpha = math.Clamp(255 * fact, 80, 255);
			col = Color(color_green.r, color_green.g, color_green.b, alpha);

			surface.SetDrawColor(color_green.r, color_green.g, color_green.b, alpha);
			surface.DrawRect(x - size / 2, y - size / 2, size, size);
			draw.SimpleText(ply:GetEntry("Name") .. " (" .. ply:Name() .. ")", "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end

	for index, ent in pairs(ents.FindByClass("bash_*")) do
		if ent:IsWeapon() then continue end;
		if !ent:IsValid() then continue end;

		screenPos = ent:GetPos():ToScreen();
		x, y = math.Clamp(screenPos.x, 5, SCRW - 5), math.Clamp(screenPos.y, 5, SCRH - 5);
		dist = LocalPlayer():GetPos():Distance(ent:GetPos());
		fact = 1 - math.Clamp(dist / 1024, 0, 1);
		size = math.max(10, 32 * fact);
		alpha = math.Clamp(255 * fact, 80, 255);
		if ent:IsItem() then
			col = Color(color_red.r, color_red.g, color_red.b, alpha);
		else
			col = Color(100, 100, 200, alpha);
		end

		surface.SetDrawColor(col.r, col.g, col.b, alpha);
		surface.DrawRect(x - size / 2, y - size / 2, size, size);
		if ent:IsItem() then
			if ent:GetTable().ItemData then
				draw.SimpleText(ent:GetTable().ItemData.Name, "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			else
				draw.SimpleText("Item", "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		else
			draw.SimpleText(ent:GetTable().PrintName, "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end

	for index, ent in pairs(ents.FindByClass("anom_*")) do
		if !ent:IsValid() then continue end;

		screenPos = ent:GetPos():ToScreen();
		x, y = math.Clamp(screenPos.x, 5, SCRW - 5), math.Clamp(screenPos.y, 5, SCRH - 5);
		dist = LocalPlayer():GetPos():Distance(ent:GetPos());
		fact = 1 - math.Clamp(dist / 1024, 0, 1);
		size = math.max(10, 32 * fact);
		alpha = math.Clamp(255 * fact, 80, 255);
		col = Color(200, 100, 0, alpha);

		surface.SetDrawColor(col.r, col.g, col.b, alpha);
		surface.DrawRect(x - size / 2, y - size / 2, size, size);
		draw.SimpleText(ent:GetTable().PrintName, "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	for index, ent in pairs(ents.FindByClass("npc_*")) do
		if !ent:IsValid() then continue end;

		screenPos = ent:GetPos():ToScreen();
		x, y = math.Clamp(screenPos.x, 5, SCRW - 5), math.Clamp(screenPos.y, 5, SCRH - 5);
		dist = LocalPlayer():GetPos():Distance(ent:GetPos());
		fact = 1 - math.Clamp(dist / 1024, 0, 1);
		size = math.max(10, 32 * fact);
		alpha = math.Clamp(255 * fact, 80, 255);
		col = Color(100, 100, 200, alpha);

		surface.SetDrawColor(col.r, col.g, col.b, alpha);
		surface.DrawRect(x - size / 2, y - size / 2, size, size);
		draw.SimpleText(ent:GetTable().PrintName, "BASHFontHeavy", x, y - size, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	draw.SimpleText("Players", "BASHFontHeavy", SCRW / 2, 2, color_green, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	draw.SimpleText("Items", "BASHFontHeavy", SCRW / 2, 22, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	draw.SimpleText("Anomalies", "BASHFontHeavy", SCRW / 2, 42, Color(200, 100, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	draw.SimpleText("Other Entities", "BASHFontHeavy", SCRW / 2, 62, Color(100, 100, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
end

function BASH:DrawLootBirth()
	local ents = ents.FindByClass("bash_loot");
	for _, ent in pairs(ents) do
		local entPos = ent:GetPos():ToScreen();
		if entPos.visible then
			local diff = math.Round(CurTime() - ent:GetNWInt("Birth", 0));
			local suff = " seconds.";

			if diff > 60 then
				diff = math.Round(diff / 60);
				suff = " minutes.";
				if diff > 60 then
					diff = math.Round(diff / 60);
					suff = " hours.";
				end
			end

			draw.SimpleText(diff .. suff, "BASHFontHeavy", entPos.x, entPos.y + 40, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
		end
	end
end

function BASH:DrawPropString()
	local trace = LocalPlayer():GetEyeTrace();
	if !trace.Entity or !trace.Entity:IsValid() or !trace.Entity:IsProp() then return end;
	if trace.Entity:GetPos():Distance(LocalPlayer():GetPos()) > 300 then return end;
	if trace.Entity:GetNWString("UseString", "") == "" then return end;

	local str = trace.Entity:GetNWString("UseString", "");
	draw.NoTexture();
	draw.SimpleText(str, "BASHFontHeavy", (SCRW / 2) + 5, (SCRH / 2) + 5, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
end

function BASH:DrawDeath()
	if deathCurtain.a != 255 then
		deathCurtain.a = math.Approach(deathCurtain.a, 255, 2);
	end

	draw.RoundedBox(0, 0, 0, SCRW, SCRH, deathCurtain);

	if deathCurtain.a == 255 then
		deathText.a = math.Approach(deathText.a, 255, 2);
	end

	draw.SimpleText(LocalPlayer():GetEntry("Name") .. " has passed.", "BASHFontApp", CENTER_X, CENTER_Y - 2, deathText, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);

	if deathText.a == 255 then
		deathSub.a = math.Approach(deathSub.a, 255, 2);
	end

	draw.SimpleText("They are one with the Zone now.", "BASHFontApp", CENTER_X, CENTER_Y + 2, deathSub, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

	if deathSub.a == 255 then
		deathInst.a = math.Approach(deathInst.a, 255, 2);
	end

	draw.SimpleText("(Click or Space to respawn.)", "BASHFontApp", CENTER_X, CENTER_Y + 42, deathInst, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
end

function BASH:DrawPK()
	if self.PKDone then return end;

	if deathCurtain.a != 255 then
		deathCurtain.a = math.Approach(deathCurtain.a, 255, 2);
	end

	draw.RoundedBox(0, 0, 0, SCRW, SCRH, deathCurtain);

	if deathCurtain.a == 255 then
		deathText.a = math.Approach(deathText.a, 255, 2);
	end

	draw.SimpleText(LocalPlayer():GetEntry("Name"), "BASHFontHeavy", CENTER_X, pkScroll, deathText, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

	if deathText.a == 255 then
		deathSub.a = math.Approach(deathSub.a, 255, 2);
		draw.SimpleText(LocalPlayer():GetEntry("Description"), "BASHFontLight", CENTER_X, pkScroll + 20, deathSub, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
		draw.SimpleText("The Zone has claimed another soul.", "BASHFontLight", CENTER_X, pkScroll + 40, deathSub, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

		pkScroll = math.Approach(pkScroll, SCRH + 20, 1);

		if pkScroll >= SCRH + 20 then
			self:CreateCharacterMenu();
			self.PKDone = true;
			return;
		end
	end
end

function BASH:ColorModify()
	DrawColorModify(COLOR_MODIFY.DEFAULT);
end

local Status = hudImages.STATUS_STANDING;
function BASH:DrawElements()
	if LocalPlayer():KeyDown(IN_DUCK) then
		Status = hudImages.STATUS_CROUCHING;
	elseif LocalPlayer():KeyDown(IN_SPEED) then
		Status = hudImages.STATUS_RUNNING;
	elseif LocalPlayer():KeyDown(IN_FORWARD) or LocalPlayer():KeyDown(IN_BACK) or LocalPlayer():KeyDown(IN_MOVELEFT) or LocalPlayer():KeyDown(IN_MOVERIGHT) then
		Status = hudImages.STATUS_WALKING;
	else
		Status = hudImages.STATUS_STANDING;
	end

	surface.SetDrawColor(255, 255, 255, 255);
	surface.SetTexture(hudImages.STATUS);
	surface.DrawTexturedRect(SCRW - 300, SCRH - 200, 128, 256);

	surface.SetTexture(Status);
	surface.DrawTexturedRect(SCRW - 265, SCRH - 100, 64, 64);

	surface.SetTexture(hudImages.HEALTH)
	surface.DrawTexturedRect(SCRW - 230, SCRH - 170 - 66, 256, 128)

	surface.SetTexture(hudImages.HEALTH)
	surface.DrawTexturedRect(SCRW - 230, SCRH - 170, 256, 128)

	surface.SetTexture(hudImages.AMMO)
	surface.DrawTexturedRect(SCRW - 230, SCRH - 110, 256, 128)

	draw.SimpleText("+", "BASHFontHeavy", SCRW - 170, SCRH - 126 - 66, Color(200, 200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("*", "BASHFontHeavy", SCRW - 170, SCRH - 84 - 66, Color(200, 200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("R", "BASHFontHeavy", SCRW - 170, SCRH - 126, Color(200, 200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("?", "BASHFontHeavy", SCRW - 170, SCRH - 84, Color(200, 200, 200, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function BASH:DrawStatuses()
	local healthPerc = LocalPlayer():Health() / LocalPlayer():GetEntry("MaxHealth");
	draw.RoundedBox(2, SCRW - 150, SCRH - 117 - 66, 109 * healthPerc, 10, Color(130, 0, 0, 200));

	local _, suitCond = ParseDouble(LocalPlayer():GetEntry("Suit"));
	if suitCond then
		local suitPerc = suitCond / 100;
		draw.RoundedBox(2, SCRW - 150, SCRH - 98 - 66, 109 * suitPerc, 10, Color(0, 0, 130, 200));
	end

	if LocalPlayer():GetEntry("Radiation") > 0 then
		local radPerc = LocalPlayer():GetEntry("Radiation") / 100;
		draw.RoundedBox(2, SCRW - 150, SCRH - 117, 109 * radPerc, 10, Color(210, 105, 30, 150));
	end

	local sprintPerc = LocalPlayer():GetEntry("Stamina") / LocalPlayer():GetEntry("MaxStamina");
	draw.RoundedBox(2, SCRW - 264, SCRH - 29, 56 * sprintPerc, 3, Color(0, 128, 255, 200));

	if self.Chat.Open then
		if CurTime() - LocalPlayer():GetEntry("LastOOC") < self.OOCDelay and !ply:IsStaff() then
			local message = "Next OOC: " .. tostring(math.ceil((LocalPlayer():GetEntry("LastOOC") + self.OOCDelay) - CurTime())) .. " seconds.";
			surface.SetFont("BASHFontHeavy");
			local x, _ = surface.GetTextSize(message);
			draw.RoundedBox(0, 25, SCRH - 300, x + 10, 20, Color(0, 0, 0, 255));
			draw.RoundedBox(0, 26, SCRH - 299, x + 8, 18, Color(75, 75, 75, 255));
			draw.RoundedBox(0, 27, SCRH - 298, x + 6, 16, Color(50, 50, 50, 255));
			draw.SimpleText(message, "BASHFontHeavy", ((x + 10) / 2) + 25, SCRH - 290, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		end
	end

	local wep = LocalPlayer():GetActiveWeapon();
	if wep:IsValid() and wep:GetTable().IsBASHWeapon and !wep:GetTable().IsMelee and wep:GetClass() != "bash_wep_hands" then
		local succ, ammoTotal = LocalPlayer():HasItem("ammo_" .. wep:GetTable().Primary.Ammo, true);
		draw.SimpleText(wep:Clip1() .. "/" .. ammoTotal, "BASHFontLarge", SCRW - 40, SCRH - 55, Color(210, 105, 30, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM);
	end
end

Targets = {};
function BASH:DrawHoverInfo()
	local traceInfo = {
		start = LocalPlayer():EyePos(),
		endpos = LocalPlayer():EyePos() + LocalPlayer():GetAimVector() * 300,
		filter = LocalPlayer()
	};
	local trace = util.TraceLine(traceInfo);
	local traceEnt = trace.Entity;
	local traceIndex = traceEnt:EntIndex();

	if traceEnt and traceEnt:IsValid() and LocalPlayer():KeyDown(IN_USE) then
		if traceEnt:IsPlayer() then
			if Targets[traceIndex] then
				Targets[traceIndex].FullTitle = true;
			end
		end
	end

	if traceEnt and traceEnt:IsPlayer() and traceEnt:Alive() and traceEnt:GetEntry("Name") then
		if !Targets[traceIndex] then
			Targets[traceIndex] = {};
			Targets[traceIndex].StartTime = CurTime();
			Targets[traceIndex].Alpha = 0;
			Targets[traceIndex].Text = traceEnt:GetEntry("Name");
			Targets[traceIndex].FullTitle = false;
		else
			Targets[traceIndex].Alpha = math.Clamp(Targets[traceIndex].Alpha + (300 * FrameTime()), 0, 255);
		end
	elseif traceEnt and traceEnt:IsItem() and traceEnt:GetTable().ItemID then
		if !Targets[traceIndex] then
			Targets[traceIndex] = {};
			Targets[traceIndex].StartTime = CurTime();
			Targets[traceIndex].Alpha = 0;
			Targets[traceIndex].Text = (traceEnt:GetTable().ItemData and traceEnt:GetTable().ItemData.Name) or "Item";
		else
			Targets[traceIndex].Alpha = math.Clamp(Targets[traceIndex].Alpha + (300 * FrameTime()), 0, 255);
		end
	elseif traceEnt and traceEnt:IsProp() then
		if !Targets[traceIndex] then
			Targets[traceIndex] = {};
			Targets[traceIndex].StartTime = CurTime();
			Targets[traceIndex].Alpha = 0;
			Targets[traceIndex].Text = traceEnt:GetNWString("Description", "");
		else
			Targets[traceIndex].Alpha = math.Clamp(Targets[traceIndex].Alpha + (300 * FrameTime()), 0, 255);
		end
	end

	for entIndex, data in pairs(Targets) do
		local ent = ents.GetByIndex(entIndex);

		if ent and ent:IsPlayer() then
			local pos = ent:EyePos() + Vector(0, 0, 8);
			local screenPos = pos:ToScreen();
			local factionColor = Color(0, 120, 0, 255);
			if self.Factions[ent:GetEntry("Faction")] then
				factionColor = self.Factions[ent:GetEntry("Faction")].Color;
			end
			local displayText = "";

			if ent:GetEntry("Description") then
				if data.FullTitle then
					displayText = displayText .. FormatString(ent:GetEntry("Description"), "BASHFontLight", 400);
				else
					displayText = displayText .. FormatString(ChokeString(ent:GetEntry("Description"), 125), "BASHFontLight", 400);
				end
			end

			local explodedText = string.Explode('\n', displayText);
			local typingBuffer = 16;

			draw.SimpleTextOutlined(data.Text, "BASHFontHeavy", screenPos.x, screenPos.y, Color(factionColor.r, factionColor.g, factionColor.b, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));

			if ent:GetEntry("IsTyping") then
				draw.SimpleTextOutlined("[Typing...]", "BASHFontHeavy", screenPos.x, screenPos.y + 16, Color(255, 255, 255, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
				typingBuffer = typingBuffer + 16;
			end

			if ent:HasClothing() then
				local clothingText = "";
				local clothing = ent:GetEntry("Clothing");
				clothing = util.JSONToTable(clothing);
				for part, article in pairs(clothing) do
					if article and article != "" then
						local itemData = self.Items[article];
						if clothingText == "" then
							clothingText = itemData.Name .. ", ";
						else
							clothingText = clothingText .. itemData.Name .. ", ";
						end
					end
				end
				clothingText = string.sub(clothingText, 1, string.len(clothingText) - 2);
				clothingText = FormatString("Wearing: " .. clothingText, "BASHFontHeavy", 400);
				local clothingExp = string.Explode('\n', clothingText);
				for index, line in pairs(clothingExp) do
					draw.SimpleTextOutlined(line, "BASHFontHeavy", screenPos.x, screenPos.y + typingBuffer, Color(150, 150, 150, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
					typingBuffer = typingBuffer + 16;
				end
			end

			for index, title in pairs(explodedText) do
				draw.SimpleTextOutlined(title, "BASHFontHeavy", screenPos.x, screenPos.y + typingBuffer + (16 * (index - 1)), Color(255, 255, 255, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
			end
		elseif ent and ent:IsItem() then
			local pos = ent:GetPos() + Vector(0, 0, 2);
			local screenPos = pos:ToScreen();

			draw.SimpleText(data.Text, "BASHFontHeavy", screenPos.x, screenPos.y, Color(255, 255, 255, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
		elseif ent and ent:IsProp() then
			if data.Text != "" then
				local pos = ent:GetPos() + Vector(0, 0, 2);
				local screenPos = pos:ToScreen();

				draw.SimpleText(data.Text, "BASHFontHeavy", screenPos.x, screenPos.y, Color(255, 255, 255, data.Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			end
		end

		if ent and ent:IsValid() and ent != traceEnt then
			Targets[entIndex].Alpha = math.Clamp(Targets[entIndex].Alpha - (300 * FrameTime()), 0, 255);

			if Targets[entIndex].Alpha == 0 then
				Targets[entIndex] = nil;
			end
		end

		if !ent:IsValid() then
			Targets[entIndex] = nil;
		end
	end
end

BASH.WepSelect = {};
BASH.WepSelect.Slots = {};
BASH.WepSelect.MajorIndex = 1;
BASH.WepSelect.MinorIndex = 1;
BASH.WepSelect.LastScroll = 0;
function BASH:ReformatWeaponSelect()
	if !self.WepSelect.Slots[1] then
		self.WepSelect.Slots[1] = {"bash_wep_hands"};
	end

	self.WepSelect.Slots[2] = {};
	local weps = LocalPlayer():GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	local index = 1;
	for _, wep in pairs(weps) do
		if wep.ID then
			local wepData = self.Items[wep.ID];
			self.WepSelect.Slots[2][index] = wepData.WeaponEntity;
			index = index + 1;
		end
	end

	self.WepSelect.Slots[3] = {};
	index = 1;
	if LocalPlayer():GetWeapon("weapon_physgun"):IsValid() then
		self.WepSelect.Slots[3][index] = "weapon_physgun";
		index = index + 1;
	end
	if LocalPlayer():GetWeapon("gmod_tool"):IsValid() then
		self.WepSelect.Slots[3][index] = "gmod_tool";
	end
end
function BASH:DrawWeaponSelect()
	if CurTime() - self.WepSelect.LastScroll > 3 then return end;

	local x = (SCRW / 2) - 260;
	local y = 5;
	local curX = 155;
	local curY = 30;
	local alpha = 200 - (((CurTime() - self.WepSelect.LastScroll) / 3) * 200)
	local curCol = Color(100, 100, 100, alpha);
	local wepEnt;
	for index, slots in pairs(self.WepSelect.Slots) do
		if index == self.WepSelect.MajorIndex then
			curX = 195;
		else
			curX = 155;
		end

		for ind, slot in pairs(slots) do
			local wepEnt = LocalPlayer():GetWeapon(slot);
			if !wepEnt or !wepEnt:IsValid() then continue end;
			if index == self.WepSelect.MajorIndex and ind == self.WepSelect.MinorIndex then
				curCol = Color(50, 50, 200, alpha);
			else
				curCol = Color(50, 50, 50, alpha);
			end

			draw.RoundedBox(8, x, y, curX, curY, Color(0, 0, 0, alpha));
			draw.RoundedBox(8, x + 1, y + 1, curX - 2, curY - 2, Color(75, 75, 75, alpha));
			draw.RoundedBox(8, x + 2, y + 2, curX - 4, curY - 4, curCol);
			draw.SimpleText(wepEnt:GetPrintName(), "BASHFontHeavy", x + (curX / 2), y + (curY / 2), Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
			y = y + curY;
		end

		x = x + curX + 5;
		y = 5;
	end
end
