include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal+Vector(90,0,20))
	ent:Spawn()
	ent:SetBodygroup(4,1)
	ent:SetBodygroup(5,1)
	ent:Activate()
	ent.Owner=ply
	return ent
end

function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
	if seat == 1 or seat == 2 then
		if name == "Flare" and value>0.5 then
			 self:FlareShootRight(value > 0.5, seat)
			 self:FlareShootLeft(value > 0.5, seat)
		 end
	 end
	if seat == 1 then
	    if name == "Cockpit" and value>0.5 then
           self.Cockpit1 = !self.Cockpit1
    	end
	end
	if seat == 2 then
	    if name == "Cockpit" and value>0.5 then
           self.Cockpit2 = !self.Cockpit2
    	end
	end
	if seat == 1 or seat == 2 then
		if name == "Door1" and value>0.5 then
			self.Door1 = !self.Door1
		end
		if name == "Door2" and value>0.5 then
			self.Door2 = !self.Door2
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
function ENT:SetNextFlare( delay )
	self.NextFlare = CurTime() + delay
end
function ENT:CanFlare()
	self.NextFlare = self.NextFlare or 0
	return self.NextFlare < CurTime()
end
function ENT:FlareShootLeft()	
	if not self:CanFlare() then return end
	self:SetNextFlare( 5 )	
	self:EmitSound( "wac/mi171/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-170,350,90))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight()	
	if not self:CanFlare() then return end
    self:EmitSound( "wac/mi171/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-170,-350,90))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	self:SetNWFloat("Cockpit1",self.Cockpit1Closed)
	self:SetNWFloat("Cockpit2",self.Cockpit2Closed)
	self:SetNWFloat("Door1",self.Door1Closed)
	self:SetNWFloat("Door2",self.Door2Closed)
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	if self.Cockpit1 and !self.Cockpit1Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Cockpit1Closed = true
		self:SetBodygroup(3,1)
	elseif !self.Cockpit1 and self.Cockpit1Closed then
		self:EmitSound("uh60/door.wav"	)
		self.Cockpit1Closed = false
		self:SetBodygroup(3,0)
	end
	if self.Cockpit2 and !self.Cockpit2Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Cockpit2Closed = true
		self:SetBodygroup(2,1)
	elseif !self.Cockpit2 and self.Cockpit2Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Cockpit2Closed = false
		self:SetBodygroup(2,0)
	end
	if self.Door1 and !self.Door1Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Door1Closed = true
		self:SetBodygroup(4,0)
	elseif !self.Door1 and self.Door1Closed then
		self:EmitSound("uh60/door.wav"	)
		self.Door1Closed = false
		self:SetBodygroup(4,1)
	end
	if self.Door2 and !self.Door2Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Door2Closed = true
		self:SetBodygroup(5,0)
	elseif !self.Door2 and self.Door2Closed then
		self:EmitSound( "uh60/door.wav"	)
		self.Door2Closed = false
		self:SetBodygroup(5,1)
	end
end

function ENT:KillTopRotor()
	if !self.TopRotor2 then return end
	local e = self:addEntity("prop_physics")
	e:SetPos(self.topRotor2:GetPos())
	e:SetAngles(self.topRotor2:GetAngles())
	e:SetModel(self.TopRotor2.model)
	e:SetSkin(self.topRotor.vis:GetSkin())
	e:Spawn()
	local ph = e:GetPhysicsObject()
	e.wac_ignore=true
	if ph:IsValid() then
		ph:SetMass(1000)
		ph:EnableDrag(false)
		ph:AddAngleVelocity(self.topRotor2.Phys:GetAngleVelocity())
		ph:SetVelocity(self.topRotor2.Phys:GetAngleVelocity():Length()*self.topRotor2:GetUp()*0.5 + self.topRotor2:GetVelocity())
	end
	self.topRotor2:Remove()
	self.topRotor2 = nil
	e:SetNotSolid(true)
	timer.Simple(15, function()
		if !e or !e:IsValid() then return end
		e:Remove()
	end)
	
	self:base("wac_hc_base").KillTopRotor(self)
end