AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_junk/rock001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.isCooking = false
	self.isCooking2 = false
	self.isCooking3 = false
	self.isCooking4 = false
    self.finishBakeTime = 0
	self:SetMaterial("models/debug/debugwhite")
	self:SetColor(Color(255,240,112))
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_apple" and self.isCooking == false then
        ent:Remove()
        self.isCooking = true
        self.finishBakeTime = CurTime() + 0
    end
end

function ENT:Think()
    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
			self.isCooking = false
			self:Remove()
			local bread = ents.Create("cm_pie")
			bread:SetPos(self:GetPos() + Vector(0, 0, 0))
			bread:Spawn()
        end
    end
end

