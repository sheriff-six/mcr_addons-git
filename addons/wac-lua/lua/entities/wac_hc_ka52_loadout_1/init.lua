include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(ply, tr)
	if (!tr.Hit) then return end
	local ent=ents.Create(ClassName)
	ent:SetPos(tr.HitPos+tr.HitNormal+Vector(0,0,90))
	ent:Spawn()
	ent:Activate()
	ent.Owner=ply
	return ent
end

function ENT:addWheels()
	for _,t in pairs(self.Wheels) do
		if t.mdl then
			local e=self:addEntity("prop_physics")
			e:SetModel(t.mdl)
			e:SetPos(self:LocalToWorld(t.pos))
			e:SetAngles(self:GetAngles())
			e:Spawn()
			e:Activate()
			e:PhysicsInitSphere( e:BoundingRadius()/2, "rubber")
			local ph=e:GetPhysicsObject()
			if t.mass then
				ph:SetMass(t.mass)
			end
			if t.ice then
				ph:SetMaterial("gmod_ice")
			end
			ph:EnableDrag(false)
			constraint.Axis(e,self,0,0,Vector(0,0,0),self:WorldToLocal(e:LocalToWorld(Vector(0,1,0))),0,0,t.friction,1)
			table.insert(self.wheels,e)
			self:AddOnRemove(e)
		end
	end
end

function ENT:Initialize()
    self:base("wac_hc_base").Initialize(self)
	self.GearDisabled = false
end

function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
	if seat == 1 or seat == 2 then
	    if name == "Landing_Gear" and value>0.5 then
            self.Gear = !self.Gear
		end
	end
	if seat == 1 and name == "Cockpit" and value>0.5 then
        self.CockpitL = !self.CockpitL
	end
	if seat == 2 and  name == "Cockpit" and value>0.5 then
        self.CockpitR = !self.CockpitR
	end
	if name == "Flare" and value>0.5 then
		self:FlareShootRight(value > 0.5, seat)
		self:FlareShootRight2(value > 0.5, seat)
		self:FlareShootRight3(value > 0.5, seat)
		self:FlareShootRight4(value > 0.5, seat)
		self:FlareShootRight5(value > 0.5, seat)
		self:FlareShootLeft(value > 0.5, seat)

	end
end
function ENT:CatapultL(ply,idx,t)
	if !idx then
		for k,p in pairs(self.passengers) do
			if p==ply then idx=k end
		end
		if !idx then
			return
		end
	end
	local seatPos = self:GetPos()+Vector(250,0,120)
	local Seat=self:addEntity("prop_physics")
	if !self.CatapultedL then
	Seat:SetModel("models/sw/avia/ka52/seat.mdl")
	Seat:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,350))
	Seat:SetAngles(self:GetAngles())
	Seat:Spawn()
	self:SetBodygroup(3,2)
	self:SetBodygroup(5,2)
	ply.LastVehicleEntered = CurTime()+0.5
	ply:ExitVehicle()
	ply:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,350))
	ply:SetVelocity(self:GetPhysicsObject():GetVelocity()*1.2)
	ply:SetEyeAngles((self:LocalToWorld(self.Seats[idx].pos-Vector(0,0,40))-ply:GetPos()):Angle())
	self:updateSeats()
	self.CatapultedL = true
	end
end
function ENT:CatapultR(ply,idx,t)
	if !idx then
		for k,p in pairs(self.passengers) do
			if p==ply then idx=k end
		end
		if !idx then
			return
		end
	end
	local seatPos = self:GetPos()+Vector(250,0,120)
	local Seat=self:addEntity("prop_physics")
	if !self.CatapultedR then
	Seat:SetModel("models/sw/avia/ka52/seat.mdl")
	Seat:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,350))
	Seat:SetAngles(self:GetAngles())
	Seat:Spawn()
	self:SetBodygroup(2,2)
	self:SetBodygroup(4,2)
	ply.LastVehicleEntered = CurTime()+0.5
	ply:ExitVehicle()
	ply:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,350))
	ply:SetVelocity(self:GetPhysicsObject():GetVelocity()*1.2)
	ply:SetEyeAngles((self:LocalToWorld(self.Seats[idx].pos-Vector(0,0,40))-ply:GetPos()):Angle())
	self:updateSeats()
	self.CatapultedR = true
	end
end

function ENT:EjectPassenger(ply,idx,t)
	if !idx then
		for k,p in pairs(self.passengers) do
			if p==ply then idx=k end
		end
		if !idx then
			return
		end
	end
	if self.CockpitClosed then
		return
	end
	ply.LastVehicleEntered = CurTime()+0.5
	ply:ExitVehicle()
	ply:SetPos(self:LocalToWorld(self.Seats[idx].exit))
	ply:SetVelocity(self:GetPhysicsObject():GetVelocity()*1.2)
	ply:SetEyeAngles((self:LocalToWorld(self.Seats[idx].pos-Vector(0,0,40))-ply:GetPos()):Angle())
	self:updateSeats()
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
		local grockets = ents.FindByClass("sent_stinger_missile")
		table.Merge(rockets,grockets, ents.FindByClass("wac_w_rocket"))
		for _, e in pairs(rockets) do
			if e:GetPos():Distance(self:GetPos()) < 6500 then b = true break end
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
	self.flare:SetPos(self:LocalToWorld(Vector(-10,250,70))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-10,-250,70)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight2()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,-250,70)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight3()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,-60,-40)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 90 )
end
function ENT:FlareShootRight4()	
	if not self:CanFlare() then return end	
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-100,250,70))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight5()	
	if not self:CanFlare() then return end
	self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,-20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,60,-40))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -90 )
end

function ENT:addRotors()
	self:base("wac_hc_base").addRotors(self)
	self.topRotor2 = self:addEntity("prop_physics")
	self.topRotor2:SetModel("models/props_junk/sawblade001a.mdl")
	self.topRotor2:SetPos(self:LocalToWorld(self.TopRotor2.pos))
	self.topRotor2:SetAngles(self:LocalToWorldAngles(self.TopRotor2.angles))
	self.topRotor2:SetOwner(self.Owner)
	self.topRotor2:SetNotSolid(true)
	self.topRotor2:Spawn()
	self.topRotor2.Phys = self.topRotor2:GetPhysicsObject()
	self.topRotor2.Phys:EnableGravity(false)
	self.topRotor2.Phys:SetMass(5)
	self.topRotor2.Phys:EnableDrag(false)
	self.topRotor2:SetNoDraw(true)
	self.topRotor2.fHealth = 100
	self.topRotor2.wac_ignore = true
	if self.TopRotor2.model then
		local e = self:addEntity("wac_hitdetector")
		self:SetNWEntity("wac_air_rotor_main", e)
		e:SetModel(self.TopRotor2.model)
		e:SetPos(self.topRotor2:GetPos())
		e:SetAngles(self.topRotor2:GetAngles())
		e:Spawn()
		e:SetNotSolid(true)
		e:SetParent(self.topRotor2)
		e.wac_ignore = true
		local obb = e:OBBMaxs()
		self.RotorWidth2 = (obb.x>obb.y and obb.x or obb.y)
		self.RotorHeight2 = obb.z
		self.topRotor2.vis = e
	end
	constraint.Axis(self.Entity, self.topRotor2, 0, 0, self.TopRotor2.pos, Vector(0,0,1), 0,0,0,1)
	self:AddOnRemove(self.topRotor2)
end
function ENT:PhysicsUpdate(ph)
	self:base("wac_hc_base").PhysicsUpdate(self,ph)		
	self:SetNWFloat("CockpitL",self.CockpitLClosed)
	self:SetNWFloat("CockpitR",self.CockpitRClosed)
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
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.wheels[4], self.rotor})
	local phys=self:GetPhysicsObject()
	local phm = FrameTime()*66
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	local gearwarningtrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-100), self)
	local geardown,t1=self:LookupSequence("geardown")
	local gearup,t2=self:LookupSequence("gearup")		
	if self.CockpitL and !self.CockpitLClosed then
		self:EmitSound( "ka52/door.wav"	)
		self:SetBodygroup(2,1)
		self.CockpitLClosed = true
	elseif !self.CockpitL and self.CockpitLClosed then
		self:EmitSound( "ka52/door.wav"	)
		self:SetBodygroup(2,0)
		self.CockpitLClosed = false
	end
	if self.CockpitR and !self.CockpitRClosed then
		self:EmitSound( "ka52/door.wav"	)
		self:SetBodygroup(3,1)
		self.CockpitRClosed = true
	elseif !self.CockpitR and self.CockpitRClosed then
		self:EmitSound( "wka52/door.wav"	)
		self:SetBodygroup(3,0)
		self.CockpitRClosed = false
	end
	if self.Gear and !self.GearUp and !geartrace.Hit then
		self:EmitSound( "ka52/gear.wav"	)
		self:ResetSequence(geardown) 
		self:SetPlaybackRate(0.2)
		self:SetBodygroup(1,1)
		self.GearUp = true
		 for i=1,4 do 
				 self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				 self.wheels[i]:SetColor(Color(255,255,255,0))
				 self.wheels[i]:SetSolid(SOLID_NONE)
		 end
	elseif !self.Gear and self.GearUp and !geartrace.Hit then
		self:EmitSound( "ka52/gear.wav"	)
		self:ResetSequence(gearup)
		self:SetPlaybackRate(0.2)
		geardown,time1=self:LookupSequence("geardown")
		self.GearUp = false
		self.GearDisabled = true
		timer.Simple(time1,function()
		if self.wheels then
			for i=1,4 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
				self.wheels[i]:SetColor(Color(255,255,255,255))
				self.wheels[i]:SetSolid(SOLID_VPHYSICS)
			end
			self:SetBodygroup(1,0)
			self.GearDisabled = false
			end
		end)
	end	
	if self.UsePhysRotor then
		if self.topRotor2 and self.topRotor2.Phys and self.topRotor2.Phys:IsValid() then
			if self.RotorBlurModel then
				self.topRotor2.vis:SetColor(Color(255,255,255,math.Clamp(1.3-self.rotorRpm,0.1,1)*255))
			end
				-- top rotor physics
			local rotor = {}
			rotor.phys = self.topRotor2.Phys
			rotor.angVel = rotor.phys:GetAngleVelocity()
			rotor.upvel = self.topRotor2:WorldToLocal(self.topRotor2:GetVelocity()+self.topRotor2:GetPos()).z
			rotor.brake =
				math.Clamp(math.abs(rotor.angVel.z) - 2950, 0, 100)/10 -- RPM cap
				+ math.pow(math.Clamp(1500 - math.abs(rotor.angVel.z), 0, 1500)/900, 3)
				+ math.abs(rotor.angVel.z/10000)
				- (rotor.upvel - self.rotorRpm)*self.controls.throttle/1000
				rotor.targetAngVel =
				Vector(0, 0, math.pow(self.engineRpm,2)*self.TopRotor2.dir*10)
				- rotor.angVel*rotor.brake/200
				rotor.phys:AddAngleVelocity(rotor.targetAngVel)
		end
	end
	self.LastPhys = CurTime()

	if self.topRotor and IsValid(self.topRotor) and IsValid(self.topRotor.vis) then
		if self.rotorRpm > 0.6 and self.rotorRpm < 0.79 then
			self.topRotor.vis:SetBodygroup(0,1)
		elseif self.rotorRpm > 0.8 then
			self.topRotor.vis:SetBodygroup(0,1)
		elseif self.rotorRpm < 0.4 then
			self.topRotor.vis:SetBodygroup(0,0)
		end
	end
	
	if self.topRotor2 and IsValid(self.topRotor2) and IsValid(self.topRotor2.vis) then
		if self.rotorRpm > 0.6 and self.rotorRpm < 0.79 then
			self.topRotor2.vis:SetBodygroup(0,1)
		elseif self.rotorRpm > 0.8 then
			self.topRotor2.vis:SetBodygroup(0,1)
		elseif self.rotorRpm < 0.4 then
			self.topRotor2.vis:SetBodygroup(0,0)
		end
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