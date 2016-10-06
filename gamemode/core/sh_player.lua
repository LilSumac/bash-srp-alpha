local BASH = BASH;
local Player = FindMetaTable("Player");

/*
**  Utility Functions
*/

/*
**  Player.CalculateQuirkEffects
**  Calculates a player's stats, taking into account any quirks
**	they may have.	Returns a table of modified default stats.
**	returns: table
*/
function Player:CalculateQuirkEffects()
	local tab = {};
	tab.MaxHealth = 100;
	tab.HealthRegen = 5;
	tab.MaxWeight = 50;
	tab.NormalMaxStamina = 100;
	tab.NormalStaminaRegen = 5;
	tab.HungryMaxStamina = 75;
	tab.ThirstyStaminaRegen = 3.33;
	tab.HungerLength = 2700;
	tab.ThirstLength = 2700;

	local quirks = util.JSONToTable(self:GetEntry("Quirks"));
	local quirkData;
	for index, quirk in pairs(quirks) do
		quirkData = BASH.Quirks[quirk];

		tab.MaxHealth = tab.MaxHealth + quirkData.MaxHealth;
		tab.HealthRegen = tab.HealthRegen + quirkData.HealthRegen;
		tab.MaxWeight = tab.MaxWeight + quirkData.MaxWeight;
		tab.NormalMaxStamina = tab.NormalMaxStamina + quirkData.NormalMaxStamina;
		tab.NormalStaminaRegen = tab.NormalStaminaRegen + quirkData.NormalStaminaRegen;
		tab.HungryMaxStamina = tab.HungryMaxStamina + quirkData.HungryMaxStamina;
		tab.ThirstyStaminaRegen = tab.ThirstyStaminaRegen + quirkData.ThirstyStaminaRegen;
		tab.HungerLength = tab.HungerLength + quirkData.HungerLength;
		tab.ThirstLength = tab.ThirstLength + quirkData.ThirstLength;
	end

	return tab;
end

/*
**  Player.HandleQuirks
**  A hook to handle a player's quirk effects.
*/
function Player:HandleQuirks()
	if !CheckPly(self) then return end;

	local predicted = self:CalculateQuirkEffects();
	local isHungry = self:GetEntry("IsHungry");
	local isThirsty = self:GetEntry("IsThirsty");
	local maxStamina = self:GetEntry("MaxStamina");
	local staminaRegen = self:GetEntry("StaminaRegen");
	local lastAte = self:GetEntry("LastAte");
	local lastDrank = self:GetEntry("LastDrank");

	//	Check hunger status.
	if isHungry == 0 and maxStamina != predicted.NormalMaxStamina then
		self:UpdateEntry("MaxStamina", predicted.NormalMaxStamina);
	elseif isHungry == 1 and maxStamina != predicted.HungryMaxStamina then
		self:UpdateEntry("MaxStamina", predicted.HungryMaxStamina);
	end
	if os.time() - lastAte > predicted.HungerLength and isHungry == 0 then
		self:UpdateEntry("IsHungry", 1);
		self:UpdateEntry("NextHungerNotif", os.time());
		self:UpdateEntry("MaxStamina", predicted.HungryMaxStamina);
	end
	if self.ResetInitialStamina then
		self:UpdateEntry("Stamina", self:GetEntry("MaxStamina"));
		self.ResetInitialStamina = false;
	end

	//	Check thirst status.
	if isThirsty == 0 and staminaRegen != predicted.NormalStaminaRegen then
		self:UpdateEntry("StaminaRegen", predicted.NormalStaminaRegen);
	elseif isThirsty == 1 and staminaRegen != predicted.ThirstyStaminaRegen then
		self:UpdateEntry("StaminaRegen", predicted.ThirstyStaminaRegen);
	end
	if os.time() - lastDrank > predicted.ThirstLength and isThirsty == 0 then
		self:UpdateEntry("IsThirsty", 1);
		self:UpdateEntry("NextThirstNotif", os.time());
		self:UpdateEntry("StaminaRegen", predicted.ThirstyStaminaRegen);
	end
end

/*
**  Player.HandleMonologue
**  CURRENTLY UNUSED.
**	A simple way of handling a player's monologue based on their
**	quirks/statuses.
*/
function Player:HandleMonologue()
	if !CheckPly(self) then return end;
	if self.OverflowPrevention then
		if CurTime() - self.OverflowPrevention < 5 then return end;
	end

	if os.time() >= self:GetEntry("NextHungerNotif") and os.time() - self:GetEntry("LastNotif") > 300 then
		self:PrintChat(table.Random(BASH.HungerMessages));
		self:UpdateEntry("LastNotif", os.time());
		self.OverflowPrevention = CurTime();
	end

	if os.time() >= self:GetEntry("NextThirstNotif") and os.time() - self:GetEntry("LastNotif") > 300 then
		self:PrintChat(table.Random(BASH.ThirstMessages));
		self:UpdateEntry("LastNotif", os.time());
		self.OverflowPrevention = CurTime();
	end
end

/*
**  Player.PrintChat
**  Prints a message to the player's chatbox.
*/
function Player:PrintChat(text)
	if CLIENT then
		netstream.Start("BASH_Send_Chat", {text, text, CHAT_TYPES.UTIL.ID});
	elseif SERVER then
		BASH:HandleChat(self, text, text, CHAT_TYPES.UTIL.ID);
	end
end

/*
**  Boolean Functions
*/

/*
**  Player.CanJoinFaction
**  Checks to see if a player can join the supplied faction.
**		faction: Faction data table.
**  returns: boolean
*/
function Player:CanJoinFaction(faction)
	if !CheckPly(self) then return end;
	if self:IsSumac() then return true end;
	local data = faction;

	if isstring(faction) then
		for _, factData in pairs(BASH.Factions) do
			if faction == factData.ID then
				data = factData;
			end
		end
	end

	//	YOU AIN'T ON THE LIST
	if self:HasWhitelist(data.ID) == 0 and !data.Default then return false end;

	local charCount = 0;
	for index, char in pairs(self.CharData) do
		if char.Faction == data.ID then
			charCount = charCount + 1;
		end
	end

	if charCount >= data.MaxCharacters then
		return false;
	else
		return true;
	end
end

/*
**  Player.HasFlag
**  Checks to see if a player has a certain flag.
**		flag: Flag to check.
**		flagType: Type of the supplied flag.
**  returns: boolean
*/
function Player:HasFlag(flag, flagType)
	if !CheckPly(self) or !self.PlyData then return end;

	local plyFlags = self:GetEntry("PlayerFlags");
	local charFlags = self:GetEntry("CharFlags");
	if flagType == FLAG_PLY then
		if string.find(plyFlags, flag) then
			return true;
		else
			return false;
		end
	elseif flagType == FLAG_CHAR then
		if string.find(charFlags, flag) then
			return true;
		else
			return false;
		end
	elseif !flagType then
		if string.find(plyFlags, flag) or string.find(charFlags, flag) then
			return true;
		else
			return false;
		end
	end
end

/*
**  Player.HasWhitelist
**  Checks to see if a player has a certain whitelist.
**		id: ID of the whitelist.
**  returns: boolean
*/
function Player:HasWhitelist(id)
	if !CheckPly(self) then return false end;

	local whitelists = self:GetEntry("Whitelists");
	whitelists = string.Explode(';', whitelists);
	for ind, wlist in pairs(whitelists) do
		if wlist == id then return true end;
	end
	return false;
end

/*
**  Player.HasQuirk
**  Checks to see if a player has a certain quirk.
**		id: ID of the quirk.
**  returns: boolean
*/
function Player:HasQuirk(id)
	if !CheckPly(self) or !CheckChar(self) then return end;

	local quirks = self:GetEntry("Quirks");
	quirks = util.JSONToTable(quirks);
	for index, quirk in pairs(quirks) do
		if quirk == id then
			return true;
		end
	end

	return false;
end

/*
**  Player.HasItem
**  Checks to see if a player has a certain item. If a second
**	argument is given, it will check if the player has enough
**	of the item. Returns whether or not they have the item,
**	the inventory in which they have it, the X and Y position
**	in the inventory, and the amount.
**		id: ID of the item.
**		findAmount: An amount to look for (minimum).
**  returns: boolean, string, number, number, number
*/
function Player:HasItem(id, findAmount)
	local curInv = self:GetEntry("InvMain");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;
	local itemFound = false;
	local total = 0;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID and curItem.ID == id then
				if findAmount then
					itemFound = true;
					total = total + curItem.Stacks;
				else
					return true, "InvMain", invX, invY, curItem.Stacks;
				end
			end
		end
	end

	curInv = self:GetEntry("InvSec");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID and curItem.ID == id then
				if findAmount then
					itemFound = true;
					total = total + curItem.Stacks;
				else
					return true, "InvSec", invX, invY, curItem.Stacks;
				end
			end
		end
	end

	curInv = self:GetEntry("InvAcc");
	curInv = util.JSONToTable(curInv);
	curInv = curInv.Content;

	for invX = 1, #curInv do
		for invY = 1, #curInv[1] do
			local curItem = curInv[invX][invY];
			if curItem.ID and curItem.ID == id then
				if findAmount then
					itemFound = true;
					total = total + curItem.Stacks;
				else
					return true, "InvAcc", invX, invY, curItem.Stacks;
				end
			end
		end
	end

	if itemFound then
		return true, total;
	else
		return false, total;
	end
end

/*
**  Player.HasClothing
**  Checks to see if a player is wearing something on a certain
**	body part.
**		id: ID of the body part.
**  returns: boolean
*/
function Player:HasClothing(bodyPart)
	local clothing = self:GetEntry("Clothing") or "[]";
	clothing = util.JSONToTable(clothing) or {};
	for part, article in pairs(clothing) do
		if bodyPart and bodyPart == part then
			if article and article != "" then
				return true;
			end
		else
			if article and article != "" then
				return true;
			end
		end
	end

	return false;
end

/*
**  Player.IsWearing
**  Checks to see if a player is wearing a certain article of
**	clothing.
**		id: ID of the clothing.
**  returns: boolean
*/
function Player:IsWearing(article)
	local clothing = util.JSONToTable(self:GetEntry("Clothing"));
	for part, curArticle in pairs(clothing) do
		if curArticle == article then return true end;
	end

	return false;
end

function Player:HasRespiration()
	if self:IsWearing("respirator") or self:IsWearing("gasmask") then return true end;

	local hasResp = false;
	local suit, _ = ParseDouble(self:GetEntry("Suit"));
	if suit != "" then
		local suitData = BASH.Items[suit];
		hasResp = suitData.Respiration;
	end

	local acc = self:GetEntry("Acc");
	if acc != "" and !hasResp then
		local accData = BASH.Items[acc];
		hasResp = accData.Respiration;
	end

	return hasResp;
end

function Player:IsSumac()
	return self:SteamID() == "STEAM_0:1:26293888";
end

function Player:IsHelper()
	return self:HasFlag("g") or self:IsStaff();
end

function Player:IsStaff()
	return self:HasFlag("q") or self:HasFlag("a") or self:HasFlag("d") or self:IsSumac();
end

function Player:IsWearingExo()
	return string.sub(self:GetEntry("Suit"), 1, 4) == "exo_";
end

/*
**  Inventory Functions
*/

function Player:RefreshWeight()
	local weight = 0;
	local suit, _ = ParseDouble(self:GetEntry("Suit"));
	if suit != "" then
		local suitData = BASH.Items[suit];
		weight = weight + suitData.Weight;
	end
	local acc = self:GetEntry("Acc");
	local accHasInv = true;
	if acc != "" then
		local accData = BASH.Items[acc];
		if accData.NoInventory then accHasInv = false end;
		weight = weight + accData.Weight;
	end
	local weps = self:GetEntry("Weapons");
	weps = util.JSONToTable(weps);
	for index, wep in pairs(weps) do
		if wep.ID then
			local wepData = BASH.Items[wep.ID];
			if wepData then
				weight = weight + wepData.Weight;
			end
			if wep.Attachments then
				for ind, att in pairs(wep.Attachments) do
					local attData;
					for id, item in pairs(BASH.Items) do
						if istable(att) then
							attData = BASH.Items[att.ent];
						else
							attData = BASH.Items[att];
						end
					end
				end
			end
		end
	end

	local invMain = util.JSONToTable(self:GetEntry("InvMain"));
	for invX = 1, #invMain.Content do
		for invY = 1, #invMain.Content[1] do
			local curItem = invMain.Content[invX][invY];
			local itemData = BASH.Items[curItem.ID];
			if itemData then
				local itemWeight = itemData.Weight * (curItem.Stacks or 1);
				local invWeight = 0;
				if curItem.Inventory and ((isstring(curItem.Inventory) and curItem.Inventory != "" and curItem.Inventory != "[]") or (istable(curItem.Inventory))) then
					local itemInvTab;
					if isstring(curItem.Inventory) then
						itemInvTab = util.JSONToTable(curItem.Inventory);
					elseif istable(curItem.Inventory) then
						itemInvTab = curItem.Inventory;
					end
					if itemInvTab.Content and itemInvTab.Content[1] then
						for invY = 1, #itemInvTab.Content[1] do
							for invX = 1, #itemInvTab.Content do
								invWeight = invWeight + BASH:GetMultiInvWeight(itemInvTab.Content[invX][invY]);
							end
						end
					end
				end

				weight = weight + itemWeight + invWeight;
			end
		end
	end
	local invSec = util.JSONToTable(self:GetEntry("InvSec"));
	for invX = 1, #invSec.Content do
		for invY = 1, #invSec.Content[1] do
			local curItem = invSec.Content[invX][invY];
			local itemData = BASH.Items[curItem.ID];
			if itemData then
				local itemWeight = itemData.Weight * (curItem.Stacks or 1);
				local invWeight = 0;
				if curItem.Inventory and ((isstring(curItem.Inventory) and curItem.Inventory != "" and curItem.Inventory != "[]") or (istable(curItem.Inventory))) then
					local itemInvTab;
					if isstring(curItem.Inventory) then
						itemInvTab = util.JSONToTable(curItem.Inventory);
					elseif istable(curItem.Inventory) then
						itemInvTab = curItem.Inventory;
					end
					if itemInvTab.Content and itemInvTab.Content[1] then
						for invY = 1, #itemInvTab.Content[1] do
							for invX = 1, #itemInvTab.Content do
								invWeight = invWeight + BASH:GetMultiInvWeight(itemInvTab.Content[invX][invY]);
							end
						end
					end
				end

				weight = weight + itemWeight + invWeight;
			end
		end
	end
	local invAcc = util.JSONToTable(self:GetEntry("InvAcc"));
	if accHasInv then
		for invX = 1, #invAcc.Content do
			for invY = 1, #invAcc.Content[1] do
				local curItem = invAcc.Content[invX][invY];
				local itemData = BASH.Items[curItem.ID];
				if itemData then
					local itemWeight = itemData.Weight * (curItem.Stacks or 1);
					local invWeight = 0;
					if curItem.Inventory and ((isstring(curItem.Inventory) and curItem.Inventory != "" and curItem.Inventory != "[]") or (istable(curItem.Inventory))) then
						local itemInvTab;
						if isstring(curItem.Inventory) then
							itemInvTab = util.JSONToTable(curItem.Inventory);
						elseif istable(curItem.Inventory) then
							itemInvTab = curItem.Inventory;
						end
						if itemInvTab.Content and itemInvTab.Content[1] then
							for invY = 1, #itemInvTab.Content[1] do
								for invX = 1, #itemInvTab.Content do
									invWeight = invWeight + BASH:GetMultiInvWeight(itemInvTab.Content[invX][invY]);
								end
							end
						end
					end

					weight = weight + itemWeight + invWeight;
				end
			end
		end
	end
	local clothing = util.JSONToTable(self:GetEntry("Clothing"));
	for index, bodyPart in pairs(BODY_PARTS) do
		local curItem = clothing[bodyPart];
		local itemData = BASH.Items[curItem];
		if itemData then
			local itemWeight = itemData.Weight;
			weight = weight + itemWeight;
		end
	end
	self:UpdateEntry("Weight", weight);
end

netstream.Hook("BASH_Remove_Nerd", function(ply, data)
	if !CheckPly(ply) then return end;

	Broadcast("The Server has banned " .. ply:Name() .. " permenantly. [GEAR1/GEAR2/AHack/Sasha/Other hacks detected. Farewell friend. :^)]");
	MsgCon(color_green, "The Server banned " .. ply:Name() .. " [" .. ply:SteamID() .. "] permenantly. [GEAR1/GEAR2/AHack/Sasha/Other hacks detected. Farewell friend. :^)]", true);
	BASH:BanPlayer("Server", ply, 0, "GEAR1/GEAR2/AHack/Sasha/Other hacks detected. Farewell friend. :^)");
end);
