AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/props_trainstation/trashcan_indoor001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self:SetPos(self:GetPos() + Vector(0,0,30))
end

function ENT:Use( activator )
end

function ENT:StartTouch(ent)
    if ent:GetClass() == "cm_apple" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_bread" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_bread_toast" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cabbage" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cake" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cheese" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_chocolate" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_clorox" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_coffee" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cola" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cookedmeat" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cookedmeat2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cup" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_cup2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_dough" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_dough1" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_dough2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_dough3" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_fish1" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_fish2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_fish3" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_fishcooked" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_flour" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodbacon1" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodbacon2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodburger" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodburger2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodegg1" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_foodegg2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_meat" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_meat2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_meatbad" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_milk" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_pan" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_pancake" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_pie" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_pizza" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_toast1" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_toast2" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_tomato" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_tortilla" then
	ent:Remove()
	end
    if ent:GetClass() == "cm_water" then
	ent:Remove()
	end

end