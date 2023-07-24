AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_junk/garbage_bag001a.mdl" )
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
	self.isCooking5 = false
	self.isCooking4 = false
    self.finishBakeTime = 0
    self.egg = 0
end

function ENT:Use( activator )

end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_water" and self.isCooking == false and self.isCooking4 == false then
        ent:Remove()
        self.isCooking = true
        self.finishBakeTime = CurTime() + 0
    end
	
    if ent:GetClass() == "cm_foodegg2" and self.isCooking2 == false then
        ent:Remove()
        self.isCooking2 = true
        self.egg = CurTime() + 1
    end
    if ent:GetClass() == "cm_foodegg2" and self.isCooking2 == true and self.egg <= CurTime() and self.isCooking5 == false then
        ent:Remove()
        self.isCooking5 = true
    end
    if ent:GetClass() == "cm_milk" and self.isCooking3 == false then
        ent:Remove()
        self.isCooking3 = true
        self.finishBakeTime = CurTime() + 0
    end
    if ent:GetClass() == "cm_chocolate" and self.isCooking4 == false and self.isCooking == false then
        ent:Remove()
        self.isCooking4 = true
        self.finishBakeTime = CurTime() + 0
    end
end

function ENT:Think()
    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
			if self.isCooking2 == true and self.isCooking3 == false then
				if self.isCooking5 == true then
					self:Remove()
					local bread = ents.Create("cm_dough")
					bread:SetPos(self:GetPos() + Vector(0, 0, 0))
					bread:Spawn()
				end
			end
        end
    end
	
    if self.isCooking2 == true then
        if self.finishBakeTime <= CurTime() then
			if self.isCooking3 == true then
				if self.isCooking4 == true then
					if self.isCooking5 == true then
						self:Remove()
						local bread = ents.Create("cm_dough2")
						bread:SetPos(self:GetPos() + Vector(0, 0, 0))
						bread:Spawn()
					end
				end
			end
        end
    end
    if self.isCooking == true then
        if self.finishBakeTime <= CurTime() then
			if self.isCooking2 == true then
				if self.isCooking3 == true then
					if self.isCooking5 == true then
						self:Remove()
						local bread = ents.Create("cm_dough3")
						bread:SetPos(self:GetPos() + Vector(0, 0, 0))
						bread:Spawn()
					end
				end
			end
        end
    end
end

