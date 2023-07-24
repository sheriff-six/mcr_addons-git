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
	self.isCooking5 = false
	self.isCooking6 = false
	self.isCooking7 = false

    self.finishBakeTime = 0
	self:SetMaterial("models/debug/debugwhite")
	self:SetColor(Color(255,240,112))
end

function ENT:Use( activator )

end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_tomato" and self.isCooking == false then
        ent:Remove()
        self.isCooking = true
        self.finishBakeTime = CurTime() + 0
    end
	
    if ent:GetClass() == "cm_cheese" and self.isCooking2 == false then
        ent:Remove()
        self.isCooking2 = true
        self.finishBakeTime = CurTime() + 0
    end
    if ent:GetClass() == "cm_apple" and self.isCooking3 == false and self.isCooking == false and self.isCooking2 == false then
        ent:Remove()
        self.isCooking3 = true
        self.finishBakeTime = CurTime() + 0
    end
    if ent:GetClass() == "cm_milk" and self.isCooking5 == false and self.isCooking == false and self.isCooking2 == false then
        ent:Remove()
        self.isCooking5 = true
        self.finishBakeTime = CurTime() + 0
    end
    if ent:GetClass() == "cm_cookedmeat" and self.isCooking6 == false and self.isCooking3 == false and self.isCooking5 == false and self.isCooking2 == false then
        ent:Remove()
        self.isCooking6 = true
        self.finishBakeTime = CurTime() + 0
    end
    if ent:GetClass() == "cm_cabbage" and self.isCooking7 == false and self.isCooking3 == false and self.isCooking5 == false and self.isCooking2 == false then
        ent:Remove()
        self.isCooking7 = true
        self.finishBakeTime = CurTime() + 0
    end
end

function ENT:Think()

    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
			if self.isCooking2 == true then
				self.isCooking = false
				self:Remove()
				local bread = ents.Create("cm_coldpizza")
				bread:SetPos(self:GetPos() + Vector(0, 0, 0))
				bread:Spawn()
			end
        end
    end
	
    if self.isCooking3 == true then
        if self.finishBakeTime <= CurTime() then
			self.isCooking3 = false
			self:Remove()
			local bread = ents.Create("cm_dough1")
			bread:SetPos(self:GetPos() + Vector(0, 0, 0))
			bread:Spawn()
        end
    end
    if self.isCooking5 == true then
        if self.finishBakeTime <= CurTime() then
			self:Remove()
			local bread = ents.Create("cm_dough3")
			bread:SetPos(self:GetPos() + Vector(0, 0, 0))
			bread:Spawn()
			bread:SetColor(Color(255,191,0))
        end
    end
    if self.isCooking6 == true and self.isCooking == true and self.isCooking7 == true and self.isCooking5 == false and self.isCooking3 == false and self.isCooking2 == false then
        if self.finishBakeTime <= CurTime() then
			self:Remove()
			local bread = ents.Create("cm_tortilla")
			bread:SetPos(self:GetPos() + Vector(0, 0, 0))
			bread:Spawn()
        end
    end
end

