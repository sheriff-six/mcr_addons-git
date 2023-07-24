include("shared.lua")
AddCSLuaFile("shared.lua")

function ENT:SpawnFunction(p, tr)
	if (!tr.Hit) then return end
	local e = ents.Create(ClassName)
	e:SetPos(tr.HitPos + tr.HitNormal*20)
	e.Owner = p
	e:Spawn()
	e:Activate()
	return e
end

function ENT:receiveInput(name, value, seat)
	self:base("wac_hc_base").receiveInput(self, name, value, seat)
    if name == "Flare" and value>0.5 then
		self:FlareShootRight(value > 0.5, seat)
		self:FlareShootRight2(value > 0.5, seat)
		self:FlareShootRight3(value > 0.5, seat)
		self:FlareShootLeft(value > 0.5, seat)
	end
	if name == "Cockpit" and value>0.5 then
        self.Cockpit = !self.Cockpit
	end
	if name == "Landing_Gear" and value>0.5 then
        self.Gear = !self.Gear
	end
	if name == "Catapult" and value>0.5 and self.passengers[seat].wac.lastEnter<CurTime()-0.5 then
		self:Catapult(self.passengers[seat])
	end
end
function ENT:Catapult(ply,idx,t)
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
	local cockpitPos = self:GetPos()+Vector(250,0,150)
	local Cockpit=self:addEntity("prop_physics")
	if !self.Catapulted then
	Seat:SetModel("models/su25WAC/seat.mdl")
	Seat:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,580))
	Seat:SetAngles(self:GetAngles())
	Seat:Spawn()
	self:SetBodygroup(3,1)
	self:SetBodygroup(5,1)
	ply.LastVehicleEntered = CurTime()+0.5
	ply:ExitVehicle()
	ply:SetPos(self:LocalToWorld(self.Seats[idx].exit)+Vector(-50,-100,580))
	ply:SetVelocity(self:GetPhysicsObject():GetVelocity()*1.2)
	ply:SetEyeAngles((self:LocalToWorld(self.Seats[idx].pos-Vector(0,0,40))-ply:GetPos()):Angle())
	self:updateSeats()
	self.Catapulted = true
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
ENT.Aerodynamics = {
	Rotation = {
		Front = Vector(0, -2, 0),
		Right = Vector(0, 0, 40), -- Rotate towards flying direction
		Top = Vector(0, -40, 0)
	},
	Lift = {
		Front = Vector(0, 0, 10), -- Go up when flying forward
		Right = Vector(0, 0, 0),
		Top = Vector(0, 0, -0.5)
	},
	Rail = Vector(1, 5, 20),
	Drag = {
		Directional = Vector(0.01, 0.0001, 0.01),
		Angular = Vector(0.01, 3.1, 0.1)
	}
}

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
	self.flare:SetPos(self:LocalToWorld(Vector(-300,100,50))) 
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -1000 )
end
function ENT:FlareShootRight()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,0,50)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * 1000 )
end
function ENT:FlareShootRight2()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,0,50)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetRight() * -1000 )
end
function ENT:FlareShootRight3()
	if not self:CanFlare() then return end	
self:EmitSound( "ka52/flare.wav")
	---local shootOrigin = self:GetPos()-Vector(0,20,0)
	self.flare = ents.Create("misc_flare")
	self.flare:SetPos(self:LocalToWorld(Vector(-300,-100,50)))
	self.flare:SetModel( "models/flare.mdl" )
	self.flare:Spawn()
	self.flare:GetPhysicsObject():ApplyForceCenter(self:GetForward() * -1000 )
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

function ENT:PhysicsUpdate(ph)
	self:base("wac_pl_base").PhysicsUpdate(self,ph)
	self:SetNWFloat("Cockpit",self.CockpitClosed)
	self:SetNWFloat("Gear",self.GearUp)
	local ammo = self.weapons["Р-60"]:GetAmmo()
	local trace=util.QuickTrace(self:LocalToWorld(Vector(0,0,62)), self:LocalToWorld(Vector(0,0,50)), {self, self.wheels[1], self.wheels[2], self.wheels[3], self.rotor})
	local phys=self:GetPhysicsObject()
	local geartrace = util.QuickTrace(self:LocalToWorld(Vector(0,0,-80)), Vector(0,0,-5), self)
	local door,t1=self:LookupSequence("door")
	local doorOpen,t2=self:LookupSequence("doorOpen")	
	if self.Cockpit and !self.CockpitClosed then
		self:EmitSound( "su25lfs/cockpit.wav"	)
		self:ResetSequence(doorOpen) 
		self:SetPlaybackRate(0.5)
		self.CockpitClosed = true

	elseif !self.Cockpit and self.CockpitClosed then
		self:EmitSound( "su25lfs/cockpit.wav"	)
		self:ResetSequence(door)
		self:SetPlaybackRate(0.5)
		door,time1=self:LookupSequence("door")
		self.CockpitClosed = false

	end
	if self.Gear and !self.GearUp and !geartrace.Hit then
		self:EmitSound( "su25lfs/Gear.wav"	)
		self:SetBodygroup(1,1)
		self.GearUp = true
		 for i=1,3 do 
				 self.wheels[i]:SetRenderMode(RENDERMODE_TRANSALPHA)
				 self.wheels[i]:SetColor(Color(255,255,255,0))
				 self.wheels[i]:SetSolid(SOLID_NONE)
		 end
	elseif !self.Gear and self.GearUp and !geartrace.Hit then
		self:EmitSound( "su25lfs/Gear.wav"	)
		self:SetBodygroup(1,0)
		self.GearUp = false
		if self.wheels then
			for i=1,3 do 
				self.wheels[i]:SetRenderMode(RENDERMODE_NORMAL)
				self.wheels[i]:SetColor(Color(255,255,255,255))
				self.wheels[i]:SetSolid(SOLID_VPHYSICS)
			end
		end
	end
	if self.rotor2 then
		local vel = ph:GetVelocity()	
		local pos = self:GetPos()
		local lvel = self:WorldToLocal(pos+vel)
		local throttle = self.controls.throttle/2 + 0.5
		local phm = FrameTime()*66
		local brake = (throttle+1)*self.rotorRpm/900+self.rotor.phys:GetAngleVelocity().z/100
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,self.engineRpm*30 + throttle*self.engineRpm*20)*self.rotorDir*phm)
		self.rotor2.phys:AddAngleVelocity(Vector(0,0,-brake + lvel.x*lvel.x/500000)*self.rotorDir*phm)
	end
	if ammo == 2 then
        self:SetBodygroup(4,0)
	elseif ammo == 1 then
		self:SetBodygroup(4,1)
	elseif ammo == 0 then
		self:SetBodygroup(4,2)
	end
end

function ENT:addRotors()
	self:base("wac_pl_base").addRotors(self)

	self.rotorModel.TouchFunc=nil
	
	self.rotor2 = ents.Create("prop_physics")
	self.rotor2:SetModel("models/props_junk/sawblade001a.mdl")
	self.rotor2:SetPos(self:LocalToWorld(self.rotorPos2))
	self.rotor2:SetAngles(self:GetAngles() + Angle(90, 0, 0))
	self.rotor2:SetOwner(self.Owner)
	self.rotor2:Spawn()
	self.rotor2:SetNotSolid(true)
	self.rotor2.phys = self.rotor2:GetPhysicsObject()
	self.rotor2.phys:EnableGravity(false)
	self.rotor2.phys:SetMass(5)
	--self.rotor2.phys:EnableDrag(false)
	self.rotor2:SetNoDraw(true)
	self.rotor2.health = 100
	self.rotor2.wac_ignore = true
	if self.RotorModel2 then
		local e = ents.Create("wac_hitdetector")
		e:SetModel(self.RotorModel2)
		e:SetPos(self:LocalToWorld(self.rotorPos2))
		e:SetAngles(self:GetAngles())
		e:Spawn()
		e:SetOwner(self.Owner)
		e:SetParent(self.rotor2)
		e.wac_ignore = true
		local obb=e:OBBMaxs()
		self.RotorWidth=(obb.x>obb.y and obb.x or obb.y)
		self.RotorHeight=obb.z
		self.rotorModel2=e
		self:AddOnRemove(e)
	end
	constraint.Axis(self.Entity, self.rotor2, 0, 0, self.rotorPos2, Vector(0,0,1), 0,0,0.01,1)
	self:AddOnRemove(self.rotor2)
end
