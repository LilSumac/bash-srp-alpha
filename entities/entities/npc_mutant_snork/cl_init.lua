include('shared.lua')

language.Add("npc_mutant_snork", "Snork")

function ENT:Initialize()
end

function ENT:Draw()
	//self:SetModelScale( Vector(5,5,5) )
	self.Entity:DrawModel()
end
