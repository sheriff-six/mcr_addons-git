AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self:SetModel( "models/house furniture/coffemachine.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
    self.coffee = false
    self.finishBakeTime = 0
	self.cup = false
end

function ENT:Use( activator )
end

function ENT:StartTouch(ent)
	if ent:GetClass() == "cm_cup" and self.cup == false and self.coffee == true then
		self.cup = true
		ent:Remove()
        self.finishBakeTime = CurTime() + 30
		local prop1 = ents.Create("cm_cup1")
		prop1:SetPos(self:GetPos() + self:GetAngles():Up()*-2.3 + self:GetAngles():Right()*-0.5 + self:GetAngles():Forward()*4.2)
		prop1:SetAngles(self:GetAngles())
		prop1:Spawn()
		prop1:SetModel("models/props_junk/garbage_coffeemug001a.mdl")
		prop1:Activate()
		prop1:SetParent(self)
		prop1:SetSolid(SOLID_VPHYSICS)
		self:EmitSound("buttons/button1.wav")
		timer.Create("remove", 30, 1, function()
			prop1:Remove()
		end)
	end
	if ent:GetClass() == "cm_coffee" and self.coffee == false and self.cup == false then
	ent:Remove()
	self.coffee = true
	end
end

function ENT:Think()
    if self.cup == true and self.coffee == true then
        if self.finishBakeTime <= CurTime() then
			self.cup = false
			self.coffee = false
			self:EmitSound("buttons/lightswitch2.wav")
            local bread = ents.Create("cm_cup2")
            bread:SetPos(self:GetPos() + Vector(20, 0, 0))
            bread:Spawn()
        end
    end
end

function ENT:OnRemove()
	timer.Remove("remove")
end

