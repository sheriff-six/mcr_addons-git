include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal+Vector(0,0,140))
	ent:Spawn()
	ent:SetBodygroup(2,0)
	ent:Activate()
	ent.Owner=ply
	return ent
end

function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
	if seat == 1 or seat == 2 then
	    if name == "Landing_Gear" and value>0.5 then
            self.Gear = !self.Gear
		end
	end
	if seat == 1 or seat == 2 then
		if name == "Flare" and value>0.5 then
			self:FlareShootRight(value > 0.5, seat)
			self:FlareShootRight2(value > 0.5, seat)
			self:FlareShootRight3(value > 0.5, seat)
			self:FlareShootRight4(value > 0.5, seat)
			self:FlareShootRight5(value > 0.5, seat)
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
	if seat == 1 or seat == 3 or seat == 4 or seat == 5 or seat == 6 then
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
		local grockets = ents.FindByClass("ent_stingermissile")
		local grockets = ents.FindByClass("ent_kub_sam")
		local grockets = ents.FindByClass("wac_hc_rocket")
		local grockets = ents.FindByClass("ent_cod4rm_stingermissile")
		local grockets = ents.FindByClass("ent_igla_radar_passive")
		local grockets = ents.FindByClass("ent_igla_radar_active")
		local grockets = ents.FindByClass("ent_cod4rm_javelinmissile_dir")
		local grockets = ents.FindByClass("ent_cod4rm_javelinmissile")
		local grockets = ents.FindByClass("sw_pod_vyihr_wac")
		local grockets = ents.FindByClass("wac_pod_vrocket_9m39")
		local grockets = ents.FindByClass("sw_pod_agm114_wac")
		local grockets = ents.FindByClass("sw_pod_aim92_wac")
		local grockets = ents.FindByClass("sw_pod_aim9_wac")
		table.Merge(rockets,grockets, ents.FindByClass("wac_w_rocket"))
		for _, e in pairs(rockets) do
			if e:GetPos():Distance(self:GetPos()) < 50000 then b = true break end
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
	self:SetNextFlare( 2.5 )	
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-10,250,-30))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-10,-250,-30)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight2()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,-250,-30)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight3()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,-60,-30)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 90 )
end
function ENT:FlareShootRight4()	
	if not self:CanFlare() then return end	
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,250,-30))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight5()	
	if not self:CanFlare() then return end
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,60,-30))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -90 )
end

function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	self:SetNWFloat("Cockpit1",self.Cockpit1Closed)
	self:SetNWFloat("Cockpit2",self.Cockpit2Closed)
	self:SetNWFloat("Door1",self.Door1Closed)
	self:SetNWFloat("Door2",self.Door2Closed)
	self:SetNWFloat("Gear",self.GearUp)
	local vel = ph:GetVelocity()	
	local pos = self:GetPos()
	local ri = self:GetRight()
	local up = self:GetUp()
	local fwd = self:GetForward()
	local ang = self:GetAngles()
	local dvel = vel:Length()
	local lvel = self:WorldToLocal(pos+vel)
	local pilot = self.passengers[1]
	local hover = self:calcHover(ph,pos,vel,ang)
	local rotateX = (self.controls.roll*1.5+hover.r)*self.rotorRpm
	local rotateY = (self.controls.pitch+hover.p)*self.rotorRpm
	local rotateZ = self.controls.yaw*1.5*self.rotorRpm
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	local gearDOWN,t1=self:LookupSequence("gearDOWN")
	local gearUP,t2=self:LookupSequence("gearUP")	
	if self.Door1 and !self.Door1Closed then
		self:EmitSound( "mi24/door.wav"	)
		self.Door1Closed = true
		self:SetBodygroup(7,1)
	elseif !self.Door1 and self.Door1Closed then
		self:EmitSound( "mi24/door.wav"	)
		self.Door1Closed = false
		self:SetBodygroup(7,0)
	end
	if self.Door2 and !self.Door2Closed then
		self:EmitSound( "mi24/door.wav"	)
		self.Door2Closed = true
		self:SetBodygroup(8,1)
	elseif !self.Door2 and self.Door2Closed then
		self:EmitSound( "mi24/door.wav"	)
		self.Door2Closed = false
		self:SetBodygroup(8,0)
	end
	if self.Cockpit1 and !self.Cockpit1Closed then
		self:EmitSound( "mi24/cockpit.wav"	)
		self.Cockpit1Closed = true
		self:SetBodygroup(10,1)
	elseif !self.Cockpit1 and self.Cockpit1Closed then
		self:EmitSound( "mi24/cockpit.wav"	)
		self.Cockpit1Closed = false
		self:SetBodygroup(10,0)
	end
	if self.Cockpit2 and !self.Cockpit2Closed then
		self:EmitSound( "mi24/cockpit.wav"	)
		self.Cockpit2Closed = true
		self:SetBodygroup(9,1)
	elseif !self.Cockpit2 and self.Cockpit2Closed then
		self:EmitSound( "mi24/cockpit.wav"	)
		self.Cockpit2Closed = false
		self:SetBodygroup(9,0)
	end
	if self.Gear and !self.GearUp and !geartrace.Hit then
		self:EmitSound( "ka52/gear.wav"	)
		self:ResetSequence(gearDOWN) 
		self:SetPlaybackRate(0.2)
		self:SetBodygroup(1,1)
		self.GearUp = true
		 for i=1,3 do 
				 self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				 self.wheels[i]:SetColor(Color(255,255,255,0))
				 self.wheels[i]:SetSolid(SOLID_NONE)
		 end
	elseif !self.Gear and self.GearUp and !geartrace.Hit then
		self:EmitSound( "ka52/gear.wav"	)
		self:ResetSequence(gearUP)
		self:SetPlaybackRate(0.2)
		geardown,time1=self:LookupSequence("gearDOWN")
		self.GearUp = false
		self.GearDisabled = true
		timer.Simple(time1,function()
		if self.wheels then
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
				self.wheels[i]:SetColor(Color(255,255,255,255))
				self.wheels[i]:SetSolid(SOLID_VPHYSICS)
			end
			self:SetBodygroup(1,0)
			self.GearDisabled = false
			end
		end)
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