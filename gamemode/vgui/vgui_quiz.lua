local BASH = BASH;
BASH.Quiz = {};
BASH.Quiz.Object = nil;
BASH.Quiz.Content = nil;
BASH.Quiz.InnerBox = nil;
BASH.Quiz.Open = false;
BASH.Quiz.Answers = {};

function BASH:CreateQuiz()
	gui.EnableScreenClicker(true);
	self.Quiz.Object = self:CreatePanel(CENTER_X - 250, SCRH + 1, 500, 350);
	self.Quiz.Content = vgui.Create("BASHScroll", self.Quiz.Object);
	self.Quiz.Content:SetSize(500, 320);
	self.Quiz.Content:SetPos(0, 0);
	self.Quiz.Object:MoveTo(CENTER_X - 250, CENTER_Y - 175, 1, 1, 1);
	self.Quiz.Open = true;
	
	self.Quiz.Content.Questions = {};
	local y = 5;
	for index, object in pairs(self.QuizQuestions) do
		self.Quiz.Content.Questions[index] = vgui.Create("DLabel", self.Quiz.Content);
		self.Quiz.Content.Questions[index]:SetPos(5, y);
		self.Quiz.Content.Questions[index]:SetFont("BASHFontLight");
		self.Quiz.Content.Questions[index]:SetText(FormatString(object.Text, "BASHFontLight", self.Quiz.Content:GetWide() - 30));
		self.Quiz.Content.Questions[index]:SizeToContents();
		y = y + self.Quiz.Content.Questions[index]:GetTall() + 4;
		self.Quiz.Content:AddItem(self.Quiz.Content.Questions[index]);
		
		self.Quiz.Content.Questions[index].Selection = vgui.Create("DComboBox", self.Quiz.Content);
		self.Quiz.Content.Questions[index].Selection:SetPos(5, y);
		self.Quiz.Content.Questions[index].Selection:SetSize(125, 20);
		for _, answer in pairs(object.Answers) do
			self.Quiz.Content.Questions[index].Selection:AddChoice(answer);
			self.Quiz.Content.Questions[index].Selection.OnSelect = function(self, answerIndex, value)
				BASH.Quiz.Answers[index] = answerIndex;
			end
		end
		y = y + 24;
		self.Quiz.Content:AddItem(self.Quiz.Content.Questions[index].Selection);
	end
	
	surface.SetFont("BASHFontHeavy");
	local submitX, textY = surface.GetTextSize("Submit");
	
	local disconnect = self:CreateTextButton("Disconnect", "BASHFontHeavy", 5, self.Quiz.Object:GetTall() - textY - 6 - 5, self.Quiz.Object);
	disconnect.Action = function()
		LocalPlayer():ConCommand("disconnect\n");
	end
	
	local submit = self:CreateTextButton("Submit", "BASHFontHeavy", self.Quiz.Object:GetWide() - submitX - 18 - 5, self.Quiz.Object:GetTall() - 24, self.Quiz.Object);
	submit.Disabled = true;
	submit.Think = function()
		if #self.Quiz.Answers == #self.QuizQuestions and !submit.ForceDisable then
			submit.Disabled = false;
		else
			submit.Disabled = true;
		end
	end
	submit.Action = function()
		submit.ForceDisable = true;
		local passedQuiz = true;
		
		for index, question in pairs(self.QuizQuestions) do
			if self.Quiz.Answers[index] != question.Answer then
				passedQuiz = false;
			end
		end
		
		self.Quiz.Object:MoveTo(CENTER_X - 250, -self.Quiz.Object:GetTall(), 1, 0, 1, function(data, panel)
			panel:Remove();
			self.Quiz.Open = false;
			
			netstream.Start("BASH_Post_Quiz", passedQuiz);
		end);
	end
end

netstream.Hook("BASH_Post_Quiz_Return", function(data)
	BASH.PostQuizStart = true;
end);