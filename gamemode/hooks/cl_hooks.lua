local BASH = BASH;

/*
**	Init Business
*/
local dataTime;
local dataSent = false;
local dataRec = false;
local backupMade = false;
local crashData = "cleared";
function BASH:CrashCheck()
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) then return end;

	if !dataTime then
		dataTime = CurTime();
	end

	if !dataSent then
		netstream.Start("BASH_Check_Crash", crashData);
		dataSent = true;
		dataRec = false;
		dataTime = CurTime();
	end

	if dataSent and !dataRec then
		if CurTime() - dataTime > 20 and !backupMade then
			local invs = {"InvMain", "InvSec", "InvAcc"};
			local encrypted, key, final;
			local folder = RandomString(16);
			for index, invString in pairs(invs) do
				encrypted = LocalPlayer():GetEntry(invString);
				key = RandomString(1);
				final = index .. key .. "#";
				for index, char in pairs(string.ToTable(encrypted)) do
					final = final .. string.char(bit.bxor(string.byte(char), string.byte(key)));
				end

				self:CreateDirectory("bash/recovery/" .. folder);
				self:WriteToFile("bash/recovery/" .. folder .. "/" .. RandomString(6) .. ".txt", final);
			end

			backupMade = true;
			MsgCon(color_red, "Inventory recovery keys saved to folder 'data/bash/recovery/" .. folder .. "/'! Submit the contents of this folder to an authorized staff member to recover lost items.");
		end
	end
end
netstream.Hook("BASH_Check_Crash_Return", function(data)
	if data == "cleared" then
		dataSent = false;
		dataRec = true;
	end
end);

function BASH:InitPostEntity()
	//  Teehee :^)
	timer.Simple(2, function()
		surface.PlaySound("bash/gui/load.wav");
	end);

	netstream.Start("BASH_Dank_Fix");
end

local spawnCurtain = Color(0, 0, 0, 255);
function BASH:PostRenderVGUI()
	if gui.IsGameUIVisible() or !self.Initialized then return end;

	if !self.IntroDone then
		self:IntroHook();
		return;
	end

	if !self.AlphaDone then
		self:AlphaHook();
		return;
	end

	if self.PostQuizStart and !self.PostQuizDone then
		self:PostQuiz();
		return;
	end

	if LocalPlayer().PostSpawn then
		spawnCurtain.a = math.Approach(spawnCurtain.a, 0, 2);
		draw.RoundedBox(0, 0, 0, SCRW, SCRH, spawnCurtain);

		if spawnCurtain.a == 0 then
			LocalPlayer().PostSpawn = false;
			self:CreateNotif("You're playing as " .. LocalPlayer():GetEntry("Name") .. ".", "BASHFontHeavy", NOTIF_TOP_LEFT, 4);
		end
	end
end

local currentMessage = "Loading..."
local fadeInStart = Color(0, 0, 0);
local fadeInEnd = Color(44, 62, 80);
local foreground = Color(255, 255, 255, 0);
local curSin, curCos;
function BASH:IntroHook()
	if fadeInStart != fadeInEnd and !LocalPlayer().InitDone then
		fadeInStart.r = math.Approach(fadeInStart.r, fadeInEnd.r, 1.1);
		fadeInStart.g = math.Approach(fadeInStart.g, fadeInEnd.g, 1.55);
		fadeInStart.b = math.Approach(fadeInStart.b, fadeInEnd.b, 2);
		foreground.a = math.Approach(foreground.a, 153, 4);
	end

	draw.RoundedBox(0, 0, 0, SCRW, SCRH, fadeInStart);
	draw.SimpleText("Stuck here? Try reconnecting!", "BASHFontSmall", CENTER_X, 5, foreground, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	draw.SimpleText("Your session is initializing...", "ChatFont", CENTER_X, CENTER_Y - 50, foreground, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
	draw.SimpleText(currentMessage, "ChatFont", CENTER_X, CENTER_Y - 25, foreground, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
	curSin = math.abs(math.sin(RealTime()));
	curCos = math.abs(math.cos(RealTime()));
	draw.Circle(CENTER_X, CENTER_Y + 35, curSin * 50, curSin * 100, foreground);
	draw.Circle(CENTER_X, CENTER_Y + 35, curCos * 50, curCos * 100, foreground);

	if LocalPlayer().InitDone then
		if !LocalPlayer().PlyData then return end;
		if LocalPlayer().PlyData.PassedQuiz != 0 then
			fadeInStart.r = math.Approach(fadeInStart.r, 0, 1.1);
			fadeInStart.g = math.Approach(fadeInStart.g, 0, 1.55);
			fadeInStart.b = math.Approach(fadeInStart.b, 0, 2);
			fadeInStart.a = math.Approach(fadeInStart.a, 0, 4);
			foreground.a = math.Approach(foreground.a, 0, 4);
		else
			fadeInStart.r = math.Approach(fadeInStart.r, 0, 1.1);
			fadeInStart.g = math.Approach(fadeInStart.g, 0, 1.55);
			fadeInStart.b = math.Approach(fadeInStart.b, 0, 2);
			fadeInStart.a = math.Approach(fadeInStart.a, 255, 4);
			foreground.a = math.Approach(foreground.a, 0, 4);
		end
	end

	if fadeInStart.r == 0 and foreground.a == 0 then
		MsgCon(color_green, "Loading...");
		self.IntroDone = true;
		if LocalPlayer().PlyData.PassedQuiz != 0 then
			self.AlphaDone = true;
			self:QuizHook();
		end
	end
end

BASH.AlphaDone = false;
local backCol = Color(0, 0, 0, 255);
local titleCol = Color(255, 255, 255, 0);
local textCol = Color(255, 255, 255, 0);
local finishedFade = 0;
function BASH:AlphaHook()
	draw.RoundedBox(0, 0, 0, SCRW, SCRH, backCol);
	draw.SimpleText("Welcome to the #!/BASH/SRP official public alpha.", "BASHFontLarge", CENTER_X, CENTER_Y - 28, titleCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
	draw.SimpleText("The following gamemode is under development.", "BASHFontYell", CENTER_X, CENTER_Y - 4, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP);
	draw.SimpleText("Features and content are liable to change at any time.", "BASHFontYell", CENTER_X, CENTER_Y, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	draw.SimpleText("Participate at your own discretion.", "BASHFontYell", CENTER_X, CENTER_Y + 22, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);

	if titleCol.a != 255 and finishedFade == 0 then
		titleCol.a = math.Approach(titleCol.a, 255, 3);
		return;
	end

	if textCol.a != 255 and finishedFade == 0 then
		textCol.a = math.Approach(textCol.a, 255, 3);
		return;
	elseif textCol.a == 255 and finishedFade == 0 then
		finishedFade = CurTime();
	end

	if CurTime() - finishedFade > 6 then
		backCol.a = math.Approach(backCol.a, 0, 4);
		titleCol.a = math.Approach(titleCol.a, 0, 4);
		textCol.a = math.Approach(textCol.a, 0, 4);
	end

	if backCol.a == 0 then
		self.AlphaDone = true;
		self:QuizHook();
	end
end

BASH.PostQuizStart = false;
BASH.PostQuizDone = false;
local time = 0;
local introString;
local currentString = "";
local currentLength = 1;
local currentChar;
local multLines;
local cacheLines = {};
local multIndex = 1;
local backgroundGlow = Color(0, 0, 0, 255);
local x = 25;
local y = 25;
function BASH:PostQuiz()
	if !introString then
		introString = table.Random(self.IntroMessages);
	end
	if string.find(introString, "*") and !multLines then
		multLines = string.Explode("*", introString);
		for index, line in pairs(multLines) do
			cacheLines[index] = "";
		end
	elseif !string.find(introString, "*") and !multLines then
		multLines = {introString};
	end

	draw.RoundedBox(0, 0, 0, SCRW, SCRH, backgroundGlow);
	draw.SimpleText("Type '#!/skipintro' in console (~) to skip.", "BASHFontSmall", SCRW / 2, 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM);
	curSin = math.abs(math.sin(RealTime()));
	backgroundGlow.r, backgroundGlow.g, backgroundGlow.b = curSin * 30, curSin * 30, curSin * 30;

	local waitTime = math.Rand(0.05, 0.1);
	local elapsedTime = FrameTime();
	time = time + elapsedTime;

	if multIndex == #multLines and currentLength == string.len(multLines[multIndex]) then
		waitTime = 2;

		if time > waitTime then
			self.PostQuizDone = true;
			surface.PlaySound("bash/gui/keystroke_enter.wav");
			self:CreateCharacterMenu();
			MsgN(string.gsub(introString, "*", '\n'));
			return;
		else
			for index = 1, multIndex do
				draw.SimpleText(cacheLines[index], "BASHFontLarge", x, y * index, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
			end

			return;
		end
	else
		for index = 1, multIndex do
			draw.SimpleText(cacheLines[index], "BASHFontLarge", x, y * index, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
		end
	end

	if time < waitTime then return end;

	if currentLength < string.len(multLines[multIndex]) then
		currentLength = currentLength + 1;
		currentString = string.sub(multLines[multIndex], 1, currentLength);
		currentChar = string.GetChar(multLines[multIndex], currentLength);
		cacheLines[multIndex] = currentString;
		time = 0;

		if currentChar == ' ' then
			surface.PlaySound("bash/gui/keystroke_space.wav");
		else
			surface.PlaySound("bash/gui/keystroke.wav");
		end
	elseif currentLength >= string.len(multLines[multIndex]) then
		surface.PlaySound("bash/gui/keystroke_space.wav");
		currentLength = 1;
		currentString = cacheLines[multIndex + 1];
		currentChar = nil;
		multIndex = multIndex + 1;
		time = 0;
	end
end
concommand.Add("#!/skipintro", function(ply, cmd, args)
	if BASH.PostQuizDone then return end;
	BASH.PostQuizDone = true;
	surface.PlaySound("bash/gui/keystroke_enter.wav");
	BASH:CreateCharacterMenu();
	MsgN(string.gsub(introString or "", "*", '\n'));
end);

function BASH:QuizHook()
	if LocalPlayer().PlyData.PassedQuiz != 0 then
		self:CreateCharacterMenu();
		self:CreateNotif("Welcome back, " .. LocalPlayer():Name() .. "!", "BASHFontHeavy", NOTIF_TOP_LEFT, 4);
	else
		self:CreateQuiz();
		self:CreateNotif("Hey there! Looks like you're new to this server. That's great!\nPlease answer this quiz to the best of your ability.\nIf you fail, this isn't the server for you.", "BASHFontHeavy", NOTIF_TOP_CENT, 8);
	end
end

netstream.Hook("BASH_Init_Messages", function(data)
	MsgCon(color_green, data);
	currentMessage = data;
end);

netstream.Hook("BASH_Init_Data", function(data)
	LocalPlayer().PlyData = data[1] or {};
	LocalPlayer().CharData = data[2] or {};
	LocalPlayer().InitDone = true;
end);

netstream.Hook("BASH_Init_Done", function(data)
	LocalPlayer().InitDone = true;
end);

netstream.Hook("BASH_Ply_Data", function(data)
	LocalPlayer().PlyData = data;
end);

netstream.Hook("BASH_Char_Data", function(data)
	LocalPlayer().CharData = data;
end);

/*
**	Base Hooks
*/
local lastCheck;
local hackCommands = {
	// GEAR1 Commands
	"gear_printents", "gw_toggle",
	"gw_pos", "gearmenu",
	"gb_reload", "gb_toggle",
	"+gb", "-gb", "gb_menu",
	// GEAR2 Commands
	"gear2_menu",
	// AHack Commands
	"ahack_menu",
	// Sasha Commands
	"sasha_menu",
	// Misc. Commands
	"showents", "showhxmenu"
};
function BASH:Think()
	if !lastCheck then
		lastCheck = CurTime();
	end

	if !self.LastCrashCheck then
		self.LastCrashCheck = CurTime();
	end

	if CurTime() - lastCheck > 15 then
		local commands, _ = concommand.GetTable();

		for _, cmd in pairs(hackCommands) do
			if commands[cmd] then
				netstream.Start("BASH_Remove_Nerd");
				return;
			end
		end

		lastCheck = CurTime();
	end

	if LocalPlayer():GetEntry("CharLoaded") then
		if CurTime() - self.LastCrashCheck > 20 then
			self:CrashCheck();
			self.LastCrashCheck = CurTime();
		end

		if !LocalPlayer():Alive() then
			if self.ActionMenu.Open then
				self:RemoveActionMenu();
			end
			if self.ContextMenu.Open then
				self:OnContextMenuClose();
			end
			if self.Inventory.Open then
				self:CloseInventory();
			end
			if self.HelpMenu.Open then
				self:CloseHelpMenu();
			end
			if self.Chat.Open then
				self:RemoveChat();
			end
			if self.Writing.Open then
				self:CloseWriting();
			end
			return;
		end

		local stamina = LocalPlayer():GetEntry("Stamina");
		local maxStamina = LocalPlayer():GetEntry("MaxStamina");
		local staminaRegen = LocalPlayer():GetEntry("StaminaRegen");
		if LocalPlayer():KeyDown(IN_SPEED) and LocalPlayer():GetVelocity():Length() > 60 and LocalPlayer():IsOnGround() and !LocalPlayer():InVehicle() and !LocalPlayer():GetEntry("Observing") then
			if stamina >= 10 then
				if !LocalPlayer().LastStaminaLoss then
					LocalPlayer().LastStaminaLoss = 0;
				end

				if CurTime() - LocalPlayer().LastStaminaLoss > 1 then
					LocalPlayer():UpdateEntry("Stamina", math.Clamp(stamina - 10, 0, maxStamina));
					LocalPlayer().LastStaminaLoss = CurTime();
				end
			end
		elseif LocalPlayer():KeyDown(IN_JUMP) and !LocalPlayer():InVehicle() and !LocalPlayer():GetEntry("IsObserving") then
			if LocalPlayer().JumpStamina then
				LocalPlayer():UpdateEntry("Stamina", math.Clamp(stamina - 10, 0, maxStamina));
				LocalPlayer().JumpStamina = false;
			end
		elseif stamina < maxStamina then
			if !LocalPlayer().LastStaminaGain then
				LocalPlayer().LastStaminaGain = CurTime();
			end

			if CurTime() - LocalPlayer().LastStaminaGain > 1 then
				LocalPlayer():UpdateEntry("Stamina", math.Clamp(stamina + staminaRegen, 0, maxStamina));
				LocalPlayer().LastStaminaGain = CurTime();
			end
		end

		if LocalPlayer():Health() > 100 then
			LocalPlayer():SetHealth(100);
		end

		LocalPlayer():HandleQuirks();
		//	Disabling monologue for now. Uncomment if you wish to use it.
		//LocalPlayer():HandleMonologue();
	end
end
netstream.Hook("BASH_Reset_Stamina", function(data)
	LocalPlayer().ResetInitialStamina = true;
end);

function BASH:HUDShouldDraw(name)
	if name == "CHudCrosshair" then
		if LocalPlayer():GetActiveWeapon() != NULL then
			if table.HasValue(ENABLED_CROSSHAIRS, LocalPlayer():GetActiveWeapon():GetClass()) then return true end;
		end
	end

	for _, disable in pairs(DISABLED_HUD) do
		if name == disable then return false end;
	end

	return true;
end

local SphereMat = Material("phoenix_storms/gear");
function BASH:PostDrawOpaqueRenderables()
	if self.Inventory.Open then
		local traceInfo = {
			start = LocalPlayer():EyePos(),
			endpos = LocalPlayer():EyePos() + LocalPlayer():GetAimVector() * 300,
			filter = LocalPlayer()
		};
		local trace = util.TraceLine(traceInfo);

		render.SetMaterial(SphereMat);
		render.DrawSphere(trace.HitPos, 1, 20, 20, Color(255, 0, 0, 255));
	end
end

function BASH:PostDrawViewModel(vm, ply, weapon)
	if weapon.UseHands or !weapon:IsScripted() then
		local hands = LocalPlayer():GetHands();
		if hands:IsValid() then hands:DrawModel() end
	end
end

function BASH:CalcView(ply, origin, angles, fov)
	local view = {};
	view.origin = origin;
	view.angles = angles;
	view.fov = fov;

	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) or !LocalPlayer():Alive() then return view end;

	local drunk = LocalPlayer():GetEntry("DrunkMul");
	if drunk > 30 then
		drunk = drunk - 30;

		if !self.HeadBobCosine then
			self.HeadBobCosine = 0;
		end
		if !self.HeadBobSine then
			self.HeadBobSine = 180;
		end
		if !self.HeadBobYawMul then
			self.HeadBobYawMul = math.Rand(-1, 1);
		end

		self.HeadBobCosine = self.HeadBobCosine + 120 * FrameTime();
		self.HeadBobSine = self.HeadBobSine + 120 * FrameTime();
		if self.HeadBobCosine > 360 then
			self.HeadBobCosine = self.HeadBobCosine - 360;
			self.ShiftedPitchYaw = false;
		end
		if self.HeadBobSine > 360 then
			self.HeadBobSine = self.HeadBobSine - 360;
		end
		if self.HeadBobCosine > 90 and !self.ShiftedPitchYaw then
			self.HeadBobYawMul = math.Rand(-1, 1);
			self.ShiftedPitchYaw = true;
			self.HeadBobCosine = 90;
		end

		local bobDist = math.cos(math.pi * (self.HeadBobCosine / 180));
		local bobDist2 = math.sin(math.pi * (self.HeadBobSine / 180));
		view.angles.pitch = view.angles.pitch + (bobDist * (8 * (drunk / 100) * self.HeadBobYawMul));
		view.angles.yaw = view.angles.yaw + (bobDist2 * (6 * (drunk / 100) * self.HeadBobYawMul));
	end

	return view;
end

function BASH:RenderScreenspaceEffects()
	if !CheckPly(LocalPlayer()) or !CheckChar(LocalPlayer()) or !LocalPlayer():Alive() then return view end;

	local drunk = LocalPlayer():GetEntry("DrunkMul");
	if drunk > 0 then
		DrawMotionBlur(0.05, 0.825, 0.05);
	end
end

function BASH:PlayerBindPress(ply, bind, pressed)
	if !pressed then return true end;
	if self:GUIOpen() then return true end;

	if bind == "+voicerecord" then
		return true;
	end

	if ply:Alive() and ply:GetEntry("CharLoaded") then
		local stamina = LocalPlayer():GetEntry("Stamina");
		local maxStamina = LocalPlayer():GetEntry("MaxStamina");
		if bind == "+jump" then
			if !LocalPlayer().NextJump then
				LocalPlayer().NextJump = 0;
			end
			if (stamina < 15 or LocalPlayer().NextJump > CurTime()) and !LocalPlayer():GetEntry("Observing") then
				return true;
			else
				LocalPlayer().JumpStamina = true;
				LocalPlayer().NextJump = CurTime() + 1.25;
			end
		end
		if bind == "+speed" then
			if stamina < 10 and !LocalPlayer():GetEntry("Observing") then
				return true;
			end
		end
		if bind == "invnext" then
			local wep = LocalPlayer():GetActiveWeapon();
			if wep and wep:IsValid() and wep:GetClass() == "weapon_physgun" and LocalPlayer():KeyDown(IN_ATTACK) then return true end;

			self:ReformatWeaponSelect();

			if self.WepSelect.MinorIndex + 1 > table.Count(self.WepSelect.Slots[self.WepSelect.MajorIndex]) then
				if self.WepSelect.MajorIndex + 1 > table.Count(self.WepSelect.Slots) then
					self.WepSelect.MajorIndex = 1;
				else
					self.WepSelect.MajorIndex = self.WepSelect.MajorIndex + 1;
				end

				//	No Weapons Equipped
				if !self.WepSelect.Slots[self.WepSelect.MajorIndex][1] then
					if self.WepSelect.MajorIndex - 1 <= 0 then
						self.WepSelect.MajorIndex = 1;
					else
						self.WepSelect.MajorIndex = self.WepSelect.MajorIndex + 1;
					end
				end

				self.WepSelect.MinorIndex = 1;
			else
				self.WepSelect.MinorIndex = self.WepSelect.MinorIndex + 1;
			end

			if self.WepSelect.Slots[self.WepSelect.MajorIndex] and !self.WepSelect.Slots[self.WepSelect.MajorIndex][1] then
				self.WepSelect.MajorIndex = self.WepSelect.MajorIndex + 1;
			end

			self.WepSelect.LastScroll = CurTime();
		end
		if bind == "invprev" then
			local wep = LocalPlayer():GetActiveWeapon();
			if wep and wep:IsValid() and wep:GetClass() == "weapon_physgun" and LocalPlayer():KeyDown(IN_ATTACK) then return true end;

			self:ReformatWeaponSelect();

			if self.WepSelect.MinorIndex - 1 <= 0 then
				if self.WepSelect.MajorIndex - 1 <= 0 then
					self.WepSelect.MajorIndex = table.Count(self.WepSelect.Slots);
				else
					self.WepSelect.MajorIndex = self.WepSelect.MajorIndex - 1;
				end

				//	No Weapons Equipped
				if !self.WepSelect.Slots[self.WepSelect.MajorIndex][1] then
					if self.WepSelect.MajorIndex - 1 <= 0 then
						self.WepSelect.MajorIndex = table.Count(self.WepSelect.Slots);
					else
						self.WepSelect.MajorIndex = self.WepSelect.MajorIndex - 1;
					end
				end

				self.WepSelect.MinorIndex = table.Count(self.WepSelect.Slots[self.WepSelect.MajorIndex]);
			else
				self.WepSelect.MinorIndex = self.WepSelect.MinorIndex - 1;
			end

			self.WepSelect.LastScroll = CurTime();
		end
		if bind == "+attack" then
			if self.ActionMenu.Open then return true end;

			if CurTime() - self.WepSelect.LastScroll < 3 then
				local wepString = self.WepSelect.Slots[self.WepSelect.MajorIndex][self.WepSelect.MinorIndex];
				netstream.Start("BASH_Select_Weapon", wepString);
				//LocalPlayer():ConCommand("use " .. wepString);
				self.WepSelect.LastScroll = 0;
				return true;
			end
		end

		if bind == "+speed" and ply:IsWearingExo() then return true end;

		if bind == "messagemode" or bind == "messagemode2" then
			if ply:GetEntry("CharLoaded") then
				self:OpenChat(self.Chat.CurrentTab or 1);
			end

			return true;
		end

		if bind == "gm_showhelp" then
			if self.HelpMenu.Open then
				self:CloseHelpMenu();
			else
				self:CreateHelpMenu();
			end

			return true;
		end

		if string.sub(bind, 1, 3) == "say" then
			surface.PlaySound("bash/gui/report.wav");
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_TOP_LEFT, 5);
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_TOP_CENT, 5);
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_TOP_RIGHT, 5);
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_BOT_LEFT, 5);
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_BOT_CENT, 5);
			self:CreateNotif("Binds are for casuals, friend. :^)", "BASHFontHeavy", NOTIF_BOT_RIGHT, 5);
			return true;
		end

		if bind == "gm_showteam" then
			self:ToggleInventory();
		end
	end
end

netstream.Hook("BASH_Send_Damage", function(data)
	if !data then return end;

	local takingDamage = data[1];
	local hitID = data[2];
	local ammo = data[3];
	local dist = data[4];
	local hitgroup = data[5];

	local hit = "";
	if hitgroup then
		if hitgroup == HITGROUP_HEAD then
			hit = "in the head ";
		elseif hitgroup == HITGROUP_CHEST then
			hit = "in the torso ";
		elseif hitgroup == HITGROUP_STOMACH then
			hit = "in the abdomen ";
		elseif hitgroup == HITGROUP_LEFTARM then
			hit = "in the left arm ";
		elseif hitgroup == HITGROUP_RIGHTARM then
			hit = "in the right arm ";
		elseif hitgroup == HITGROUP_LEFTLEG then
			hit = "in the left leg ";
		elseif hitgroup == HITGROUP_RIGHTLEG then
			hit = "in the right leg ";
		end
	end

	if takingDamage then
		MsgN("[" .. hitID .. "] You were hit by a(n) " .. ammo .. " round " .. hit .. "from ".. dist .. " meters away!");
	else
		MsgN("[" .. hitID .. "] You hit someone with a(n) " .. ammo .. " round from ".. dist .. " meters away!");
	end
end);
