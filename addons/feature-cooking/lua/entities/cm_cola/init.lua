AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/colabig.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
    self.esegg = false
end

function ENT:Use( activator )
	if self.esegg == false then
		activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 15 ) )
		self:EmitSound("eating_&_drinking/soda.wav")
		self:Remove()
	end
	if self.esegg == true then
		activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 15 ) )
		activator:SetArmor( math.min( activator:Armor() + 15 ) )
		self:EmitSound("eating_&_drinking/soda.wav")
		self:Remove()
	end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_milk" and self.esegg == false then
        ent:Remove()
        self.esegg = true
    end
end