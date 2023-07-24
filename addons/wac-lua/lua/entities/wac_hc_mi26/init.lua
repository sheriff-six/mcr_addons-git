include("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal+Vector(0,0,5))
	ent:Spawn()
	ent:Activate()
	ent.Owner=ply
	return ent
end


function ENT:Initialize()
    self:base("wac_hc_base").Initialize(self)
	self.Ramp = 0
	self.door1 = 0
	if !self.rampSpawned then
		self.rampOpenCollider = ents.Create("prop_physics")
		self.rampOpenCollider:SetModel("models/mi26/mi26_new_ramp_open.mdl")
		self.rampOpenCollider:SetPos(self:GetPos())
		self.rampOpenCollider:SetAngles(self:GetAngles())
		self.rampOpenCollider:Spawn()
		--self.rampOpenCollider:GetPhysicsObject():EnableGravity(false)
		self.rampOpenCollider:GetPhysicsObject():EnableDrag(false)
		--self.rampOpenCollider:GetPhysicsObject():SetMass(50)
		self.rampOpenCollider:SetOwner(self:GetOwner())
		local rampOpenColliderNocollide = constraint.NoCollide(self.rampOpenCollider, self, 0, 0)		
		self:DeleteOnRemove(self.rampOpenCollider)
		self.rampClosedCollider = ents.Create("prop_physics")
		self.rampClosedCollider:SetModel("models/mi26/mi26_new_ramp_closed.mdl")
		self.rampClosedCollider:SetPos(self:GetPos())
		self.rampClosedCollider:SetAngles(self:GetAngles())
		self.rampClosedCollider:Spawn()
		--self.rampClosedCollider:GetPhysicsObject():EnableGravity(false)
		self.rampClosedCollider:GetPhysicsObject():EnableDrag(false)
		--self.rampClosedCollider:GetPhysicsObject():SetMass(50)
		self.rampClosedCollider:SetOwner(self:GetOwner())
		local rampClosedColliderNocollide = constraint.NoCollide(self.rampClosedCollider, self, 0, 0)		
		self:DeleteOnRemove(self.rampClosedCollider)
		
		self.rampSpawned = true
	end
	if !self.door1Spawned then
		self.door1OpenCollider = ents.Create("prop_physics")
		self.door1OpenCollider:SetModel("models/mi26/mi26_new_door1_open.mdl")
		self.door1OpenCollider:SetPos(self:GetPos())
		self.door1OpenCollider:SetAngles(self:GetAngles())
		self.door1OpenCollider:Spawn()
		--self.door1OpenCollider:GetPhysicsObject():EnableGravity(false)
		self.door1OpenCollider:GetPhysicsObject():EnableDrag(false)
		--self.door1OpenCollider:GetPhysicsObject():SetMass(50)
		self.door1OpenCollider:SetOwner(self:GetOwner())
		local door1OpenColliderNocollide = constraint.NoCollide(self.door1OpenCollider, self, 0, 0)		
		self:DeleteOnRemove(self.door1OpenCollider)
		self.door1ClosedCollider = ents.Create("prop_physics")
		self.door1ClosedCollider:SetModel("models/mi26/mi26_new_door1_closed.mdl")
		self.door1ClosedCollider:SetPos(self:GetPos())
		self.door1ClosedCollider:SetAngles(self:GetAngles())
		self.door1ClosedCollider:Spawn()
		--self.door1ClosedCollider:GetPhysicsObject():EnableGravity(false)
		self.door1ClosedCollider:GetPhysicsObject():EnableDrag(false)
		--self.doorClosedCollider:GetPhysicsObject():SetMass(50)
		self.door1ClosedCollider:SetOwner(self:GetOwner())
		local door1ClosedColliderNocollide = constraint.NoCollide(self.door1ClosedCollider, self, 0, 0)		
		self:DeleteOnRemove(self.door1ClosedCollider)
		
		self.door1Spawned = true
	end
end

function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
	if seat == 2 or seat == 3 or seat == 4 then
		if name == "Cargo_ramp" then
		
		if value > 0.5 then 
			self.Ramp = !self.Ramp
			
			--print(self.Gear)
		end
			
		end
		if seat == 2 or seat == 3 or seat == 4 then
			if name == "Door1" and value>0.5 then
				self.door1 = !self.door1
			end
		end
	end
end
function ENT:RocketAlert()
	local b=false
	if self.rotorRpm > 0.1 then
		local rockets = ents.FindByClass("rpg_missile")
		local grockets = ents.FindByClass("wac_base_grocket")
		table.Merge(rockets,grockets, ents.FindByClass("wac_w_rocket"))
		for _, e in pairs(rockets) do
			if e:GetPos():Distance(self:GetPos()) < 2000 then b = true break end
		end
		if self.sounds.MissileAlert:IsPlaying() then
			if !b then
				self.sounds.MissileAlert:Stop()
			end
		elseif b then
			self.sounds.MissileAlert:Play()
		end
	end
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	self:SetNWFloat("Ramp",self.RampClosed)
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	if self.door1 then
		self:SetNWFloat("Door1",0)
		self.door1ClosedCollider:SetNotSolid(true)
		self.door1OpenCollider:SetNotSolid(false)
		self:SetBodygroup(2,1)
	elseif !self.door1 then
		self:SetNWFloat("Door1",1)
		self.door1ClosedCollider:SetNotSolid(false)
		self.door1OpenCollider:SetNotSolid(true)
		self:SetBodygroup(2,0)
	end
	if self.Ramp then
		self:SetNWFloat("Cargo_ramp",0)
		self.rampClosedCollider:SetNotSolid(false)
		self.rampOpenCollider:SetNotSolid(true)
		self:SetBodygroup(6,1)
	elseif !self.Ramp then
		self:SetNWFloat("Cargo_ramp",1)
		self.rampClosedCollider:SetNotSolid(true)
		self.rampOpenCollider:SetNotSolid(false)
		self:SetBodygroup(6,0)
	end
	if IsValid(phys) then
		if self.rampClosedCollider:GetPhysicsObject():IsMotionEnabled() then
			self.rampClosedCollider:GetPhysicsObject():EnableMotion(false)
		end
		if self.rampOpenCollider:GetPhysicsObject():IsMotionEnabled() then
			self.rampOpenCollider:GetPhysicsObject():EnableMotion(false)
		end
		self.rampClosedCollider:SetPos(self:GetPos())
		self.rampOpenCollider:SetPos(self:GetPos())
		self.rampClosedCollider:SetAngles(self:GetAngles())
		self.rampOpenCollider:SetAngles(self:GetAngles())
	end
	if IsValid(phys) then
		if self.door1ClosedCollider:GetPhysicsObject():IsMotionEnabled() then
			self.door1ClosedCollider:GetPhysicsObject():EnableMotion(false)
		end
		if self.door1OpenCollider:GetPhysicsObject():IsMotionEnabled() then
			self.door1OpenCollider:GetPhysicsObject():EnableMotion(false)
		end
		self.door1ClosedCollider:SetPos(self:GetPos())
		self.door1OpenCollider:SetPos(self:GetPos())
		self.door1ClosedCollider:SetAngles(self:GetAngles())
		self.door1OpenCollider:SetAngles(self:GetAngles())
	end
end