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
	self:SetColor(Color(201,255,148))
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() - 10 ) )
	if( activator:Health() <= 0 ) then
		activator:Kill()
	end
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
	timer.Create("sound" .. activator:UserID(), 8, 1, function()
		activator:EmitSound("npc/zombie/zombie_pain1.wav")
    end)
end