AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/drug_mod/the_bottle_of_water.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.poison = false
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 10 ) )
	self:EmitSound("eating_&_drinking/drinking.wav")
	self:Remove()
	if self.poison == true then
		self:EmitSound("eating_&_drinking/drinking.wav")
		self:Remove()
		timer.Create("sound" .. activator:UserID(), 20, 1, function()
		activator:EmitSound("npc/zombie/zombie_pain1.wav")
		end)
	
		timer.Create("poison" .. activator:UserID(), 30, 1, function()
		activator:EmitSound("vo/npc/Barney/ba_pain09.wav")
        activator:Kill()
		end)
	end
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_clorox" and self.poison == false then
        ent:Remove()
        self.poison = true
    end
end