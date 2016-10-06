local BASH = BASH;
BASH.HelpMenu = {};
BASH.HelpMenu.Open = false;
BASH.HelpMenu.Object = nil;
BASH.HelpMenu.InnerBox = {};
BASH.HelpMenu.Tabs = {};
BASH.HelpMenu.CurrentTab = nil;

local function formatModules(index)
	local x, y = 5, 5;
	for _, mod in pairs(BASH.Modules) do
		local modHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		modHeader:SetPos(x, y);
		modHeader:SetFont("BASHFontHeavy");
		modHeader:SetText(FormatString(mod.Name .. " [" .. mod.Author .. "]", "BASHFontHeavy", 470));
		modHeader:SizeToContents();
		y = y + modHeader:GetTall();

		local modDesc = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		modDesc:SetPos(x, y);
		modDesc:SetFont("BASHFontLight");
		modDesc:SetText(FormatString(mod.Description, "BASHFontLight", 470));
		modDesc:SizeToContents();
		y = y + modDesc:GetTall();

		if mod.Dependencies then
			local deps = "";
			for index, dep in pairs(mod.Dependencies) do deps = deps .. dep .. ", " end;
			deps = string.sub(deps, 1, string.len(deps) - 2);
			local modDep = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
			modDep:SetPos(x, y);
			modDep:SetFont("BASHFontLight");
			modDep:SetText(FormatString("Dependencies: " .. deps, "BASHFontLight", 470));
			modDep:SizeToContents();
			y = y + 5 + modDep:GetTall();
		else
			y = y + 5;
		end
	end

	BASH.HelpMenu.InnerBox[index].Content:SetTall(y);
end

local function formatCommands(index)
	local x, y = 5, 5;
	local introHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
	introHeader:SetPos(x, y);
	introHeader:SetFont("BASHFontHeavy");
	introHeader:SetText(FormatString("Command Keyword(s)", "BASHFontHeavy", 470));
	introHeader:SetTextColor(color_white);
	introHeader:SizeToContents();
	y = y + introHeader:GetTall();

	local introDesc = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
	introDesc:SetPos(x, y);
	introDesc:SetFont("BASHFontLight");
	introDesc:SetText(FormatString("<Arguments> - Description", "BASHFontLight", 470));
	introDesc:SetTextColor(Color(200, 200, 200));
	introDesc:SizeToContents();
	y = y + introDesc:GetTall() + 10;

	local chatHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
	chatHeader:SetPos(x, y);
	chatHeader:SetFont("BASHFontLarge");
	chatHeader:SetText("Basic Commands");
	chatHeader:SetTextColor(Color(100, 100, 200));
	chatHeader:SizeToContents();
	y = y + chatHeader:GetTall() + 10;

	local heads = {};
	local descs = {};
	local index2 = 1;
	while index2 <= table.Count(CHAT_TYPES) - 4 do
		for _, cmd in pairs(CHAT_TYPES) do
			if index2 == cmd.ID then
				if !cmd.Command then index2 = index2 + 1 continue end;

				heads[index2] = "";
				for _, keyword in pairs(cmd.Command) do
					if heads[index2] != "" then
						heads[index2] = heads[index2] .. " ";
					end
					heads[index2] = heads[index2] .. keyword .. ", ";
				end
				heads[index2] = string.sub(heads[index2], 1, string.len(heads[index2]) - 2);
				descs[index2] = cmd.Desc or "";
				index2 = index2 + 1;
			end
		end
	end

	for ind, head in pairs(heads) do
		local chatHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		chatHeader:SetPos(x, y);
		chatHeader:SetFont("BASHFontHeavy");
		chatHeader:SetText(FormatString(head, "BASHFontHeavy", 470));
		chatHeader:SetTextColor(color_white);
		chatHeader:SizeToContents();
		y = y + chatHeader:GetTall();

		local chatDesc = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		chatDesc:SetPos(x, y);
		chatDesc:SetFont("BASHFontLight");
		chatDesc:SetText(FormatString(descs[ind], "BASHFontLight", 470));
		chatDesc:SetTextColor(Color(200, 200, 200));
		chatDesc:SizeToContents();
		y = y + chatDesc:GetTall() + 5;
	end

	y = y + 5;
	local playerHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
	playerHeader:SetPos(x, y);
	playerHeader:SetFont("BASHFontLarge");
	playerHeader:SetText("Player Commands");
	playerHeader:SetTextColor(Color(0, 200, 0));
	playerHeader:SizeToContents();
	y = y + playerHeader:GetTall() + 10;

	for ind, cmd in pairs(BASH.ChatCMDFormatted) do
		if ind <= 6 then continue end;	// Fuck languages.
		if cmd.AdminOnly then continue end;

		local header = "";
		for _, keyword in pairs(cmd.Keywords) do
			if header != "" then
				header = header .. " ";
			end
			header = header .. keyword .. ",";
		end
		header = string.sub(header, 1, string.len(header) - 1);
		local cmdHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		cmdHeader:SetPos(x, y);
		cmdHeader:SetFont("BASHFontHeavy");
		cmdHeader:SetText(FormatString(header, "BASHFontHeavy", 470));
		cmdHeader:SetTextColor(color_white);
		cmdHeader:SizeToContents();
		y = y + cmdHeader:GetTall();

		local cmdDesc = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		cmdDesc:SetPos(x, y);
		cmdDesc:SetFont("BASHFontLight");
		cmdDesc:SetText(FormatString(cmd.Desc, "BASHFontLight", 470));
		cmdDesc:SetTextColor(Color(200, 200, 200));
		cmdDesc:SizeToContents();
		y = y + cmdDesc:GetTall() + 5;
	end

	y = y + 5;
	local adminHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
	adminHeader:SetPos(x, y);
	adminHeader:SetFont("BASHFontLarge");
	adminHeader:SetText("Admin Commands");
	adminHeader:SetTextColor(Color(200, 0, 0));
	adminHeader:SizeToContents();
	y = y + adminHeader:GetTall() + 10;
	hitAdminCommand = true;
	for ind, cmd in pairs(BASH.ChatCMDFormatted) do
		if ind <= 6 then continue end;	// Fuck languages.
		if !cmd.AdminOnly then continue end;


		local header = "";
		for _, keyword in pairs(cmd.Keywords) do
			if header != "" then
				header = header .. " ";
			end
			header = header .. keyword .. ",";
		end
		header = string.sub(header, 1, string.len(header) - 1);
		local cmdHeader = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		cmdHeader:SetPos(x, y);
		cmdHeader:SetFont("BASHFontHeavy");
		cmdHeader:SetText(FormatString(header, "BASHFontHeavy", 470));
		cmdHeader:SetTextColor(color_white);
		cmdHeader:SizeToContents();
		y = y + cmdHeader:GetTall();

		local cmdDesc = vgui.Create("DLabel", BASH.HelpMenu.InnerBox[index].Content);
		cmdDesc:SetPos(x, y);
		cmdDesc:SetFont("BASHFontLight");
		cmdDesc:SetText(FormatString(cmd.Desc, "BASHFontLight", 470));
		cmdDesc:SetTextColor(Color(200, 200, 200));
		cmdDesc:SizeToContents();
		y = y + cmdDesc:GetTall() + 5;
	end

	BASH.HelpMenu.InnerBox[index].Content:SetTall(y);
end

BASH.HelpMenu.Windows = {
	{"Welcome", [[Hello there! First off, welcome to The Wizard Tree! We're happy to have you and hope you enjoy yourself on our server to the fullest extent.

If you're completely new to this type of server or the gamemode, it's recommended that you check out the 'Help' and 'FAQ' tabs on this menu. It isn't difficult to get aquainted with this gamemode, but there are some features you may miss or be confused with! These tabs will help you become comfortable in no time.

Do not hesitate to ask for assistance at any point, whether it be from a player or staff. Everyone is given the opporitunity to participate, as long as they show initiative!

-LilSumac]]},
	{"Features", [[* A modular framework that allows new features and content to be added seamlessly and painlessly.
* A simplistic interface that's easy on the eyes, and older computers.
* An alert system that lets staff and volunteers know when and where you need help or see a problem.
* Each and every type of chat command that a roleplay server needs.
* Virtual economy leashes such as gold sinks and other repressors that fight out-of-control inflation and other server-killing menaces.
* A custom weapon base with roleplay-specific features, such as Shoot-to-Roleplay/Shoot-to-Kill modes, firemodes, and variable weapon slotting.]]},
	{"Help", [[Here are some common/useful features that you may miss!

* There should be some simple HUD elements already on your screen.
** Bottom-Left: This is your movement status element. It shows your current position (running, standing, crouching) as well as your stamina.
*** Your stamina and the rate at which it regenerates is affected by several factors, such as your hunger, thirst, quirks, etc.
** Bottom-Right: This is your character status element. The bars show some of your character's current statuses.
*** + : Your character's current health.
*** * : Your character's current suit condition (if wearing a suit).
*** R : Your character's current radiation levels.
*** ? : Your character's curreoag -- 495P 8tcNr6Xp EHyw msMW -- ___ _____ ____ ____ __ __ ... NO PROBLEM CAN BE SOLVED FROM THE SAME LEVEL OF CONSCIOUSNESS THAT CREATED IT.

* Hold down your Context Menu key (Default: C) to open up your context menu. You should see some GUI features slide into place on your screen.
** Top-Left: Change your name, description, and open your character menu.
** Top-Right: Statuses of any alerts you currently have.
** Left-Click: Left-clicking an alert will bring up a menu to view its information, hide it, etc.
** Right-Click: Submit a request or report and manage your reports en masse.

* Hit your F2 key to toggle your inventory.
** Your inventory works on a seperated, expandable grid-system, similar to that found in most MMO games. One item takes up one square, unless stackable.
** You will always have a 4x2 inventory grid by default. In order to get more inventories, you must wear either a suit or accessory or both. Some suits/accessories have no inventory, but instead serve a different purpose. For example, a three-point sling accessory offers no inventory space, but allows your a second active slot for a primary weapon.
** Inventories are space-restricted. Most are dictated by common sense. For example, you cannot put a suit into a pouch. This prevents a simple infinitely-collapsed inventory exploit.
** When removing a suit/accessory, the corresponding inventory is collapsed into that item. The items are preserved and accessable once the suit/accessory is worn once more. Collapsed items' weights are still accounted for in your inventory, no matter how many dimensions an inventory goes down (item inside of an item inside of an item...).
** The 'Clothing' section is for items which are not suits/accessories and do not offer protective properties, but are instead simply for aestetics. Your worn clothing shows up automatically above your description when a player looks at your playermodel. Some suits/accessories block the use of clothing when in use.

* Hit your Chat key (Default: Y) to open up your chat. This is your main method of communication with the players around you.
** Along the top of the chat box are several tabs used for filtering messages.
** Chat commands can be found on the 'Commands' tab of this menu.]]},
	{"FAQs", [[* What is #!/BASH?
- BASH is a gamemode created from scratch specifically for the purpose of serious roleplay in Garry's Mod. It aims to serve the best features possible with few/no gimmicks for its users. Inspiration for this gamemode came from scripts like TacoScript, NutScript, etc. The gamemode features quite a few custom modules made for the specific setting in which the server takes place. The current modules in use can be found on the 'Modules' tab.

* Who made BASH?
- BASH was developed primarily by LilSumac. However, ideas for specific features and servers came from a wide audience of close friends and staff. Contributors can be found on the 'Credits' tab.

* Can I have BASH?
- In short, no. I've yet to make the gamemode's code as readable and modular as I'd like it to be. In addition, I made the gamemode in order to make a very unique and engaging server that no one had ever experienced anything like. I may release the source code in the future, but I've yet to come to that bridge, let alone cross it.

* Are there rules here?
- Of course. Unfortunately, there are too many to be listed on a simple help menu GUI. The full breadth of this server's rules can be found on our forums.

* How do I change my name/description, open the character menu, or request help?
- Hold down your Context Menu key (Default: C). Right-click to get additional options.

* You haven't answered all of my questions!
- Sorry! Your best bet is to refer to the 'Help' tab or request assistance from a staff member in game using your Context Menu or OOC chat. Good luck!]]},
	{"Commands", formatCommands},
	{"Modules", formatModules},
	{"Credits", [[* DEVELOPMENT
Lead Development: LilSumac
Plot & Story: Staff
Testers:
-AotsFTW
-Cocothegogo
-Cradboard
-Drfreecan
-Joseph
-Max Payne
-Plexi
-Vegas

* STAFF
Director: LilSumac
Administrators:
-Tom
-Max Payne
-Vegas
-Aots
-Comebackid
-Flower
-Muffin
-Dirty

* CONTENT
STALKER Playermodels: Dave Brown, STALKER MISERY Mod
Backpack, Satchel, and Pouch Models: Jason278
STALKER Anomaly Entities: Darsenvall
STALKER NPC Entities: Darsenvall]]}
};

function BASH:CreateHelpMenu()
	if self:GUIOpen() then return end;
	if self:GUIOccupied() then return end;

	local width = 5;
	local textX, _;
	surface.SetFont("BASHFontHeavy");
	for index, window in pairs(self.HelpMenu.Windows) do
		textX, _ = surface.GetTextSize(window[1]);
		width = width + textX + 23;
	end

	gui.EnableScreenClicker(true);
	self.HelpMenu.Open = true;
	self.HelpMenu.Object = self:CreatePanel(0, 0, width, 300);
	self.HelpMenu.Object:Center();
	self.HelpMenu.Object.PaintOver = function(self)
		draw.SimpleText("#!/BASH/SRP/Alpha", "BASHFontHeavy", self:GetWide() / 2, 10, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end

	local function SetActiveBox(index)
		if self.HelpMenu.CurrentTab == index then return end;

		if !self.HelpMenu.CurrentTab then
			self.HelpMenu.Tabs[index].AlwaysHighlight = true;
			self.HelpMenu.InnerBox[index]:SetVisible(true);
			self.HelpMenu.InnerBox[index].Content:SetVisible(true);
		else
			self.HelpMenu.Tabs[self.HelpMenu.CurrentTab].AlwaysHighlight = false;
			self.HelpMenu.Tabs[index].AlwaysHighlight = true;
			self.HelpMenu.InnerBox[self.HelpMenu.CurrentTab]:SetVisible(false);
			self.HelpMenu.InnerBox[self.HelpMenu.CurrentTab].Content:SetVisible(false);
			self.HelpMenu.InnerBox[index]:SetVisible(true);
			self.HelpMenu.InnerBox[index].Content:SetVisible(true);
		end

		self.HelpMenu.CurrentTab = index;
	end

	local close = vgui.Create("DButton", self.HelpMenu.Object);
	close:SetPos(self.HelpMenu.Object:GetWide() - 22, 2);
	close:SetSize(20, 20);
	close:SetFont("marlett");
	close:SetText("r");
	close.Paint = function() end;
	close.DoClick = function()
		self:CloseHelpMenu();
	end

	local buttonOffset = 5;
	for index, window in pairs(self.HelpMenu.Windows) do
		self.HelpMenu.InnerBox[index] = vgui.Create("BASHScroll", self.HelpMenu.Object);
		self.HelpMenu.InnerBox[index]:SetSize(width - 10, 245);
		self.HelpMenu.InnerBox[index]:SetPos(5, 50);
		self.HelpMenu.InnerBox[index]:SetVisible(false);

		self.HelpMenu.Tabs[index] = self:CreateTextButton(window[1], "BASHFontHeavy", buttonOffset, 24, self.HelpMenu.Object);
		self.HelpMenu.Tabs[index].Action = function()
			SetActiveBox(index);
		end
		buttonOffset = buttonOffset + self.HelpMenu.Tabs[index]:GetWide() + 5;

		self.HelpMenu.InnerBox[index].Content = self:CreatePanel(0, 0, width - 25, 0, self.HelpMenu.InnerBox[index]);
		self.HelpMenu.InnerBox[index].Content:SetVisible(false);
		self.HelpMenu.InnerBox[index].Content.Paint = function() end;

		self.HelpMenu.InnerBox[index]:AddItem(self.HelpMenu.InnerBox[index].Content);

		if isfunction(window[2]) then
			window[2](index);
		else
			local formattedContent = FormatString(window[2], "BASHFontLight", self.HelpMenu.InnerBox[index].Content:GetWide() - 5);
			formattedContent = string.Explode('\n', formattedContent);
			surface.SetFont("BASHFontLight");
			local _, textY = surface.GetTextSize(formattedContent[1]);
			textY = (textY * (#formattedContent + 1)) + (2 * #formattedContent);

			self.HelpMenu.InnerBox[index].Content:SetTall(textY);
			self.HelpMenu.InnerBox[index].Content.Paint = function()
				local yOffset = 5;
				for index, line in pairs(formattedContent) do
					draw.SimpleText(line, "BASHFontLight", 5, yOffset, COLOR_WHITE, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);
					yOffset = yOffset + 16;
				end
			end
		end
	end

	SetActiveBox(1);
end

function BASH:CloseHelpMenu()
	if !self.HelpMenu.Open or !self.HelpMenu.Object then return end;

	gui.EnableScreenClicker(false);
	self.HelpMenu.Object:Remove();
	self.HelpMenu.Object = nil;
	self.HelpMenu.InnerBox = {};
	self.HelpMenu.Open = false;
	self.HelpMenu.CurrentTab = nil;
end
