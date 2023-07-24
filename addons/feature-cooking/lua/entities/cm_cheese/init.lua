AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/foodnhouseholditems/cheesewheel1c.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.isCooking2 = false
	self.isCooking3 = false
	self.isCooking4 = false
	self.isCooking5 = false
    self.finishBakeTime = 0
    self.sandwich = 0
end

function ENT:Use( activator )
	activator:SetHealth( math.min( activator:GetMaxHealth(), activator:Health() + 5 ) )
	self:EmitSound("eating_&_drinking/eating.wav")
	self:Remove()
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_cookedmeat" and self.isCooking2 == false then
        ent:Remove()
        self.isCooking2 = true
    end
    if ent:GetClass() == "cm_cabbage" and self.isCooking3 == false then
        ent:Remove()
        self.isCooking3 = true
    end
    if ent:GetClass() == "cm_bread_slice" and self.isCooking4 == false then
        ent:Remove()
        self.isCooking4 = true
        self.sandwich = CurTime() + 1
    end
    if ent:GetClass() == "cm_bread_slice" and self.isCooking5 == false and self.isCooking4 == true and self.sandwich <= CurTime() then
        ent:Remove()
        self.isCooking5 = true
    end
end

function ENT:Think()
	if self.isCooking2 == true and self.isCooking3 == true and self.isCooking4 == true and self.isCooking5 == true then
		self:Remove()
		local bread = ents.Create("cm_sandwich")
		bread:SetPos(self:GetPos() + Vector(0, 0, 0))
		bread:Spawn()
	end
end