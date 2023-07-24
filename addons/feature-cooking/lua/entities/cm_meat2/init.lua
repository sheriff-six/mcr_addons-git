AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/meat7.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
    timer.Create("bad".. math.random(1,999999999999999999), 240, 1, function()
		self.bad = true
    end)
	self.bad = false
    self:SetModelScale(1.25)
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 10 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end

function ENT:Think()
	if self.bad == true then
		self:Remove()
	    local bread = ents.Create("cm_meatbad")
	    bread:SetPos(self:GetPos() + Vector(0, 0, 0))
	    bread:Spawn()
		bread:SetModel("models/foodnhouseholditems/meat7.mdl")
	end
end