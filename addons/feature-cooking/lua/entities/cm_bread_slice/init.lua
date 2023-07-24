AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/bread_slice.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
    self:SetModelScale(1.25)
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 8 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end