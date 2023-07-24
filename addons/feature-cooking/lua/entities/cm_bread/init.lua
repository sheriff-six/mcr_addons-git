AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/bread-1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.isCooking = false
	self.isCooking2 = false
    self.finishBakeTime = 0
	self.meat  = true
	self.meat1 = false
	self.meat2 = false
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 5 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_cheese" and self.isCooking == false then
        ent:Remove()
        self.isCooking = true
        self.finishBakeTime = CurTime() + 0
    end
	
    if ent:GetClass() == "cm_cookedmeat" and self.isCooking2 == false then
        ent:Remove()
        self.isCooking2 = true
        self.finishBakeTime = CurTime() + 0
    end
end

function ENT:Think()
    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
			if self.isCooking2 == true then
				self.isCooking = false
				self:Remove()
				local bread = ents.Create("cm_foodburger")
				bread:SetPos(self:GetPos() + Vector(0, 0, 0))
				bread:Spawn()
			end
        end
    end
end