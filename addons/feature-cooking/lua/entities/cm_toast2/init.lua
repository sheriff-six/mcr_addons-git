AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/toast.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetColor( Color( 255, 244, 154, 255 ) )
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 20 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end