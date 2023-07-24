AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/steak1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
    timer.Create("bad".. math.random(1,999999999999999999), 180, 1, function()
		self.bad = true
    end)
	self.bad = false
    self:SetModelScale(1.25)
end

function ENT:Use( activator )
	local health = activator:Health()
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 5 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end

function ENT:Think()
	if self.bad == true then
		self:Remove()
	    local bread = ents.Create("cm_meatbad")
	    bread:SetPos(self:GetPos() + Vector(0, 0, 0))
	    bread:Spawn()
	end
end